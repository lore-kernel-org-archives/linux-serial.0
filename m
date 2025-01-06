Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05F17108A;
	Mon,  6 Jan 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147983; cv=none; b=BBKb8VvqvMdxbcCg9DiPGSYzzFZ42Orhx0bm/PgbAolaOi55RZy3Ofxv6VXGd29G6m9exjEQ9kY4t4pnhMc4ojj6U6Oob6HMOz7flAogpkAIGR+Vbny2HecwwbB+N5J5caHt8G42IeVOwF/FRTsWZJI6gTdoqznlSHGw+4T+heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147983; c=relaxed/simple;
	bh=B3efo318cw9eVa3HfJbCZ+pQV/Z1U+8yRtV6EtP5h6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBrQ/z6jUkk+2gDwaXRQX4h/qPdzNvxpqi/ntUqYPUvjCvwYmpltCfp35c03ih3vPu67kENOAfHmAc4+1D2GjqjrARCpDH0HWkGrlE6+hXwLhR4hB+E3ZbrnmChDQh4K7dCzpvhyo1kkBxEnkuVCHKtb5KYSoU/HqcgkQtYd0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lluWa7jO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lluWa7jO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD2C4CED2;
	Mon,  6 Jan 2025 07:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736147982;
	bh=B3efo318cw9eVa3HfJbCZ+pQV/Z1U+8yRtV6EtP5h6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lluWa7jO0Hx3y2qzhwNUVZGalEFfFV6YO9woS1LLIkEaS/UB3G3f7UMXl4JlXyNVn
	 oMC3q6Y1b0DO5GwtE4jVWTCH4wzNRnz1LDalbf6QwE8HzWlSTVjhi9a+egUpv6dBpp
	 r0w5/H2qQzhoJzq/yd+6CKAECmvqqbnRxjAYY8l5munilICXRd0QD0RS+b8H/7/Jmw
	 yTs5eJLw4sK/veWttwZQelQkff3FSO/ibT9HG+OHFGAtF5C+ZeNSUkIP/7aAXq7cQi
	 mudbMn3hJkXQFiz/Vb4mQQ6YyJfusPBGTyVk1LNlF+OmeMMiw/MCuzTLINKQlc4fXY
	 IHw3NdUis9iog==
Date: Mon, 6 Jan 2025 08:19:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	ansuelsmth@gmail.com, lorenzo@kernel.org
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Message-ID: <cztvjlvaif4bh6xhd6ttbrbx2px7nebfwh4nuga4dz6wpz3oz3@cz75csyt2gfd>
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250105131147.2290237-3-benjamin.larsson@genexis.eu>

On Sun, Jan 05, 2025 at 02:11:47PM +0100, Benjamin Larsson wrote:
> Support for Airoha AN7581 SoC UART and HSUART baud rate
> calculation routine.
> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> ---
>  drivers/tty/serial/8250/8250_airoha.c | 85 +++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_of.c     |  2 +
>  drivers/tty/serial/8250/8250_port.c   | 26 ++++++++
>  drivers/tty/serial/8250/Kconfig       | 10 ++++
>  drivers/tty/serial/8250/Makefile      |  1 +
>  include/linux/serial_8250.h           |  1 +
>  include/uapi/linux/serial_core.h      |  6 ++
>  include/uapi/linux/serial_reg.h       |  9 +++
>  8 files changed, 140 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_airoha.c
> 
> diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
> new file mode 100644
> index 000000000000..c57789dcc174
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_airoha.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Airoha UART driver.
> + *
> + * Copyright (c) 2025 Genexis Sweden AB
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + */
> +
> +#include <linux/clk.h>

Where is it used?

> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>

Where is it used?

> +#include <linux/of_platform.h>

Where is it used?

> +#include <linux/pinctrl/consumer.h>

I have impression that none of these are used. You include some huge
amount of unused headers.

> +#include <linux/platform_device.h>

???

> +#include <linux/pm_runtime.h>

I really cannot find it.

> +#include <linux/serial_8250.h>
> +#include <linux/serial_reg.h>
> +#include <linux/console.h>
> +#include <linux/dma-mapping.h>

Where do you use DMA?

> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>

Any of these?

> +
> +#include "8250.h"
> +
> +/* The Airoha UART is 16550-compatible except for the baud rate calculation.
> + *
> + * crystal_clock = 20 MHz
> + * xindiv_clock = crystal_clock / clock_div
> + * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
> + * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
> + *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
> + *
> + * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
> + *
> + * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
> + * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 give even values
> + * for usual baud rates.
> + *
> + * Selecting divider needs to fulfill
> + * 1.8432 MHz <= xindiv_clk <= APB clock / 2
> + * The clocks are unknown but a divider of value 1 did not result in a valid
> + * waveform.
> + *
> + */
> +
> +#define CLOCK_DIV_TAB_ELEMS 3

No, use ARRAY_SIZE in your code.

> +#define XYD_Y 65000
> +#define XINDIV_CLOCK 20000000

And what if input clock has different rate?

> +#define UART_BRDL_20M 0x01
> +#define UART_BRDH_20M 0x00

Blank line

> +static int clock_div_tab[] = { 10, 4, 2};
> +static int clock_div_reg[] = {  4, 2, 1};

Why not const?

Best regards,
Krzysztof

