From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices.
Date: Wed, 3 Jul 2019 19:25:54 +0200
Message-ID: <20190703172554.GA27719@kroah.com>
References: <20190702032323.28967-1-je.yen.tam@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190702032323.28967-1-je.yen.tam@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeyentam <je.yen.tam@ni.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 01, 2019 at 08:23:23PM -0700, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 879 +++++++++++++++++++----------
>  1 file changed, 582 insertions(+), 297 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index df41397de478..0a711b895b33 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *  Probe module for 8250/16550-type PCI serial ports.
> + *	Probe module for 8250/16550-type PCI serial ports.
>   *
> - *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
> + *	Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
>   *
> - *  Copyright (C) 2001 Russell King, All Rights Reserved.
> + *	Copyright (C) 2001 Russell King, All Rights Reserved.
>   */

Why are you changing comments for no reason?
