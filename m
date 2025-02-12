Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFA2B9BC
	for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352717; cv=none; b=Wz50KN7OpYbLvJNXCwLV0kPjqghhHIrbaxTxY3XWAKPvL/LWoZCdkzfPIiFdNaaXV+KNZ31M3XI3eYjFnEXF3R4QFqkPmYvIwqlRScvBOzrmGcvi4IJM4hpt6BAWfttD7JDcCGxW8lr9MZOr4Lh+BLs36kLMTeUFKzg7xGlEfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352717; c=relaxed/simple;
	bh=xwRte9YsVdwb0xBTGfFlyXcUGHNimIJBT1n4g6gs43Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzBGd6qqHvI23IGjs94EkkhrGA7PAsrydWLXE+GGP/ffvPW/Ws5uMvtDAoymubF4+B7lq586AhLpgdt4NaVaIsoD3hSA9Trqhm/cqzDswZp+6n4Qd1VM1O/A9bbDwX/WOlPyPsIc/uWOBM172jsqo4O+XsIE5CmwCExTDV50pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZTEqdGF0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZTEqdGF0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4093542D83;
	Wed, 12 Feb 2025 09:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739352706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzmRi2p5r2jAWWu/ZpToZHo1qVX8JesoHSspmxBUqGU=;
	b=ZTEqdGF0OkUKzkUXzIBpq6Aiia+ZIjXZhdAl4T84h0zZMzdURi1XIBT3FdN8tUgsf+VoDP
	H6pkwtP1sdxVV2zDfKtEGuyo12St5fm/wpApfHMPklLFL+Av1G7+C+dksH1xOFvMBH3jU8
	7G4dPtCuq6doeuQCqtlf9nTpU6YL4KxPLw7Oe32hPww4NQV1h8nTSOYu8IZsVkXNhCQgLb
	E9R5oDO1c3rq8aZVY9MHDJ2g9j8o1d7oHNdDZwmO/ugofjTxrHNQBB4/oWatnLngCYVji2
	+jMjcEmwTOV4JNF/1BUO6wzBo2LhGt2SRbeTciSKTJ+SYoARMhLz6ZzQvNT3+Q==
Message-ID: <10adc700-3d3a-4e49-b552-484049703abd@bootlin.com>
Date: Wed, 12 Feb 2025 10:31:45 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Splat: sleep in atomic section in atmel_serial
To: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc: Richard Genoud <richard.genoud@bootlin.com>,
 Nicolas Ferre <Nicolas.Ferre@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <kernel@pengutronix.de>
References: <3d227ebe-1ee6-4d57-b1ec-78be59af7244@bootlin.com>
 <1eb0cd31-4d29-4b87-b19f-7e245787bfbd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <1eb0cd31-4d29-4b87-b19f-7e245787bfbd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdetteektdehudelheehkeeggfejgfelveevgeevtdejudfgveetgefhtdduuedtnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopeglkffrggeimedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgurdhgvghnohhuugess
 ghoohhtlhhinhdrtghomhdprhgtphhtthhopefpihgtohhlrghsrdfhvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Jiri,

On 2/12/25 07:34, Jiri Slaby wrote:
> On 11. 02. 25, 19:09, Alexis Lothoré wrote:
>> Hello,
>>
>> I am currently working on a device driver for a serial device, on a setup
>> involving one of the standard UART from SAMA5D27 (not the flexcom one), as well
>> as two additional gpios for flow control (CTS/RTS). I can reliably reproduce a
>> splat when trying to enable/disable flow control on the target uart (through
>> serdev_device_set_flow_control). I am basing my work on top of the current
>> wireless-next tree:
>>
>> BUG: sleeping function called from invalid context at kernel/irq/manage.c:738

[...]

>> My current understanding is that the issue is around atmel_set_termios which
>> disables interrupts (through uart_port_lock_irqsave), but then calls
>> mctrl_gpio_disable_ms, which in turn calls disable_irq, which can not be called
>> in atomic context. It looks like the issue may have been around for quite some
>> time, but it may have started to appear because of disable_irq having been
>> marked with might_sleep: see commit 17549b0f184d ("genirq: Add might_sleep() to
>> disable_irq()") ?
> 
> We likely want to introduce 'bool sync' param to mctrl_gpio_disable_ms(). It
> would call disable_irq() or disable_irq_nosync() appropriately. As for example,
> imx_uart_shutdown() wants to sync, but serial8250_disable_ms() and
> atmel_disable_ms() do not.
> 
> But I am no expert in this mctrl land.

Thanks for your suggestion. I can come up with a patch implementing this, since
I have some hw available to test it. I'll wait a bit in case someone come with
an objection or a better idea.

Thanks,

Alexis
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
