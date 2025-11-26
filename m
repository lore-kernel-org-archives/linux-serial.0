Received: from mx05lb.world4you.com (mx05lb.world4you.com [81.19.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF422E228C
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194733; cv=none; b=JuvJDe6RJWozKByYouX4r87lBVDLmBLL2rXcNMAxN8FoNKLl+0wUtefmI9t/dT53P/3z++Qzwq07o9eQ7kr7WJkyGAt67XQo7q4BQEriTSC/Yz0BIaO0WMYFHrtfbRcbYTB+05FJ4ar5V/finorrA1tKccMFmFKRUNGRjLvEMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194733; c=relaxed/simple;
	bh=cwb50hWHXXXYh0hB2g+VdutJEGlOlVvOj2HjVMOFPkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCUN7Jo7FzjZsE1mTZVKlYWV0kUNE1cVPfkBeGZJq2Tq2ZL15/xrVqTo35jTYm24TGV3S0SZzurROF2uSTcpz1FGCccm69D2PPvZhXXwwTBFi3uYwztlxmqTB9rSGPscs9oYp+YeX8dd/U5f0PkhngICZNCd7IBBMKF3LZbZr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=t6AaKJvt; arc=none smtp.client-ip=81.19.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="t6AaKJvt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DGmPzWEQYvbyS/Qga/juhtfLR+VduMu4bcH8jNn1yp0=; b=t6AaKJvts3H3lhpzQCCU3K/eyt
	SUW9p3QwoBXQp1QNBNXS94k8PiR6AS7QUm2TUHI1VbXHcPJkiWviCOCga3/mDxol+SN/5GCDjeKDs
	froZvtwXrWX2dSBgg8qHijKWmyyewMUgTTaBfNyMVrqF26fGZPmYdQHVyrpx/d3LjmdM=;
Received: from [188.23.34.236] (helo=[10.0.0.160])
	by mx05lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vON5O-0000000059l-3Y30;
	Wed, 26 Nov 2025 22:30:03 +0100
Message-ID: <2e23bf3b-c42e-45b2-8035-e210ed566f0d@engleder-embedded.com>
Date: Wed, 26 Nov 2025 22:30:01 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] serial: 8250: add driver for KEBA UART
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial <linux-serial@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Gerhard Engleder <eg@keba.com>, Daniel Gierlinger <gida@keba.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-3-gerhard@engleder-embedded.com>
 <b7f51612-9192-998c-b0fd-18512d84c154@linux.intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <b7f51612-9192-998c-b0fd-18512d84c154@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 26.11.25 16:46, Ilpo Järvinen wrote:
> On Thu, 23 Oct 2025, Gerhard Engleder wrote:
> 
>> From: Gerhard Engleder <eg@keba.com>
>>
>> The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
>> mostly 8250 compatible with extension for some UART modes.
>>
>> 3 different variants exist. The simpliest variant supports only RS-232
>> and is used for debug interfaces. The next variant supports only RS-485
>> and is used mostly for communication with KEBA panel devices. The third
>> variant is able to support RS-232, RS-485 and RS-422. For this variant
>> not only the mode of the UART is configured, also the physics and
>> transceivers are switched according to the mode.
>>
>> Signed-off-by: Gerhard Engleder <eg@keba.com>
>> Tested-by: Daniel Gierlinger <gida@keba.com>
>> ---
>>   drivers/tty/serial/8250/8250_keba.c | 280 ++++++++++++++++++++++++++++
>>   drivers/tty/serial/8250/Kconfig     |  13 ++
>>   drivers/tty/serial/8250/Makefile    |   1 +
>>   3 files changed, 294 insertions(+)
>>   create mode 100644 drivers/tty/serial/8250/8250_keba.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/8250/8250_keba.c
>> new file mode 100644
>> index 000000000000..c05b89551b12
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_keba.c
>> @@ -0,0 +1,280 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2025 KEBA Industrial Automation GmbH
>> + *
>> + * Driver for KEBA UART FPGA IP core
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/misc/keba.h>
>> +#include <linux/module.h>
> 
> + linux/serial_core.h

Is this really necessary even with the include of 8250.h below?

>> +
>> +#include "8250.h"
>> +
>> +#define KUART "kuart"

...

>> +static void kuart_enhanced_mode(struct uart_8250_port *up, bool enable)
>> +{
>> +	u8 lcr, efr;
>> +
>> +	/* backup LCR register */
> 
> Save + restore is quite obvious thing. IMO, no comment is needed about it.

Yes it could be ommited. The patch is already merged, so I would keep
it. Ok?

>> +	lcr = serial_in(up, UART_LCR);
>> +
>> +	/* enable 650 compatible register set (EFR, ...) */
>> +	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>> +
>> +	/* enable/disable enhanced mode with indexed control registers */
>> +	efr = serial_in(up, UART_EFR);
>> +	if (enable)
>> +		efr |= UART_EFR_ECB;
>> +	else
>> +		efr &= ~UART_EFR_ECB;
>> +	serial_out(up, UART_EFR, efr);
>> +
>> +	/* disable 650 compatible register set, restore LCR */
>> +	serial_out(up, UART_LCR, lcr);
>> +}
>> +
>> +static void kuart_dtr_line_config(struct uart_8250_port *up, u8 dtrlc)
>> +{
>> +	u8 acr;
>> +
>> +	/* set index register to 0 to access ACR register */
>> +	serial_out(up, UART_SCR, UART_ACR);
> 
> So the scratch register has some special use on this UART (register
> multiplexer?), it would probably better name it with define, if that's the
> case.

This UART supports an enhanced mode, which changes the behavior of some
registers. But the register still have their normal use with enhanced
mode disabled. So I would keep the register name.

>> +
>> +	/* set value register to 0x10 writing DTR mode (1,0) */
>> +	acr = serial_in(up, UART_LSR);
>> +	acr &= ~UART_ACR_DTRLC_MASK;
>> +	acr |= dtrlc;
>> +	serial_out(up, UART_LSR, acr);
>> +}

...

>> +	/*
>> +	 * UART supports RS485, RS422 and RS232 with switching of physical
>> +	 * interface
>> +	 */
>> +	uart.port.rs485_config = kuart_rs485_config;
>> +	if (kuart->flags & KUART_RS485) {
>> +		uart.port.rs485_supported.flags = SER_RS485_ENABLED |
>> +						  SER_RS485_RTS_ON_SEND;
>> +		uart.port.rs485.flags = SER_RS485_ENABLED |
>> +					SER_RS485_RTS_ON_SEND;
>> +	}
>> +	if (kuart->flags & KUART_USE_CAPABILITY) {
>> +		/* default mode priority is RS485 > RS422 > RS232 */
>> +		if (kuart->capability & KUART_CAPABILITY_RS422) {
>> +			uart.port.rs485_supported.flags |= SER_RS485_ENABLED |
>> +							   SER_RS485_RTS_ON_SEND |
>> +							   SER_RS485_MODE_RS422;
>> +			uart.port.rs485.flags = SER_RS485_ENABLED |
>> +						SER_RS485_RTS_ON_SEND |
>> +						SER_RS485_MODE_RS422;
>> +		}
>> +		if (kuart->capability & KUART_CAPABILITY_RS485) {
>> +			uart.port.rs485_supported.flags |= SER_RS485_ENABLED |
>> +							   SER_RS485_RTS_ON_SEND;
>> +			uart.port.rs485.flags = SER_RS485_ENABLED |
>> +						SER_RS485_RTS_ON_SEND;
>> +		}
>> +	}
> 
> Is it so that only one mode is supported or can that be changes using
> kuart_rs485_config() in which case you should have all flags listed (you
> seem to talk about priority so that sounds like all are supported)?

Both. As written in the commit message, there are 3 variants of the
device. 2 variants support only one mode and 1 variant supports up to
3 modes.

>> +
>> +	retval = serial8250_register_8250_port(&uart);
>> +	if (retval < 0) {
>> +		dev_err(&auxdev->dev, "UART registration failed!\n");
> 
> Missing header.

I will check for the header.

As this patch is already merged, I will do a follow up.

regards, gerhard
