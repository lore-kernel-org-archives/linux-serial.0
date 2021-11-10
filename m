Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7830EC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF32611ED
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhKJMNc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232040AbhKJMN1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 07:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636546230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rr36Cb2Y1cvFR41scNcUzd8wBnS/OAi/NVPg1Fb83xQ=;
        b=TeqQ3UfuZQ1vLPkxqnQ0Zs1DmQ6qg4rue+zrOWh+GuO4pTUFhAHktXgQj/rCtxgEEbBwus
        LC+FSSvcYXDcq22bPhuixOT4KQWfeaxQ8TFh+fFX4bGLGolQWLXSiHT+zKJVF+13UoimB9
        d5tAOtRD7oJVaYv5KX/DrDNUKHkBYfo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-3w8A-ggEOmOt3-yZr79bEQ-1; Wed, 10 Nov 2021 07:10:27 -0500
X-MC-Unique: 3w8A-ggEOmOt3-yZr79bEQ-1
Received: by mail-ed1-f69.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so2158873edf.5
        for <linux-serial@vger.kernel.org>; Wed, 10 Nov 2021 04:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rr36Cb2Y1cvFR41scNcUzd8wBnS/OAi/NVPg1Fb83xQ=;
        b=BKllmWfPfw4zsym/L/pzVFoMiHiQ+O/fwHBJUZ+3IJuTYpCUY4089/wMbI3ZSIqHLr
         WxLUfOXFQb5SeuPUbfJITBTaT+5S0j77cagywy17EviQ3cdWv2/tyv+omd2P3QgdXwqG
         3VrfjpFDaDvGmZ8tDyLcWyaCrwihF6kJetRwPFOPDnfCsrLU50JUOw3vfAmhGmpdxfp4
         2325degix2uis6wUJWYJEhc8DftOXoKbSaoRx+3i+Njiytwvvexh6uPBZMDzf4x2ASJ6
         vZ6P4jquAYXRAxKRydYHAoahj32LC2riXovBMVmuEvBZW+MmA1qrojDcxl9yFnMZk4ko
         4ZgA==
X-Gm-Message-State: AOAM532VqbelI3i2E9OD/XSKYn1tr01+foyNPoR5tuXvwt81tkQDKGym
        CAvz0ffoD/wK89U5Wend/dIUQwLxgOi9/lmJoAOWH87iruQ2mtg61mEeCHxk1CZVTagrYiMokoA
        9tDKjjErmTzNyUQyl3ttgTOInikNFIMmTaWtfYEkw
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr19787424ejb.178.1636546226125;
        Wed, 10 Nov 2021 04:10:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwf4XP8fkeIWWNmHm7LmReGjzuQX86h1/sC+gmwglVaX4WVJuIk3uu0SgugELXK3xZxJVQ9JlvsL+t5QFcdnjo=
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr19787400ejb.178.1636546225940;
 Wed, 10 Nov 2021 04:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20211029201402.428284-1-wander@redhat.com> <CAHp75VeZBp4gKvGBDzaD=EpGRDZ1-wTvD8K9Ui6Q59kDjmkXmQ@mail.gmail.com>
 <CAAq0SUmzHqEzNk3aw3SEgYVWRukQeHK1WtcJ3MjXcQKJrbC1Dw@mail.gmail.com> <CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com>
In-Reply-To: <CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 10 Nov 2021 09:10:14 -0300
Message-ID: <CAAq0SU=wYZ9e9NJvwcLvEvxj-J7PhAPFjRAu2uFVYPprR7A_qQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     wander@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 1, 2021 at 12:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Nov 1, 2021 at 5:22 PM Wander Costa <wcosta@redhat.com> wrote:
> > Em s=C3=A1b., 30 de out. de 2021 04:41, Andy Shevchenko
> > <andy.shevchenko@gmail.com> escreveu:
> > > On Friday, October 29, 2021, <wander@redhat.com> wrote:
>
> ...
>
> > > I don't see any links.
> >
> > Oops, sorry about that. I must have accidentally deleted it while
> > editing the commit message.
> > Here it is https://github.com/walac/serial-console-test.
> > I will update the patch with the link.
>
> Thanks!
>
> ...
>
> > > On how many different UARTs have you tested this? Have you tested oop=
s and NMI contexts?
> > >
> > I only tested in a half dozen machines that I have available. I tried
> > it in panic, warnings, IRQ contexts, etc. Theoretically, this change
> > should not be affected by the context. Theoretically...
> >
> > > What I would like to say here is that the code is being used on zilli=
ons of different 8250 implementations here and I would be rather skeptical =
about enabling the feature for everyone.
> > >
> > I did my homework and studied the 16550 datasheets, but yes, there is
> > always this risk. Maybe people more experienced with PC serial ports
> > than me might think the patch is not worth the risk of breaking some
> > unknown number of devices out there, and I am ok with that. It is a
> > valid point.
>
> Here is a translation of my comment to a roadmap.
>
> 1. Introduce yet another UART quirk or capability (see corresponding
> UART_CAP_* or UART_*_QUIRK definitions)
> 2. Add your patch conditionally based on the above
> 3. Enable it on UART(s) you _have tested_
>
Thank you for the feedback, I submitted a v2 patch with your proposed chang=
es,

Cheers,
Wander

> --
> With Best Regards,
> Andy Shevchenko
>

