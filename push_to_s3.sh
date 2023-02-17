zip -g helloWorldLambda.zip lambda.py

zip -vr helloWorldLambda.zip cache/ -x "*.DS_Store"


aws s3api put-object \
    --bucket cfe-lambda-jiggy \
    --key helloWorld/helloWorldLambda.zip \
    --body helloWorldLambda.zip