Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E717F4EB;
	Wed, 12 Jun 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203597; cv=none; b=fx4ZYuAZE7UxkdiDpze6zc1BOT52mquWh6AZ22qQQriOQzkZ63cWUs60bsf0Kb9F5OKYR3s+9WzzqI8Vyk1Iy/c7sby/DQMg8aaZeI+n+S3rQhJxNGYiZZpcVaCwvDsHX6o33lL19WTTmAy94S98iW3/G12pFMcsf6Tk2nBrulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203597; c=relaxed/simple;
	bh=XJT/PCOkR0tlDddtOt5cCGCqD4uw4jewvUumGQpbGiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbK1EXwNEkTnlVy+tTHPWpHd2xIYrJLQ/dYevqb4euu0QIK05Il6Y/jsQbQkf3XHoRNNHkrjqGEzLDYeAMjLkvVTUONEOdD81hahgm4ROHi3vJhHYZikA8j/wvNdR1aGgOm6UHcuG77Uy1fu0hE3sBEZLyXH2nRbHcvSFBpI1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZqkJNYn3; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZqkJNYn3"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8FDE33F5F5;
	Wed, 12 Jun 2024 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718203584;
	bh=P2ZpUzVfDEqnrfh2KnWliiZ1HuIVAcENcZDvsUv2EO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ZqkJNYn337W6uYB7tURrrNEz4FsgyY2hhGF3CqzRRlvsDEelTHIqJ2tLLSViA6eoC
	 duhISS/yIk2Rl2unIPDHRO1WWiktzxGh91xfl61hoNRL0kPAqG0iuQ2bwgnz7Ms137
	 fRJ9vC+8cWy43s2FX0V2f2hnTg3olbB6F+UawTOKES4jWHoiiB39rY7qtB9oggqMKl
	 8sXVCS+aHkQ7m103aOWOmNvWb+lMswwV88b4EsLwjoD73D69cGvIHRbYR4Uga5TPq/
	 UxjvmczR0CkgcaWSU7Ad812unLMqUIlyNhtR2rvtWfWKZDb03cUcAETZq/Pqmw3oLb
	 phYezzF2nafdg==
Message-ID: <2cbbb6cf-7dff-4b28-9b98-a795d92937ae@canonical.com>
Date: Wed, 12 Jun 2024 22:46:12 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
References: <20240612131454.49671-1-hui.wang@canonical.com>
 <20240612131454.49671-2-hui.wang@canonical.com>
 <20240612095023.946d77e6c30f7ecc4cdad672@hugovil.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240612095023.946d77e6c30f7ecc4cdad672@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/12/24 21:50, Hugo Villeneuve wrote:
> On Wed, 12 Jun 2024 21:14:54 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
> Hi Hui,
>
>> Some boards connect a GPIO to the reset pin, and the reset pin needs
>> to be setup correctly before accessing the chip.
>>
>> Add a function to handle the chip reset. If the reset-gpios is defined
>> in the DT, do hardware reset through this GPIO, othwerwise do software
>> reset as before.
...
>> +		/* The minimum reset pulse width is 3 us. */
>> +		udelay(5);
>> +		gpiod_set_value_cansleep(reset_gpio, 0);
>> +		/* Deassert GPIO */
> Move this comment after its corresponding statement:
>      gpiod_set_value_cansleep(reset_gpio, 0); /* Deassert GPIO */
>
Got it.
>> +	} else {
>> +		/* Software reset */
>> +		regmap_write(regmap, SC16IS7XX_IOCONTROL_REG,
>> +			     SC16IS7XX_IOCONTROL_SRESET_BIT);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   		    struct regmap *regmaps[], int irq)
>>   {
>> @@ -1527,6 +1552,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   	s->devtype = devtype;
>>   	dev_set_drvdata(dev, s);
>>   
>> +	ret = sc16is7xx_reset(dev, regmaps[0]);
>> +	if (ret)
>> +		goto out_clk;
>> +
> You could move this block where the original software reset was
> located, unless you have a good reason to move it here? This will make
> the review (diff) easier...

If I move it to the place where the original software reset was located, 
I can't use "goto out_clk" anymore, it not only needs to release clk but 
also needs to stop the kthread, so I have to add a new tag before the 
kthread_stop(s->kworker_task) and goto that tag.

Thanks.

>>   	kthread_init_worker(&s->kworker);
>>   	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
>>   				      "sc16is7xx");
>> @@ -1536,10 +1565,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   	}
>>   	sched_set_fifo(s->kworker_task);
>>   
>> -	/* reset device, purging any pending irq / data */
>> -	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
>> -		     SC16IS7XX_IOCONTROL_SRESET_BIT);
>> -
>>   	/* Mark each port line and status as uninitialised. */
>>   	for (i = 0; i < devtype->nr_uart; ++i) {
>>   		s->p[i].port.line = SC16IS7XX_MAX_DEVS;
>> -- 
>> 2.34.1
>
