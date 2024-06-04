Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE9144D2C;
	Tue,  4 Jun 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497606; cv=none; b=QP726Uk73fvYTlIfQHRqTKLC509pxI8gO1pUd//BsYRK8QyRIm2MTuXPWCRvjRtgJL5WNC6zP//nHQB3LGo76uLzCODVkGz2EJdYYDJv7RpHhWFnc/3LF7nw3g7z9NXCWIQmUi2ZhfLAvPLm+7RSPZL5i9qfZ9VWOl/Dp700H+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497606; c=relaxed/simple;
	bh=ofGGe7pYu7+4nliYpZKxLnR3ezTfWQzQpya2z8TbzAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCOzZ8FKl6+3JnPUnx/5p4ACAGENDJPHTLgALQodbiZDRaBUw7v7KBzn4QK2QLaXnjKCg4BoaGNcmotsoiVNUPh/okDro8hx4brDRC6tnUvUQZvgN6H1D9CEpelYjBgt31+yEtxVzoTJ8tbU8TLS4yeOwH17Pw4ghAqGovfE9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VfTQiEK6; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VfTQiEK6"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7EF6E3F1E9;
	Tue,  4 Jun 2024 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717497273;
	bh=401YlDvjkeBbO2ZQMYij/HBNYPBcwsxZ/aOmo3EOcqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=VfTQiEK6gI/wKCztu5heKCH0gm0E5xPVoTfjujjmIeGbeRrnW/CnjxXYQeDzE6HFH
	 01KW6/nWb8XxVxa+r7QbLvs/ZNBSULEkHWhCFAOdk4MligvbocAIqtie3Vc9rPelhK
	 g7VPqa0i6ffV20eNkW9DrN3dA+E8XXodqjoTPTXRnPhnmgjvQzND8aZhcASo2RGnV9
	 syLwFBeX4cIUd28nRyztYoIRkprpcWJfnR4knXeNcEYw5mLZ4jLnu8M/vfIqFLMhdb
	 pBYvl5jgpGitKu/qrZAS7wGD7WYs33/bpOz1vT0KBrDqS/SHVogjE6nviBqsZEuJpN
	 3julSLqdAGDNA==
Message-ID: <405d24a3-7e61-46a1-b185-83299706cedd@canonical.com>
Date: Tue, 4 Jun 2024 18:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: sc16is7xx: setup reset pin if it is defined
 in device tree
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com
References: <20240603123710.649549-1-hui.wang@canonical.com>
 <20240603123710.649549-2-hui.wang@canonical.com>
 <20240603091112.d3491b3be00830126580662e@hugovil.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240603091112.d3491b3be00830126580662e@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugo,

Will address all your comment in the v2.

Thanks,

Hui.

On 6/3/24 21:11, Hugo Villeneuve wrote:
> On Mon,  3 Jun 2024 20:37:10 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
> Hi Hui,
>
>> Certain designs connect a gpio to the reset pin, and the reset pin
>> needs to be setup correctly before accessing the chip.
>>
>> Here adding a function to handle the reset pin. This change has no
>> impact if there is no reset_gpios defined in the device tree.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/tty/serial/sc16is7xx.c     | 22 ++++++++++++++++++++++
>>   drivers/tty/serial/sc16is7xx.h     |  2 ++
>>   drivers/tty/serial/sc16is7xx_i2c.c |  2 ++
>>   drivers/tty/serial/sc16is7xx_spi.c |  2 ++
>>   4 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>> index bf0065d1c8e9..53bfb603b03c 100644
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/kthread.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>> +#include <linux/of_gpio.h>
>>   #include <linux/property.h>
>>   #include <linux/regmap.h>
>>   #include <linux/sched.h>
>> @@ -1467,6 +1468,27 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
>>   	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>>   };
>>   
>> +void sc16is7xx_setup_reset_pin(struct device *dev)
> Potentially rename to sc16is7xx_reset() based on my comments below
> about software reset.
>
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	int reset_gpio, err;
>> +
>> +	reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
> Maybe use devm_gpiod_get_optional() to simplify and avoid OF-specific
> code.
>
>> +	if (!gpio_is_valid(reset_gpio))
>> +		return;
>> +
>> +	err = devm_gpio_request_one(dev, reset_gpio, GPIOF_OUT_INIT_LOW,
>> +				    "sc16is7xx-reset");
>> +	if (err) {
>> +		dev_err(dev, "failed to request sc16is7xx-reset-gpios: %d\n", err);
>> +		return;
> When this error happens, you return no error to the calling function,
> why? If you specify a reset GPIO in your device tree, and you cannot use
> it, seems like an error worth reporting.
>
>> +	}
>> +
>> +	/* Deassert the reset pin */
> Do you respect the manufacturer's minimum reset pulse width? The
> datasheet states that its 3 us, so maybe add a delay before deassertion.
>
>> +	gpio_set_value_cansleep(reset_gpio, 1);
>> +}
>> +EXPORT_SYMBOL_GPL(sc16is7xx_setup_reset_pin);
>> +
>>   int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   		    struct regmap *regmaps[], int irq)
>>   {
>> diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
>> index afb784eaee45..f4ae114cc41a 100644
>> --- a/drivers/tty/serial/sc16is7xx.h
>> +++ b/drivers/tty/serial/sc16is7xx.h
>> @@ -33,6 +33,8 @@ const char *sc16is7xx_regmap_name(u8 port_id);
>>   
>>   unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id);
>>   
>> +void sc16is7xx_setup_reset_pin(struct device *dev);
>> +
>>   int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>   		    struct regmap *regmaps[], int irq);
>>   
>> diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
>> index 3ed47c306d85..9833c3b935c2 100644
>> --- a/drivers/tty/serial/sc16is7xx_i2c.c
>> +++ b/drivers/tty/serial/sc16is7xx_i2c.c
>> @@ -21,6 +21,8 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
>>   	if (!devtype)
>>   		return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
>>   
>> +	sc16is7xx_setup_reset_pin(&i2c->dev);
> Move this call inside sc16is7xx_probe() function, since it is common to
> both i2c and spi interfaces. Also, you will see in sc16is7xx_probe()
> that we already issue a software reset. If you
> specify a hardware reset pin, then you shouldn't issue the software
> reset.
>
>> +
>>   	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
>>   
>>   	for (i = 0; i < devtype->nr_uart; i++) {
>> diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
>> index 73df36f8a7fd..ce38561faaf0 100644
>> --- a/drivers/tty/serial/sc16is7xx_spi.c
>> +++ b/drivers/tty/serial/sc16is7xx_spi.c
>> @@ -38,6 +38,8 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
>>   	if (!devtype)
>>   		return dev_err_probe(&spi->dev, -ENODEV, "Failed to match device\n");
>>   
>> +	sc16is7xx_setup_reset_pin(&spi->dev);
>> +
>>   	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
>>   
>>   	for (i = 0; i < devtype->nr_uart; i++) {
>> -- 
>> 2.34.1
>>
>>
>>
>
