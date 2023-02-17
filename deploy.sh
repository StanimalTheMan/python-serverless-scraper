/Users/stanimal/Dev/serverless-app/prepare.sh

zip -g helloWorldLambda.zip scraper.py
zip -g helloWorldLambda.zip lambda.py

zip -vr helloWorldLambda.zip cache/ -x "*.DS_Store"


aws s3api put-object \
    --bucket cfe-lambda-jiggy \
    --key helloWorld/helloWorldLambda.zip \
    --body helloWorldLambda.zip

aws lambda update-function-code \
    --function-name helloWorldLambda \
    --s3-bucket cfe-lambda-jiggy \
    --s3-key helloWorld/helloWorldLambda.zip \
    --publish \
    --region us-east-1

rm helloWorldLambda.zip