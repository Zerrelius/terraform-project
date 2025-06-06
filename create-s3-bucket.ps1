# Variablen für den S3 Bucket definieren
$BUCKET_NAME = "terraform-state-{0}" -f (Get-Random -Maximum 999999)
$REGION = "eu-central-1"

# S3 Bucket erstellen
Write-Host "Erstelle S3 Bucket '$BUCKET_NAME' in Region '$REGION'..."
aws s3api create-bucket `
    --bucket $BUCKET_NAME `
    --region $REGION `
    --create-bucket-configuration LocationConstraint=$REGION

# Versionierung aktivieren
Write-Host "Aktiviere Versionierung..."
aws s3api put-bucket-versioning `
    --bucket $BUCKET_NAME `
    --versioning-configuration Status=Enabled

# Verschlüsselung aktivieren
Write-Host "Aktiviere Verschlüsselung..."
aws s3api put-bucket-encryption `
    --bucket $BUCKET_NAME `
    --server-side-encryption-configuration '{
        "Rules": [
            {
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                }
            }
        ]
    }'

Write-Host "S3 Bucket erfolgreich erstellt: $BUCKET_NAME"
Write-Host "Bitte notieren Sie sich den Bucket-Namen für die backend.tf Konfiguration!"