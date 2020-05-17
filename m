Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67584C433E0
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 17:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D96A207DA
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="EpT6X1/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgEQRgV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 13:36:21 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:58352 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgEQRgV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 13:36:21 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2020 13:36:20 EDT
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A2BE2B033EE
        for <linux-serial@vger.kernel.org>; Sun, 17 May 2020 19:28:07 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1589736487; x=1590600488; bh=BTMk5YTSUT9CYUvfxuhhjtuD3oQXc0xwa2+
        R9dvv3Gg=; b=EpT6X1/ScxgFvbYJfKKn6NJJuZgEMW2G5vdSm1TPAtTuBkmUC8K
        4CFSsVjztkNpEaclA/GQJ8rII93yNEpbu2iQUsHlopcbESyvTRQCBV40Rz3EZJb9
        ULJqZ1PVEl/xc6hwXhiCwZ6CBFE6nUF2lsd7z5M/Rg3xFMZ10A0yRLXQ=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hxj06Yj9r9V8 for <linux-serial@vger.kernel.org>;
        Sun, 17 May 2020 19:28:07 +0200 (CEST)
Received: from [192.168.2.105] (146-241-10-121.dyn.eolo.it [146.241.10.121])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 0F597B033DB;
        Sun, 17 May 2020 19:28:06 +0200 (CEST)
Subject: Re: [PATCH v2 4/7] serial: 8250: Handle implementations not having
 TEMT interrupt using em485
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, christoph.muellner@theobroma-systems.com
References: <20200325231422.1502366-1-heiko@sntech.de>
 <12195570.sTQbgxCmNy@diego>
 <ac74f702-9444-f660-974b-85a006805070@micronovasrl.com>
 <3036126.9QgpAzkLCg@diego>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <d7723588-3df8-10f4-45a3-2e061cd06dc2@micronovasrl.com>
Date:   Sun, 17 May 2020 19:28:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3036126.9QgpAzkLCg@diego>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Heiko,

Il 17/05/2020 17:04, Heiko Stübner ha scritto:
> Hi Giulio,
> 
> Am Donnerstag, 26. März 2020, 03:02:39 CEST schrieb Giulio Benetti:
>> Il 26/03/2020 01:05, Heiko Stübner ha scritto:
>>> Am Donnerstag, 26. März 2020, 00:47:38 CET schrieb Giulio Benetti:
>>>> very cleaner way to handle TEMT as a capability!
>>>> And I've found one thing...
>>>>
>>>> Il 26/03/2020 00:14, Heiko Stuebner ha scritto:
>>>>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>>>
>>>>> Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
>>>>> standard, instead only available on some implementations.
>>>>>
>>>>> The current em485 implementation does not work on ports without it.
>>>>> The only chance to make it work is to loop-read on LSR register.
>>>>>
>>>>> So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
>>>>> update all current em485 users with that capability and make
>>>>> the stop_tx function loop-read on uarts not having it.
>>>>>
>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>>> [moved to use added UART_CAP_TEMT, use readx_poll_timeout]
>>>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>>>>> ---
>>>>>     drivers/tty/serial/8250/8250.h            |  1 +
>>>>>     drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
>>>>>     drivers/tty/serial/8250/8250_of.c         |  2 ++
>>>>>     drivers/tty/serial/8250/8250_omap.c       |  2 +-
>>>>>     drivers/tty/serial/8250/8250_port.c       | 25 +++++++++++++++++++----
>>>>>     5 files changed, 26 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>>>>> index 52bb21205bb6..770eb00db497 100644
>>>>> --- a/drivers/tty/serial/8250/8250.h
>>>>> +++ b/drivers/tty/serial/8250/8250.h
>>>>> @@ -82,6 +82,7 @@ struct serial8250_config {
>>>>>     #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
>>>>>     					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>>>>>     					 */
>>>>> +#define UART_CAP_TEMT	(1 << 18)	/* UART has TEMT interrupt */
>>>>>     
>>>>>     #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
>>>>>     #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
>>>>> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
>>>>> index 12d03e678295..3881242424ca 100644
>>>>> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
>>>>> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
>>>>> @@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>>>>>     		return -ENOMEM;
>>>>>     
>>>>>     	/* initialize data */
>>>>> -	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
>>>>> +	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
>>>>>     	up.port.dev = &pdev->dev;
>>>>>     	up.port.regshift = 2;
>>>>>     	up.port.type = PORT_16550;
>>>>> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
>>>>> index 65e9045dafe6..841f6fcb2878 100644
>>>>> --- a/drivers/tty/serial/8250/8250_of.c
>>>>> +++ b/drivers/tty/serial/8250/8250_of.c
>>>>> @@ -225,6 +225,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>>>>>     			&port8250.overrun_backoff_time_ms) != 0)
>>>>>     		port8250.overrun_backoff_time_ms = 0;
>>>>>     
>>>>> +	port8250.capabilities |= UART_CAP_TEMT;
>>>>> +
>>>>
>>>> Shouldn't this be NOT UART_CAP_TEMT set by default? On all other
>>>> vendor specific files you enable it, I think here you shouldn't enable
>>>> it too by default. Right?
>>>
>>> 8250_of does use the em485 emulation - see of_platform_serial_setup()
>>> So I did go by the lazy assumption that any 8250 driver using rs485
>>> before my series always used the interrupt driver code path, so
>>> implicitly required to have the TEMT interrupt.
>>>
>>> Of course, you're right that with the 8250_of maybe not all variants
>>> actually do have this interrupt, so falling back to the polling here might
>>> be safer.
>>
>> Probably here it's worth introducing a dt boolean property like
>> "temt-capability", then you set or not UART_CAP_TEMT according to its
>> presence in dts. This way all cases are covered and we can act
>> completely through dts files.
>>
>> What about that?
> 
> Sorry that this was sitting around for over a month.

np at all

> I think there are two problems with this:
> 
> (1) this would break backwards compatibility ... right now the whole code
> just assumes that everyone does support the TEMT interrupt, so adding
> a property to keep it working would break old DTs, which is something that
> should not happen ... I guess one option would be to use the inverse
> no-temt-interrupt
> 
> (2) uarts handled by 8250_of are still identified by their compatible
> though and there is no generic 8250-of compatible, so the
> presence / absence of the temt capability should actually just be
> bound to the relevant compatible.
> 
> 
> So my "gut feeling" is to just keep the current way
> (was expecting temt-capability before anyway) until an uart
> variant without temt comes along

I agree with you, what I was proposing is another thing more to do an
can be done when needed.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
