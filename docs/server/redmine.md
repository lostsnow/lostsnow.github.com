Redmine
=======

version: 1.3

mail 配置
---------

`vim config/configuration.yml`

    production:
      email_delivery:
        delivery_method: :sendmail

    default:
      email_delivery:
        delivery_method: :sendmail


`vim config/environments/production.rb`

    config.action_mailer.sendmail_settings = {
      :location => '/usr/sbin/sendmail',
      :arguments => '-i -t'
    }


quote 的换行
------------

`vim app/controllers/journals_controller.rb`

    70     content = "#{ll(Setting.default_language, :text_user_wrote, user)}\n\n> "

`vim app/controllers/messages_controller.rb`

    115     content = "#{ll(Setting.default_language, :text_user_wrote, user)}\\n\\n> "
