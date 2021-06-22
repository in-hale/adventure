## Installation

Prior to installation, make sure you have the following installed on your machine.
* `Ruby 2.7.3`
* `gem bundler`

In order to install Adventure follow these steps:

```shell
$ git clone https://github.com/in-hale/adventure.git
$ cd adventure
$ bundle
```

## Usage

The application has a ready-to-go boilerplate story `scenes.yml` which is specified as the default

In order to create your own story, you'll have to check the following points:
* Have a `.yml` story file. See scenes.yml as an example
* The file should have one start anchor tag (`_start`)
* The file should have at least one reference to the end tag (`_exit`)
* Specify your custom file path in the options

```  
Usage: run/adventure.rb [options]
    -f, --file PATH                  Story file path. Default: scenes.yml
    -n, --name NAME                  Player name. Default: Buddy
    -h, --help                       Prints help message
```

Run the default story with a custom player name:
```shell
$ run/adventure.rb -n Laurent
```

Run a custom story:
```shell
$ run/adventure.rb -f custom_story.yml
```

## Specs and testing

In order to run the whole test suit you'll have to execute the following:
```shell
$ rspec
```
Add a `-fd` flag to see a meaningful output:
```shell
$ rspec -fd
```
Run the linter for the whole project with the following command:
```shell
$ rubocop
```

## Troubleshooting

In case you are having issues with running the executable file, make sure the file has the execution permission configured:
```shell
$ chmod +x run/adventure.rb
```

## Possible improvements

* `dry-schema`, `dry-validations` for the story source files
* FactoryBot for `Scene`, `SceneAction` creation in specs
