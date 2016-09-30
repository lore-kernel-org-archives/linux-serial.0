From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv4 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Fri, 30 Sep 2016 13:16:06 +0200
Message-ID: <20160930111606.zcain6i4nsujsg5s@piout.net>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
 <20160930085801.21497-3-richard.genoud@gmail.com>
 <20160930091230.qzd42qnelylmkqxe@pengutronix.de>
 <CACQ1gAgE+BvteH9y62PcRx_tA9_e2X11RCJ12PC98FK+5z98QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACQ1gAgE+BvteH9y62PcRx_tA9_e2X11RCJ12PC98FK+5z98QQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 30/09/2016 at 13:04:28 +0200, Richard Genoud wrote :
> Anyway, the problematics setups are all the setups with USMODE_HWHS
> enabled on platform without Fifos or PDC,
> i.e. all platforms but sama5d2 (Cyrille, correct me if I'm wrong).
> 

This is a wrong assumption, at91rm9200 to at91sam9g45 all have a pdc.
Please, don't break those platforms.

The only affected platforms are sam9x5, sama5d3 and sama5d4.

> For instance, on sam9x5, if DMA is used, USMODE_HWHS enabled and
> RTS/CTS NOT muxed as GPIOS,
> it's like there was no flow control at all (the CTS pin doesn't
> disable the transmitter).
> 
> Since atmel HW guys said that USMODE_HWHS is broken for platforms !sama5d2,
> (cfhttps://lkml.org/lkml/2016/9/7/598 ),  I honestly didn't dig any
> further into that flag.
> 
> 
> Regards,
> Richard

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
