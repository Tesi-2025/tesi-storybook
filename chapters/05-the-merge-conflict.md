# Chapter 5 — The Merge Conflict

They had been coding, quietly and productively, for six hours. Babbo had rewritten the ten-line summary. Mamma had rebuilt the traction chart from her memory (which for a giraffe is very good — giraffes remember exactly where every acacia tree in their lives has stood). Draghetta had scrupulously not exhaled near any electronics. Topo had reorganised the assets folder with the tidy meticulousness of a mouse who has strong feelings about kerning.

Then Mamma tried to push.

```
$ git push origin main
To github.com:donkeyshoes/pitch.git
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs
```

She pulled.

```
Auto-merging pitch-deck.md
CONFLICT (content): Merge conflict in pitch-deck.md
Automatic merge failed; fix conflicts and then commit the result.
```

The kitchen paused again. Everybody knew that particular pause. It was the pause of a merge conflict — the small silent kitchen-pause that has, in software startups the world over, ended more marriages than infidelity.

"*Chi ha spinto?*" said Mamma, calmly. Who pushed?

"I did," said Babbo, from the moka pot, with the guilt of a man who has just realised he pushed to main from his phone at the airport last night and completely forgot to mention it.

"*Ah,*" said Mamma. "*Va bene. Vediamo.*"

She opened the file.

```
<<<<<<< HEAD
Donkey Shoes is comfortable footwear for animals of all species,
starting with hoofed mammals in the £3B ungulate market.
=======
Donkey Shoes is comfortable footwear for animals of all species,
starting with quadrupeds in the £8B multi-legged mobility market.
>>>>>>> babbo/airport-edit
```

Both versions were, on inspection, quite good.

"*Which market size is right?*" asked Draghetta.

"They are both right," said Mamma. "It depends on how we define the beachhead."

"So we take both?" said Draghetta.

"No, in git you can only take one."

"So which do we take?"

Mamma considered this. Tesi, who was standing on the trackpad again, considered it too. He looked at the *HEAD* version. He looked at the *babbo/airport-edit* version. He hopped, deliberately, onto the number `8` on the keyboard.

Then he bit the giraffe's ear.

Mamma laughed. "*Otto miliardi, allora. Bene. Otto miliardi.*"

She rewrote the paragraph, taking Babbo's larger market and her own crisper phrasing, and the file became better than either version alone had been — which is, Mamma later noted, the only actually good outcome of a merge conflict. She staged, she committed with a message that said `[donkey-shoes] resolve conflict: combine ungulate + quadruped framing 🦒 grazie Babbo, grazie Tesi`, and she pushed.

```
Everything up-to-date.
```

Babbo, from the moka, raised his espresso in a small silent toast. Mamma raised hers back. Tesi bit her ear one more time, for the record.

```
   <<<<<<< HEAD
   we love you
   =======
   we love you
   >>>>>>> babbo
   ---
   resolved: we love each other
```
