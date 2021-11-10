velero install --provider azure \
                --plugins velero/velero-plugin-for-microsoft-azure:v1.1.0 \
                --bucket "velero" --secret-file ./velerocreds.tpl \
                --backup-location-config resourceGroup=${veleroRG},storageAccount=${veleroSTA} \
                --use-volume-snapshots=true \
                --snapshot-location-config apiTimeout=5m,resourceGroup=${veleroRG},subscriptionId=${targetSub}