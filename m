Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FF190463;
	Wed,  5 Jun 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569406; cv=none; b=RA3P5a5YVx9UHy3nsQSvHWGV74dOce6EOJQQKDLLWHjSGwi0hcrBhmpMgkD1OzYlKLVIJ2ntBk0pRNjKntW3HM9RsuRX4Xhc1OKaehVsswsAdEPVUsRKJlX6YF7nNRG5qkAhfK+w5cId0mDiIuWikMyPeFcdFvkXFGuffIU7sgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569406; c=relaxed/simple;
	bh=rECvOhO0dQQdFtXpI7f3K7CiGAxr4E6p07mnNX/HXrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUna2GKcgLliSBwM0lP2eDaZp7/HJ3G2M0uVwJXrc9GbxpIHlU3CZSZx/E0uYHjuYeLcZ7Oe13P5y+crVoIeyif/ZKb9ur3zGKWHJTAIGUJfDVTfLXTU9oP2j9VqHkGKr0VjR7GPF7+PUtKuIEConUcJa2xibCpx9eitxImVsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uOJhh2j5; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uOJhh2j5"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A57C140F6E;
	Wed,  5 Jun 2024 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717569387;
	bh=OAkyBlF9Xw3gnAL27ple10J0J3dmlC0ykeK1EDSplhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=uOJhh2j5udEUilx+Fx4V224+YZdpLdgI8yLnaQP7j2hiUhWfX7Y0jJsIjqu/qbGI5
	 xbyVJ4p/7j5o/7K/fMy5f1NaHxMsWc4YdzepINBkVn09sNWvuUDLqXHyJ9HhKCh/m6
	 XIKyhLY22CxPAP3kFiOFosTv/b5Zb9q2K9IuTJS4XuPN+wc+ARSXmU1eqQvaNhFo3O
	 k+Zg1sNW0Y+LZjO5np87k59l+qpbrwfRFq0NJJN3sR9+NLNT8tgJGiM6/dMcJuFp4r
	 syuzGpdix/EmG+U0avtiOcCkp0TFxymAewbJu10qGQ8xw8ac2Kk9a69BF+JHDGljYs
	 9Mp64ZJUoWxiA==
Message-ID: <62ae5910-e8ec-42f9-a1c7-d834777bee4d@canonical.com>
Date: Wed, 5 Jun 2024 14:36:20 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lech.perczak@camlingroup.com
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com>
 <Zl8ZyZ6ftvNTusFi@smile.fi.intel.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <Zl8ZyZ6ftvNTusFi@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/24 21:42, Andy Shevchenko wrote:
> On Tue, Jun 04, 2024 at 09:27:26PM +0800, Hui Wang wrote:
>> Certain designs connect a gpio to the reset pin, and the reset pin
> GPIO
Got it.
>> needs to be setup correctly before accessing the chip.
>>
>> Here adding a function to handle the chip reset. If the reset-gpios is
>> defined in the dt, do the hard reset through this gpio, othwerwise do
> DT
Got it.
>
>> the soft reset as before.
> ...
>
>> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmaps[])
>> +{
>> +	struct gpio_desc *reset_gpiod;
>> +	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>> +	if (!reset_gpiod)
>> +		/* soft reset device, purging any pending irq / data */
>> +		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
>> +			     SC16IS7XX_IOCONTROL_SRESET_BIT);
>> +	else if (!IS_ERR(reset_gpiod)) {
>> +		/* delay 5 us (at least 3 us) and deassert the gpio to exit the hard reset */
>> +		udelay(5);
>> +		gpiod_set_value_cansleep(reset_gpiod, 0);
>> +	} else
>> +		return PTR_ERR(reset_gpiod);
> You can do better here.
>
> 	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> 	if (IS_ERR(reset_gpiod))
> 		return PTR_ERR(reset_gpiod);
>
> 	if (reset_gpiod) {
> 		/* delay 5 us (at least 3 us) and deassert the GPIO to exit the hard reset */
> 		fsleep(5);
> 		gpiod_set_value_cansleep(reset_gpiod, 0);
> 	} else {
> 		/* soft reset device, purging any pending IRQ / data */
> 		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
> 			     SC16IS7XX_IOCONTROL_SRESET_BIT);
> 	}

OK, got it, will fix all comment in the v3.

Thanks.

>> +	return 0;
>> +}
