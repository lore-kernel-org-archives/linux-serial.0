Return-Path: <SRS0=FrDw=4M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F6AC3567B
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 07:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15CF20714
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 07:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="TgxEEuOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgBXHwn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:52:43 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:45143 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXHwn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Feb 2020 02:52:43 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 975662305A;
        Mon, 24 Feb 2020 08:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582530759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBxlnsiSNn4IX2ytnABMPUzdL3xMEAvDHZtEeRFmG94=;
        b=TgxEEuOOX2NQW0xSnlCCubFfdMs868+Mu+uyGOlDyWzMFhoT8PGDwgoJnWGTwPZBdcMtB/
        cpZ+J+O2fOrzeGoWpoavutSwiW9RL3neWAD1MkQvs9AHS4TpAf6QV55O/k/J1X0etziHd/
        rn+acdcNfpQ65nRlFndPz78IjYnTboM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Feb 2020 08:52:38 +0100
From:   Michael Walle <michael@walle.cc>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Yuan Yao <yao.yuan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
 EARLYCON_DECLARE"
In-Reply-To: <AM0PR04MB4481B36B83A67E32EA816A5988EC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20200220174334.23322-1-michael@walle.cc>
 <AM0PR04MB44817308EA80EBEDC0338E6D88120@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <51db0e6ba10b4b32dab207e0df8ef0d8@walle.cc>
 <AM0PR04MB4481B36B83A67E32EA816A5988EC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Message-ID: <d549c0ec7d39d38492a9680fc66fe86f@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 975662305A
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         NEURAL_HAM(-0.00)[-0.594];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,


Am 2020-02-24 02:12, schrieb Peng Fan:
>> Subject: Re: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
>> EARLYCON_DECLARE"
>> 
>> Hi,
>> 
>> Am 2020-02-21 02:30, schrieb Peng Fan:
>> >> Subject: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
>> >> EARLYCON_DECLARE"
>> >>
>> >> This reverts commit a659652f6169240a5818cb244b280c5a362ef5a4.
>> >>
>> >> This broke the earlycon on LS1021A processors because the order of
>> >> the
>> >> earlycon_setup() functions were changed. Before the commit the normal
>> >> lpuart32_early_console_setup() was called. After the commit the
>> >> lpuart32_imx_early_console_setup() is called instead.
>> >
>> > How do you pass earlycon args to kernel?
>> 
>> earlycon=lpuart32,mmio32be,0x2950000,115200
>> 
>> please note that there are two possible declarations: (1) an OF/ACPI 
>> based
>> earlycon, eg just "earlycon" on the bootargs and (2) an elaborate one 
>> where
>> you can give the offset and access method yourself, eg. the one from 
>> above.
>> 
>> (1) will still work even with the EARLYCON_DECLARE() removed. But (2) 
>> will
>> search through all possible
>>    OF_DELARE_EARLYCON(lpuart32,..)
>>    EARLYCON_DECLARE(lpuart32,..)
>> 
>> and doesn't take the compatible into account. So which setup function 
>> is
>> actually called depends on (a) the order of the OF_DECLARE_EARLYCON() 
>> and
>> EARLYCON_DECLARE() statements and (b) on the compiler (thats just a 
>> guess!).
>> For me, the order in which it will actually end up in the 
>> __earlycon_table is
>> reversed, eg. the last one is called. So now that you've removed the
>> EARLYCON_DECLARE() the last one is the imx setup function which will 
>> add
>> the reg offset and doesn't work on LS1021A.
> 
> You mean the OF_DECLARD_EARLYCON for i.MX7ULP will be put before 
> LS1021A
> in Image? I am not sure about this. If this is true, you could try
> below diff, to see

well, you could have a look at the disassembly; so no need for real 
hardware,
if thats what you're missing.


> whether it works. i.MX always use little endian.
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c 
> b/drivers/tty/serial/fsl_lpuart.c
> index 91e2805e6441..1b0aa3b836c5 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2381,8 +2381,10 @@ static int __init
> lpuart32_imx_early_console_setup(struct earlycon_device *devic
>         if (!device->port.membase)
>                 return -ENODEV;
> 
> -       device->port.iotype = UPIO_MEM32;
> -       device->port.membase += IMX_REG_OFF;
> +       if (device->port.iotype != UPIO_MEM32BE) {
> +               device->port.iotype = UPIO_MEM32;
> +               device->port.membase += IMX_REG_OFF;
> +       }
>         device->con->write = lpuart32_early_write;
> 
>         return 0;

while that would also fix the problem (I guess; I'm too lazy to try), it 
is
really bad because:
  (A) it doesn't fix the underlying problem that there are multiple setup
      functions for lpuart32 (and this is not only a problem for 
lpuart32)
  (B) it would've broken the lpuart32 for IMX in the form (2), if it had 
ever
      been working.
  (C) it will break if some developer adds a new setup function to the 
end of
      the list
  (D) you basically make every setup() function behave like the ls1021a 
setup()
      if its called in form (2)

Please, lets try to find a more generic solution for this, like my 
proposed
patch [1].

-michael

[1] 
https://lore.kernel.org/linux-serial/20200220174607.24285-1-michael@walle.cc
