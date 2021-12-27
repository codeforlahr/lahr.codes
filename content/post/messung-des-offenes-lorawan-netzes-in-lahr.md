---
title: Messung des offenes LoRaWAN Netzes in Lahr
type: post
date: 2020-11-12T13:07:00.000Z
description: Anleitung zur Erstellung eines LoRaWAN-Reichweite Mappers mit The
  Things Network.
image: img/radiusmap-lora-1.5km.png
---
Autor: [David](https://github.com/synolus-david), [Jonas](https://github.com/jfehre) 
Veröffentlicht: 11.11.2020  

*Update 17.11.2021: Anleitung und Bilder von TTN v2 auf TTN v3 angepasst.*

## Was ist LoRaWAN, TTN und warum gibt es das in Lahr?

Seit längerem faszinieren wir uns für das Thema LoRaWAN, bzw. insbesondere das TheThingsNetwork (TTN). LoRaWan steht für “Long Range Wide Area Network” und ist ein Funknetzwerk, das mit hohen Reichweiten die ganze Stadt mit einen Zugang für IoT „Internet of Things“ bereitstellt. Wärend es auch geschlossene LoRaWAN Netze gibt, ist das Netz in Lahr komplett offen und ist Teil des [TheThingsNetwork](https://www.thethingsnetwork.org/). Der Community basierte Aufbau und der Open-Source Ansatz gefällt uns und hat den Vorteil Unabhängigkeit von kommerziellen Anbietern zu sein. Da wir das Thema schon einige Jahre auf dem Schirm haben, hatten wir zu unseren Social Hackathons das Thema immer mal wieder gepusht. Dann hatten wir die Idee [„LoRaWAN für Lahr“](https://www.lahr.de/gateways-fuer-die-nutzung-des-lorawan-installiert.129603.htm) beim Bürgerideenwettbewerb "Stadtgulden 2019" der Stadt eingereicht. Zu unserer Überraschung fand das Thema Anklang bei den Bürgerinnen und Bürger der Stadt und wurde zu einem der beliebtesten Projekte gewählt, wodurch der Aufbau eines Netzes finanziert wurde.

Mittlweile konnten wir als Initiatoren gemeinsam mit der Stadt Lahr und der Badenova AG ein Konzept aufbauen, bei welchem insgesamt 6 LoRaWAN Gateways in Lahr aufgebaut. 

![Erwartete Abdeckung des öffentlichen LoRaWAN Netzes in Lahr mit 2km je Gateway](img/radiusmap-lora-1.5km.png)

## Wo habe ich tatsächlich LoRaWAN Empfang?

Da die Reichweiten der Gateways stark von Umgebungsfaktoren abhängig sind (Lage des Gateways, Höhe, Bebauung etc.) hat sich die TTN-Community eine [Karte](https://ttnmapper.org/) aufgebaut, auf welcher die Abdeckung des Netzes kartographiert wird. Es gibt verschiedene Möglichkeiten auf die Karte zu mappen, zum Beispiel mit Hilfe einer App, welche die GPS Signal des Handys benutzt und einem LoRaWAN Device, oder mit speziellen TTN-Mappern, die direkt mit GPS Sensor ausgestattet sind. Da die diesjährige CodeWeek online stattfand, hatten wir beschlossen, die Teilnehmer TTN-Mapper bauen zu lassen und bei sich zu Hause Empfang zu messen. Es gibt einen [Blog Beitrag](http://integra-lahr.de/index.php/2020/10/19/4-social-hackathon-der-integra-lahr-ggmbh/) der IntegrA Lahr gGmbH, welche die Veranstaltung beschreibt. Da wir aber mit der benutzen Hardware nur in den Experimentiermodus der TTN-Map mappen konnten, haben wir gemeinsam mit Felix und Mario vom senseBox-Team aus Münster die benutzte Hardware weiterentwickelt. Im folgenden findet sich die Dokumentation zum Nachbau:

## Einfacher Bau eines TTN-Mappers

### Einleitung

Für den Bau des TTN-Mappers nutzen wir das [senseBox TTN-Mapper Set](https://sensebox.kaufen/product/sensebox-ttn-mapper-set) welches für 77 Euro erhältlich ist. Da viele auch noch einen [OLED-Display](https://sensebox.kaufen/product/led-display) verfügbar haben, wird auch die Option gezeigt, wie man diesen einbindet. Das Set mobil nutzen zu können, macht es Sinn außerdem noch eine CR1225 Knopfzelle für das GPS-Modul zu besorgen, eine Powerbank, oder [LiPo-Akku](https://eckstein-shop.de/LiPo-Akku-Lithium-Ion-Polymer-Batterie-37V-2000mAh-JST-PH-Connector) für mobile Stromversorgung und ein Micro-USB Kabel, welches für Dateinübertragung geeignet sein soll (z.B. altes Handykabel :-) ). 

### Aufbau der Hardware

Das LoRa-Bee steckt man auf XBee1 auf, sodass die Antenne des Bees vom Mikrocontroller weg zeigt. Das GPS-Modul wird mit Hilfe eines der JST-JST Kabel an einen der I2C/Wire Steckplätze angeschlossen. Die Knopfzelle kommt in das GPS-Modul. Falls ihr einen Display nutzt, wird dieser auch an einen der I2C/Wire Steckplätze angeschlossen. Das Micro-USB Kabel wird an den dafür vorgesehen Micro-USB-Port ageschlossen und mit dem USB-Port deines Laptops verbunden. Die Powerbank ersetzt dann später deinen Computer. Wenn du einen LiPo-Akku besorgt hast, kannst du den direkt in den JST-PH Steckeranschluss anschließen.

*Fritzing-Graphik-Aufbau*

### Einstellung in der TTN-Console

### 1. *Application und Device anlegen*

Gehe auf deine [TTN-Console](https://console.thethingsnetwork.org/) und wähle das Netzwerk Cluster in deiner Nähe aus (z.B. eu1).
Falls du noch kein Konto hast, musst du dir noch eines erstellen. Gehe auf **Go to applications** um eine neue Applikation zu erstellen 
Du gelangst auf eine Übersicht, mit allen deinen Applikationen. Dort kannst du auf **add application** klicken um eine neue Applikation anzulegen. 
Bennene deine "Application ID" (z.B. ttn-mapper-lahr-codes), füge einen Namen ein und beschreibe deine Applikation. Klicke dann auf **Create application**.

![Erster Schritt bei TTN ist das anlegen einer Applikation](img/application-anlegen_v3.png)

Dann erhälst du eine Übersicht deiner neuen Applikation. Nun musst du noch ein Endgerät hinzufügen. Gehe dafür unter der Rubrik **End devices** und füge ein neues Endgerät mit **Add end device** hinzu.
Wähle oben **Manually** aus. Wähle als "Frequency plan" *Europe 863-870 MHz (SF9 for RX2 - recommended)* aus, als "LoRaWAN version" *MAC V1.0.2* und bei "Regional Parameters Version" die Option *PHY V1.0.2 REV A*

Als nächstes müssen die EUIs eingetragen werden.. Durch klicken auf die geschlungenen Pfeile (**Generate**) bei “DevEUI” wird dir automatisch einen DeviceEUI generiert.
Die "AppEUI" kann mit Nullen gefüllt werden und der "AppKey" kann auch automatisch generiert werden, über die Knöpfe.
Danach landest du wieder in einer Übersicht, diesmal für die Device Einstellungen.

![Übersicht](img/device-anlegen_v3.png)


### 2. *Integration anlegen*

Da wir die Daten später an den TTN Mapper senden möchten, musst Du außerdem eine “Integration” hinzufügen. 
Diese findest du links in deinem Menü unter **Integrations**. Klicke auf **Webhooks** und füge eine neue Integration mit **Add webhook** hinzu.
Dort hast du dann die Möglichkeit, verschiedenste Integrations hinzuzufügen, um die Daten von TTN an andere Services weiterzuleiten. 
Wähle dort den “TTN Mapper” aus. Gib nun eine “Webhook ID” an, die du frei wählen kannst. Gib auch deine E-Mail Adresse an, für den Fall das Rückfrage zu deinen Daten entstehen. 

Dann kommt die Entscheidung, ob du deine Daten als Experiment verwenden möchtest, oder einfach nur Mappen willst. 
Deinem Experiment kannst du dort also einen Namen geben. 
Wenn du den Experiment Namen auslässt dann bist du nicht mehr in der Lage deine eigenen Messungen auf dem TTN Mapper zu identifizieren. 
Klicke dann auf **Create ttn mapper webhook**.

!["Die ausgefüllte Integration für den TTN-Mapper"](img/integration-anlegen_v3.png)

### 3. *Payload Formats angeben*

Im letzten Schritt müssen wir noch ein sogenanntes Decoding-Profil anlegen. 
Dieses Profil decodiert im Prinzip die  Bytes welche später vom Device geschickt werden zu den ursprünglichen Werten zurück. 
Wenn dich die Theorie dahinter interessiert, kannst du das [hier](https://docs.sensebox.de/blockly/blockly-web-lora/) nachlesen. 
Klicke dafür auf **Payload formatters** links im Menü und anschließend auf **Uplink**. 
In diesem Tutorial wird das Cayenne Payload Format genutzt. Wähle daher als "Formatter type" *Cayenne LPP*. Speicher die Änderung mit **Save changes**.


![Einfügen des Decoding Profils](img/decoding-anlegen_v3.png)

### Programmieren des Mikrocontrollers

Der einfachste Weg die senseBox zu Programmieren ist mit Hilfe der visuellen Programmierumgebung [Blockly](https://blockly.sensebox.de/ardublockly/?board=sensebox-mcu). 
Theoretisch kann man aber auch mit der Arduino IDE arbeiten. Die Schwierigkeit der Programmierung ist etwas fortgeschritten, trotzdem kann jede(r) die folgenden Codes einfach nachklicken. 
Wir dokumentieren die Codes in der englischen Sprache, es gibt aber auch die Möglichkeit auf Deutsch umzustellen. 
Blockly ist sehr intuitiv zu verstehen. Einen Code baust du immer durch "Drag&Drop" aus verschiedenen einzelnen Blöcken. 
An der linken Seite finden sich alle vorgefertigten Blöcke mit denen du deinen Code bauen kannst und oben rechts findest du Funktionen und Features. 

### 4. "Initialisierung"

Blockly ist der Arduino Programmiersprache nachempfunden und besteht aus einer `setup()` und einer `loop()` Abschnitt im Code. 
Im `setup()` werden Funktionen definiert die beim Start des Mikrocontrollers ausgeführt werden sollen. 

Hier möchten wir nun, dass sich unser Mikrocontroller mit TTN verbindet. Dazu braucht man verschiedene Keys aus deinem Device, welche du in der Übersicht deines Gerätes unter **End devices** in der TTN Konsole findest. 
In Blockly klickst du auf "Web", "LoRa" und dann auf "Activation" und ziehst den Block mit dem Namen `Initialize LoRa (OTAA)` auf die Programmierfläche in den `setup()` Abschnitt. 
Hier hast du die Möglichkeit 4 Felder auszufüllen.

> Beim Kopieren der EUIs und des Keys muss man darauf achten, das richtige Format (lsb, msb) zu nutzen. Außerdem muss man die geschweiften Klammern { und } selbst vor bzw. hinter die Hexadezimalzahlen setzen, da diese aktuell nicht mitkopiert werden 

1. in das Feld `Device EUI (lsb)` kopierst du den Code aus deiner Device Übersicht. Bevor du diesen kopierst: **Ändere das Format des Keys auf Hexadezimal durch klicken auf das "<>" Symbol. Nutze anschließend die kleinen Pfeile ⇆ im Textfeld um von msb auf lsb zu wechseln**
2. in das Feld `Application EUI (lsb)` kopierst du den Code aus deiner Device Übersicht. Bitte ändere auch dort das Format auf lsb. 
3. Die "Device Address" kannst du einfach so kopieren
4. Ins letzte Feld kannst du eingeben wie oft Daten vom Device übertragen werden sollen. Da der Mapper später mobil genutzt werden soll, macht es Sinn hier ein kleineres Intervall einzutragen.

Wenn du aber stationäre Devices aufbaust, solltest du immer längere Intervalle eingeben und dich an die [Fair Use Policy](https://www.thethingsnetwork.org/community/rhein-sieg/post/fair-use-policy-vom-nehmen-und-geben-bitte-danke) der TTN Community halten.

![Block für die Initialisierung](img/setup-lora_v3.png)

### 5. "Schleife"

**TTN Mapper**

In der `loop()` Abschnitt des Codes kommen nun die Funktionen, die (solange das Board angeschalten ist) immer wieder wiederholt werden sollen. 

Da wir in diesem Tutorial das Cayenne Payload Format für die Übertragung der Daten nutzen, wähle den Block `Send as Cayenne Payload` unter "Lora", "Cayenne LPP".
Das Wichtigste was wir übertragen wollen, ist unsere aktuelle Position, damit später auf dem TTN Mapper angezeigt wird, ob es an dieser Stelle ein LoRa-Signal gibt.
Suche den Block `Latitude, Longitude, Altidude, Channel` unter "Lora", "Cayenne LPP".
Füge anschließend den `GPS-Module` Block (unter "Sensors") ein und wähle den jeweiligen Wert aus. Der Channel kann auf 1 gesetzt bleiben.

![Der Block für den TTN-Mapper](img/loop-ttnmapper_v3.png)

**Statusanzeigt mit dem OLED-Display**

Falls du einen zur senseBox passenden OLED-Display hast, kannst du auch diesen nutzen um dein GPS-Signal anzuzeigen. 
Nutze dazu den Block `Print on Display` und den `Show Measurements` Block welchen man nutzt um Sensorwerte anzuzeigen. 
Im folgenden zeigen wir die "latitude" und die "longitude" an. Erhälst du den Wert 0, hast du kein GPS-Empfang und musst etwas warten.

> Vergiss nicht den Display im `status()` Abschnitt zu initialisieren!

![Die zwei Status LED auf dem Board zeigen an, ob der TTN Mapper gerade einen GPS Signal empfängt](img/status-display.png)

### 6. "Code Übertragen"

Nun fehlt nur noch Code auf den Mikrocontroller zu übertragen. Oben rechts siehst du einen roten, runden Knopf mit einem Haken. 
Wenn du auf diesen Knopf drückst, werden die Blöcke "kompiliert" und es entsteht ein Code, welcher vom Mikrocontroller gelesen werden kann. 
Klickst du auf den Knopf, entsteht eine Datei im Format ".bin" welche in deinem Download Ordner landet.

Schließe jetzt die senseBox an deinen USB-Port an, und doppelklicke den roten Button auf dem Board um den "Lernmodus" zu aktivieren, wie auch in diesem [Video](https://youtu.be/jzlOJ7Zuqqw) gezeigt wird.

Dann kannst du den Code mit Drag&Drop auf dein Board laden und dein Mapper ist fertig.  Wenn du Probleme mit der Code Übertragung hast, kannst du auch nochmal [dieses Video](https://www.youtube.com/watch?v=f3UqvTFt7Ek&t=76s) anschauen.

### 7. "Funktioniert mein Mapper?"

Wenn dein Mapper funktioniert, sammelst du Werte welche auf der Website https://ttnmapper.org/ angezeigt werden. 
Schaue in deiner Nachbarschaft, ob du ein Gateway entdeckst und wo du Signale empfängst. 
Es lohnt sich generell immer, am Anfang erst ein Experiment anzulegen, um nur die Daten deines Mappers zu sehen und zu testen ob alles funktioniert.

![So sieht dein Experiment auf dem TTN-Mapper aus](img/experiment-mapper.png)

Deinen persönlichen TTN Mapper findest Du dann unter dem Namen deines Experiments. Wähle dazu **Advanced maps** und füge dein Experiment Namen in **Show Experiment Data** ein.
Mit einem Klick auf **View Map** werden auf der Karte die Messpunkte von dir angezeigt.  
Falls du zwischenzeitlich den Namen deines Experiments vergessen hast, kannst du diesen in der TTN Konsole unter **Webhooks** und dann bei deinem "TTN Mapper Webhook" bei "Additional headers" nachschauen.  
Es dauert ein bisschen bis die senseBox GPS Daten empfängt. Zwischendurch kannst Du die Seite neu laden um die neuesten Messungen zu sehen oder auf dem Display nachschauen ob GPS Daten bereits empfangen wurden.

### 8. Hilfe

Du kannst in der TTN Konsole nachschauen ob LoRa Daten bei TTN ankommen. 
Klicke in deiner Application auf **Live data** und ein `Forward join-accept message` sollte zu sehen sein, sobald sich das Gerät mit einem LoRa Gateway verbunden konnte. 
Falls keine Nachrichten ankommen schau nochmal über deine Keys die du aus TTN-Console übertragen hast und insbesondere auf deren Format. 
Ansonsten könnte es sein, dass in deiner Umgebung kein LoRa Gateway in Reichweite ist.

>Es kann eine Weile dauern bis das GPS Modul Daten empfängt. Manchmal dauert es mehrere Stunden bei der ersten Nutzung.

Wurden aber einmal Daten empfangen, sollte es beim nächsten mal schneller funktionieren. Die Nutzung der Knopfzelle verbessert den GPS Empfang.  
Manchmal hilft es auch den Sensor im Freien zu testen

##### Es kommt nur Accept join-request in der TTN Konsole an

Anscheinend kommt dies häufiger vor seit TTN V3, da es so aussieht als ob TTN länger benötigt um ein Endgerät ins Netzwerk aufzunehmen.
Einfach das Gerät weiterlaufen lassen und warten. Sobald der erste Beitritt erfolgreich ist, sollte es danach wie gewohnt schnell gehen ([Quelle](https://forum.sensebox.de/t/ttn-v3-ausser-accept-join-request/1335/2))

Generell Hilfe zur senseBox findest du außerdem in der [Dokumentation](https://docs.sensebox.de) des Mikrocontrollers oder mit Hilfe anderer Nutzer in diesem [Forum](https://forum.sensebox.de). 

Viel Spaß beim Nachbauen und Mappen!
