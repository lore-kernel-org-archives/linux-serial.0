From: Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()
Date: Fri, 4 Oct 2019 20:12:56 -0400
Message-ID: <20191004201256.GB32368@t480s.localdomain>
References: <20191004215537.5308-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004215537.5308-1-andrew.smirnov@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Andrew Lunn <andrew@lunn.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Andrey,

On Fri,  4 Oct 2019 14:55:37 -0700, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Fix incorrect read-modify-write sequence in lpuart_flush_buffer() that
> was reading from UARTPFIFO and writing to UARTCFIFO instead of
> operating solely on the latter.
> 
> Fixes: 9bc19af9dacb ("tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

This fixes the TTY on my ZII Devel Boards Rev B and C:

Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
Tested-by: Vivien Didelot <vivien.didelot@gmail.com>


Thank you!

	Vivien
