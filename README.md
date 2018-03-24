# smartinvoicetest

```
var supplier = web3.eth.accounts[0] //supplier
var investor = web3.eth.accounts[1] //investor
var buyer = web3.eth.accounts[2] //buyer

CredentialManager.deployed().then(function(instance) {cred = instance })
Verification.deployed().then(function(instance) {verif = instance})
Chainy.deployed().then(function(instance) {chainy = instance})
InvoiceToken.deployed().then(function(instance) {invoice = instance})

var jsonstring = '{"id":"smartinvoice","version":1,"type":"L","filename":"apple.jpg","hash":"f2551293c0cc13f8bdf8f04c4c220ac6613d8703a0d076bde54a5ae74a9a3583","filetype":"img","filesize":"22665"}'

chainy.setCredentialManager(cred.address)
cred.setRole(0,supplier)

var last = chainy.getLastChainy(supplier )

invoice.mint(investor, last, supplier, investor, buyer, 5, 5)

//invoice hanya bisa dibaca oleh g, h, dan j
var someoneelse = web3.eth.accounts[3]
var index = invoice.totalSupply()

//berhasil
invoice.tokenMetadata(index,{from:supplier})
invoice.tokenMetadata(index,{from:investor})
invoice.tokenMetadata(index,{from:buyer})

//gagal
invoice.tokenMetadata(index,{from:someoneelse})
```
