From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] BUG: atmel_serial: Interrupts not disabled on close
Date: Thu, 15 Sep 2016 12:33:28 +0200
Message-ID: <20160915103328.GA23118@kroah.com>
References: <20160912133441.14597-1-richard.genoud@gmail.com>
 <c98f5e6a-a971-aee1-cd9b-16a2ef36d9f8@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c98f5e6a-a971-aee1-cd9b-16a2ef36d9f8@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 12, 2016 at 05:22:58PM +0200, Nicolas Ferre wrote:
> Le 12/09/2016 à 15:34, Richard Genoud a écrit :
> > Since commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
> > provided mctrl-gpio"), interrupts from GPIOs are not disabled any more
> > when the serial port is closed, leading to an oops when the one of the
> > input pin is toggled (CTS/DSR/DCD/RNG).
> > 
> > This is only the case if those pins are used as GPIOs, i.e. declared
> > like that:
> > usart1: serial@f8020000 {
> >         /* CTS and DTS will be handled by GPIO */
> >         status = "okay";
> >         rts-gpios = <&pioB 17 GPIO_ACTIVE_LOW>;
> >         cts-gpios = <&pioB 16 GPIO_ACTIVE_LOW>;
> >         dtr-gpios = <&pioB 14 GPIO_ACTIVE_LOW>;
> >         dsr-gpios = <&pioC 31 GPIO_ACTIVE_LOW>;
> >         rng-gpios = <&pioB 12 GPIO_ACTIVE_LOW>;
> >         dcd-gpios = <&pioB 15 GPIO_ACTIVE_LOW>;
> > };
> > 
> > That's because modem interrupts used to be freed in atmel_shutdown().
> > After commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
> > provided mctrl-gpio"), this code was just removed.
> > Calling atmel_disable_ms() disables the interrupts and everything works
> > fine again.
> > 
> > Tested on at91sam9g35-cm
> > 
> > (This patch doesn't apply on -stable kernels, fixes for 4.4 and 4.7 will
> > be sent after this one is applied.)
> > 
> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > Fixes: 18dfef9c7f87 ("serial: atmel: convert to irq handling provided mctrl-gpio")
> 
> I thinks it's a bit late for "4.8-fixes".
> 
> Greg, tell me if you want that I add the Cc: stable tag to this patch
> (as advised by Uwe) and re-send?

I'll add it, no worries.

greg k-h
