From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] imx-serial: RX DMA startup latency
Date: Wed, 17 May 2017 12:04:18 +0200
Message-ID: <20170517100418.rvn2rajpvkpaf453@pengutronix.de>
References: <20170514123515.15794-1-peter.senna@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170514123515.15794-1-peter.senna@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Senna Tschudin <peter.senna@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, May 14, 2017 at 02:35:15PM +0200, Peter Senna Tschudin wrote:
> 18a4208 introduced a change to reduce the RX DMA latency on the first reception
> when the serial port was opened for reading. However it was claiming a hardirq
> unsafe lock after a hardirq safe lock which is not allowed and causes lockdep
> to complain verbosely.
> 
> This patch changes the code to always start RX DMA earlier, instead of
> relying on the flags used to open the serial port removing the code that
> was looking for the serial file flags.
> 
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> Tested on iMX53.

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

(on an i.MX6)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
