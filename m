From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V2 2/4] gpio: gpio-f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO GPIOLIB support
Date: Fri, 29 Jan 2016 16:15:49 +0800
Message-ID: <56AB1FB5.3080603@gmail.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453972838-30268-3-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453982584.2521.285.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1453982584.2521.285.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Andy Shevchenko =E6=96=BC 2016/1/28 =E4=B8=8B=E5=8D=88 08:03 =E5=AF=AB=E9=
=81=93:
> On Thu, 2016-01-28 at 17:20 +0800, Peter Hung wrote:
>> +	/* set output data */
>> +	tmp =3D inb(priv->gpio_ioaddr + gc->idx);
>
> ioread8 is a bit better since it automatically works with IO space an=
d
> MMIO. But if you are certain you will always have the address in IO
> space, you can disregard this comment.

I had only tested on x86 environment currently. We'll try to get an ARM
platform with PCIE to test it. We'll remain it until getting new board.

>> +static int f81504_gpio_probe(struct platform_device *pdev)
>> +{
>> +	int status;
>> +	struct f81504_gpio_chip *gc;
>> +	void *data =3D dev_get_platdata(&pdev->dev);
>> +	u8 gpio_idx =3D *(u8 *)data;
>> +	char *name;
>> +
>> +	if (gpio_idx >=3D ARRAY_SIZE(fintek_gpio_mapping)) {
>> +		dev_err(&pdev->dev, "%s: gpio_idx:%d out of
>> range.\n",
>> +				__func__, gpio_idx);
>> +		return -ENODEV;
>> +	}
>> +
>> +	gc =3D devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
>> +	if (!gc)
>> +		return -ENOMEM;
>> +
>>
>
>> +	kfree(data);
>
> What the heck?

Sorry for the big mistake, I'd confused for dev_get_platdata() &
platform_set_drvdata(). I'll rewrite this and check 8250_f81504.c
too.

>> +	status =3D gpiochip_add(&gc->chip);
>> +	if (status) {
>> +		dev_err(&pdev->dev, "%s: gpiochip_add failed: %d\n",
>> __func__,
>> +				status);
>> +		return -ENOMEM;
>
> You ignored the status.
>
>> +	}
>> +
>> +	return 0;
>
> Perhaps just
> return gpiochip_add(); ?

Just return gpiochip_add() seems good.

Thanks your advices
--=20
With Best Regards,
Peter Hung
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
