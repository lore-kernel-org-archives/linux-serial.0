Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE8C32793
	for <linux-serial@archiver.kernel.org>; Wed, 18 Jan 2023 15:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjARPoD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjARPoC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Jan 2023 10:44:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A662F79E
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2023 07:44:00 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mp20so37639251ejc.7
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2023 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TS9CCaD3W/Ef+3BKZ1mHmrI6rBrjUs7n/cOcP3Yjhmg=;
        b=Sz5zif0XpsrhWxDQC7aqEmSRXbgFoklqDczGmOyasi4+bAcquxfeb2w9q4G9v7UFEk
         F7vAiyULwgLTKCo78F/UXzpQQLsd+bfXLd/SUEpJ3Z4+A1YjlNCze/h7eECfA+JTrzTX
         1igyU2bg0gGg36iBuGm9U79wTFEcLnTmlGriBgib/Wk+tDIjOKfOWLerI3WLIuw1CduZ
         Z365IY20ugTz2h3EAQl4WRl2D/FUqPEAzkFCGhz50eAlsSmkTpSTybJqdwq9G/zcdd8N
         5HfIP1B1yaA08qABoklA+L6znmIiRuKmLFOWZUTKoALQGgBTzbOtz7UsEUVUkVwQePUR
         3qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS9CCaD3W/Ef+3BKZ1mHmrI6rBrjUs7n/cOcP3Yjhmg=;
        b=20YZxWVwXkWy7rG2cW+SgK8x0JsBTNa2W+veOdrqzMMCMiF2rp7CK2sa1lrcRUGHY/
         ouCg/0viIWCKV/0WXF0ViZPlWPi7mxhZzjZLI5ZEerVfTPXuY8pfceyuMRlGWCklUZ+k
         la3j/9ZJEPi9EVQ3RqQlb2GAD4iTbU/C2NY0uArJDQzkCwHUhV7rRMKH/FXlrFPfRbdd
         Ybkd7jMFKCBQsPzIZbp7+3AZ3flzc6iWnbPdgIqxVVHTfSE6Wy35mwb8Vuq45cHVtkG6
         vzSqvsWIjUT15xBnuBA8Q4cJ2xbwMJS/hioWoY1H6DIWuP6uR7Eflg7I40G2hsNd/aT2
         ZIcA==
X-Gm-Message-State: AFqh2koSHkRVAMYvY9hInLMhEKGKzSd79cJfrVkc7TD2phsX64rTZKsy
        BmHPdBBWhpx1zXj9pkORVuo=
X-Google-Smtp-Source: AMrXdXvOJPASPFYP23YMH/bEYgBLynA6wIJW70hAqoXhinXvT07+SEnHOlJuMvPK3/LsNzeRVEk2Pg==
X-Received: by 2002:a17:907:98f4:b0:872:6bd0:d25 with SMTP id ke20-20020a17090798f400b008726bd00d25mr7447296ejc.37.1674056639300;
        Wed, 18 Jan 2023 07:43:59 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906970200b0073dbaeb50f6sm14664730ejx.169.2023.01.18.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:43:58 -0800 (PST)
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
        <87lem12h0k.fsf@osv.gnss.ru>
        <be325aca-843-f7a7-cd8e-447cf4f7bf7@linux.intel.com>
Date:   Wed, 18 Jan 2023 18:43:56 +0300
In-Reply-To: <be325aca-843-f7a7-cd8e-447cf4f7bf7@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Wed, 18 Jan 2023 10:24:13 +0200
 (EET)")
Message-ID: <87edrrzw3n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:

> On Tue, 17 Jan 2023, Sergey Organov wrote:
>
>> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:
>> 
>> > On Fri, 13 Jan 2023, Sergey Organov wrote:
>> >
>> >> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
>> >> we read registers that must not be cached.
>> >> 
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  drivers/tty/serial/imx.c | 5 +++--
>> >>  1 file changed, 3 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> index be00362b8b67..f4236e8995fa 100644
>> >> --- a/drivers/tty/serial/imx.c
>> >> +++ b/drivers/tty/serial/imx.c
>> >> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>> >>  	struct imx_port *sport = dev_id;
>> >>  	unsigned int rx, flg;
>> >>  	struct tty_port *port = &sport->port.state->port;
>> >> +	typeof(sport->port.membase) membase = sport->port.membase;
>> >>  	u32 usr2;
>> >>  
>> >>  	/* If we received something, check for 0xff flood */
>> >> -	usr2 = imx_uart_readl(sport, USR2);
>> >> +	usr2 = readl(membase + USR2);
>> >>  	if (usr2 & USR2_RDR)
>> >>  		imx_uart_check_flood(sport, usr2);
>> >>  
>> >> -	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
>> >> +	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
>> >>  		flg = TTY_NORMAL;
>> >>  		sport->port.icount.rx++;
>> >
>> > I'd just make a uport local variable and use uport->membase + xx. There 
>> > are plenty of sport->port constructs to replace with uport in that 
>> > function anyway.
>> 
>> OK, thanks, will do it this way. Probably with global rename over this
>> function in a separate patch?
>
> Yes, it is better to have it in own patch.

Well, it now seems that I'll drop this patch altogether, by agreement
with Uwe. Do you think introducing of 'uport' still worth it in this
one function? I figure it's probably not, provided the reset of the code
in the driver still doesn't use the idiom.

Thanks,
-- Sergey
