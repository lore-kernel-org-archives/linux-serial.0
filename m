From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Sun, 8 Jan 2017 19:06:09 +0100
Message-ID: <20170108180609.GB24155@archie.localdomain>
References: <20170106225026.GA3804@archie.localdomain>
 <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
 <20170107134557.GA12299@archie.localdomain>
 <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
 <20170107153434.GA13307@archie.localdomain>
 <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
 <20170107205930.GA12367@archie.localdomain>
 <CAOMZO5D00YFLS=pddAqPo_FUoP6MF-juAef2H71-Wx_NQArdpw@mail.gmail.com>
 <20170107230624.GA21729@archie.localdomain>
 <CAOMZO5DedNURGV_k5Y=nt1O98SojsvrOd69PEPEzi8F7N3dJuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DedNURGV_k5Y=nt1O98SojsvrOd69PEPEzi8F7N3dJuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

On Sun, Jan 08, 2017 at 12:30:24AM -0200, Fabio Estevam wrote:
> Hi Clemens,
> 
> On Sat, Jan 7, 2017 at 9:06 PM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> 
> > Just remuxed GPIO signals to these pads, applied your two patches and
> > used rts-gpios in the DT but I still see the same problem :/
> >
> > When transmit something, I get doubled characters, then zeros and at the
> > end garbled data of previous transmissions, same as described in my
> > first post (Logic analyzer: https://pqgruber.com/rs485_results.png)
> > The data is always 4096 bytes long, this explains why the echo command
> > is blocking for about 4 seconds (<- 4096 bytes at a baudrate of 9600).
> > The TE line is also high until all 4096 bytes are sent.
> >
> > I think this comes from the UART_XMIT_SIZE which is defined to the page
> > size.
> > Maybe there is something wrong in imx_transmit_buffer and leads to the
> > whole circular buffer being sent out all the time, not stopping..
> >
> > Do these debug logs tell you anything?
> > https://gist.github.com/clemensg/1ac5ee8a8ea32acc9145c5aa8407aea5
> >
> > I am analyzing the signals coming directly from the i.MX6Q, so this must
> > be a software problem, but I don't understand why it works for you, if
> > we use the same software.
> >
> > Do you use any other patches on top of mainline and do you use the SDMA
> > scripts from the ROM?
> 
> No, I use the original 4.9 + the two patches I sent. Yes, I do use the
> SDMA scripts from ROM.
> 
> Here is the procedure I did to try to reproduce the issue you reported:
> 
> (The rs485conf is available at:
> https://github.com/mniestroj/rs485conf/blob/master/main.c )
> 
> First of all I enable rs485 for ttymxc3 using the rs485conf application:
> 
> root@imx6qsabresd:/home# ./rs485conf  /dev/ttymxc3 -e 1
> [   27.106517] random: crng init done
> = Current configuration:
> RS485 enabled:                false
> RTS on send:                  high
> RTS after send:               low
> RTS delay before send:        0
> RTS delay after send:         0
> Receive during sending data:  true
> 
> = New configuration:
> RS485 enabled:                true
> RTS on send:                  high
> RTS after send:               low
> RTS delay before send:        0
> RTS delay after send:         0
> Receive during sending data:  true
> 
> = Saved configuration:
> RS485 enabled:                true
> RTS on send:                  high
> RTS after send:               low
> RTS delay before send:        0
> RTS delay after send:         0
> Receive during sending data:  true
> root@imx6qsabresd:/ho
> 
> Then
> 
> root@imx6qsabresd:/home# echo A > /dev/ttymxc3
> 
> (wait 10 seconds)
> 
> root@imx6qsabresd:/home# echo B > /dev/ttymxc3
> 
> (wait 10 seconds)
> 
> root@imx6qsabresd:/home# echo C > /dev/ttymxc3
> 
> On the serial console at 9600bps only the:
> A
> B
> C
> 
> are seen, so not duplicated characters, nor noise is seen on the console.

I just did the experiment with your configuration and the rs485conf tool
you mentioned.
But still, no luck :(

What's the revision of the i.MX6Q on your board? Mine is 1.5 (TO 1.3)

Another example: If I run the following on the board..

while true; do
  echo ABCDEFGHIJKLM > /dev/ttymxc4
  sleep 0.5
  echo abc > /dev/ttymxc4 > /dev/ttymxc4
  sleep 0.5
done

Many transmits contain garbled (doubled and sometimes also extended to
a length of 4096 bytes, containing zeros) data.
I can see a few transmissions that are sent correctly, though.

Interesting side note: With the following patch, the problems disappear:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 451e50f6d77a..eb9f0ce6c34a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1270,8 +1270,10 @@ static int imx_startup(struct uart_port *port)
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
 	/* Can we enable the DMA support? */
+#if 0
 	if (!uart_console(port) && !sport->dma_is_inited)
 		imx_uart_dma_init(sport);
+#endif
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	/* Reset fifo's and state machines */
--

Regards,
Clemens
