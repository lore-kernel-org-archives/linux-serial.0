Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8117F4F5;
	Wed, 12 Jun 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203817; cv=none; b=n2WetYcr3nrs8OtHuDNR0TK+jWbeWj0Io+gBfQmqTLGSr0oO1kTscdrd8AX8yZD+spk/bNZu9dCyI5D8mwdpcpypDUmp+vtOu3Q7H+N9So70WLmbjXbEsTVD6kKeFnw36PtMIH7kEPZirGL2n5+xShBbC1d76Smdk2wtwBDKGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203817; c=relaxed/simple;
	bh=gTVjA1lU2IXRk2J6/Gdpx6FdAP/OUlGWT/y2xhtrS7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+IMxhdUbSIRNbVMRb9LMawHqq4ZSNSG0LlGIRqGgkJKc3Oy9R8xPEKouD3/E7loEzpd9obbqLoLPOqWAJW1ZCTAH/xLKPZCGl3U+fC4si+z6+XetrMiqOStmajCttoMoQ9ASRlOJqjYHALVGxM2mzsTL4HLBoSp8s0J284M/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ebLq0quz; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ebLq0quz"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 96AFE3F1D3;
	Wed, 12 Jun 2024 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718203811;
	bh=EVeO/ntZpuwYpx+X1bX9nEioZ0b1qYOSTHEmiyczwwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ebLq0quzNIevLXUytjTmaDHbW2I5o8dvNodx7eydc53D/s8ulZACazCg9DjpFkyTv
	 HUzkcVf6LUtIjxIbqJWwgGXqyPmdLq0vAesah+vow7BWRx+ktFSkAf0j9Bt2jGAvZK
	 nosqeMGn/v4pvirKDcCm2a3Ux/A8NFvtqwV7MGEEflsAIXiQ6Ue8/9n42i/kBensND
	 6dlYjAVfHEdsmFqvdCag7Gw4sp11Gy4wJpPtjw41xCqRnhbtKJdKjH7KZ6wVZpbWze
	 yGbjMz1YMK2iWTzKld1aZVblZfRSSw0N8yxqSFZo3IgG9i+Ns0ZHaCBJUdjwgrUH0O
	 kRwR35VOV98Pg==
Message-ID: <a4daaf0e-2484-4943-9ac2-589485d69993@canonical.com>
Date: Wed, 12 Jun 2024 22:50:01 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Lech Perczak <lech.perczak@camlingroup.com>,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 Maarten.Brock@sttls.nl
References: <20240612131454.49671-1-hui.wang@canonical.com>
 <20240612131454.49671-2-hui.wang@canonical.com>
 <18a1beeb-e45b-4d6d-bd21-74b85c33dc2c@camlingroup.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <18a1beeb-e45b-4d6d-bd21-74b85c33dc2c@camlingroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/12/24 21:56, Lech Perczak wrote:
> Hi,
> Some comments inline.
>
> W dniu 12.06.2024 o 15:14, Hui Wang pisze:
>> Some boards connect a GPIO to the reset pin, and the reset pin needs
>> to be setup correctly before accessing the chip.
>>
>> Add a function to handle the chip reset. If the reset-gpios is defined
>> in the DT, do hardware reset through this GPIO, othwerwise do software
>> reset as before.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>> In the v3:
>>   - drop Reviewed-by
>>   - adjust the sequence of if, else if and else
>>   - replace PTR_ERR(reset_gpiod) with dev_err_probe
>>   - change GPIOD_OUT_LOW to GPIOD_OUT_HIGH, this will assert the reset pin after requesting the GPIO
>>   - change the 2nd parameter struct regmap *regmap[] to struct regmap *regmap
>>   - address all spelling and description issues in the v2
>>
>>   drivers/tty/serial/sc16is7xx.c | 33 +++++++++++++++++++++++++++++----
>>   1 file changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>> index bf0065d1c8e9..8c7e0fe76049 100644
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
>> @@ -1467,6 +1468,30 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
>>          .delay_rts_after_send = 1,      /* Not supported but keep returning -EINVAL */
>>   };
>>
>> +/* Reset device, purging any pending irq / data */
>> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
>> +{
>> +       struct gpio_desc *reset_gpio;
>> +
>> +       /* The reset GPIO is ACTIVE_LOW, flag GPIOD_OUT_HIGH asserts the reset GPIO */
> s/reset GPIO is ACTIVE_LOW /reset input is active low/ - because we're referring to the chip input here, and this is reflected in DT bindings.
>
> Also, it isn't clear from the comment that GPIO is asserted immediately.
Got it.
>
>
>> +       reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> +       if (IS_ERR(reset_gpio))
>> +               return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to get reset GPIO\n");
>> +
>> +       if (reset_gpio) {
>> +               /* The minimum reset pulse width is 3 us. */
>> +               udelay(5);
> Prefer usleep_range() over that, since maximum reset time isn't all that critical.
Got it.
>
>
>> +               gpiod_set_value_cansleep(reset_gpio, 0);
>> +               /* Deassert GPIO */
> This comment should go one line above or be removed entirely.

Got it.

Thanks.

>
>
>> +       } else {
>> +               /* Software reset */
>> +               regmap_write(regmap, SC16IS7XX_IOCONTROL_REG,
>> +                            SC16IS7XX_IOCONTROL_SRESET_BIT);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>                      struct regmap *regmaps[], int irq)
>>   {
>> @@ -1527,6 +1552,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>          s->devtype = devtype;
>>          dev_set_drvdata(dev, s);
>>
>> +       ret = sc16is7xx_reset(dev, regmaps[0]);
>> +       if (ret)
>> +               goto out_clk;
>> +
>>          kthread_init_worker(&s->kworker);
>>          s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
>>                                        "sc16is7xx");
>> @@ -1536,10 +1565,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>>          }
>>          sched_set_fifo(s->kworker_task);
>>
>> -       /* reset device, purging any pending irq / data */
>> -       regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
>> -                    SC16IS7XX_IOCONTROL_SRESET_BIT);
>> -
>>          /* Mark each port line and status as uninitialised. */
>>          for (i = 0; i < devtype->nr_uart; ++i) {
>>                  s->p[i].port.line = SC16IS7XX_MAX_DEVS;
>> --
>> 2.34.1
