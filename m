From: Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 2/2] serial: imx: fix endless loop during suspend
Date: Wed, 3 Jan 2018 22:43:59 +0100
Message-ID: <20180103214359.GA11695@botnar.kaiser.cx>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
 <1514395632-15390-2-git-send-email-martin@kaiser.cx>
 <CAOMZO5AvFePCoKYQe7bt9bzFmdLYrgDyPLkepz99bJk7BTB0Lg@mail.gmail.com>
 <20180102161555.GA4503@botnar.kaiser.cx>
 <CAOMZO5BVQE45W6cSaPVLkDWAvTsaR54FPWD20krKCpgdGLX3CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5BVQE45W6cSaPVLkDWAvTsaR54FPWD20krKCpgdGLX3CQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

Thus wrote Fabio Estevam (festevam@gmail.com):

> I am not able to reproduce this problem on a imx25 pdk running 4.14.11
> or linux-next.

this is no surprise. The problem shows up only if the AWAKE bit in UART
Status Register 1 is set before we go into suspend. My understanding is
that this bit will be set when the signal on the rx pin goes from high
to low. 

> Is it 100% reproducible on your board?

On my board, I have one uart port that's connected to an external chip.
A power cycle of this external chip creates the falling edge on rx and
makes the imx uart set the AWAKE bit. The problem can then be reproduced
100%.

It can be argued that this is an obscure scenario, but nevertheless, it
should not put the kernel into an endless loop.

This is my understanding of what happens:
- AWAKE is set in the USR1 register
- there's no uart transfer running, the clocks are disabled
   (As I write this I'm not sure why this is the case, clk_ipg should
    still be enabled but it seems that it's not. If I enable it
    manually, the behaviour is different.)
- we enter suspend
- AWAKEN (UART control register 3) is set so that AWAKE creates an interrupt
- we get an interrupt immediately
   (the imx interrupt is not yet disabled at this point. it'll be
    disabled later and then reenabled if the uart port acts as a wakeup
    source)
   -> we get into the interrupt handler with the clocks disabled
- the interrupt handler tries to clear the AWAKE bit, this does not work
  since the clocks are off, we exit and AWAKE is still set
- we get another interrupt immediately
   -> endless loop

What I'm trying to do with my patch is to clear the AWAKE bit before we
set AWAKEEN. We don't want to be woken up by events that happened before
we started going into suspend.

To do this, I have to find a suitable place where the clocks are
enabled. That's why I tried to move clearing AWAKE and setting AWAKEEN
into suspend_noirq, where the clocks are already enabled to save all
registers before we finally suspend. While this works ok on my board, it
cuases problems on imx6q.

I'm not sure what makes my patch fail for you. I could imagine it is
because now, the imx interrupt is enabled (as a wakeup source) before
AWAKEN is set. The current code sets AWAKEN first and then enables the
interrupt for the wakeup source.

I'll try a different approach that keeps this order.

> Care to share its dts? Do you use multiple UART ports? Do any of them
> use RTS/CTS?

There's nothing special regarding the uarts, There's a couple of them,
none of which are using rts/cts.

It all depends on the awake bit.

Best regards,

   Martin
