Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7113C8EA
	for <linux-serial@vger.kernel.org>; Wed, 15 Oct 2025 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508899; cv=none; b=XbOdwsnY2q/CKYmywgxpfRIHKL1lF+3HKcv+gBXNRWyQnJrosi/PGwAh0poBStp8kKktV1RFi2li9Y9WyEFt8fiFJW33qDHHXBQCVfiKVPuNS5ORT+7hWXHk8ClzIGbq8RK3m0apFh5i2yxB0VEubX7z2KzWdpKAgxf0lbJE0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508899; c=relaxed/simple;
	bh=fK0L+WVgj/7bzbhpA4eddawdiPeyckRQ6QLCDhKj/h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM/cyXsV0/PFf3AGfpqQJm9kdh+NDeLUQGXlZzo/l40q/FJPdGShpUQwBFbK2i6XT1Hf0NJXih3MRshu55Je845L/wi7pbGYG3xSHwGh7gt8GvPbUl8D2hgUjLc4lPiVqlhOUb71jKdzLCEe7u35rdMMzm+3KpwKsTwZ7vlcNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfMw2WD/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfMw2WD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C0C4CEF8;
	Wed, 15 Oct 2025 06:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760508899;
	bh=fK0L+WVgj/7bzbhpA4eddawdiPeyckRQ6QLCDhKj/h8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nfMw2WD/QPPUtu3HUMYfIAuTdl2Sn180hTro7G9eOYJkscINCZCMzNCjKfisoUdRr
	 dBOqtaZzDXkSo1xOdgdJAgOoTvfTKuNAVffzbR963/E8z5W2qKq1wsxrCcOp1gehip
	 zdtWP0PWV1G8pCqf+N2up/E5PFBizVi6Awg6w2QQyOKfo1mso8GEhzCcxGWwCb63x6
	 iDClyP/adCzAcBy79sRaGEH2LBpfbpaOB1SLhjlhNpanheUwJkLdXkR34klK0EWOqA
	 MRJdhMNtdcmLpgqoNjE0Ca4lFfv6dKi+mhNeM883L34lCkimR4KA8TTb01S3eaWBAT
	 1mjdlVxCuqNJA==
Message-ID: <01ea9c8b-08cb-40d0-b550-12eb60e515ab@kernel.org>
Date: Wed, 15 Oct 2025 08:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: 8250: add driver for KEBA UART
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
 linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Gerhard Engleder <eg@keba.com>,
 Daniel Gierlinger <gida@keba.com>
References: <20251014191515.75888-1-gerhard@engleder-embedded.com>
 <20251014191515.75888-3-gerhard@engleder-embedded.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20251014191515.75888-3-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 10. 25, 21:15, Gerhard Engleder wrote:
> From: Gerhard Engleder <eg@keba.com>
> 
> The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
> mostly 8250 compatible with extension for some UART modes.
> 
> 3 different variants exist. The simpliest variant supports only RS-232
> and is used for debug interfaces. The next variant supports only RS-485
> and is used mostly for communication with KEBA panel devices. The third
> variant is able to support RS-232, RS-485 and RS-422. For this variant
> not only the mode of the UART is configured, also the physics and
> transceivers are switched according to the mode.
> 
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> Tested-by: Daniel Gierlinger <gida@keba.com>
> ---
>   drivers/tty/serial/8250/8250_keba.c | 279 ++++++++++++++++++++++++++++
>   drivers/tty/serial/8250/Kconfig     |  13 ++
>   drivers/tty/serial/8250/Makefile    |   1 +
>   3 files changed, 293 insertions(+)
>   create mode 100644 drivers/tty/serial/8250/8250_keba.c
> 
> diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/8250/8250_keba.c
> new file mode 100644
> index 000000000000..e1dccc0e1026
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_keba.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 KEBA Industrial Automation GmbH
> + *
> + * Driver for KEBA UART FPGA IP core
> + */
> +
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/misc/keba.h>
> +
> +#include "8250.h"
> +
> +#define KUART "kuart"
> +
> +/* flags */
> +#define KUART_RS485		0x00000001
> +#define KUART_USE_CAPABILITY	0x00000002

use BIT()

> +/* registers */
> +#define KUART_VERSION		0x0000
> +#define KUART_REVISION		0x0001
> +#define KUART_CAPABILITY	0x0002
> +#define KUART_CONTROL		0x0004
> +#define KUART_BASE		0x000C
> +#define KUART_REGSHIFT		2
> +#define KUART_CLK		1843200
> +
> +/* mode flags */
> +#define KUART_MODE_NONE		0
> +#define KUART_MODE_RS485	1
> +#define KUART_MODE_RS422	2
> +#define KUART_MODE_RS232	3

Use enum.

> +/* capability flags */
> +#define KUART_CAPABILITY_NONE	(1<<KUART_MODE_NONE)
> +#define KUART_CAPABILITY_RS485	(1<<KUART_MODE_RS485)
> +#define KUART_CAPABILITY_RS422	(1<<KUART_MODE_RS422)
> +#define KUART_CAPABILITY_RS232	(1<<KUART_MODE_RS232)

use BIT()

> +#define KUART_CAPABILITY_MASK	0x0000000f

Use GENMASK().

> +/* Additional Control Register DTR line configuration */
> +#define UART_ACR_DTRLC_MASK		0x18
> +#define UART_ACR_DTRLC_COMPAT		0x00
> +#define UART_ACR_DTRLC_ENABLE_LOW	0x10
> +
> +struct kuart {
> +	struct keba_uart_auxdev *auxdev;
> +	void __iomem *base;
> +	int line;

unsigned

> +
> +	unsigned long flags;

I would say unsigned int would be enough.

> +	u8 capability;
> +	int mode;

Use the new enum as a type.

> +};
> +
> +static void kuart_set_phy_mode(struct kuart *kuart, int mode)

enum too.

> +{
> +	iowrite8(mode, kuart->base + KUART_CONTROL);
> +}
...
> +static int kuart_rs485_config(struct uart_port *port, struct ktermios *termios,
> +			      struct serial_rs485 *rs485)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	struct kuart *kuart = port->private_data;
> +	int mode;

enum

...
> +	return 0;
> +}

Otherwise looks good.

thanks,
-- 
js
suse labs
