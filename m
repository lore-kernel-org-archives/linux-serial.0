From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] tty/serial: atmel: remove
 atmel_default_console_device handling
Date: Fri, 23 Jun 2017 11:01:36 +0200
Message-ID: <20170623090136.mblnokm3f2twurwq@pengutronix.de>
References: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 13, 2017 at 10:24:38PM +0200, Alexandre Belloni wrote:
> atmel_default_console_device was only used by AVR32, in particular
> arch/avr32/mach-at32ap/at32ap700x.c which is now gone. Remove it from the
> driver.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
I found the same change independently, but as you were there first:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
