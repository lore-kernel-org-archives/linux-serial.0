From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCHv4 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Tue, 4 Oct 2016 09:25:25 +0200
Message-ID: <20161004072525.josgoglunmvufcn2@pengutronix.de>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
 <20160930085801.21497-3-richard.genoud@gmail.com>
 <20160930091230.qzd42qnelylmkqxe@pengutronix.de>
 <CACQ1gAgE+BvteH9y62PcRx_tA9_e2X11RCJ12PC98FK+5z98QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACQ1gAgE+BvteH9y62PcRx_tA9_e2X11RCJ12PC98FK+5z98QQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 30, 2016 at 01:04:28PM +0200, Richard Genoud wrote:
> 2016-09-30 11:12 GMT+02:00 Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
> > Hello Richard,
> >
> > On Fri, Sep 30, 2016 at 10:58:00AM +0200, Richard Genoud wrote:
> >> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> >> hardware handshake is enabled") broke the hardware handshake when GPIOs
> >> were used.
> >>
> >> Hardware handshake with GPIOs used to work before this commit because
> >> the CRTSCTS flag (termios->c_cflag) was set, but not the
> >> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
> >> enabled, but not handled by the controller.
> >
> > What does the HWHS flag control? What if only RTS is a gpio and CTS is
> > not? Or the other way round?
> First, HWHS flag is used only in SAMA5D2. (if I correctly understood
> Atmel HW guys,
> all other platforms (sam9, sam9x5, sama5d3...) have this flag, but it
> is unusable,
> because they don't have Fifos nor PDC).
> So, on SAMA5D2, the HWHS flag tells the controller to drive the RTS
> pin according to
> the number of char present in the rx fifo (cf Figure 44-29 §44.7.3.15 p.1438 of
>  http://www.atmel.com/Images/Atmel-11267-32-bit-Cortex-A5-Microcontroller-SAMA5D2_Datasheet.pdf).
> The controller will also start/stop the transmission on CTS changes.
> But, as I haven't got this hard, I couldn't test it. (but Cyrille did I guess).
> With this flag set, It's mandatory to have CTS and RTS not handled via
> GPIO, because if
> they were, the controller couldn't, well, control them.

Assuming the respective pin doesn't reach the hardware both are no
problem though. And it would keep the driver simpler to just ignore
this. There would be no need for patch 1 and also this patch could be
dropped. So I guess there is really something to fix, otherwise you
wouldn't start patching the driver. But I don't understand the issue, so
I'd like to have a better picture.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
