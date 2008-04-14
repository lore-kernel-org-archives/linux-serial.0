From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] avr32: add include/asm-avr32/serial.h
Date: Mon, 14 Apr 2008 22:56:17 +0100
Message-ID: <20080414225617.5d41a13b@core>
References: <20080414141721.GI6695@cs181133002.pp.htv.fi>
	<20080414153625.6150e999@core>
	<20080414184220.GC6695@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35163 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752171AbYDNWAv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2008 18:00:51 -0400
In-Reply-To: <20080414184220.GC6695@cs181133002.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: hskinnemoen@atmel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> 7beddb9fe7aee73227a9796a039cee9583cecc0a diff --git a/include/asm-avr32/serial.h b/include/asm-avr32/serial.h
> new file mode 100644
> index 0000000..5ecaebc
> --- /dev/null
> +++ b/include/asm-avr32/serial.h
> @@ -0,0 +1,13 @@
> +#ifndef _ASM_SERIAL_H
> +#define _ASM_SERIAL_H
> +
> +/*
> + * This assumes you have a 1.8432 MHz clock for your UART.
> + *
> + * It'd be nice if someone built a serial card with a 24.576 MHz
> + * clock, since the 16550A is capable of handling a top speed of 1.5
> + * megabits/second; but this requires the faster clock.
> + */
> +#define BASE_BAUD (1843200 / 16)
> +
> +#endif /* _ASM_SERIAL_H */

Acked-by: Alan Cox <alan@redhat.com>
