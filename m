From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Sun, 8 Jan 2017 00:06:24 +0100
Message-ID: <20170107230624.GA21729@archie.localdomain>
References: <20170104160024.GA13442@archie.localdomain>
 <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
 <20170106225026.GA3804@archie.localdomain>
 <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
 <20170107134557.GA12299@archie.localdomain>
 <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
 <20170107153434.GA13307@archie.localdomain>
 <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
 <20170107205930.GA12367@archie.localdomain>
 <CAOMZO5D00YFLS=pddAqPo_FUoP6MF-juAef2H71-Wx_NQArdpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5D00YFLS=pddAqPo_FUoP6MF-juAef2H71-Wx_NQArdpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

On Sat, Jan 07, 2017 at 07:43:48PM -0200, Fabio Estevam wrote:
> Hi Clemens,
> 
> On Sat, Jan 7, 2017 at 6:59 PM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> 
> > Great!
> >
> > Did you observe the same effect I described, with the doubling of
> > characters in the front and the leftovers from previous transmissions at
> > the end?
> 
> No, I don't observe these errors when I use 'rts-gpios' in the device tree.
> 
> Maybe you could try to use 'rts-gpios' for a quick test by applying
> the patches I have just sent.
> 
> If you run this test, please remove 'uart-has-rtscts' from your dts.
> According to Documentation/devicetree/bindings/serial/serial.txt they
> are mutually-exclusive.

Just remuxed GPIO signals to these pads, applied your two patches and
used rts-gpios in the DT but I still see the same problem :/

When transmit something, I get doubled characters, then zeros and at the
end garbled data of previous transmissions, same as described in my
first post (Logic analyzer: https://pqgruber.com/rs485_results.png)
The data is always 4096 bytes long, this explains why the echo command
is blocking for about 4 seconds (<- 4096 bytes at a baudrate of 9600).
The TE line is also high until all 4096 bytes are sent.

I think this comes from the UART_XMIT_SIZE which is defined to the page
size.
Maybe there is something wrong in imx_transmit_buffer and leads to the
whole circular buffer being sent out all the time, not stopping..

Do these debug logs tell you anything?
https://gist.github.com/clemensg/1ac5ee8a8ea32acc9145c5aa8407aea5

I am analyzing the signals coming directly from the i.MX6Q, so this must
be a software problem, but I don't understand why it works for you, if
we use the same software.

Do you use any other patches on top of mainline and do you use the SDMA
scripts from the ROM?

Thanks,
Clemens
