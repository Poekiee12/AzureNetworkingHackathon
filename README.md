# Azure Networking Hackathon

Zie onderstaande plaat voor hetgeen wat we straks gaan uitrollen:
![image](/Netwerktekening.png)

## Prerequisites
- Visual Studio Code
- Powershell
- AZ module
- BICEP
- Azure omgeving waarin je Owner bent

## Uitrol Azure Resources

1. Open Visual Studio Code. Zorg dat je het BICEP bestand voor je team lokaal op je laptop hebt staan.
2. Installeer de benodigde Powershell modules door het volgende command te runnen:
Install-Module Az -Force
3. Mogelijk moet je je Visual Studio Code herstarten nadat je dit commando hebt uitgevoerd.
4. Log via de Powershell terminal in op je Azure omgeving door het commando "Connect-AzAccount" te gebruiken.
5. Gebruik het volgende commando om het BICEP bestand uit te rollen:
New-AzResourceGroupDeployment -ResourceGroupName "resourcegroupname" -TemplateFile "c:\map\vwan routing team x.bicep" -Verbose
6. Deze uitrol kan tot ongeveer 45 minuten duren.

## Opdrachten

Je ziet als het goed is dat er een aantal resources zijn uitgerold:
- Virtual WAN
- Virtual WAN Hub
- 3 Virtuele netwerken
- 3 Virtuele machines
- 1 VPN Gateway, gekoppeld in de Virtual WAN HUB
- 1 Virtual Network Gateway
- 1 Local Network Gateway
- 1 Firewall Policy


### Opdracht 1
1. Bekijk per netwerkkaart van VM01 en VM02 wat de effectieve routes zijn. Sla deze op. Zie: https://learn.microsoft.com/en-us/azure/virtual-network/manage-route-table#view-effective-routes
2. Koppel de VNET’s aan de VWAN. Kies voor de optie "Propogate to none": Yes. Kies voor de optie "Associate Route table": Default. https://learn.microsoft.com/en-us/azure/virtual-wan/howto-connect-vnet-hub. Speel met de routing configuration en controleer daarbij welke routes je op de NIC van de VM01 en VM02 zien terugkomen net zoals opdracht 1.
4. Wat is het verschil tussen route association en route propogation? Dit mag uitgelegd worden in de presentatie.
5. Kijk of de VM’s elkaar kunnen benaderen door gebruik te maken van een ping of test-netconnection commando.

### Opdracht 2
1. Koppel nu in de Azure Portal een Azure Firewall Standard in je HUB. Gebruik hiervoor de Firewall Policy FWP01 die al klaar staat. Het uitrollen hiervan duurt ongeveer 10 minuten.
2. Schakel diagnostic settings aan voor de Azure Firewall. Selecteer alle opties voor logging.
3. Stel in de security configuration in dat de vnet’s beveiligd moeten worden met Azure Firewall. Welke routes zie je nu terugkomen in je VM’s?
4. Haal de security configuration weg in de Azure Firewall weg. Schakel Routing intent i.c.m. met de Azure Firewall in op de HUB. Zie je nu iets veranderen in de routing op de VM's?
5. Controleer in de firewall logging of je verkeer voorbij ziet komen van je VM's.

### Opdracht 3
1. Maak een Site-to-Site VPN connectie tussen de VPNGW01 en VPNGW02. Zie voor de VPNGW01 configuratie: https://learn.microsoft.com/en-us/azure/virtual-wan/virtual-wan-site-to-site-portal#site. Zie voor de VPNGW02 configuratie: https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal#LocalNetworkGateway. **LET OP: De Local Network Gateway LNG01 bestaat al, je hoeft hier enkel de configuratie voor aan te passen, namelijk het publieke IP adres van de VPNGW01.** 
2. Maak in eerste instantie gebruik van statische routering. Wat zie je veranderen in de routering van de VWAN?
3. Test of je kunt verbinden vanaf de VM01/VM02 naar de VM03 door middel van een ping of test-netconnection.
4. Pas de statische routering aan en configureer BGP. Wat zie je veranderen in de routering op de VWAN?
5. Test of je kunt verbinden met de VM van het andere team door middel van een ping of test-netconnection.
6. Wat is het verschil tussen de statische routering en het gebruik van BGP? Zijn er voor en nadelen?

### Opdracht 4 - Geadvanceerd - Optioneel
1. Creëer een tweede secured virtual hub in de bestaande Virtual WAN.
2. Creëer een VNET04 met een VM04 hierin. Koppel dit VNET aan de VWAN.
3. Zorg dat de VM's via de Secured Virtual HUB's met elkaar kunnen praten. Gebruik hiervoor onder andere Routing Intent.
4. Zorg ervoor dat de VM03 via de VPNGW02 ook met de nieuwe VM04 kan communiceren. Mogelijk moet je hiervoor nieuwe resources aanmaken, maar dit mag je zelf uitzoeken :-)

### Presentatie

Aan het eind presenteer je de volgende dingen:
- Per opdracht, wat ging er goed, waar liep je tegen aan? - 10 punten per opdracht
- Wat is het verschil tussen route association en route propogation? - 5 punten
- Wat is Routing Intent en Security Configuration? Wat is het verschil er tussen? - 5 punten
- Wat is een Site-to-Site connection? - 5 punten
- Wat is static routing? Wat is BGP? Wat zijn de voor en nadelen van beide oplossingen? - 10 punten
- Wat is je opgevallen aan de verschillen van de effectieve routes op een NIC van een VM na aanpassingen? - 5 punten
- Leuke vorm van presentatie - 10 punten
