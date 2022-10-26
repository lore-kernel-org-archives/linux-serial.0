Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C6DC38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 21:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJZVsp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJZVso (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 17:48:44 -0400
X-Greylist: delayed 5872 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 14:48:42 PDT
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF5F09B846
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 14:48:42 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id nmjaohDontk1anmjao3cDN; Wed, 26 Oct 2022 22:10:48 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Oct 2022 22:10:48 +0200
X-ME-IP: 86.243.100.34
Message-ID: <61826266-3f02-bc04-bd98-6391fe5d9fa6@wanadoo.fr>
Date:   Wed, 26 Oct 2022 22:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Content-Language: fr, en-US
To:     Tharunkumar.Pasumarthi@microchip.com, jk@ozlabs.org,
        Kumaravel.Thiagarajan@microchip.com, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, wander@redhat.com,
        u.kleine-koenig@pengutronix.de, etremblay@distech-controls.com,
        macro@orcam.me.uk, jirislaby@kernel.org, johan@kernel.org,
        andy.shevchenko@gmail.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
 <676c5723-a9b7-9f28-fbb4-27a5c6f6145b@wanadoo.fr>
 <c9c19aebb2bf28bad7e98c4d8365ea81ec58bc08.camel@microchip.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c9c19aebb2bf28bad7e98c4d8365ea81ec58bc08.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 26/10/2022 à 13:12, Tharunkumar.Pasumarthi@microchip.com a écrit :
> On Mon, 2022-10-03 at 21:36 +0200, Christophe JAILLET wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>> +             }
>>> +             priv->line[i] = serial8250_register_8250_port(&uart);
>>
>> In case of error, this should be undone in an error handling path in the
>> probe, as done in the remove() function below.
>>
>> If we break, we still continue and return success. But the last
>> priv->line[i] are still 0. Is it an issue when pci1xxxx_serial_remove()
>> is called?
> 
> This will not cause a problem in pci1xxxx_serial_remove as this condition 'priv-
>> line[i] >= 0' will be checked for each of the ports before calling
> serial8250_unregister_port API.

Yes, this is my point.

We check for >=0 in pci1xxxx_serial_remove(), but if we have an error in 
the "for (i = 0; i < nr_ports; i++)" loop, some line[i] we'll still be 
zeroed because 'priv' is zalloc'ed.

In such a case, the probe still succeeds.

So, if pci1xxxx_serial_remove() is called later, we potentially call 
serial8250_unregister_port(0) several times.

This can lead to double (or more) free in serial8250_em485_destroy() 
(but maybe this path can't be taken here?) or maybe some other troubles 
elsewhere (I've not checked all the logic in uart_remove_one_port() to 
make sure that calling several times this function with the same args is 
fine).

So my point is maybe just a "can't happen" case.
If so, apologize for the noise.

CJ

> 
> 
> Thanks,
> Tharun Kumar P

