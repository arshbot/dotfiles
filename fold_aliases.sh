# Mark fold bash aliases

# Decode, edit and save secrets. This provides a way to edit production configs.
# Secrets are temporarily saved to /tmp/cfcsecrets as a backup. Delete these or
# reboot to prevent the values from persisting on your computer.
function cfceditsecret {
    mkdir -p /tmp/cfcsecrets/
    secretName=$1
    kubectl get secret $secretName -o json > /tmp/cfcsecrets/$secretName.json
    jq '.data[]' /tmp/cfcsecrets/$secretName.json | cut -d '"' -f 2 | base64 -d > /tmp/cfcsecrets/$secretName-decoded.yaml
    vim /tmp/cfcsecrets/$secretName-decoded.yaml
    encodedSecret="$(cat /tmp/cfcsecrets/$secretName-decoded.yaml | base64 -w0)"
    jq --indent 4 '.data[] = "'"$encodedSecret"'"' /tmp/cfcsecrets/$secretName.json > /tmp/cfcsecrets/$secretName-new.json
    read -p "Press enter to save changes. Control-c to quit"
    kubectl apply -f /tmp/cfcsecrets/$secretName-new.json
}
export -f cfceditsecret

# Change to a different namespace (this edits the current context)
function ksn {
    export CONTEXT=$(kubectl config view | awk '/current-context/ {print $2}');
    kubectl config set-context $CONTEXT --namespace="$1";
}
export -f ksn

# Switch to a different context
alias ksc='kubectl config use-context $1'

# List all available contexts
alias kgc='kubectl config get-contexts'

# Rename a context
alias krc='kubectl config rename-context $1 $2'

# Delete a context
alias kdc='kubectl config delete-context $1'

# Trigger a rolling deploy after changing secrets
function kroll {
    kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"`date +'%s'`\"}}}}}"
}
export -f kroll

# Patch kubernetes deployments to trigger a rolling deploy
function krollcfc {
    kroll cardforcoin
    kroll celery-beat
    kroll celery-cardforcoin
    kroll celery-cfc
    kroll celery-fold
    kroll celery-fold-account-actor
    kroll celery-fold-card-actor
    kroll celery-fold-check-transactions
    kroll fold
    kroll fold-api
    kroll fold-multibrand
    kroll fold-webhook
}
export -f krollcfc

# Trigger a rolling deploy after changing secrets
function kscale {
    kubectl scale deployment/$1 --replicas $2
}
export -f kscale

function ksh {
    POD=`kubectl get pod -l app=$1 --no-headers | grep Running | head -1 | cut -f 1 -d " "`
    kubectl exec -it $POD sh
}
export -f ksh

# Scale all deployments to the given number
function kscalecfc {
    kscale cardforcoin $1
    kscale celery-beat $1
    kscale celery-cardforcoin $1
    kscale celery-cfc $1
    kscale celery-fold $1
    kscale celery-fold-account-actor $1
    kscale celery-fold-card-actor $1
    kscale celery-fold-check-transactions $1
    kscale fold $1
    kscale fold-api $1
    kscale fold-multibrand $1
    kscale fold-webhook $1
}
export -f kscalecfc

function kdeleteterminating {
    kubectl delete pods --grace-period=0 --force --field-selector=status.phase=Pending
}
export -f kdeleteterminating

# Usage: `kshellplus fold-multibrand`
function kshellplus {
    POD=`kubectl get pod -l app=$1 --no-headers | grep Running | head -1 | cut -f 1 -d " "`
    kubectl exec -it $POD python manage.py shell_plus
}
export -f kshellplus

function kcfcpayresend {
    CONTEXT=payments-prd
    POD=`kubectl get pod --namespace=default --context=$CONTEXT -l app=cardforcoin --no-headers | grep Running | head -1 | cut -f 1 -d " "`
    kubectl exec -it --namespace=default --context=$CONTEXT $POD -- bash -c "echo 'from cardforcoin.repl import *;w=Withdrawal.objects.get(id=$1);w.payment.bitgopayment.remit();w.payment.bitgopayment.db_refresh();print(w.payment.bitgopayment.tx_hash)' | python manage.py shell"
}
export -f kcfcpayresend
function kcfcpaynew {
    CONTEXT=payments-prd
    POD=`kubectl get pod --namespace=default --context=$CONTEXT -l app=cardforcoin --no-headers | grep Running | head -1 | cut -f 1 -d " "`
    kubectl exec -it --namespace=default --context=$CONTEXT $POD -- bash -c "echo 'from cardforcoin.repl import *;w=Withdrawal.objects.get(id=$1);cardforcoin.withdrawals.pay_withdrawal(w);w.payment.bitgopayment.db_refresh();print(w.payment.bitgopayment.tx_hash)' | python manage.py shell"
}
export -f kcfcpaynew

# Usage `kbash fold-multibrand`
# Open shell in pod
function kbash {
    POD=`kubectl get pod -l app=$1 --no-headers | grep Running | head -1 | cut -f 1 -d " "`
    kubectl exec -it $POD bash
}
export -f kbash

# A safe version of skaffold that can only be run against minikube
function sk {
    KUBECTL_CONTEXT=`kubectl config current-context`
    if [[ $KUBECTL_CONTEXT != "minikube" ]]; then
        echo "ERROR: Current kubectl context is $KUBECTL_CONTEXT. Use skaffold for prod environments."
        return 1
    fi
    skaffold "$@"
}
export -f sk

