Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3CAC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 12 Feb 2022 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiBLLua (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Feb 2022 06:50:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBLLu3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Feb 2022 06:50:29 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121D2613A
        for <linux-serial@vger.kernel.org>; Sat, 12 Feb 2022 03:50:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 13so21340153lfp.7
        for <linux-serial@vger.kernel.org>; Sat, 12 Feb 2022 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lIrQqj6Xy+e0vqsK1Llae1q8ogM+CHQ1TW9A74hQUsU=;
        b=VN0K7/jsrmWwElXQwr92xxfIacKCbTJECuTZVgSzJV/RKjm21dDZvXnkT1QRgGfA6T
         UdtWSai0wo1dtR8hmGFsHa58/oS8k5YJCu/Fd9i8QBxyXWfbJJcyI8KqQR0BQqaxCgX9
         MRkY4oq0pr/pZa53d7O6Qs7Tm5/9opSzkBNJqvqpYosdTwdjgHKMGB0jHuMcZ4PgMQr3
         /JF7isvJL/uQaK0SN+a1483WkB/NDYVxgjOBKSbUfC8vp2NkSWEqlwnbFlaMnjV/sQTu
         UZE2iAXCXrpc0rnoDAtXhgXzxiSfhR0BDLaqjP6d+LlMBJb7f1qBWh8yi/708ThJWM4z
         cgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=lIrQqj6Xy+e0vqsK1Llae1q8ogM+CHQ1TW9A74hQUsU=;
        b=ldovWsjWPnNYNhji1pAKVMQ6AhuCIa7ZE22kVY1wYnPCBFM31MU7Dga3/UiYF+d7MO
         tCV+PdUtMB5OAEl49E2hVRpQ09XJBnSaI6c4eKXe6PCT7TbExAM85LeSjRq9MVGlWcZM
         PeodNlzxKc7/a2KDjt5PRHskygFtPfEVZoK+MF9UgbE3iRO50U/JxBlWSheGUcp3YAeD
         u0OKIDm5cjbEBB3WxqB67wymluBDUNkdpjle/jE4D7tuuYKuoHeOPwzsfKhWczT3ZMxX
         KAF8XDUCtzODhaMs6lHZ37wxYoW2bPCAxaVvHz37n2lSTY27OurqohoXIChSx1/+uKkC
         rmng==
X-Gm-Message-State: AOAM5332xZC305vT8h/i8KjeCqVY7IQAVrGJRzQC1j5kEnHGO+RR8urU
        jIcfv1o+o2ldNA8crStex/1Iu1LUta0=
X-Google-Smtp-Source: ABdhPJwfCN4ujbAY8UQqmZYMJ+GRp7cO7MVeCdY87PapQaSQrNDqjW8jlO1yOrQxxTthGFP92x4IvQ==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr4398222lfh.304.1644666623885;
        Sat, 12 Feb 2022 03:50:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m26sm3460096lfo.62.2022.02.12.03.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 03:50:23 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Huang Shijie <b32955@freescale.com>,
        Dirk Behme <dirk.behme@googlemail.com>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: Modem control lines for RTSCTS hardware flow control via
 rts-gpio and cts-gpio with IMX
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
        <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
        <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com>
        <c66ae9ce-7345-736c-010e-1dd5602b67df@gmail.com>
        <CAJ+vNU2qk6G_YLAr-1_FP1czBe8wF2OUOTu914zLVNN0Lm9UFQ@mail.gmail.com>
        <CAJ+vNU2ra8g90ZWcwS0xnRq3LO_4Q2PFJo-OuXuBgCpPsXcXkg@mail.gmail.com>
Date:   Sat, 12 Feb 2022 14:50:22 +0300
In-Reply-To: <CAJ+vNU2ra8g90ZWcwS0xnRq3LO_4Q2PFJo-OuXuBgCpPsXcXkg@mail.gmail.com>
        (Tim Harvey's message of "Thu, 10 Feb 2022 13:30:33 -0800")
Message-ID: <87k0e0z4ld.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Tim Harvey <tharvey@gateworks.com> writes:


[...]

> I have found the issue here which causes hardware flow control when
> using GPIO's with the imx UART driver to fail. The
> imx_uart_set_termios() function clears the UCR2_IRTS whenver hardware
> flow control is enabled which configures the transmitter to only send
> with the RTS pin is asserted. In the case of a GPIO being used instead
> of the dedicated internal RTS pin for the uart, this will keep the
> transmitter from ever transmitting. In the hardware flow control case
> where a GPIO is used UCR2_IRTS must be set to ignore the RTS pin. We
> can use the have_rtsgpio flag which is set when 'rts-gpios' property
> is used as a qualifier for this.
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index df8a0c8b8b29..d506cbd679dd 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1674,8 +1674,7 @@ imx_uart_set_termios(struct uart_port *port,
> struct ktermios *termios,
>                 if (ucr2 & UCR2_CTS)
>                         ucr2 |= UCR2_CTSC;
>         }
> -
> -       if (termios->c_cflag & CRTSCTS)
> +       if (!sport->have_rtsgpio && termios->c_cflag & CRTSCTS)
>                 ucr2 &= ~UCR2_IRTS;
>         if (termios->c_cflag & CSTOPB)
>                 ucr2 |= UCR2_STPB;
>
> If this makes sense, I'll send a patch.

To me it does make sense. Driver should stay away from UCR2_IRTS indeed
if software (GPIO) RTS/CTS management is in use.

-- Sergey Organov
