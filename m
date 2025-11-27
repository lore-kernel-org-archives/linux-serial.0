Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E852FFFB7
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764272592; cv=none; b=rkRgvENvzxjHTuQt59A0yis80nmvlurKduvcnoim2sywsIP6SpaYRvTEC4GFa8PgvgreNedt8btm0to5Id74HVJebv5UVCV8TBy9HFcX0P/Vct61y7mKJrPqYLu5DMmZMrRrgTCMredUsGk2bLVyVPVZyKNWK1LSt4J6n5rX0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764272592; c=relaxed/simple;
	bh=b+SSNIbSSygAvTQhE8bORIr8oe1IUL1I9tcl3dCP+2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0giCRIVTHnG6/BYV7SRYlwLmPg1k2+JsUbqNGfmvJf8/t7hDDoVlFz7gMeHGuAN8Ix1sWLOVt60drSeEhqmJAqAS7JIphH9v2NgCdEFuZr7UHx/skWM7JjW1kxmLyDqr/EWI072mbP8y2qJv6TXs7g62tw62LzleOGKkDo+RsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=M2dIV1ED; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="M2dIV1ED"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+XEjCrR6FM50mDQxVtUWZZ88k/no/mSW71JxCOmVlTs=; b=M2dIV1EDv/ulEyzFzTw+Sz885O
	OZrAuRgsOplNBeQznM7+wFsGBrq2Y/b7IGJaDVYkpVNMCyVBFrfD/Y8B5EsTEnmU0QuNoryiqEBcl
	jLa8I2Oov15k/1JspZEQl1ATNLoWiiym50OhYNfzt8DBoCq6aKSX7uAAKDk8RrcSiLDs=;
Received: from [188.23.34.236] (helo=[10.0.0.160])
	by mx11lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vOhtT-000000000s9-15Jf;
	Thu, 27 Nov 2025 20:43:07 +0100
Message-ID: <913848d6-5c16-4155-b636-84babdb38182@engleder-embedded.com>
Date: Thu, 27 Nov 2025 20:43:06 +0100
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
 <2e23bf3b-c42e-45b2-8035-e210ed566f0d@engleder-embedded.com>
 <9abd5fcd-973d-cede-5165-591ecf6e14da@linux.intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <9abd5fcd-973d-cede-5165-591ecf6e14da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 27.11.25 10:28, Ilpo Järvinen wrote:
> On Wed, 26 Nov 2025, Gerhard Engleder wrote:
> 
>> On 26.11.25 16:46, Ilpo Järvinen wrote:
>>> On Thu, 23 Oct 2025, Gerhard Engleder wrote:
>>>
>>>> From: Gerhard Engleder <eg@keba.com>
>>>>
>>>> The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
>>>> mostly 8250 compatible with extension for some UART modes.
>>>>
>>>> 3 different variants exist. The simpliest variant supports only RS-232
>>>> and is used for debug interfaces. The next variant supports only RS-485
>>>> and is used mostly for communication with KEBA panel devices. The third
>>>> variant is able to support RS-232, RS-485 and RS-422. For this variant
>>>> not only the mode of the UART is configured, also the physics and
>>>> transceivers are switched according to the mode.
>>>>
>>>> Signed-off-by: Gerhard Engleder <eg@keba.com>
>>>> Tested-by: Daniel Gierlinger <gida@keba.com>
>>>> ---
>>>>    drivers/tty/serial/8250/8250_keba.c | 280 ++++++++++++++++++++++++++++
>>>>    drivers/tty/serial/8250/Kconfig     |  13 ++
>>>>    drivers/tty/serial/8250/Makefile    |   1 +
>>>>    3 files changed, 294 insertions(+)
>>>>    create mode 100644 drivers/tty/serial/8250/8250_keba.c

...

>>>> +#include <linux/auxiliary_bus.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/misc/keba.h>
>>>> +#include <linux/module.h>
>>>
>>> + linux/serial_core.h
>>
>> Is this really necessary even with the include of 8250.h below?
> 
> Yes. Generally don't rely on indirect includes.

I will add it to the follow up.

>>>> +
>>>> +#include "8250.h"
>>>> +
>>>> +#define KUART "kuart"

...

>>>> +static void kuart_dtr_line_config(struct uart_8250_port *up, u8 dtrlc)
>>>> +{
>>>> +	u8 acr;
>>>> +
>>>> +	/* set index register to 0 to access ACR register */
>>>> +	serial_out(up, UART_SCR, UART_ACR);
>>>
>>> So the scratch register has some special use on this UART (register
>>> multiplexer?), it would probably better name it with define, if that's the
>>> case.
>>
>> This UART supports an enhanced mode, which changes the behavior of some
>> registers. But the register still have their normal use with enhanced
>> mode disabled. So I would keep the register name.
> 
> But this code clearly assume UART is in enhanced mode. Same number can
> have different names. You could of course reuse the other define in the
> define:
> 
> #define KUART_EMODE_INDEX_REG	UART_SCR

I will consider it for the follow up.

Thank you for your comments!

Gerhard

