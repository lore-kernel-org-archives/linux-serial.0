From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] serial: imx: fix cached UCR2 read on software reset
Date: Thu, 7 Jun 2018 09:56:33 +0200
Message-ID: <20180607075633.y3tm245jv7nkdrqx@pengutronix.de>
References: <20180420124407.12892-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420124407.12892-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, festevam@gmail.com, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 20, 2018 at 02:44:07PM +0200, Stefan Agner wrote:
> To reset the UART the SRST needs be cleared (low active). According
> to the documentation the bit will remain active for 4 module clocks
> until it is cleared (set to 1).
> 
> Hence the real register need to be read in case the cached register
> indicates that the SRST bit is zero.
> 
> This bug lead to wrong baudrate because the baud rate register got
> restored before reset completed in imx_flush_buffer.
> 
> Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

For the record, there is a customer of mine who reports that this commit
breaks rs485 communication on i.MX25 because RTS stops to toggle as
intended.

(Some details: uart3, fsl,uart-has-rtscts, fsl,dte-mode,
linux,rs485-enabled-at-boot-time, native RTS.)

I didn't debug this yet.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
