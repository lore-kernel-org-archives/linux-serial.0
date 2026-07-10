Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7EB3C4B9A;
	Fri, 10 Jul 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687844; cv=none; b=axIkIviCVdpUnM8En0Pad0rcCzhC2RhxXE8p0BXkeu58U0psAwmUMUNk5Ana3eLmJMO325PcNifv6F1o0fPjfqThDiN9B5Yo1y6r0y0VCtWaNL7ioi922PshuYwcXLUWNU2NCnkkeoV+marqEKDt5CoXfxu+8se3a2ORfNf/47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687844; c=relaxed/simple;
	bh=/jPsqqlALac6PFhfTzuVWjhjI7sEWc9j3QSQVhS6ovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4t+Fib05aelfrh1Z4Waa6lOh3RHHBh6Id9fNsof7PYRqXQFpCpB1J4nwZTxJ21qREC2i2pnFzTZoHPXgb7M1zD2s2NNp2/nywuIBp9aKOhXw29vE7dq5Um/CmeHNuZrWd5spsTlLprHNZW/dai9Nw0KoB3OvIUwwMAzpIKPqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sOq3XGrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sOq3XGrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA471F000E9;
	Fri, 10 Jul 2026 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783687842;
	bh=ZQVjKXupU3Cshyl/zymUwx2UW3B9sDrZKGRpJoscEXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sOq3XGrAYHUu1FNIyPvR1JCIrAQQ3IHzJ44YSJCtvdR5t64miV3wNE73v5WuzJIw+
	 AH4OXdZmCzsoACJWQNyI4e/yE0a/XsGwlROpJjLE6WkFdDEf7ERvZXWfFHsSeiRKl6
	 GgFhcrLbUaYUeq+nfxg3XKRyn9HN9b4LMBoEnHcw=
Date: Fri, 10 Jul 2026 14:50:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 00/10] serial: add new I/O type for SPI and I2C bus
 devices
Message-ID: <2026071029-repulsion-oasis-06cb@gregkh>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>

On Thu, May 21, 2026 at 02:16:46PM -0400, Hugo Villeneuve wrote:
> Hello,
> this patch series add a new I/O type for serial devices on a SPI/I2C bus,
> and a few related cleanups/improvements.
> 
> These changes are based on a suggestion [1] made by Ilpo Järvinen during
> past sc16is7xx driver patches review.
> 
> The first patches make use of uart_iotype_*() functions to simplify and
> cleanup the UART report functions.
> 
> This cleanup sets the stage to avoid displaying irrelevant MMIO or legacy
> I/O information for serial devices on I2C or SPI busses when we add the new
> UPIO_BUS type.
> 
> Tested on a imx6 board with two SC16is752 using SPI mode, and a dummy
> device-tree entry for a MAX3100:
>   dmesg -t | grep "base_baud"
>     2020000.serial: ttymxc0 MMIO:0x02020000 (irq = 197, base_baud = 5000000) is a IMX
>     21e8000.serial: ttymxc1 MMIO:0x021e8000 (irq = 198, base_baud = 5000000) is a IMX
>     spi1.0: ttySC0 (irq = 165, base_baud = 1500000) is a SC16IS752
>     spi1.0: ttySC1 (irq = 165, base_baud = 1500000) is a SC16IS752
>     spi3.0: ttySC2 (irq = 37, base_baud = 1500000) is a SC16IS752
>     spi3.0: ttySC3 (irq = 37, base_baud = 1500000) is a SC16IS752
>     spi3.1: ttyMAX0 (irq = 0, base_baud = 0) is a MAX3100
> Note that before these patches, max3100 silently failed in uart_configure_port()
> because membase/iobase/mapbase were zero.
> 
> For max310x and SC16is7xx in i2c mode, tested only that driver is properly
> registered by using i2c-stub.
> 
> Also tested on a custom board with a Renesas RZ/G2L cpu (sh-sci driver) to
> confirm there is no regression (also with earlycon):
>   dmesg -t | grep "MMIO"
>     earlycon: scif0 MMIO:0x000000001004b800 (options '115200n8')
>     1004b800.serial: ttySC0 MMIO:0x000000001004b800 (irq = 35, base_baud = 0) is a scif
>     1004bc00.serial: ttySC1 MMIO:0x000000001004bc00 (irq = 40, base_baud = 0) is a scif
> 
> Thank you.
> 
> [1] https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com/raw
> 
> Link: [v1] https://lore.kernel.org/all/20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com/
> Link: [v2] https://lore.kernel.org/all/20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com/
> 
> Changes for v3:
> - Rename uart_iotype_legacy_io() -> uart_iotype_io() (Andy)
> - Merge patches 15, 4, 5, 6, 7 and 8
> 
> Changes for v2:
> - Replace snprintf with scnprintf (Ilpo)
> - Fix alignment of : to ? (Ilpo)
> - Move hub6 match port to 8250_hub6.c (Ilpo)
> - earlycon: use uart_iotype_*()
> - 8250_rsa: use uart_iotype_*()
> - 8250_port: use uart_iotype_*() in serial_port_out_sync()
> - simplified uart_line_info() even more and remove intermediate mmio
>   variable
> - Split and rename patch serial: core: prevent irrelevant I/O infos display
>   for UPIO_BUS to serial: core: use uart_iotype_*() to simplify
>   uart_report_port() and moved before UPIO_BUS patch.
> - Add a new patch to implement a function to uniformize the display
>   of I/O infos for uart_report_port(), uart_line_info() and
>   earlycon_print_info(). If accepted could be better integrated/merged with
>   the next series submission. If not, can simply be dropped.
> - Add patch for uart_regiowidth_to_iotype()
> 
> ---
> Hugo Villeneuve (10):
>       serial: 8250_hub6: add hub6_match_port()
>       serial: core: add uart_iotype_mmio/io helper functions
>       serial: core: use uart_iotype_*() to simplify uart_match_port()
>       serial: uniformize serial port I/O infos display
>       serial: 8250: use uart_iotype_*() to simplify code
>       serial: 8250_rsa: use uart_iotype_*() to simplify code
>       serial: core: add new I/O type for SPI and I2C bus devices
>       serial: sc16is7xx: use new UPIO_BUS as iotype
>       serial: max310x: use new UPIO_BUS as iotype
>       serial: max3100: use new UPIO_BUS as iotype
> 
>  drivers/tty/serial/8250/8250.h      |   7 ++
>  drivers/tty/serial/8250/8250_hub6.c |   6 ++
>  drivers/tty/serial/8250/8250_port.c |  43 ++----------
>  drivers/tty/serial/8250/8250_rsa.c  |  40 +++++------
>  drivers/tty/serial/earlycon.c       |  17 ++---
>  drivers/tty/serial/max3100.c        |   1 +
>  drivers/tty/serial/max310x.c        |   9 +--
>  drivers/tty/serial/sc16is7xx.c      |   9 +--
>  drivers/tty/serial/serial_core.c    | 135 +++++++++++++++++++++---------------
>  include/linux/serial_core.h         |   6 ++
>  include/uapi/linux/serial.h         |   1 +
>  11 files changed, 135 insertions(+), 139 deletions(-)

Nice work, all now queued up.

greg k-h
