ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ItemsPlayerCanBuy = { -- Prevents Exploiting...
  "combomeal",
  "bigmac",
  "mcpollo",
  "mcroyaldeluxe",
  "cbo",
  "cuartodelibra",
  "grandmcextreme",
  "bigchickensupreme",
  "bigcrispybbq",
  "bigdoublecheese",
  "hamburgesa",
  "hamburgesadepollo",
  "mcfish",
  "happymeal",
  "cocacola",
  "nestea",
  "agua",
  "monsterenergy",
  "cerveza",
  "aquarius",
  "sprite",
  "colacao",
  "nuggets",
  "patatasfritas",
  "topfries",
  "fanta",
}

RegisterServerEvent('BMX-MCDONALDS:realizarpedido')
AddEventHandler('BMX-MCDONALDS:realizarpedido', function(data)
    local _src = source
    local _char = ESX.GetPlayerFromId(_src)
    local _charmoney = _char.getMoney()
    local _price = tonumber(data.price * data.amount)
    local _isitemvalid = false
    for k,v in pairs(ItemsPlayerCanBuy) do
      if v == data.item then
        _isitemvalid = true
      end
    end
    if _isitemvalid then
      if _charmoney >= _price and _price > 0 then
        _char.removeMoney(_price)
        _char.addInventoryItem(data.item, data.amount)
        --TriggerClientEvent('mythic_notify:client:SendAlert',_src, { type = 'success', length = 5000, text = "Has comprado una " .. data.item .. " por " .. data.price .. "$ con éxito." }) -- EXAMPLE
        TriggerClientEvent('esx:showNotification', source, '~g~ GRACIAS POR LA COMPRA')
        
        -- ADD YOUR NOTIFICATIONS RIGHT HERE!
      else
        --TriggerClientEvent('mythic_notify:client:SendAlert',_src, { type = 'error', length = 5000, text = "No tienes suficiente dinero en efectivo." }) -- EXAMPLE
        --ESX.ShowNotification("No tienes suficiente dinero")
        TriggerClientEvent('esx:showNotification', source, '~r~ NO TIENES SUFICIENTE DINERO')
        -- ADD YOUR NOTIFICATIONS RIGHT HERE!
      end
    else
      DropPlayer(_src, "El jugador ha llamado a un evento del BMX_MCDONALDS para comprar un item que no está en la lista whitelisteado!")
    end
end)
