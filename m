From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 3/4] tty: serial: bcm63xx_uart: add support for DT probing
Date: Wed, 19 Feb 2014 17:29:31 -0800
Message-ID: <CAGVrzcYEWJ6nKncSx3jjWFp9TXf8PFJnd-joPwSe0mDh-CeMiw@mail.gmail.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
 <1392852167-26243-4-git-send-email-f.fainelli@gmail.com> <CAOiHx==rYbsy66zRUc-QXTS7ZjaX8v9kiomp+m33+tcEtKC-dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61177 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbaBTBaM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Feb 2014 20:30:12 -0500
In-Reply-To: <CAOiHx==rYbsy66zRUc-QXTS7ZjaX8v9kiomp+m33+tcEtKC-dA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonas Gorski <jogo@openwrt.org>
Cc: linux-serial@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Maxime Bizon <mbizon@freebox.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

2014-02-19 16:00 GMT-08:00 Jonas Gorski <jogo@openwrt.org>:
> On Thu, Feb 20, 2014 at 12:22 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Add a matching table for the the bcm63xx_uart driver on the compatible
>> string "brcm,bcm63xx-uart" which covers all BCM63xx implementations.
>> Also make sure that we convert the id based on the uart aliases provided
>> by the relevant Device Tree.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/tty/serial/bcm63xx_uart.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
>> index 37e7e33..538e84c 100644
>> --- a/drivers/tty/serial/bcm63xx_uart.c
>> +++ b/drivers/tty/serial/bcm63xx_uart.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/serial_core.h>
>>  #include <linux/serial_bcm63xx.h>
>>  #include <linux/io.h>
>> +#include <linux/of.h>
>>
>>  #define BCM63XX_NR_UARTS       2
>>
>> @@ -806,6 +807,9 @@ static int bcm_uart_probe(struct platform_device *pdev)
>>         struct clk *clk;
>>         int ret;
>>
>> +       if (pdev->dev.of_node)
>> +               pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
>> +
>>         if (pdev->id < 0 || pdev->id >= BCM63XX_NR_UARTS)
>>                 return -EINVAL;
>>
>> @@ -857,6 +861,12 @@ static int bcm_uart_remove(struct platform_device *pdev)
>>         return 0;
>>  }
>>
>> +static const struct of_device_id bcm63xx_of_match[] = {
>> +       { .compatible = "brcm,bcm63xx-uart" },
>
> From my understanding, this should be "brcm,bcm6345-uart", because
> this kind of uart appeared first on bcm6345 (well, maybe bcm6335, no
> idea which one of these two was first, but the latter was never
> supported in mainline anyway).

That's right, in fact, I think it might be desirable to handle both
compatible string, just as a hint that it is compatible with the
entire bcm63xx family. Would that work for you?

> The same applies to 4/4.
>
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, bcm63xx_of_match);
>> +
>>  /*
>>   * platform driver stuff
>>   */
>> @@ -866,6 +876,7 @@ static struct platform_driver bcm_uart_platform_driver = {
>>         .driver = {
>>                 .owner = THIS_MODULE,
>>                 .name  = "bcm63xx_uart",
>> +               .of_match_table = bcm63xx_of_match,
>
> You could guard this one with of_match_ptr (and then bcm63xx_of_match
> with CONFIG_OF. Probably not much, but it's the little things ;-)

Good catch.
-- 
Florian
