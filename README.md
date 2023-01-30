# icalendar-bot
Telegram bot for generate iCalendar appointments

## Usage

TBD

## Development

### Requirement
serverless framework

### Create gemlayer
```
docker run --rm -it -v $PWD:/var/gem_build -w /var/gem_build lambci/lambda:build-ruby2.7 bundle install --path=.
```

### Run dynamoDb locally
```
docker pull instructure/dynamo-local-admin
docker run -p 8000:8000 -it --rm instructure/dynamo-local-admin
```

### Deploy
```
sls deploy
```

## License
The project is developed by [NIX](http://nixsolutions.com) team and distributed under [MIT LICENSE](https://github.com/nixsolutions/icalendar-bot/blob/master/LICENSE)
