Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCA4C63797
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjAQNmd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjAQNmX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:23 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CCB35263
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 05:42:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ss4so68147028ejb.11
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 05:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tT9+QHsQAB0PxMA24zm4eZ5A1QSOhTgJqn8OjV/yXcY=;
        b=FNLyWZCdFRUqEbzYoztO6wpFlFdRh4yc+uJrvy7SRszcDZBx+NO3pWU9g3a634g8rt
         QvZX5AssPFmrSznXjHQpoCSKCqxLByR2IUA/1zDkAeptZB4rVunb9Sr/NGpVQCkHsG0F
         Z6btkX9YpQdSP2dtWfRRW2kFhjgcvHm80tsC2ltb81JAngoTDl+2xbgsLW8VeeLuS8Xr
         UN9hpIvs1AGcV24VTYsDUO+z36cDbcoxGJ2MBZbiOqROmf/Kq3XHm7Q5pC08vO/zm32e
         DV61k+ns8ZO3s0gNWPDuc48eQl9wfKGvekhrJEtuFagR1PoTZVlVvkRSv2MwdDsUcmqq
         1gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT9+QHsQAB0PxMA24zm4eZ5A1QSOhTgJqn8OjV/yXcY=;
        b=mSyKEY/aXDz40fwiSR6W0XqWba5gzoUY+hZ8nNG+w955nxDpDZA9ZwZpp2VvNfQkA7
         Z7EyjXK5JcLWebnepy7LLUXw6zc70wVlillrtYf/dMpRd258u+SVYI1fSNjmnTOM+b6c
         nNNPRUt1Og0AowIsW9YmaXH+Ysv+ekiADj4I65JE3QUbAVfes9K7MngdRqDLFFigqExk
         JatXlJYg0CnDXZjGW1jgGP4duQkGug1Mj10IAs6YZQVdQwD/zA1UD3gSTB4i5iFstJk8
         yrtAbQ1fjdfCFG6X7T4bvk6m5GSKIpoX/0mhk/RyULHH3gX3Y93SjzUgWBU1aQ7bm5IQ
         YEtA==
X-Gm-Message-State: AFqh2kofHuk5wkL1EVstq/a9b/tillCa7ZQqEOAYP5fmM1+kFsgPsEqx
        HqO+xzK52VxzcpGPiXCp6/8=
X-Google-Smtp-Source: AMrXdXuRr5a4vSOw6uC/PdkfBRuwM2STtP5F8GXDgozazU7NDAUk9k8z9ECs+lEhbm6A75HccHUyoQ==
X-Received: by 2002:a17:906:8d86:b0:870:dceb:696d with SMTP id ry6-20020a1709068d8600b00870dceb696dmr7440364ejc.43.1673962936420;
        Tue, 17 Jan 2023 05:42:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906970200b0073dbaeb50f6sm13045168ejx.169.2023.01.17.05.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:42:15 -0800 (PST)
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
Subject: Re: [PATCH 1/8] serial: imx: factor-out common code to
 imx_uart_soft_reset()
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230113184334.287130-1-sorganov@gmail.com>
        <20230113184334.287130-2-sorganov@gmail.com>
        <aa3d9c37-369b-5163-79f6-6dc213e92bc9@linux.intel.com>
Date:   Tue, 17 Jan 2023 16:42:14 +0300
In-Reply-To: <aa3d9c37-369b-5163-79f6-6dc213e92bc9@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Mon, 16 Jan 2023 12:30:11 +0200
 (EET)")
Message-ID: <87y1q12s7d.fsf@osv.gnss.ru>
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
>> We perform soft reset in 2 places, slightly differently for no sufficient
>> reasons, so move more generic variant to a function, and re-use the code.
>> 
>> Out of 2 repeat counters, 10 and 100, select 10, as the code works at
>> interrupts disabled, and in practice the reset happens immediately.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 73 ++++++++++++++++++++--------------------
>>  1 file changed, 37 insertions(+), 36 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 757825edb0cd..bf222d8568a9 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -397,6 +397,39 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>>         hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
>>  }
>>  
>> +/* called with port.lock taken and irqs off */
>> +static void imx_uart_soft_reset(struct imx_port *sport)
>> +{
>> +	int i = 10;
>> +	u32 ucr2, ubir, ubmr, uts;
>> +
>> +	/*
>> +	 * According to the Reference Manual description of the UART SRST bit:
>> +	 *
>> +	 * "Reset the transmit and receive state machines,
>> +	 * all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD
>> +	 * and UTS[6-3]".
>> +	 *
>> +	 * We don't need to restore the old values from USR1, USR2, URXD and
>> +	 * UTXD. UBRC is read only, so only save/restore the other three
>> +	 * registers.
>> +	 */
>> +	ubir = imx_uart_readl(sport, UBIR);
>> +	ubmr = imx_uart_readl(sport, UBMR);
>> +	uts = imx_uart_readl(sport, IMX21_UTS);
>> +
>> +	ucr2 = imx_uart_readl(sport, UCR2);
>> +	imx_uart_writel(sport, ucr2 & ~UCR2_SRST, UCR2);
>> +
>> +	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
>> +		udelay(1);
>
> This could use read_poll_timeout_atomic().

As this is just a factor-out of existing code that uses the loop, I'm not
sure if it's a good idea to change this along the way.

Do you want me to add yet another patch to the series? I'd rather not,
as I won't be able to test it on my outdated kernel anyway.

Thanks,
-- Sergey Organov
