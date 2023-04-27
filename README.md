# SY_Notify

<kbd><img src="https://user-images.githubusercontent.com/89760730/233840565-3baaad49-52b0-4a5c-9d0b-97be0be92efe.png" /><kbd>

<kbd><img src="https://user-images.githubusercontent.com/89760730/234043343-a3402e7b-e702-4106-88ff-c04dbe07f3e0.png" /></kbd>

[ESX-Version SY_Notify](https://github.com/SYNO-SY/SY_Notify)

# Dependency

- [QBCore](https://github.com/qbcore-framework/qb-core)
- [oxmysql](https://github.com/overextended/oxmysql)

# Installation

- Download the file and put it in the resource directory
- Install Sql
  ```sql
    CREATE TABLE IF NOT EXISTS `sy_notify` (
   `identifier` varchar(65) DEFAULT NULL,
   `position` longtext DEFAULT NULL,
    UNIQUE KEY `identifier` (`identifier`) USING HASH
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
  ```
- Rename the Folder to SY_Notify.
- Add `ensure SY_Notify` in you're server.cfg

1. To display a notification you should call it like below:
   1. Using Client Side:
   ```lua
      exports['SY_Notify']:Alert("Title", "Message", Time, 'type')
   ```
   2. Using Server Side:
   ```lua
      TriggerClientEvent('SY_Notify:Alert', source, "Title", "Message", Time, 'type')
   ```
2. To set the notification display time, use:

   1. 1000 - `[1 second]`
   2. 2000 - `[2 seconds]`
   3. 5000 - `[5 seconds]`
   4. 10000 - `[10 seconds]`
   5. etc...

3. To change the type of notification, use this types of notifications:

   1. success
   2. info
   3. warning
   4. error

4. IF YOU NEED TO ADD THIS NOTIFICATION AS DEFAULT IN QbCore, ADD THE GIVEN CODE IN @qb-core/client/functions.lua (Line Number "88")

```lua
   function QBCore.Functions.Notify(text, texttype, length)
      if type(text) == "table" then
         local ttext = text.text or 'Placeholder'
         local caption = text.caption or 'Placeholder'
         texttype = texttype or 'primary'
         length = length or 5000
         SendNUIMessage({
            action = 'notify',
            type = texttype,
            length = length,
            text = ttext,
            caption = caption
         })
      else
         texttype = texttype or 'primary'
         length = length or 5000
         SendNUIMessage({
            action = 'notify',
            type = texttype,
            length = length,
            text = text
         })
      end
   end
```

replace it with

```lua
   function QBCore.Functions.Notify(text, texttype, length)
      if type(text) == "table" then
         local ttext = text.text or 'Placeholder'
         local caption = text.caption or 'Placeholder'
         texttype = texttype or 'info'
         length = length or 5000
         exports['SY_Notify']:Alert(caption, ttext, length, texttype)
      else
         texttype = texttype or 'info'
         length = length or 5000
         exports['SY_Notify']:Alert("NOTIFICATION", ttext, length, texttype)
      end
   end
```

## TODO

- add more conifg.
- add color code.
