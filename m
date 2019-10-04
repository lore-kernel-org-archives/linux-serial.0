From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()
Date: Sat, 5 Oct 2019 00:53:59 +0200
Message-ID: <20191004225359.GE3817@lunn.ch>
References: <20191004215537.5308-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004215537.5308-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Agner <stefan@agner.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 04, 2019 at 02:55:37PM -0700, Andrey Smirnov wrote:
> Fix incorrect read-modify-write sequence in lpuart_flush_buffer() that
> was reading from UARTPFIFO and writing to UARTCFIFO instead of
> operating solely on the latter.
> 
> Fixes: 9bc19af9dacb ("tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
