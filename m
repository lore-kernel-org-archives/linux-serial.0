Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DA1946D3;
	Wed,  5 Jun 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584934; cv=none; b=HmattJsg8TdoHnsIogcpylQjZbNWKb0ZGJerTS01QZtUg2uZrvIgC3JLkW9Z9oJpLNo629Uy9zpRqRGW3Xy0m5YJ8jX2S2U27AbiMH1c8NTRX6YkpHEOpbI5BR09zcAcABlLI1fXi2Su780Z9s8VQnIp4Ru0+t84ab5O3nD6fSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584934; c=relaxed/simple;
	bh=W+U7qhUjCbi51uRgvg/U9wrwMMR6x0KWroJZjDdtMrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1MM7+u77mfVcK7pUXkz0yO0IC8DNw8GVsYPhwINPqXBa3GCcSNtPkt0MXyK/PM5TNF7KXYH2Hmuxeymg898fdGSzvbzzhaa80Ca3JPbGBK7WS251zBxCz8XcJsG3ci/nKUwOLajTkGnaL9y54v4iuj91lHLx2LnQp/PRR7v8fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qSfIEj16; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qSfIEj16"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9D2BC3F30B;
	Wed,  5 Jun 2024 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717584926;
	bh=A2fBCgA/gmiLrr61al6cFFR/2iFB/YAMVzE2ZejjVMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=qSfIEj16dUGorAnUStJ++FqiIxosMfqnqB5U9uH2sE3zXuGR8t4wNXATbFd44sL3O
	 lBNPXAYAlpRO9E8T5FbnDJT6V/1TqDYANWDmIHaynLHtZPj7wURRZRdT2/RuFfQU9Q
	 Qhfe+qJ1oWkfGuFF+lHEOgsC+lZEeeLFanFImgMnJii+2oY6b0DutsaFMWARkneSaK
	 X+R67pgRi5tpa7roEZ7IB1ZbLb7BRe9+8jCkhsDMq298CqKUfmMCQm2Bum9LbJyOVx
	 HNgPkSp6J1147m9y5DMWIL5V4MVDqwVIrwYF63qmEicsCQX/qWLTMBHq3pu1lQD5Vz
	 07FTVK409dbXw==
Message-ID: <f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com>
Date: Wed, 5 Jun 2024 18:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
To: Maarten Brock <Maarten.Brock@sttls.nl>, Hugo Villeneuve <hugo@hugovil.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jirislaby@kernel.org" <jirislaby@kernel.org>,
 "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "andy@kernel.org" <andy@kernel.org>,
 "lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com>
 <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
 <AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/5/24 18:30, Maarten Brock wrote:
>> From: Hugo Villeneuve <hugo@hugovil.com>
>> Sent: Tuesday, 4 June 2024 16:23
> <...>
>
>> Add function description from original comment "Reset device,
>> purging any pending irq / data", since the comment applies to both
>> hardware and software reset,
> No it does not (at this moment). See below.
>
>>> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmaps[])
>> Simply pass "struct regmap *regmap" as the second argument. See
>> sc16is7xx_setup_mctrl_ports() for example.
>>
>>> +{
>>> +	struct gpio_desc *reset_gpiod;
>> reset_gpiod -> reset_gpio
>>
>>> +	else if (!IS_ERR(reset_gpiod)) {
>>> +		/* delay 5 us (at least 3 us) and deassert the gpio to exit the hard
>> reset */
>>
>> You can omit the "delay 5 us" since it is obvious from the code. Maybe
>> add that "The minimum reset pulse width is 3 us" as stated in the
>> datasheet.
>>
>> As a general note for your comments: capitalize the first letter,
>> ex: "Deassert GPIO" and not "deassert GPIO".
>>
>>
>>> +		udelay(5);
>>> +		gpiod_set_value_cansleep(reset_gpiod, 0);
>> Move the comment "deassert the gpio to exit the hard reset" here. You
>> could also simplify it as "Deassert GPIO.".
> The problem here is that this only deasserts the reset if it were asserted before.
> Nothing happens if it already was deasserted. This makes the delay also pretty
> useless.
>
> To make this a proper reset pulse for the device you must first assert the reset,
> then wait >3us, and finally deassert the reset.
>
> Maarten Brock
Hi Maarten,

My understanding is when calling devm_gpiod_get_optional(dev, "reset", 
GPIOD_OUT_LOW) and returning a valid (gpio_desc *), the flag 
GPIOD_OUT_LOW guarantees the GPIO is set to output and low (assert the 
reset pin).

Thanks,

Hui.


>
