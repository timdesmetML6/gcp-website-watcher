# gcp-website-watcher

gcp-website-watcher enables you to create a web crawler that watches any URL you want. The crawler will check the page every X minutes to check if a sentence specified by you is no longer present. If the target sentence has indeed disappeared the crawler will send you an email at the same interval speed.

Example Use Case: A product is out of stock, you know this because the website says: "Out of stock". You want to be notified as soon as possible when the product gets refilled. Use gcp-website-crawler with the URL and the "Out of stock" sentence. When the words "Out of stock" are no longer on the page you will get notified almost instantly allowing you to respond fast without having to check manually.

Using this repo you can get this up in only a few minutes since all needed infrastructure is built automatically on the Google Cloud Platform.

The repo also supports having multiple web crawlers.

## Requirements

- gcloud SDK installed
- terraform installed
- GCP Account (Free Credits available)
- MailJet Account (Free tier)

## Instructions

### One Time Setup

Start by creating a Google Cloud Account if you don't have one already. Click [here](https://console.cloud.google.com/) and follow the steps. Afterward, there should be a banner on top of the page to claim your free $300 credits.

Next, install the gcloud SDK by following [these steps](https://cloud.google.com/sdk/docs/install) if you don't have it installed yet.

The steps to download terraform can be found on [this page](https://www.terraform.io/downloads.html).

Lastly, create a MailJet account in the free tier by following the steps on [this page](https://app.mailjet.com/signup?lang=en_US&_ga=2.205875219.1662219136.1613827933-638092520.1613827933).

> Note that you need to use the same email address as the one you want to receive the notifications on.

### Deploy a crawler

To deploy a crawler you only need to change the `./terraform/project.tfvars` and run a few commands.

The `./terraform/project.tfvars` file should look like:

```
project = "TODO"
pub_key = "TODO"
priv_key = "TODO"
billing = "TODO"
watchers = {
    "w1" = {
        "interval"      : "* */10 * * *",
        "function"      : "TODO",
        "topic"         : "TODO" ,
        "scheduler"     : "TODO",
        "function_url"  : "TODO",
        "email"         : "TODO",
        "string_target" : "TODO",
    },
}
```

Change every occurrence of TODO to the required value:

- `project`: a unique name for your GCP project (should not exist yet)
- `pub_key`: your API KEY value on [this page](https://app.mailjet.com/account/api_keys)
- `priv_key`: your SECRET KEY value on [this page](https://app.mailjet.com/account/api_keys)
- `billing`: the Billing Account Name of your GCP Billing Account that you want to use. This can be found [here](https://console.cloud.google.com/billing)
  > You can change the number 10 in the interval to any number between 1 and 59. It means "every X minutes". The default is set to "Every 10 minutes". If you have more experience with Cron Jobs feel free to modify the full string to your specific needs.
- `function`: This value should be a unique name. Example: function-[website]-[product]-[your-name]
- `topic`: This too should be unique. Example: topic-[website]-[product]-[your-name]
- `scheduler`: This too should be unique. Example: scheduler-[website]-[product]-[your-name]
- `function_url`: this should be the URL of the page you want to keep an eye on.
- `email`: Your email address (same as the MailJet account).
- `string_target`: The sentence you want to check. If this sentence disappears you will receive email notifications.

Next up is simply executing the following commands:

```bash
# authenticate using your google account
gcloud auth application-default login
# go inside the terraform folder
cd terraform
# check if everything works as expected
terraform plan --var-file project.tfvars
# The previous command shows what will be created, if everything looks right run the next command to deploy:
terraform apply --var-file project.tfvars
# You will be prompted first so don't forget to type 'yes'
```

### Deploy multiple crawlers

In order to deploy multiple crawlers just modify the `./terraform/project.tfvars` file by adding another crawler. Example:

```
project = "TODO"
pub_key = "TODO"
priv_key = "TODO"
billing = "TODO"
watchers = {
    "w1" = {
        "interval"      : "* */10 * * *",
        "function"      : "TODO",
        "topic"         : "TODO" ,
        "scheduler"     : "TODO",
        "function_url"  : "TODO",
        "email"         : "TODO",
        "string_target" : "TODO",
    },
    "w2" = {
        "interval"      : "* */10 * * *",
        "function"      : "TODO",
        "topic"         : "TODO" ,
        "scheduler"     : "TODO",
        "function_url"  : "TODO",
        "email"         : "TODO",
        "string_target" : "TODO",
    },
}
```

The previous section explains in detail what values are expected for the fields.

After changing the `./terraform/project.tfvars` file simply run the same commands as in the previous section.

### Remove all crawlers

You can remove all your crawlers at once without removing your project by running the following command inside of the terraform folder:

```
terraform destroy --var-file project.tfvars --target module.watcher
```

### Remove a single crawler

You can remove a single crawler without affecting your crawlers or your general project by running the following command inside of the terraform folder:

```
terraform destroy --var-file project.tfvars --target module.watcher.w1
```

> Note that the `w1` at the end of the command should change according to which crawler you want to remove.

## Associated Cost

Nothing is free so there is a cost associated with having a crawler deployed. However, the cost here is very low (sub $1 per month per crawler). You can always review the GCP pricing pages for the deployed resources.
