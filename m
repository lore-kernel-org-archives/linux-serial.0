Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253300;
	b=tfMKFBvvqUVH3kAmFl+HDtK07M3qJsI4cE8B30vbsOnRKHz8w0YYOnVGvGYY3YqhZyzn
	 jGsq6IyzfZ+E8IevZhFQY6ppZWeCD1OKS4dq5cfu5VuOawmXd4S+FBwFqkozjVc565cGT
	 f53nmdlwnAfRzZpXLd7TRmNIcxw5LgVu9RMkt7UvK2qOSiZHFcY8WNevyVk+4s9H4UwRU
	 W6003zZTIHJ9Xxrz8VMNImBFzTU1U6THPLYnRSWjK87VGyPv/1a6IdY50tHVtGKxk9LE5
	 UW0VQPS80exFp4/9RgQGGxcFC9WxXAzdB3JW3Q1S738uLGfWoLRMZRwxIWRKVd1PkrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253300;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=n00JStMcnluxyqd3reCV9Ishhs7tY4ywa3Yb3VgX2sU=;
	b=PzFJcwjfy+bRYgd2Df5bwL6S4dkDD7yIZES+Uu0E1mIA0kcAhZaO9DNeqmDT1MqcIDPh
	 WAm/S/B/PX4cFgAJOfqXCjv9sZWNtevruhdVxdgKOx9nBl2I0XboGn5ZFIsDx4nYTFQRW
	 Ol4SzjdpeB5VAvoQrqo5XWlYd5aEq5Twk+q/FriUVumq1wG1JFrLY1m5ytr81K4wLngrI
	 VjgfvM4KiUI+KRO7HK9O+1n8CRM8YbLiBZxswIDfashO1vmQhwRlNMx/PlcSBImd2SgP7
	 NxUYDAKDs/BTp7F6HsTagkGS7Zu7trIfKGwPDJhhqMYNoHt3n0xVumNyxmIm0livUnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoO53HLV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774C606A31C;
	Thu, 29 Oct 2026 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoO53HLV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30F11F01825;
	Thu, 29 Oct 2026 05:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253300;
	bh=n00JStMcnluxyqd3reCV9Ishhs7tY4ywa3Yb3VgX2sU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HoO53HLVqnRolvxFBkvTDB7ShFr9ZcofgrNWBiv1xxcAOc4+l0hz/PeTPF2S8+xCS
	 /l/GMCPvA2EF1h/jEzlf8CrdxpWHFah1Tx7xF9+DOQkq8feLFfT/m/EHxoLlrdIqfX
	 MT6NFpV1V7Tu27HoROr4CrlKd/V3reteHqnwAhkyz9xyARJbLUp38BflRxQ9JOvzWI
	 JEbmgGoqv6/bQ+97Vh6xve0QeNm0gIkBVSd0X32361/tOmsdnub6Qm6BFieJAxTveA
	 IlI1w7LsB6BANlK9YKiScq/oSN0olZHqcCvcTLsm1AW7OdbYmLy0kQDndnsdmud82E
	 UpTXh+oe0r2Lg==
Message-ID: <74e02b49-f596-4433-a132-7799029db2a5@kernel.org>
Date: Thu, 29 Oct 2026 06:54:50 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] serial: stm32: don't report a wakeup to a closed
 tty
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Tony Lindgren <tony@atomide.com>,
 Rafael Gago Castano <rgc@hms.se>, Florian Fainelli <f.fainelli@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Robert Baldyga
 <r.baldyga@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>,
 Kukjin Kim <kgene.kim@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Al Cooper <alcooperx@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, stable <stable@kernel.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org>
 <aef066bc-1b1e-b1e8-97f5-6fa8c8d18940@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <aef066bc-1b1e-b1e8-97f5-6fa8c8d18940@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27. 10. 26, 14:02, Ilpo Järvinen wrote:
> On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:
> 
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> stm32_usart_interrupt() reports a wakeup interrupt as a wakeup event of
>> tport->tty->dev.  That pointer is only set while the port is open.  The
>> port of a console is not shut down by the last close: it stays
>> initialized, so the wakeup interrupt is still enabled on suspend.  If
>> the system is then woken up by the console, the handler dereferences a
>> NULL pointer.
>>
>> Take a reference to the tty, and leave the event out if there is none.
>>
>> Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
>> Cc: stable <stable@kernel.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> Cc: Peter Hurley <peter@hurleysoftware.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   drivers/tty/serial/stm32-usart.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> index ad06b760cfca..3bc2ce877585 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -872,8 +872,15 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
>>   		writel_relaxed(USART_ICR_WUCF,
>>   			       port->membase + ofs->icr);
>>   		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
>> -		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
>> -			pm_wakeup_event(tport->tty->dev, 0);
>> +		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq))) {
>> +			struct tty_struct *tty = tty_port_tty_get(tport);
>> +
>> +			/* A console stays set up after the last close */
>> +			if (tty) {
>> +				pm_wakeup_event(tty->dev, 0);
>> +				tty_kref_put(tty);
>> +			}
>> +		}
> 
> Could we like add a helper into serial core to do this tty wakeup dance?
> It is duplicated in quite many of these patches.

Likely. Or use scoped_guard(tty_port_tty) at minimum.

thanks,
-- 
js
suse labs
