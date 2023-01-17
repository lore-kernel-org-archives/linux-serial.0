Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA6C54E76
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 17:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjAQRqz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjAQRqD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 12:46:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14123582AC
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 09:35:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y19so12533075edc.2
        for <linux-serial@vger.kernel.org>; Tue, 17 Jan 2023 09:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBcV6TpSZek+zC6eLNUBmrWBC/v5aj5VGymFY1M5tEE=;
        b=RA3xdITmXjDDedWzrBSj/TWs/AXIFYtLD23tw9KzzTLbe9tAPx23rFGLqE9t24OUVu
         K3PWz6B40BPNNT1pMQHXbsTzy41GlIogcczWrMvbJy9NXPgU9WaHqLKJ87dOs2IM/6Zt
         A0TWsqfdXJL7TzvlzSTlVGANEmOXctI9sbLnaXA50aDEvhphseamUN4gnpC2OozVhC2H
         KssL82WmikXCCevOO/TkOddaS20zrNRWolv8d7bAzJkkjaPKthlAVEeGeGYFeCWMhQKp
         TlFfw/vi22Y85j73RT2llVSFIPJT9cO7goAj+sTzAdZ3t3g2dXTEiL3iwOv1xM5lCgJi
         Xyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBcV6TpSZek+zC6eLNUBmrWBC/v5aj5VGymFY1M5tEE=;
        b=JhhKMaPfaJNkov0KP9Do9x25glNIlwNkSlfRFF849ZcR/lFR3AiCnt1WaB3Csxtrri
         59BfdkgO0Sp/K9J32iQqnct2tqrScGTI5dA9LLU3OTnTVAWZ2+PPWsbE5z3XUmFrbfTM
         CidQlFSd+WT0RDEeDxw+r980uhLDqBJzBstHL9BuG+h2r9Oees/qSL8+LBoqCgcMpHlW
         aCNVjrF5Y7RQUlFW0v4iXCX5+NHSeLwOgrHjGdDoOwCITzm+1i5QiSVKOhrKnQhm5qLn
         po/jFtAWO27UocBQWOyR1SwW8IzAxc5pE23MzXgiAwXSHLicLWpqsxgyUHWCcT6TC6Ty
         0pRQ==
X-Gm-Message-State: AFqh2kqU0FQF+9fo0L9129T8N3uM8gxsVwwZd48zNK79bV3W55CPfQl8
        wW7nye9ODZ8qUm438je3W9A=
X-Google-Smtp-Source: AMrXdXsXZQZidqD8+utTNQkDN7Ji/DhtgsUO/MLJ6PODoHOXjmdB3mHBN8U+lXBE0VFmkB4Hrja4BQ==
X-Received: by 2002:aa7:db8b:0:b0:49b:b274:b816 with SMTP id u11-20020aa7db8b000000b0049bb274b816mr4093847edt.37.1673976951462;
        Tue, 17 Jan 2023 09:35:51 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g11-20020a056402428b00b004722d7e8c7csm13010862edc.14.2023.01.17.09.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:35:50 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Johan Hovold <johan@kernel.org>
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
Subject: Re: [PATCH 3/8] serial: imx: do not sysrq broken chars
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230113184334.287130-1-sorganov@gmail.com>
        <20230113184334.287130-4-sorganov@gmail.com>
        <Y8VsFx3p+viCp1It@hovoldconsulting.com>
Date:   Tue, 17 Jan 2023 20:35:48 +0300
In-Reply-To: <Y8VsFx3p+viCp1It@hovoldconsulting.com> (Johan Hovold's message
        of "Mon, 16 Jan 2023 16:24:07 +0100")
Message-ID: <87sfg92he3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> On Fri, Jan 13, 2023 at 09:43:29PM +0300, Sergey Organov wrote:
>> Do not call uart_handle_sysrq_char() if we got any receive error along with
>> the character, as we don't want random junk to be considered a sysrq.
>> 
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  drivers/tty/serial/imx.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index e7fce31e460d..1c950112a598 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -911,9 +911,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>>  				continue;
>>  		}
>>  
>> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
>> -			continue;
>> -
>>  		if (unlikely(rx & URXD_ERR)) {
>>  			if (rx & URXD_BRK)
>>  				sport->port.icount.brk++;
>> @@ -942,7 +939,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>>  				flg = TTY_OVERRUN;
>>  
>>  			sport->port.sysrq = 0;
>> -		}
>> +		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
>> +			continue;
>
> Nit: missing braces {}
>
> Note that you could also place just place this after the block due to
> the reset of the sysrq time stamp.

Thanks, I think I'll opt for adding braces. Relying on the reset of the
timestamp feels a bit convoluted.

-- 
Sergey
