Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0367190463;
	Wed,  5 Jun 2024 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569601; cv=none; b=B0Ls9WZVlXFrcNXPG1cnbE29XdWGwnmMNRUNMM7WvnIYzZcpDyFpX1Q4qakD5ItSteFzff90UKsRUBCgwfnMaapToG8r4Umz4l0TWj05qmPTKU/8x4zaCWwfr2SV7p7JfCfAkR4W4G8wmI/4R3z5UGjGJEjsXxx+zk3U1lgU3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569601; c=relaxed/simple;
	bh=2/rlE3EHKwzbrntV8RQ9ttopzhe1taDHAjjxyHubupY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piTdoev6kJAY0+UDNVUkq7WFdbT5VPbfUg7jf8Y9eEDi/Hdwq/64D7gmHVE2tgl1BhEFKvI3QSJIRAO20jug+kw4jn1NqFXcAMytxpxcG0REYuWvVqLpNBIKEToAOdbMUek3dDK1ceg0OghB1abfs7mpVIIayTG86LdQIEytML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RrnuitFY; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RrnuitFY"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6EE3840F6E;
	Wed,  5 Jun 2024 06:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717569584;
	bh=D7KJmm5MCmM4z1crd8bCcfzrC7ERuPTo94BwMWyuFQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=RrnuitFYqCQYGa/jO1mFLBQtiOWkjpysG5Fj8yCSqlQzUOxGgYaGTQH0kjx5g1GjM
	 ChS7LCx1/rDk7T1gY0MHJp0K13ArHbE4ENfDydlYVfqPtIhCD1qr1eOWas6GPeJ1zJ
	 /IJXUiHCs2sOMPRwuu66xGJ2fzqclZt1EJuHyvhi8MpOzPMiF0LCkJ5Vxcg2ovBWnu
	 0GTPxu1iwrWbklpJ5u6/9FXTWdvF2SrBqFVhEjcbSdYoGVfQd7EtEgfznaz5e6Tv4C
	 FUZA0sSO3pXPWDnT+iemNbH9EBVw/qwf7ja3MxgukIAoOxIZ6pG/VkzNWnDYNkEi0v
	 xBBq+jiuCWuiw==
Message-ID: <c0beeb7e-b791-40d7-a729-63334778a18c@canonical.com>
Date: Wed, 5 Jun 2024 14:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com>
 <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/24 22:23, Hugo Villeneuve wrote:
> On Tue,  4 Jun 2024 21:27:26 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
> Hi Hui,
>
>> Certain designs connect a gpio to the reset pin, and the reset pin
>> needs to be setup correctly before accessing the chip.
>>
>> Here adding a function to handle the chip reset. If the reset-gpios is
>> defined in the dt, do the hard reset through this gpio, othwerwise do
>> the soft reset as before.
>>
>> Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> I never gave you permission to add this tag, remove it. Make sure you
> fully understand the meaning of tags by reading patches submission
> guidelines.

I misunderstood the meaning of "reviewed-by", will remove it and study 
the guidelines.

>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>> In the v2:
>>   - move the soft reset and hard reset into one fucntion
>>   - move the reset function to sc16is7xx.c and call it in _probe()
>>   - add udelay(5) before deasserting the gpio reset pin
>>
>>   drivers/tty/serial/sc16is7xx.c | 28 ++++++++++++++++++++++++----
>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>> index bf0065d1c8e9..119abfb4607c 100644
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/device.h>
>>   #include <linux/export.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/gpio/driver.h>
>>   #include <linux/idr.h>
>>   #include <linux/kthread.h>
>> @@ -1467,6 +1468,25 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
>>   	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>>   };
>>   
> Add function description from original comment "Reset device,
> purging any pending irq / data", since the comment applies to both
> hardware and software reset,
Got it.
>> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmaps[])
> Simply pass "struct regmap *regmap" as the second argument. See
> sc16is7xx_setup_mctrl_ports() for example.
Got it.
>
>> +{
>> +	struct gpio_desc *reset_gpiod;
> reset_gpiod -> reset_gpio
Got it.
>> +
>> +	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>> +	if (!reset_gpiod)
> Follow Andy's suggestion here.
OK.
>
>> +		/* soft reset device, purging any pending irq / data */
> "Software reset".
Got it.
>> +		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
>> +			     SC16IS7XX_IOCONTROL_SRESET_BIT);
>> +	else if (!IS_ERR(reset_gpiod)) {
>> +		/* delay 5 us (at least 3 us) and deassert the gpio to exit the hard reset */
> You can omit the "delay 5 us" since it is obvious from the code. Maybe
> add that "The minimum reset pulse width is 3 us" as stated in the
> datasheet.
>
> As a general note for your comments: capitalize the first letter,
> ex: "Deassert GPIO" and not "deassert GPIO".
OK.
>
>> +		udelay(5);
>> +		gpiod_set_value_cansleep(reset_gpiod, 0);
> Move the comment "deassert the gpio to exit the hard reset" here. You
> could also simplify it as "Deassert GPIO.".
>
OK.
>> +	} else
>> +		return PTR_ERR(reset_gpiod);
> return dev_err_probe(dev, PTR_ERR(reset_gpiod), "Failed to get reset
> GPIO\n");

Got it, will address all comment in the v3.

Thanks.

>
>> +
>> +	return 0;
>> +}
>> +
>>   int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   		    struct regmap *regmaps[], int irq)
>>   {
>> @@ -1527,6 +1547,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   	s->devtype = devtype;
>>   	dev_set_drvdata(dev, s);
>>   
>> +	ret = sc16is7xx_reset(dev, regmaps);
>> +	if (ret)
>> +		goto out_clk;
>> +
>>   	kthread_init_worker(&s->kworker);
>>   	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
>>   				      "sc16is7xx");
>> @@ -1536,10 +1560,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
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
>>
>>
>>
>
