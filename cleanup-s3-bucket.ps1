# Variablen
$BUCKET_NAME = "terraform-state-753856"
$REGION = "eu-central-1"

# Alle Objekte und Versionen löschen
Write-Host "Lösche alle Objekte und Versionen aus dem Bucket '$BUCKET_NAME'..."

# Lösche aktuelle Objekte
aws s3 rm s3://$BUCKET_NAME --recursive

# Lösche alle Versionen
$VERSIONS = $(aws s3api list-object-versions --bucket $BUCKET_NAME --output json | 
    ConvertFrom-Json)

# Lösche Objekt-Versionen
if ($VERSIONS.Versions) {
    $VERSIONS.Versions | ForEach-Object {
        aws s3api delete-object --bucket $BUCKET_NAME --key $_.Key --version-id $_.VersionId
        Write-Host "Lösche Version $($_.VersionId) von $($_.Key)"
    }
}

# Lösche Delete-Marker
if ($VERSIONS.DeleteMarkers) {
    $VERSIONS.DeleteMarkers | ForEach-Object {
        aws s3api delete-object --bucket $BUCKET_NAME --key $_.Key --version-id $_.VersionId
        Write-Host "Lösche Delete-Marker $($_.VersionId) von $($_.Key)"
    }
}

# Versionierung deaktivieren
Write-Host "Deaktiviere Versionierung..."
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Suspended

# Bucket löschen
Write-Host "Lösche S3 Bucket..."
aws s3api delete-bucket --bucket $BUCKET_NAME --region $REGION

Write-Host "Aufräumen abgeschlossen!"