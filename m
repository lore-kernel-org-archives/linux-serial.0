Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E69C3DA78
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 18:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjAQSGi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 13:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjAQSAY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 13:00:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D7539B6
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 09:48:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v6so46102540edd.6
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 09:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G67vv37nXrP7N2YLh8GUv3IGBHMNFwcEMn21AToWGSU=;
        b=pHU7sSSdMsFN3vOEpx5899GSAchHDkxi0WTQJSK1D01Et60CqYw1BLQKvAAPDSrzID
         r174o/2MLjSakXSWCLFJN1YCBtfRzcUd2nZytWV5Uo62wcijLPHJiy8wJS67EgDXOtxK
         zAIeTYPJ/Ek5F4mfKPm/vQH05jS6lbRlHGybsL8PsqbZuN+MW++fokjpJiJx8H+QefAh
         478Hd/NUP5U8KnpVup8n6hU2OwWwweIHlNcBXIDrOo9okCLMH+Dm3Fh+OsB/9ANzgRFr
         /9f+lKd17bsRP2gLu1ViRhYCoN044MKL2x6Ny/08XZF4EFKSEbD9ZPwsm/jq1+5iZpMW
         4cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G67vv37nXrP7N2YLh8GUv3IGBHMNFwcEMn21AToWGSU=;
        b=zstRVltU5k1TvcneWgWv/D01gc+qClfA2jia6vjhJg2hqyB4GDXVsifGdI4d7EWLXF
         LuSPIPw8tS3G4VvPOPWdTLZdzVV8hamLJO2SadAa2qGwvQXHGt2opF3s+TuoeXZPhIzP
         KtCVhpI9CFFtFidYip4e/v5EStNsuBFwYmUKOJT8Azzs2ZKZvw/VzvxWDrmhIWi2JjC8
         NMCt9OtCuEThCh9+g7JLe2xpRGtXbVVqVsoF6iRNM5Pu/E12WwWHM3RpY8pygRDnVa+v
         pLW8puwyOawLYCXpQCfZRZIPrhw5zRHRNbdx6/U1+tup9IS+gJgcbMmDM6WJALAfu7VC
         FAmA==
X-Gm-Message-State: AFqh2kpGmDbKyaMOT9l0DMuWB7sqPWKupAf4ME8KAJ7jumbpBKopNQwR
        +FexXx5Zkkqev5W81jxqb7Q=
X-Google-Smtp-Source: AMrXdXuXGPY2gZRY8OvRioa91gubs1hQeOA69yaxAJJSmB5IT8zrZCkzv3fkcw0KWvcRY5Mvp9sbAg==
X-Received: by 2002:a05:6402:25c4:b0:49e:24a4:4f32 with SMTP id x4-20020a05640225c400b0049e24a44f32mr4532026edb.13.1673977696795;
        Tue, 17 Jan 2023 09:48:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id gh9-20020a170906e08900b0086f4b8f9e42sm3609058ejb.65.2023.01.17.09.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:48:16 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading loop
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230113184334.287130-1-sorganov@gmail.com>
        <20230113184334.287130-8-sorganov@gmail.com>
        <AS8PR04MB8404679A61FA6BB7D913C3E192C69@AS8PR04MB8404.eurprd04.prod.outlook.com>
Date:   Tue, 17 Jan 2023 20:48:14 +0300
In-Reply-To: <AS8PR04MB8404679A61FA6BB7D913C3E192C69@AS8PR04MB8404.eurprd04.prod.outlook.com>
        (Sherry Sun's message of "Tue, 17 Jan 2023 10:20:08 +0000")
Message-ID: <87h6wp2gtd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Sherry Sun <sherry.sun@nxp.com> writes:

>> -----Original Message-----
>> From: Sergey Organov <sorganov@gmail.com>
>> Sent: 2023年1月14日 2:44
>> To: linux-serial@vger.kernel.org
>> Cc: Fabio Estevam <festevam@gmail.com>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; Richard
>> Genoud <richard.genoud@gmail.com>; Sascha Hauer
>> <s.hauer@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>;
>> tharvey@gateworks.com; Tomasz Moń <tomasz.mon@camlingroup.com>;
>> linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
>> Pengutronix Kernel Team <kernel@pengutronix.de>; Sergey Organov
>> <sorganov@gmail.com>
>> Subject: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading loop
>> 
>> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know we
>> read registers that must not be cached.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
>> be00362b8b67..f4236e8995fa 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void
>> *dev_id)
>>  	struct imx_port *sport = dev_id;
>>  	unsigned int rx, flg;
>>  	struct tty_port *port = &sport->port.state->port;
>> +	typeof(sport->port.membase) membase = sport->port.membase;
>>  	u32 usr2;
>> 
>>  	/* If we received something, check for 0xff flood */
>> -	usr2 = imx_uart_readl(sport, USR2);
>> +	usr2 = readl(membase + USR2);
>>  	if (usr2 & USR2_RDR)
>>  		imx_uart_check_flood(sport, usr2);
>> 
>> -	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
>> +	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
>
> Actually imx_uart_readl() only set shadow registers for UCRx and UFCR,
> for the USR2 and URXD0 that you used here, they will not be cached.

Sure, and that's why we here don't need to call imx_uart_readl(), that
only needlessly checks for shadowing, thus producing pure overhead.

Best Regards,
Sergey
