Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C60C4321E
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 13:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiE3Nwh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiE3Nvz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 09:51:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666FADF73;
        Mon, 30 May 2022 06:36:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id wh22so20901344ejb.7;
        Mon, 30 May 2022 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=937kmwxUYWQp9ITb4YK1bDcj17pWbp4MJAyEaMgPVI8=;
        b=P6kPWsCrPPP4m4QmX35oeBVlGVewzKEvH4KkZgpHrvLfAmo822AQ3Pe0cKy8E7iSxp
         L7TyMMUZxBWN89nTxyGkmfCTyxgTgvBVfEgAlF3vxkKhZV0D4flO5ryoXtWkRBViSYxR
         +B+HRlhCHl+Iludco8eczAungH4k6ybNUhO0dcM67HNzs9qJW7bhlCCQWcML87N9GkcG
         6qeHVXdOF9BFLRfQ+sUytO0Zfo16JCfV1im0T/wIYBY76SMZK5Ap/kBWIAlLVc5t6Tg+
         UHBZhEmVUnZ04tKFplmuUbmcvCmz66iC1sPKQqOefh23q4J4fwuHjN9p4rZeoZPDkaCL
         do9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=937kmwxUYWQp9ITb4YK1bDcj17pWbp4MJAyEaMgPVI8=;
        b=VfTIeMwUZItU4hLo3FutM7sILMCdHx/xEGJsmLvnj4KZ74cfSNIwhMVlieEQXWCkOJ
         llhPK/H0W7p2KGfNS/FxQiQ6YfBTt6QqJEF8xaQwR6onMnCTneI1tThIYf6XxM0nSf0g
         iyhL05zus1mYVOKNLmoLSZpYH4V1Gpnu/EvPmQdPPGgblnfYyccre42kolfNvhgyg52/
         xkxIJlSiEqDZ4K7/YH3JPkj3rurhE65HieIMlvdzD5giVUSVzLARdXldDKYchsGjGZJL
         MBzgdgH/VUCPP8SRAJi63RE5bzgxFJqj6d5mVrEX90ynCjyOcy/9ByxjA7g/tqe0r9fn
         rsdQ==
X-Gm-Message-State: AOAM530d3vO84GdhMQsZ8kwH0KzZ8i03/oMTvhCt2b/Agdh4CZy2Zuwy
        FrdsoCaygYgQNudSVYo55UZ/vrb67J30MgbyX5I=
X-Google-Smtp-Source: ABdhPJynoTMUIY84GPa2469SMdZmfaKyElHA9Qt9eYR5ODn56YIGffT0w/CJT8Chw/YBmCDiRJi++2Vfw41TEcxidTQ=
X-Received: by 2002:a17:907:6e01:b0:6fe:fe21:8c56 with SMTP id
 sd1-20020a1709076e0100b006fefe218c56mr28697989ejc.579.1653917815205; Mon, 30
 May 2022 06:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220527222718.A21433740218@freecalypso.org>
In-Reply-To: <20220527222718.A21433740218@freecalypso.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 May 2022 15:36:18 +0200
Message-ID: <CAHp75VdjCMjKzmE0pNzhPb9pOPeQ3qpMi925meWsJCHXUNuLiQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] serial: core: fully suppress raising DTR & RTS on
 open if manual_rtsdtr
To:     "Mychaela N. Falconia" <falcon@freecalypso.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mychaela Falconia <mychaela.falconia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, May 28, 2022 at 9:53 PM Mychaela N. Falconia
<falcon@freecalypso.org> wrote:
>
> When manual_rtsdtr sysfs attribute is written as 1,
> TTY_PORT_MANUAL_RTSDTR is set, and the call to raise DTR & RTS in
> tty_port_raise_dtr_rts() is suppressed.  However, there is one other
> place where these signals are also raised on open: uart_port_startup()
> in drivers/tty/serial/serial_core.c - this other point of raising
> DTR & RTS also needs to be suppressed if TTY_PORT_MANUAL_RTSDTR is set.

...

> -               if (init_hw && C_BAUD(tty))
> +               if (init_hw && !tty_port_manual_rtsdtr(&state->port) &&
> +                   C_BAUD(tty))
>                         uart_port_dtr_rts(uport, 1);
>         }

As per patch 1, I would put the custom flag check first.

-- 
With Best Regards,
Andy Shevchenko
