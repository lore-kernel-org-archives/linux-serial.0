From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] tty/serial: atmel: fix fractional baud rate computation
Date: Thu, 22 Sep 2016 11:43:08 +0200
Message-ID: <20160922114308.0913c60e@bbrezillon>
References: <20160921104414.16241-1-nicolas.ferre@atmel.com>
        <20160922070746.65nzezj3fwunu55s@pengutronix.de>
        <20160922093904.5b738ad6@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160922093904.5b738ad6@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, aystarik@gmail.com, Ludovic Desroches <ludovic.desroches@atmel.com>, richard.genoud@gmail.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, 22 Sep 2016 09:39:04 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Thu, 22 Sep 2016 09:07:46 +0200
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > On Wed, Sep 21, 2016 at 12:44:14PM +0200, Nicolas Ferre wrote:  
> > > From: Alexey Starikovskiy <aystarik@gmail.com>
> > > 
> > > The problem with previous code was it rounded values in wrong
> > > place and produced wrong baud rate in some cases.
> > > 
> > > Signed-off-by: Alexey Starikovskiy <aystarik@gmail.com>
> > > [nicolas.ferre@atmel.com: port to newer kernel and add commit log]
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  drivers/tty/serial/atmel_serial.c | 10 ++++++----
> > >  include/linux/atmel_serial.h      |  1 +
> > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> > > index 5f550d9feed9..fd8aa1f4ba78 100644
> > > --- a/drivers/tty/serial/atmel_serial.c
> > > +++ b/drivers/tty/serial/atmel_serial.c
> > > @@ -2170,13 +2170,15 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
> > >  	 * accurately. This feature is enabled only when using normal mode.
> > >  	 * baudrate = selected clock / (8 * (2 - OVER) * (CD + FP / 8))
> > >  	 * Currently, OVER is always set to 0 so we get
> > > -	 * baudrate = selected clock (16 * (CD + FP / 8))
> > > +	 * baudrate = selected clock / (16 * (CD + FP / 8))
> > > +	 * then
> > > +	 * 8 CD + FP = selected clock / (2 * baudrate)
> > >  	 */
> > >  	if (atmel_port->has_frac_baudrate &&
> > >  	    (mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_NORMAL) {
> > > -		div = DIV_ROUND_CLOSEST(port->uartclk, baud);
> > > -		cd = div / 16;
> > > -		fp = DIV_ROUND_CLOSEST(div % 16, 2);
> > > +		div = DIV_ROUND_CLOSEST(port->uartclk, baud * 2);
> > > +		cd = div >> 3;
> > > +		fp = div & ATMEL_US_FP_MASK;    
> > 
> > given baud = 115200 and uartclk = 5414300 this results in:
> > 
> > 	div = DIV_ROUND_CLOSEST(5414300, 115200 * 2) = 23
> > 	cd = 2
> > 	fp = 7  
> 
> How about:
> 
> 	div = DIV_ROUND_CLOSEST(port->uartclk, baud);
> 	cd = div / 16;
> 	fp = (div % 16) / 2;
> 
> 	best_baud = port->uartclk / ((16 * cd) +  (8 * fp));
> 
> 	/* Check if we can get a better approximation by rounding up. */
> 	if (div % 2) {
> 		int alt_baud, alt_fp, alt_cd;
> 
> 		alt_fp = fp++;
> 		alt_cd = cd;
> 		if (alt_fp > 7) {
> 			alt_cd++;
> 			alt_fp = 0;
> 		}
> 
> 		alt_baud = port->uartclk / ((16 * alt_cd) +  (8 *alt_fp));
> 		if (abs(best_baud - baud) > abs(alt_baud - baud)) {

After a lengthy discussion that happened on IRC (#armlinux), Uwe
proved me wrong. This should actually be


		/*
		 * Calculate the Error in the time domain:
		 * Error = (RealBaudPeriod - ExpectedBaudPeriod) /
		 *	   ExpectedBaudPeriod;
		 *
		 * which after conversion to the frequency domain gives:
		 * Error = 1 - (ExpectedBaudRate/RealBaudRate);
		 *
		 * and since we want to compare 2 errors and avoid
		 * approximation, we have:
		 *
		 * if (RealBaudRate2 * (RealBaudRate1 - ExpectedBaudRate) <
		 *     RealBaudRate1 * (RealBaudRate2 - ExpectedBaudRate))
		 *	...
		 * 
		 */
		if (alt_baud * abs(best_baud - baud) >
		    best_baud * abs(alt_baud - baud))

Thanks for your patience ;-).

> 			best_baud = alt_baud;
> 			fp = alt_fp;
> 			cd = alt_cd;
> 		}
> 	}
> 
> > 
> > which yields a rate of 5414300 / 46 = 117702.17. With cd = 3 and fp = 0
> > however the resulting rate is 5414300 / 48 = 112797.92.
> > 
> > Which one is better?
> >   
> > >  	} else {
> > >  		cd = uart_get_divisor(port, baud);
> > >  	}
> > > diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
> > > index f8e452aa48d7..bd2560502f3c 100644
> > > --- a/include/linux/atmel_serial.h
> > > +++ b/include/linux/atmel_serial.h
> > > @@ -119,6 +119,7 @@
> > >  #define ATMEL_US_BRGR		0x20	/* Baud Rate Generator Register */
> > >  #define	ATMEL_US_CD		GENMASK(15, 0)	/* Clock Divider */
> > >  #define ATMEL_US_FP_OFFSET	16	/* Fractional Part */
> > > +#define ATMEL_US_FP_MASK	0x7    
> > 
> > Is there another user of this header? If not, this can be folded into
> > the driver.
> > 
> > Best regards
> > Uwe
> >   
> 
