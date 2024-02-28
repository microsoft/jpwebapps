param(
    [string]$pullRequestId,
    [string]$accessToken
)

$organizationUrl = "https://dev.azure.com/jpdsi-edge"
$project = "edge-internals"
$repositoryId = "1a248aad-a3b5-48fe-8410-8a31c4008db9"
$siteUrl = "https://happy-bush-0e8a37100-${pullRequestId}.eastasia.4.azurestaticapps.net/"

# Create API Url
$url = "${organizationUrl}/${project}/_apis/git/repositories/${repositoryId}/pullrequests/${pullRequestId}/threads?api-version=7.1-preview.1"

# Create Header
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer ${accessToken}"
}

# Create description
$comment = "Your preview site is ready! Visit it here: ${siteUrl}"

# Create request body
$body = @{
    comments= @(
        @{
            parentCommentId = 0
            content = $comment
            commentType = "system"
        }
    )
}

# Call API
$response = Invoke-RestMethod -Uri $url -Method Post -Body ($body | ConvertTo-Json) -Headers $headers
