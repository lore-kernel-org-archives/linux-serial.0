From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: [PATCH] serial: Detect XR16C2852 UARTs correctly
Date: Mon, 9 Feb 2009 08:35:23 +0100
Message-ID: <200902090835.23649.mfuchs@ma-fu.de>
References: <200812301439.52412.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:45826 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942AbZBIHf1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Feb 2009 02:35:27 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 56EF225744A
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2009 08:35:25 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 3E296510041
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2009 08:35:25 +0100 (CET)
Received: from bunny.home (dslb-088-070-083-171.pools.arcor-ip.net [88.70.83.171])
	by mail-in-07.arcor-online.net (Postfix) with ESMTPS id 0942E3CA8E3
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2009 08:35:25 +0100 (CET)
Received: from fox.localnet (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id 2FEF32510462
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2009 08:35:20 +0100 (CET)
In-Reply-To: <200812301439.52412.mfuchs@ma-fu.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

> Without this patch Exar XR16C2852 UARTs are detected
> as Motorola 8xxx DUARTs (16550A compatible).
> 
> By checking the fifo size it is possible to
> continue probing for the correct UART type.
> 
> Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
> ---
>  drivers/serial/8250.c |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 303272a..ec27086 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -782,7 +782,7 @@ static void autoconfig_has_efr(struct uart_8250_port *up)
>  	 * reading back DLL and DLM.  The chip type depends on the DLM
>  	 * value read back:
>  	 *  0x10 - XR16C850 and the DLL contains the chip revision.
> -	 *  0x12 - XR16C2850.
> +	 *  0x12 - XR16C2850 + XR16C2852.
>  	 *  0x14 - XR16C854.
>  	 */
>  	id1 = autoconfig_read_divisor_id(up);
> @@ -869,11 +869,27 @@ static void autoconfig_16550a(struct uart_8250_port *up)
>  			DEBUG_AUTOCONF("EFRv1 ");
>  			up->port.type = PORT_16650;
>  			up->capabilities |= UART_CAP_EFR | UART_CAP_SLEEP;
> +			serial_outp(up, UART_EFR, 0);
> +			return;
>  		} else {
> -			DEBUG_AUTOCONF("Motorola 8xxx DUART ");
> +			int sf = size_fifo(up);
> +			DEBUG_AUTOCONF("sf=%d ", sf);
> +			/*
> +			 * This fifo size check is needed to detect
> +			 * Exar XR16C2852 UARTs later on.
> +			 * These devices have an AFR register at
> +			 * UART_EFR's address with LCR_DLAB set.
> +			 * Because of thier 128 byte fifo we can
> +			 * skip this point of return and let
> +			 * autoconfig_has_efr() detect them later.
> +			 */
> +			if (sf != 128) {
> +				DEBUG_AUTOCONF("Motorola 8xxx DUART ");
> +				serial_outp(up, UART_EFR, 0);
> +				return;
> +			}
>  		}
>  		serial_outp(up, UART_EFR, 0);
> -		return;
>  	}
>  
>  	/*
Did any body go over my above patch from December?

Matthias
