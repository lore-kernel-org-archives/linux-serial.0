From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH][uart] fit blackfin uart over sport driver into common
	uart inftrastructure (v2)
Date: Fri, 18 Sep 2009 12:54:29 +0800
Message-ID: <4e5ebad50909172154m3c6450f2u7512f20ee3f1951e@mail.gmail.com>
References: <1253095348.25791.6.camel@eight.analog.com>
	 <8bd0f97a0909161156x3cf83b51tb01f6c890abf8594@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:46785 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbZIRFAF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 01:00:05 -0400
In-Reply-To: <8bd0f97a0909161156x3cf83b51tb01f6c890abf8594@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

On Thu, Sep 17, 2009 at 2:56 AM, Mike Frysinger <vapier.adi@gmail.com> =
wrote:
> On Wed, Sep 16, 2009 at 06:02, sonic zhang wrote:
>> 3. Move most platform data into arch specific board files.
>
> might as well do it right now since you've done most of it already.
> i.e. all of the peripheral logic should be in the boards, not the
> driver. =A0so the bfin_uart_pin_req_sportx lists should get moved to =
the
> platform resources as well as the SPORT base addresses.

No. You can't. Because the console is registered and running much
earlier than the platform data is initialized. You have to know the
peripheral lists and base address before registering the console.


>
> then we get proper device bindings between ttySS# and SPORT# by using
> the .id field. =A0ttySS0 should always be SPORT0, ttySS1 should alway=
s
> be SPORT1, etc...

You can't either. Because the index of tty devices is increased
automatically when you successfully register a uart port.  If sport0
is used for devices other than uart, uart over sport1 is always bond
to ttySS0.


>
>> Signed-off-by: Michael Frysinger <michael.frysinger@analog.com>
>
> you shouldnt add s-o-b tags for people who didnt opt for them ... i
> was sleeping when you wrote, committed, and e-mailed out these
> changes. =A0i also handt posted these changes yet because i knew ther=
e
> were still issues to be worked out.

OK. I mean you also did some cleanup to this patch.

>
>> --- a/drivers/serial/bfin_sport_uart.c
>> +++ b/drivers/serial/bfin_sport_uart.c
>> +#define DRV_NAME "bfin-sport-uart"
>> +#define DEVICE_NAME =A0 =A0"ttySS"
>
> should really use the dev_* functions for output rather than the pr_*
> ones, but if you dont do that, you should add before the #include's:
> #define pr_fmt(fmt) DRV_NAME ": " fmt
>
>> =A0 =A0 =A0 =A0tclkdiv =3D sclk/(2 * baud_rate) - 1;
>> - =A0 =A0 =A0 tfsdiv =3D 12;
>> - =A0 =A0 =A0 rclkdiv =3D sclk/(2 * baud_rate * 3) - 1;
>> + =A0 =A0 =A0 rclkdiv =3D sclk/(2 * baud_rate * 2) - 1;
>
> missing space around the "/"
>

OK.

>> -static int sport_uart_suspend(struct platform_device *dev, pm_messa=
ge_t state)
>> +#ifdef CONFIG_PM
>> +static int sport_uart_suspend(struct platform_device *pdev, pm_mess=
age_t state)
>> =A0{
>> - =A0 =A0 =A0 struct sport_uart_port *sport =3D platform_get_drvdata=
(dev);
>> + =A0 =A0 =A0 struct sport_uart_port *sport =3D platform_get_drvdata=
(pdev);
>>
>> - =A0 =A0 =A0 pr_debug("%s enter\n", __func__);
>> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "%s enter\n", __func__);
>> =A0 =A0 =A0 =A0if (sport)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_suspend_port(&sport_uart_reg, &s=
port->port);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -static int sport_uart_resume(struct platform_device *dev)
>> +static int sport_uart_resume(struct platform_device *pdev)
>> =A0{
>> - =A0 =A0 =A0 struct sport_uart_port *sport =3D platform_get_drvdata=
(dev);
>> + =A0 =A0 =A0 struct sport_uart_port *sport =3D platform_get_drvdata=
(pdev);
>>
>> - =A0 =A0 =A0 pr_debug("%s enter\n", __func__);
>> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "%s enter\n", __func__);
>> =A0 =A0 =A0 =A0if (sport)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_resume_port(&sport_uart_reg, &sp=
ort->port);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>
> these need updating to the new dev_pm_opts structure. =A0see the chan=
ges
> i just did to the adp558-keys driver for a simple example.

OK.

>
>> --- a/drivers/serial/bfin_sport_uart.h
>> +++ b/drivers/serial/bfin_sport_uart.h
>
> while you're in here, you might as well add the proper #ifndef header=
 protection
> -mike
>

OK.

Sonic Zhang
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
