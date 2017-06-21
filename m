From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Wed, 21 Jun 2017 16:05:56 +0200
Message-ID: <20170621140556.GA766@archie.localdomain>
References: <20170620153701.12626-1-clemens.gruber@pqgruber.com>
 <CAOMZO5Djf8OsqF=jUBo1Dkm2mw7pObxmkC=qq0U0RLZsYonXgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Djf8OsqF=jUBo1Dkm2mw7pObxmkC=qq0U0RLZsYonXgQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Fugang Duan <fugang.duan@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

On Tue, Jun 20, 2017 at 01:13:18PM -0300, Fabio Estevam wrote:
> The subject gives the impression that the DMA will only be disabled
> for RS485, but the impact of this change is wider.
> 
> For example: if I have a mx6q system with a Bluetooth serial
> connection I can no longer use DMA with your change applied.
> 
> Ideally we should fix the RS485 DMA bug. If that is not possible, then
> at least we need to restrict this change to the RS485 case.
> 
> Maybe we need to pass "linux,rs485-enabled-at-boot-time" in device
> tree and then use this property to deceide if DMA will be enabled or
> not:
> 
> if (!uart_console(port) && !sport->dma_is_inited && !sport->rs485_enabled)

I'd also prefer fixing the underlying problem.
If you take a look at the DMA parts in drivers/tty/serial/imx.c, can you
spot anything SMP-unsafe?
By the way, can you get your hands on an i.MX6Q board with RS-485 to
reproduce it?

We could try for a few more weeks to find the bug and if we don't find
it, adding this rs485-enabled-at-boot-time property sounds good!

Thanks,
Clemens
