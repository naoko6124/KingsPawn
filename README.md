# King's Pawn
<<<<<<< HEAD
Jogo de estratégia em tabuleiro hexagonal com peças basedas em personagens de fantasia.
=======

A strategy game on a hexagon tile-based board with fantasy-like characters, developed for the 15th Game Jam at Facens Plugin.

## Documentation

#### Start the server

Run `start_server.bat` or manually use `server.lua` to host the game on an TCP port on your pc and pass the host and port to your friends to connect with it.

#### Using `server.lua`

```batch
  lua server.lua HOST PORT
```

| Key   | Type       | Description                           |
| :---------- | :--------- | :---------------------------------- |
| `HOST` | `string` | IP adress that the server will use. |
| `PORT` | `number` | TCP port that the server will use. |

## FAQ

#### 1. Can I play with my friends online?

Yes, if you have an open TCP port at your router, just use it on the `server.lua`. However, if you can't open a port, then we recommend using [NGROK](https://ngrok.com) to reverse proxy front an TCP port.

#### 2. Can I play with less than four players?

At the time, no. We're still working to make possible to play with less than four players.

#### 3. Can the server host multiple matches?

At the time, no. We're still working on multiple threads to run more than one match. (You can still do it with the current code, but if two players try to do a movement at the same time it'll much likely cause an overload on the server and one of them will fail!)

>>>>>>> 8cb6456da1b76d90bfc175e424fd4ca6a558c290
