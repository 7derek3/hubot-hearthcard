# hubot-hearthcard

Allows users to ask Hubot to post strings containing details of Hearthstone cards based on a card's name.

See [`src/hearthcard.coffee`](src/hearthcard.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-hearthcard --save`

Then add **hubot-hearthcard** to your `external-scripts.json`:

```json
[
  "hubot-hearthcard"
]
```

## Sample Interaction

```
user1>> hubot hs card leeroy
hubot>> Leeroy Jenkins*​ (L), 5:gem:6:dagger_knife:2:heart:, ​*Charge*​. ​*Battlecry:*​ Summon two 1/1 Whelps for your opponent.
```
