# Pacman Game

This is a project inspired by the nostalgic "PACMAN" game, and was built in the game development software GameMaker Studio 2.

![pacman_title](https://user-images.githubusercontent.com/71052352/162107885-79dd2259-7c3e-41d0-b7ea-512ea9d2c805.gif)

## Features
### Powerups 
![Webp net-gifmaker (2)](https://user-images.githubusercontent.com/71052352/162111298-e59e1f13-fdcc-43a0-b448-0e0a19c1aeb3.gif)
![Webp net-gifmaker (4)](https://user-images.githubusercontent.com/71052352/162111971-6cbf8c17-fa40-443c-9bc8-9d601041348a.gif)
![Webp net-gifmaker (6)](https://user-images.githubusercontent.com/71052352/162112331-6992d22a-58fd-4b73-8c9e-16629fb3bd44.gif)
![Webp net-gifmaker (5)](https://user-images.githubusercontent.com/71052352/162112195-477022a6-c2b8-44da-8bb2-617aaf4ca0fd.gif)


#### Four types of powerups:
  - **Ghost Mode:** Makes the player invisible and intangible to ghosts temporarily;<br><br>
  ![powerup_ghost](https://user-images.githubusercontent.com/71052352/162499988-b2df81e1-ebe4-427c-b8a0-ad7e8801e94b.gif)
  
  - **Invincible Mode**: The player becomes invulnerable and can defeat the ghosts for a short period of time;<br><br>
  ![powerup_invincible](https://user-images.githubusercontent.com/71052352/162499841-20d6d867-c3ef-4d0d-9061-d29500618875.gif)

  - **Increase Speed**: Increases the speed at which the player moves for a certain amount of time;<br><br>
  ![powerup_speed](https://user-images.githubusercontent.com/71052352/162499893-80d6beee-723b-441e-8889-879dea5f2910.gif)

  - **Health Point**: Increases the player's health by 1 point.<br><br>
  ![powerup_life](https://user-images.githubusercontent.com/71052352/162499885-044ca9c8-8b86-4ccd-ba66-0cd26e5cecaf.gif)

---

### Difficulty Scaling
When collecting all the points, the player levels up, and the points spawn again after a few seconds. Every time the player levels up, the enemies will become stronger.

**Default Values:**
- Ghost walking speed: 1;<br>
Speed at which the ghost moves normally.

- Ghost hunting speed: 2;<br>
Speed at which the ghost moves when it sees the player, and starts hunting them.

- Ghost hunting duration: 5 seconds;<br>
Duration in seconds of the time the ghost is in hunting mode when seeing the player.

- Ghost hunting multiplier: 3;<br>
Multiplier of the distance that the ghost needs to be from the player to be able to see them, where the initial value is 3 times a grid (32 pixels), that is, 96 pixels for each direction.


**From level 03:**
- Increases the default hunting time by 1 second, so the new hunting time is 6 seconds;
- Increases the ghost's sight distance multiplier by 1 unit, so the new sight distance is 128 pixels;

**From level 05:**
- Increases walking speed by 0.5, so the new ghost speed will be 1.5;
- Increases hunting speed by 0.5, so the new ghost speed will be 2.5;

**From level 07**
- Increases the default hunting time by 2 seconds, so the new hunting time is 7 seconds;
- Increases the ghost's sight distance multiplier by 2 units, so the new sight distance is 160 pixels;

**From level 09:**
- Increases walking speed by 1, so the new ghost speed will be 2;
- Increases hunting speed by 1, so the new ghost speed will be 3;

**Level 10:**
- Increases the default hunting time by 3 seconds, so the new hunting time is 8 seconds;
- Increases the ghost's sight distance multiplier by 3 units, so the new sight distance is 192 pixels;

---

### Game High Scores
Save and display game high scores upon reaching game over.

![game_over](https://user-images.githubusercontent.com/71052352/162502815-20c7e750-ed25-4378-a658-c040b7380ba5.gif)

---

### Screenshots
![screenshots](https://user-images.githubusercontent.com/71052352/162550749-143fb197-a4a8-4ed9-b6bd-b80709b3a300.png)


---

### Link to Download Executable
[Pacman.zip](https://github.com/NycolasFelipe/pacman-project/files/8439165/Pacman.zip)

---

### Thank you for your time!
