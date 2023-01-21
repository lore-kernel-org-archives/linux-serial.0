Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE8C38142
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 21:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAUVFA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 16:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAUVE7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 16:04:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6D1F5EA
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 13:04:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz11so22051831ejc.0
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPa+6EK8AKVSjpuJR3mx7O0BaY8v3OeMxyFJexLfe8s=;
        b=N/U4JY9pmKH6wk/jUD27yjs7prEI9IXwjaACYeK0/up+EJT1X8wGW94obDSQTVbpOo
         6kGqxqojEd+Dqvkpyhm+Yu765K9vCgu/s/Uo6ktZ+JJaUjTO85WWt0iyLJetU5QsEFFR
         tM5IrPxkXU+/nROh+oH5KkRJ99dA/S4oCkSrsLatM9YTwsJmLI+5Te+RRR54j0a8HOY4
         co7joIQSN+QMBXhEVpwtPjw5yCDZoheZimEdVz3pI4LRFCwdErydaG+N4jVWVb2OP6KI
         uvuZBHnVGXoCLPSaSLDx0XpvQGxVxCfoZmQEfjZCG9eHApnBihtg1R8AO6uzUbSdvc0B
         31pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPa+6EK8AKVSjpuJR3mx7O0BaY8v3OeMxyFJexLfe8s=;
        b=IX9D/dmrkgcaV3R09Kj40vfgw8r2HIvnAMsVaC4j00Rqc/2hIyhEH/CmIZumgP625f
         wb9FZVgbVbSxWk3E6EdLSmNYm62h9/2DXyX7gqxeLa/Cs10P6k9Dvj22n4D6gH9HwwsG
         4K3pn+UjqrpFgg3GBgE8L3UN8GC5H9VIzVDC+6CPONIe3lx/MDSkOUikOP/e41fGDgB5
         vnyqo/OPZ9lShNbofRJ3+U/fPYJU4ZRGBiTjhz9rLcUGxl2yx6Xgf8ziQX+a3TBSP1en
         889sK/Is0TtcZ7Z1pK8NeRrRPUcRcYrQXEtPgwFlcliHj3jKA1+IPqiMnHY9WJA5qnbV
         9uWQ==
X-Gm-Message-State: AFqh2kqDopenSBx4EX2VqucfVgg7ApFk0IEfWt7auCCDdOaQBmFa0xFW
        K6xDxrQ8f0tonvBKnClBbL1yv4oPsYE=
X-Google-Smtp-Source: AMrXdXtZ3opKlzpSg8/onoS+2wKmXlH6Kai+xR9iPu81bFxVOKaPAkS7AqSSBQK6iH1dBUKNbBD3ug==
X-Received: by 2002:a17:906:5a5c:b0:877:593a:58ef with SMTP id my28-20020a1709065a5c00b00877593a58efmr15119384ejc.77.1674335096784;
        Sat, 21 Jan 2023 13:04:56 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906101400b0085ff05d5dbdsm14519224ejm.173.2023.01.21.13.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:04:56 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v1 3/7] serial: imx: do not sysrq broken chars
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230121153639.15402-1-sorganov@gmail.com>
        <20230121153639.15402-4-sorganov@gmail.com>
        <6dc81996-6ffc-c1bc-6c3f-ca65055c94a2@i2se.com>
Date:   Sun, 22 Jan 2023 00:04:54 +0300
In-Reply-To: <6dc81996-6ffc-c1bc-6c3f-ca65055c94a2@i2se.com> (Stefan Wahren's
        message of "Sat, 21 Jan 2023 17:12:07 +0100")
Message-ID: <87fsc3wqdl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Stefan,

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Sergey,
>
> Am 21.01.23 um 16:36 schrieb Sergey Organov:
>> Do not call uart_handle_sysrq_char() if we got any receive error
>> along with the character, as we don't want random junk to be
>> considered a sysrq.
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>
> this looks like a bugfix to me. Since the relevant code is pretty old,
> i'm not sure about the fixes tag here:
>
> Fixes: 279a9acc9b72 ("2.6.11 import") ?

Dunno. I've checked a few drivers, and it seems that they don't care
either, e.g., look at atmel_serial.c, or mpc52xx_uart.c.

Either it doesn't matter, or a few drivers need similar fix? What's
going on here, I wonder?

Thanks,
-- Sergey Organov
