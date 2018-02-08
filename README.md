  # KOMPETENSDAG IGENKÄNNINGSSPEL I SWIFT

  Det vi ska göra denna månadens kompetensdag är att vi delar upp oss i grupper ~2-3 personer per grupp. Varje grupp ska skapa en app som använder sig av Apples CoreML modeller (https://developer.apple.com/machine-learning/) för att dektektera objekt i bilder, detta ska ni använda för att skapa ett spel som går ut hitta olika saker i sin omgivning.

  ## Dagen mål
  Målet med kompetensdagen är att varje grupp ska skapa ett spel som använder sig av mobilkameran och "känner igen" olika objekt och användare får poäng för de objekt som hittas. Den första gruppen som lyckas känna igen ett objekt med sin app kanske t.o.m. får ett pris 😉.

  ## Utgångsläge
  I det här repot finns det på master branchen en relativit detaljerad beskrivning (som kommentarer i koden) om hur du kan gå tillväga för att skapa en app likt demo appen, vill du ha lite mer frihet, finns en grund med enbart ett ett GUI på branchen gui som ni kan använda/bygga vidare på ifall ni vill slippa pilla med gui:t, ni kan även välja att börja helt från scratch. Låt fantasin och creativiteten flöda!

  En utav de CoreML modeller (Inception-v3), som finns i länken här ovanför, är också tillagd i projektet, det går jättebra att byta till någon av de andra om det skulle önskas.

  ## Förberedelser som kan vara bra att göra innan kompetensdagen
  1. Ha en Mac att koda på
  3. Ha en iPhone att köra appen på (det går att köra det mesta i iPhone simulatorn i Xcode men för att köra kamera integrationen behöver du köra appen på en iPhone)
  *Om du ej har en Mac/iPhone, försök para ihop dig med någon som har så kan ni parprogrammera!*
  3. Se till att ha senaste versionen av Xcode (9.2) och iOS version 11.0+ då detta krävs för att kunna köra CoreML.
  4. Värt att notera är att CoreML modellerna är ganska stora (lite beroende på vilken en väljer), en enkel app tar upp ca 140MB, se till att ha lite minne på din iPhone!
  5. Ifall du aldrig har använt Xcode/skrivit i Swift förut kan det kanske vara värt att testa på det innan, dock verkligen inget krav, vi är här för att lära oss!

  ## Dokumentation och bra reads
  ### Generellt om Swift
   - https://developer.apple.com/documentation
  ### Mer specifikt vad vi kommer använda oss av
  #### API:er
  - https://developer.apple.com/documentation/coreml
  - https://developer.apple.com/documentation/avfoundation
  - https://developer.apple.com/documentation/vision
  - https://developer.apple.com/documentation/avkit
  - https://developer.apple.com/documentation/uikit

  #### Tutorials, etc som kan vara användbara
  - https://developer.apple.com/documentation/coreml/integrating_a_core_ml_model_into_your_app
  - https://www.analyticsvidhya.com/blog/2017/09/build-machine-learning-iphone-apple-coreml/
  - https://gist.github.com/yrevar/942d3a0ac09ec9e5eb3a (lista på saker Inception-v3 bör känna igen)
