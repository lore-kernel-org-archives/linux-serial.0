Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF6CC3DA78
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 17:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjAQR4O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjAQRyG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 12:54:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3593D0A6
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 09:43:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vm8so77116719ejc.2
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 09:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ORyvxq+z9WkQfBJYa6nT9E5g6aSbxlC1oY+UU1ufU10=;
        b=Biigjaa2oK4oOdDHQs7Lg4BifDSSLpsCHyAHV6s1JcONsN4saf9RLMjuS+Xxsrs8la
         J+f3s4jd2Xn3xen2E3NX4075Y4xMgvTX6iSn1zJMBnTe/63YI7GX4Uo3Rukc25z+dntX
         ELz2w7DtbHy3tHZ8ND2M4KdXqzo3DVipUBG2NlUGW6WmvVmIlu/Bzmqb+G9UMYUdpcXK
         tKkATZJWbP+EKu6aSs6Gf9EXN+mueioHzEn8aGnGW5uaQ4HnuWLmqZLAyg+Nnbi1A6xW
         KbVNBS1KtGhYMBBaeWuolvRE4Z9KuD3m74rXbCC0sd3l/L3mIIRld3pkuvnrvC/nmXFT
         C1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORyvxq+z9WkQfBJYa6nT9E5g6aSbxlC1oY+UU1ufU10=;
        b=NquK2ANwfWtorBUitWTjRdi/OgMP2WJsmKH3Xl6MqouyNT4nqgUyEHo1XNOEowozCG
         L4YP4L4G2Syiw8PT55CKYtXfXHIoaBsUrGBTscGXTZfbXZemNB79C3xd4dJ4hgnjZ66g
         WrPRiMq/VuA2FSsY9ezoSUk1RNGpSGq0+Jn0+y7EjVs5GZKaqzsh0RD+tEHXoeckkG2a
         9QHnVpqyZ4r+JF63CRsO7SPYQpB9/dQoKYDF0m0plHlcsTCAHrmTrrkRPy5LdKDjyoMe
         gljM1TsOxOhQx62TfTFP+jL/0dSF4JmKoxDRJhYUw4C46s9B2FoCLpOAHJAkTn+8YPM2
         Jd0w==
X-Gm-Message-State: AFqh2kq5SeS/1Cf8v7/rqPNNT/Qul4hfwltE5EtUgcbvYLNPZVOq13Oq
        ZhTodC9+0PrQ+OWKPdPok4blGctkRNI=
X-Google-Smtp-Source: AMrXdXsjr0BzsxRjthdH9Y7u8o4YXPgIZKlmz1+zVACKYtDl+WnXrJgQpeY26w04ZP1pf4viydxcLg==
X-Received: by 2002:a17:906:e2cd:b0:870:2aa7:6509 with SMTP id gr13-20020a170906e2cd00b008702aa76509mr3897157ejb.43.1673977437598;
        Tue, 17 Jan 2023 09:43:57 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0087221268e49sm1647202ejr.186.2023.01.17.09.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:43:57 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
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
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading loop
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230113184334.287130-1-sorganov@gmail.com>
        <20230113184334.287130-8-sorganov@gmail.com>
        <48ba84e3-7f52-9cfb-426a-a432587c1c9@linux.intel.com>
Date:   Tue, 17 Jan 2023 20:43:55 +0300
In-Reply-To: <48ba84e3-7f52-9cfb-426a-a432587c1c9@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Mon, 16 Jan 2023 13:03:23 +0200
 (EET)")
Message-ID: <87lem12h0k.fsf@osv.gnss.ru>
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
>> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
>> we read registers that must not be cached.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index be00362b8b67..f4236e8995fa 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
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
>>  		flg = TTY_NORMAL;
>>  		sport->port.icount.rx++;
>
> I'd just make a uport local variable and use uport->membase + xx. There 
> are plenty of sport->port constructs to replace with uport in that 
> function anyway.

OK, thanks, will do it this way. Probably with global rename over this
function in a separate patch?

-- 
Sergey
