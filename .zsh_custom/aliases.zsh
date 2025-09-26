alias python3.9="python3"
alias brewski='brew update && brew upgrade && brew cleanup'
alias brewdir='cd /opt/homebrew/'
alias docpipeline="cd ~/dpp/document-pipeline/"
alias legdocpipeline="cd ~/dpp/legacy/doc-pipeline/"
alias dpcommon="cd ~/dpp/document-pipeline/document-pipeline-common/"
alias doc-ext-mon-svc="cd ~/dpp/document-pipeline/microservices/doc-ext-mon-svc/" 
alias doc-ext-subm-svc="cd ~/dpp/document-pipeline/microservices/doc-ext-subm-svc/"
alias file-conv-svc="cd ~/dpp/document-pipeline/microservices/file-conv-svc/"
alias ocr-batch-mon-svc="cd ~/dpp/document-pipeline/microservices/ocr-batch-mon-svc/"
alias ocr-batch-svc="cd ~/dpp/document-pipeline/microservices/ocr-batch-svc/"
alias ocr-conv-pkg-svc="cd ~/dpp/document-pipeline/microservices/ocr-conv-pkg-svc/"
alias ocr-conv-svc="cd ~/dpp/document-pipeline/microservices/ocr-conv-svc/"
alias ocr-mon-svc="cd ~/dpp/document-pipeline/microservices/ocr-mon-svc/"
alias ocr-subm-svc="cd ~/dpp/document-pipeline/microservices/ocr-subm-svc/"
alias pipeline-error-svc="cd ~/dpp/document-pipeline/microservices/pipeline-error-svc/"
alias pipeline-rem-svc="cd ~/dpp/document-pipeline/microservices/pipeline-rem-svc/"
alias pipeline-svc="cd ~/dpp/document-pipeline/microservices/pipeline-svc/"
alias pkg-indexing-svc="cd ~/dpp/document-pipeline/microservices/pkg-indexing-mon-svc/"
alias purge-svc="cd ~/dpp/document-pipeline/microservices/purge-svc/"
alias translation-svc="cd ~/dpp/document-pipeline/microservices/translation-svc/"
alias validation-svc="cd ~/dpp/document-pipeline/microservices/validation-svc/"
alias lg="lazygit"
alias activate="source ./.venv/bin/activate || source ./venv/bin/activate"
alias legtest="dotnet test -c Development -e GOOGLE_APPLICATION_CREDENTIALS=/Users/wimmersn/qa-automation/dev-gccredmain.json"
s3list() {
  local profile=$1
  local bucket="$(aws configure get profile.${profile}.bucket)"
  aws s3 ls ${bucket} --profile ${profile}
}

s3cp() {
  local profile=$1
  local source_path=$2
  local dest_path=$3
  local bucket="$(aws configure get profile.${profile}.bucket)"
  aws s3 cp ${source_path} ${bucket}/${dest_path} --profile ${profile}
}

s3rm() {
  local profile=$1
  local file_path=$2
  local bucket="$(aws configure get profile.${profile}.bucket)"
  aws s3 rm  ${bucket}/${file_path} --profile ${profile}
}
