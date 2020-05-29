Return-Path: <SRS0=RakX=7L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CABDC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 12:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401EE20776
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 12:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID4REpDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2MED (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 May 2020 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2MEC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 08:04:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F32C03E969;
        Fri, 29 May 2020 05:04:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id c75so1413885pga.3;
        Fri, 29 May 2020 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mnz73Vl3a4PfmC0Z2phyqbZVdHEOz6JLhDTMxB2wsIM=;
        b=ID4REpDkr7y96phQaJslv9etO7e56tB1Fvs2pQVFThbt3OWxnE9cd6GOB4rfNCZKy9
         SwmDBqEJwZh4h1516wBaUfJ5W0ErSpigoJo+K36t1tPn3Y1NrFHpmHJb5tCMcudzMvyv
         TEgH2Mm0Tvj974phEVKJVRrjUnKCpqIQm9Z8bW5wIzbYafwg6tnpmNTemy8Uvw0guST4
         Wv4LD8tAAcArg51qh6JzClmSlR2Qemwv5raR/846IhRnK84BKN6fnbwcKWf4h8uf2H9q
         QxvInPyaI7jXvmtBaIeEZ6vUxQv8eXDeKzto41yIYFuVP30P/tA6/MaBD+7fhmmGXVvz
         Fykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mnz73Vl3a4PfmC0Z2phyqbZVdHEOz6JLhDTMxB2wsIM=;
        b=Ok9Kf0XXaYLgyVk9nWpfl/Yal6oy3ZkQl0oFB5LO2pdM+vVd21gWMBJdqQILL9ky2l
         1KhvGnPisXC42klf3Z8mOhev92TGjrzkPwD8mlz7Gt2UgCaFCyOKjWaNHwN4kI/Gk7Q1
         X5Srwmq9krHAC5H43nqpQw1CuUfQgSI4BKVnF8X7Azosv6hEj9WPXQ9DRM0wWUcMKCQA
         F601hP2IeB0i7hoZhEde9DccTnKD4mm20xPuI7/yA6o14XsQRetOb7vBLsovF5CElz1L
         +UisuHggskjwg4paV/6njCd+XDViQlehW17fmRkgoNsW5GkIlRYJzHSEYccSfkR2JXg8
         N0hg==
X-Gm-Message-State: AOAM532EEBY48aQwRlVjOUcuBlvEaO1F52ICRh4hjk6v3hbV6jsvwoqc
        +B2dpxIPPt/EwGprI1nAqLvkuqheltv6cY52d+0=
X-Google-Smtp-Source: ABdhPJy3uKd3F67NcorbaDRpeFbpdAHqLp9X6qgyjdspi41F2UUGxJniR9HNoYQ1KudpdkBhWYdPVejNGSthnAiDc3A=
X-Received: by 2002:a63:545a:: with SMTP id e26mr7868665pgm.4.1590753841885;
 Fri, 29 May 2020 05:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <89f6393934fc6d493f8b9e87c1a6e916642b6a18.1590749143.git.cristian.ciocaltea@gmail.com>
 <20200529113419.GA1631227@kroah.com> <4c40d6c1-47e8-b4ec-f2fd-e9767b03630c@suse.de>
In-Reply-To: <4c40d6c1-47e8-b4ec-f2fd-e9767b03630c@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 15:03:50 +0300
Message-ID: <CAHp75Vcz0a87LSnb6Ubt5_bSF3wUcs21GbP119trXER5KBDxbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tty: serial: owl: Initialize lock before registering port
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 29, 2020 at 2:56 PM Andreas F=C3=A4rber <afaerber@suse.de> wrot=
e:
>
> Am 29.05.20 um 13:34 schrieb Greg Kroah-Hartman:
> > On Fri, May 29, 2020 at 02:06:47PM +0300, Cristian Ciocaltea wrote:
> >> Running a lockdep-enabled kernel leads to the following splat when
> >> probing the owl-uart driver:

...

> >> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial dev=
ice for console")
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

> >> +    spin_lock_init(&owl_port->port.lock);
> >> +
> >>      ret =3D uart_add_one_port(&owl_uart_driver, &owl_port->port);
> >>      if (ret)
> >>              owl_uart_ports[pdev->id] =3D NULL;
> >
> > Ugh, another one :(
> >
> > Thanks for this, will queue this up now.
>
> Thanks. If this is the expected pattern now, I'll also have to update
> in-flight patches, such as Sunplus.

Expected is to register properly console via register_console() call.
If you do so, you also need to initialize spin lock before coming to
uart_add_one_port().
It seems drivers (ab)used that feature.

$ git grep -n -w register_console -- drivers/tty/serial/ | cut -f1 -d:
| sort -u | wc -l
    37
$ git grep -n _CONSOLE -- drivers/tty/serial/ | cut -f1 -d:  | sort -u | wc=
 -l
    77

But as a quick fix this initialization is okay.

--=20
With Best Regards,
Andy Shevchenko
