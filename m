Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB4C3DA78
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 13:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjAQNaf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjAQNab (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 08:30:31 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29BE34C2C
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 05:30:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt14so16462324ejc.3
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7PtDi568nvDZ7QnbHicw2+ReSJgi7Uak7xLuSiA0KqQ=;
        b=SBs0BfNwPz7megYdnthzbaZmwfnZU+4A37DMer3pNrTUX0/t00a0XT2WQsIHigUqC0
         cBopAACIqOyMJwd0/lLBrR1FmEDnZge3o+ZdaBiNnpEXc/I4foOZxy4vBRBvSDIh/lr/
         grAnf/ONS6A+Uz+aCiU+3alXcxo8uH0/IaRNkToq8SRaSTZiRD+rg85x9IaWax/AGexE
         TxjAQkvqYHBwuIfpZl8dMl3Hf61N64zY7qXXfnCOQr8As4d7P63wXX9Iy/AHgGw8tfA+
         w6fhe12nwEfKUrrjAOLnfAShT1jOqZV1kL4iq/TEF8x4zGWRiVzMUk6F/I31x9fJUxJN
         91GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PtDi568nvDZ7QnbHicw2+ReSJgi7Uak7xLuSiA0KqQ=;
        b=AIdqND2MebOr/syK/s4Toji17F6W19YgpPZAPnv/iY+C/4mMdfZf8uCqbD1QACIkbZ
         56E9TCu4Gf3dqi4KrLBiuuIJ8zPfm1M+90CakDIqhikLP3QTzPML4h98WTY3b2vh12bx
         lPp4CgOVaZ621gitLINzAAwMVGzADPRCQkRJr5TZvUUcxiLWcMKzA4CO7NwkEgxuumsc
         Jhyv9Jii/yvHbkmjldUcV2VpI3Dms+/hLxqZCZ7Agzam/OkZladOjJhMD9gGXMyIUO3X
         vHoAvZ9PLniPvoWH3XJ+Zocu2BaG3/3W8p6K6UVyP7ybjX2rP5B07OaSgFQPbvZOM2Ot
         zRCg==
X-Gm-Message-State: AFqh2kqN2ocO8eSmhpj8M+p3Zra6M7Pts+cXmEIZQK+kABiJFIMIJk+J
        Ypfsv9O7JIchSowN1nRibA+sFgNqN38=
X-Google-Smtp-Source: AMrXdXtJVKsxuYXFr8ERmErZSCQZmV+juzZiDfpJQ4l4VRCGIDAoeXHAC6J5kO8YtAnqP3FtsgE61Q==
X-Received: by 2002:a17:907:ca07:b0:86e:cb6c:4462 with SMTP id uk7-20020a170907ca0700b0086ecb6c4462mr2648376ejc.36.1673962229132;
        Tue, 17 Jan 2023 05:30:29 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm10359629ejb.99.2023.01.17.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:30:28 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 6/8] serial: imx: stop using USR2 in FIFO reading loop
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230113184334.287130-1-sorganov@gmail.com>
        <20230113184334.287130-7-sorganov@gmail.com>
        <3c9ab74b-ff90-8371-75cd-1d2f7abb388d@linux.intel.com>
Date:   Tue, 17 Jan 2023 16:30:26 +0300
In-Reply-To: <3c9ab74b-ff90-8371-75cd-1d2f7abb388d@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Mon, 16 Jan 2023 12:54:19 +0200
 (EET)")
Message-ID: <874jsp47bh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:

> On Fri, 13 Jan 2023, Sergey Organov wrote:
>
>> The chip provides all the needed bits in the URXD0 register that we read
>> anyway for data, so get rid of reading USR2 and use only URXD0 bits
>> instead.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 18 ++++++------------
>>  1 file changed, 6 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index c44a7293c013..be00362b8b67 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -892,27 +892,21 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>>  	struct tty_port *port = &sport->port.state->port;
>>  	u32 usr2;
>>  
>> -	usr2 = imx_uart_readl(sport, USR2);
>> -
>>  	/* If we received something, check for 0xff flood */
>> +	usr2 = imx_uart_readl(sport, USR2);
>
> Please just place the read into the correct place in 2/8 rather than 
> moving it needlessly here again.

Well, this I considered and rejected already, before publishing the
patches.

In 2/8 this read was an initialization for the entire FIFO reading loop,
the value being re-used for flood check at the beginning as well, and
with this patch it becomes just a local read for subsequent 2 lines of
code that perform flood check, not used in the FIFO loop anymore, so I
moved it in this patch to where it now belongs.

Thanks,
-- Sergey Organov
