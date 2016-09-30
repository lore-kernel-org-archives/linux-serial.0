From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCHv4 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Fri, 30 Sep 2016 11:12:30 +0200
Message-ID: <20160930091230.qzd42qnelylmkqxe@pengutronix.de>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
 <20160930085801.21497-3-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160930085801.21497-3-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Richard,

On Fri, Sep 30, 2016 at 10:58:00AM +0200, Richard Genoud wrote:
> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled") broke the hardware handshake when GPIOs
> were used.
> 
> Hardware handshake with GPIOs used to work before this commit because
> the CRTSCTS flag (termios->c_cflag) was set, but not the
> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
> enabled, but not handled by the controller.

What does the HWHS flag control? What if only RTS is a gpio and CTS is
not? Or the other way round?

What is the problematic setup? I guess it's RTS and CTS are gpios and
with that setting ATMEL_US_USMODE_HWHS is wrong? What happens if that
happens?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
