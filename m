Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC5C71156
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFB62080A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMgWetRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLAKsl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAKsl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 05:48:41 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F2C0613D2;
        Tue,  1 Dec 2020 02:48:00 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id p21so618202pjv.0;
        Tue, 01 Dec 2020 02:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAFYxzGzkBEUMFK3NS6Q6bqv6vlixBH5vwa4XwPAREI=;
        b=aMgWetRkgiQlzBcnjuqoBLvrtDiSxk3dd7BF7laNfqg0dVZq/Ys9//QA8Y2dR50eoK
         BjtC/FyBS43nFPuT+zDcSKLy5ierhmZpnciYRZRN08GLpfHfLPfEXXi4pf8tZkV+IJFQ
         /5DvIVZ+Q5uAqowvcNOlX/PRPd1tbDPGff87umjMa+CmPJMncouOKtfLEkLrqXE8ggfs
         l5p/yEEyS1M+stze1lNgg9AHJrzHIJMAm5SCLtsn4DtGwWQdHV6lQ1rbosqi1Cuzna3r
         d5vyK5u7kEFgHKcVYWCwEXB1TPWjIWiQnvCqumUKqC4klCtnYyif3SdGUaCoEsgwZt+w
         GcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAFYxzGzkBEUMFK3NS6Q6bqv6vlixBH5vwa4XwPAREI=;
        b=WGkiJf3xaMW6o0qKcnoPI83MyO0z7zQSOtOmKbi/53jhKzsmS1QqxH9VnBV1gci7Va
         t8+3iKaOVHqvdn8NHh+SQOv999aBcPN99cXR59qSlF5nwBYzwV34XBNrRh8JUakO1vc9
         9DMYXtSOosgSbQvl9A6CBd6BSmtcle0vKKARohku/HxTw6Tu7v4c4ac7o+a+7x6XR26g
         nlBDb4PKfdEC/kYQ/OqqKyj0gv8ql4Ssf3MX+dOdzMHUZXH4vuagLtMICiFVme4GJCtc
         L4KwmFfbKT1FBYjHitmRokmdBYzgEiz6GnBafOTADtdHEL7dVVYGxR57HsxxnS/5RgUa
         Ma4g==
X-Gm-Message-State: AOAM531WQe5+YbpK2w0AhaKDBzfkBsclOrMI9BMfCiqZtElpIB2Zcdh2
        Q3YYnSFXqEX+ntb/adtFrfTg0KY7TcuRfczUlOC5kkcY6Lk=
X-Google-Smtp-Source: ABdhPJybJttySzBcB8mUcCOhXY2iYo1MWFQ+O19jtlDiSo1oBka3wDfRWYJ98cDB/pPAriIxy6F+McyC4OGLXUQEyI4=
X-Received: by 2002:a17:902:ac93:b029:d8:d2c5:e5b1 with SMTP id
 h19-20020a170902ac93b02900d8d2c5e5b1mr2237976plr.17.1606819680128; Tue, 01
 Dec 2020 02:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20201130153742.9163-1-johan@kernel.org> <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
In-Reply-To: <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 12:48:48 +0200
Message-ID: <CAHp75Vczx=qjNed-8nwm6iSq5sxUKE2mXzPSd70zUxumZ5sANQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 30, 2020 at 11:25 PM Mychaela Falconia
<mychaela.falconia@gmail.com> wrote:

...

> Johan's patch comments say that the new flag can also be brought out
> to termios in the future, similarly to HUPCL, but I question the
> usefulness of doing so, as it is a chicken and egg problem: one needs
> to open the tty device in order to do termios ioctls on it, and if
> that initial open triggers DTR/RTS hardware actions, then the end user
> is still screwed.  If Johan or someone else can see a potential use
> case for manipulating this new flag via termios (as opposed to sysfs
> or USB-ID-based driver quirks), perhaps you could elaborate on it?

Thanks for the very detailed description of what you are working on.
Unfortunately I have no thoughts about alternative solutions.

> Andy Shevchenko wrote:
>
> > > Add a nordy sysfs attribute to suppress raising the modem-control lines
> > > on open to signal DTE readiness.
> >
> > Why not call it nomctrl ?
>
> I have no opinion one way or another as to what the new sysfs attribute
> should be called - my use case won't involve this sysfs mechanism at
> all, instead I care much more about the path where the tty port flag
> gets set via a driver quirk upon seeing my custom USB ID. :)

Then why do we bother with sysfs right now? It's an ABI and Johan is
completely aware and knows that once it's in the kernel it is close to
being carved in stone.
I would vote to remove sysfs from now and see if we really need it in
the future.

-- 
With Best Regards,
Andy Shevchenko
