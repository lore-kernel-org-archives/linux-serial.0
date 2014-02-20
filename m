From: Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH 3/4] tty: serial: bcm63xx_uart: add support for DT probing
Date: Thu, 20 Feb 2014 11:59:04 +0100
Message-ID: <CAOiHx=mDYsGjtEXEK+8YUo4WZRQeXYvDJdfk2OQtqheeaD7icw@mail.gmail.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
 <1392852167-26243-4-git-send-email-f.fainelli@gmail.com> <CAOiHx==rYbsy66zRUc-QXTS7ZjaX8v9kiomp+m33+tcEtKC-dA@mail.gmail.com>
 <CAGVrzcYEWJ6nKncSx3jjWFp9TXf8PFJnd-joPwSe0mDh-CeMiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 0.mx.nanl.de ([217.115.11.12]:42031 "EHLO mail.nanl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428AbaBTK7c (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 05:59:32 -0500
In-Reply-To: <CAGVrzcYEWJ6nKncSx3jjWFp9TXf8PFJnd-joPwSe0mDh-CeMiw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-serial@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Maxime Bizon <mbizon@freebox.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Feb 20, 2014 at 2:29 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 2014-02-19 16:00 GMT-08:00 Jonas Gorski <jogo@openwrt.org>:
>> On Thu, Feb 20, 2014 at 12:22 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> @@ -857,6 +861,12 @@ static int bcm_uart_remove(struct platform_device *pdev)
>>>         return 0;
>>>  }
>>>
>>> +static const struct of_device_id bcm63xx_of_match[] = {
>>> +       { .compatible = "brcm,bcm63xx-uart" },
>>
>> From my understanding, this should be "brcm,bcm6345-uart", because
>> this kind of uart appeared first on bcm6345 (well, maybe bcm6335, no
>> idea which one of these two was first, but the latter was never
>> supported in mainline anyway).
>
> That's right, in fact, I think it might be desirable to handle both
> compatible string, just as a hint that it is compatible with the
> entire bcm63xx family. Would that work for you?

I think using a "generic" compatible string is rather frowned upon
(what do you do if there is eventually a bcm63xx chip with an
incompatible uart?), but I'm no device tree expert.


Jonas
