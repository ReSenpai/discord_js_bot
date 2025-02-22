const black_jack = require('engine-blackjack');
const actions = black_jack.actions;
const Game = black_jack.Game;
const prompt = require('prompt-sync')({sigint: true});

function visualizeCart(cart) {
    let suite = '';
    switch(cart.suite) {
        case 'diamonds':
            suite = '♦';
            break;
        case 'hearts':
            suite = '♥';
            break;
        case 'clubs':
            suite = '♣';
            break;
        case 'spades':
            suite = '♠';
            break;
    }
    return `${suite}${cart.text}`;
}

function visualizeHand(hand) {
    hand_text = '';
    for(let cart of hand) {
        hand_text += visualizeCart(cart) + ' ';
    }
    return hand_text.slice(0, -1);;
}

function getHandScore(hand) {
    let score = 0;
    for(let cart of hand) {
        score += cart.value;
    }
    return score;
}

const game = new Game();
while(true) {
    let state = game.getState();
    // console.log('==========================================================');
    // console.dir(state);
    console.log('==========================================================');
    console.log(`stage: ${state.stage}`);
    console.log(`Your bet is ${state.finalBet?state.finalBet:state.initialBet}`)
    let yourHand = state.handInfo.right.cards;
    let dealerHand = state.dealerCards
    if(dealerHand) {
        console.log(`Dealer hand (${getHandScore(dealerHand)}): `)
        console.log(visualizeHand(dealerHand));
    }
    if(yourHand) {
        console.log(`Your hand (${getHandScore(yourHand)}): `)
        console.log(visualizeHand(yourHand));
    }
    if(state.stage === 'done') {
        console.log(`GAME HAS ENDED YOUR REWARD IS ${state.wonOnRight}$`);
        break;
    }

    const message = prompt('Your turn: ');
    cmd = message.split(' ');
    switch(cmd[0]) {
        // раздать карты
        case 'deal':
            if(cmd.length === 2 && parseInt(cmd[1]) > 0)
                game.dispatch(actions.deal({ bet: parseInt(cmd[1]), sideBets: { luckyLucky: 0 } }))
            else
                console.log('incorrect ammount');
            break;
        // забрать пол ставки и сдаться
        case 'surrender':
            game.dispatch(actions.surrender());
            break;
        // взять карту
        case 'hit':
            game.dispatch(actions.hit('right'));
            break;
        // больше карт не нужно
        case 'stand':
            game.dispatch(actions.stand('right'));
            break;
        // удвоить ставку после разлачи
        case 'double':
            game.dispatch(actions.double('right'));
            break;
        // застраховать руку, если диллеру пришел туз первой картой
        case 'insurance':
            if(cmd.length === 2 && parseInt(cmd[1]) >= 0)
                game.dispatch(actions.insurance(parseInt(cmd[1])));
            else
                console.log('incorrect ammount');
            break;
    }
}