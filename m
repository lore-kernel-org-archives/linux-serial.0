From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Subject: Re: [PATCH 1/6] serial: 8250_dw: add support for clk api
Date: Fri, 15 Mar 2013 21:15:11 -0300
Message-ID: <BLU0-SMTP4156A39670AA58651B05028AEE0@phx.gbl>
References: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com> <1363377988-4966-2-git-send-email-maxime.ripard@free-electrons.com> <20130315223917.GZ4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130315223917.GZ4977@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sunny@allwinnertech.com, shuge@allwinnertech.com, Jiri Slaby <jslaby@suse.cz>, kevin@allwinnertech.com
List-Id: linux-serial@vger.kernel.org

Hello Russell,

El 15/03/13 19:39, Russell King - ARM Linux escribi=F3:
> On Fri, Mar 15, 2013 at 09:06:23PM +0100, Maxime Ripard wrote:
>> +	/* clock got configured through clk api, all done */
>> +	if (p->uartclk)
>=20
> 	if (IS_ERR(p->uartclk))
>=20

Isn't IS_ERR for pointers? p->uartclk is an unsigned int

>> +		return 0;
>> +
>> +	/* try to find out clock frequency from DT as fallback */
>>  	if (of_property_read_u32(np, "clock-frequency", &val)) {
>> -		dev_err(p->dev, "no clock-frequency property set\n");
>> +		dev_err(p->dev, "clk or clock-frequency not defined\n");
>>  		return -EINVAL;
>>  	}
>>  	p->uartclk =3D val;
>> @@ -294,9 +301,21 @@ static int dw8250_probe(struct platform_device =
*pdev)
>>  	if (!uart.port.membase)
>>  		return -ENOMEM;
>> =20
>> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->clk =3D devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(data->clk))
>> +		data->clk =3D NULL;
>> +	else
>> +		clk_prepare_enable(data->clk);
>=20
> 	if (!IS_ERR(data->clk))
> 		clk_prepare_enable(data->clk);
>=20

See below

>> +
>>  	uart.port.iotype =3D UPIO_MEM;
>>  	uart.port.serial_in =3D dw8250_serial_in;
>>  	uart.port.serial_out =3D dw8250_serial_out;
>> +	uart.port.private_data =3D data;
>> +	uart.port.uartclk =3D clk_get_rate(data->clk);
>=20
> What if data->clk is invalid?
>=20
> 	if (!IS_ERR(data->clk)
> 		uart.port.uartclk =3D clk_get_rate(data->clk);
>=20

I'm not sure if it is coincidental or the way it is supposed to be, but
when using the common clock framework, if you pass a NULL to
clk_get_rate, the function explicitly checks for it and returns 0. I
relied on that behaviour when implementing this; see the if..else block
above. Is this not always the case on other clock drivers?

>> =20
>>  	dw8250_setup_port(&uart);
>> =20
>> @@ -312,12 +331,6 @@ static int dw8250_probe(struct platform_device =
*pdev)
>>  		return -ENODEV;
>>  	}
>> =20
>> -	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> -	if (!data)
>> -		return -ENOMEM;
>> -
>> -	uart.port.private_data =3D data;
>> -
>>  	data->line =3D serial8250_register_8250_port(&uart);
>>  	if (data->line < 0)
>>  		return data->line;
>> @@ -333,6 +346,8 @@ static int dw8250_remove(struct platform_device =
*pdev)
>> =20
>>  	serial8250_unregister_port(data->line);
>> =20
>=20
> 	if (!IS_ERR(data->clk)
>=20

I just double checked and clk_enable/disable, clk_prepare/unprepare als=
o
ignore NULLs passed to them on the CCF.

>> +	clk_disable_unprepare(data->clk);
>> +
>>  	return 0;
>>  }
>> =20
>> --=20
>> 1.7.10.4

Thanks for the review,

Emilio
