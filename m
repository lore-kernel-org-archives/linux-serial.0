Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CD5C64E7B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BCE20809
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy1yls4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgLAKzr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAKzq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 05:55:46 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF0DC0613CF;
        Tue,  1 Dec 2020 02:55:06 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e5so1004195pjt.0;
        Tue, 01 Dec 2020 02:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i38OjRaT5QGFCtCwwPd1SCJNsYfsg7NYH5qbGP41LaE=;
        b=gy1yls4AWND+ZkAKtaYVfm0KX7T5I3KQtm6rPo9I/pWU1SURLBXEYxK3Nx5Ztn1FJC
         9MJpl/v45pAguKyhOaGHf49WG0M7bJDHumrMOi6Xy2dL/VSVLO+NDlncCUuWB3dY2l0A
         aa5xWDVv/BRObEup7FHT0KUoXmoTuXPNsmZrWWSQXF5+2lJEORMBOzt8YldBXXBhUAq6
         QKXd7ub6+ZUN/svp8aE0/9bKLHxyW1SacjW9g5JIjvFsuj8DmW0nLLPdvndN6mhscNOd
         MZ1he+FW2xHgAmZSV4jqdAW+/nysDOjfJJwVaKdaN3W6C7NbtztLnus7brBXrsnbIaS0
         nxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i38OjRaT5QGFCtCwwPd1SCJNsYfsg7NYH5qbGP41LaE=;
        b=QN2hl3JrqMTpZYa3ZOH4QMx7GBeOR3MTeIxJJ09lmUz7zM+y5PM0igNtBQKmfxL21c
         uPr37t+kIF8DwocOklGmvxRqfv3O1hjo/rsMlsMMuZTq7muC8F6EnZuKMN0vuxAeXLxz
         WMRTbQT+s1kkhdIcLuYVR2KlWTJk9b+fj20iTp9fDlzr9SkxKXCemh/a9RcO22KOTejw
         xs+7AkCmyVL+HFmFEV43kvE4umjrSB3IXOYJQWVY9kBW7y2htgh+bCZ/E37UijSlguwD
         9+TDJnGDY87BeNxspuA6xY1Fjmxbjx52Vnu7gjKpcwv9gznyyI7DfYUazA+UsMFlVFuV
         1Z+A==
X-Gm-Message-State: AOAM533xJ3vnKifKGcG4OlhuRyM8j3AKuuO4RqMBqRipW0K+2+9T/SQI
        FjPCcV7ENAH6BSA2P07NndIu6PtAnryvojpba1o=
X-Google-Smtp-Source: ABdhPJzPqmVEtEfeNfnNHED2wtu5NFar6uX+4pBneqsIFHYxmVj9mNmtNEcMOQyDrr1cQzLPNvaEvqZGxstIY8DXJmo=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr2065322pjf.181.1606820106113;
 Tue, 01 Dec 2020 02:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20201130153742.9163-1-johan@kernel.org> <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com> <X8X9B1jYujUIWXaK@localhost>
In-Reply-To: <X8X9B1jYujUIWXaK@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 12:55:54 +0200
Message-ID: <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
Subject: Re: [PATCH 2/5] serial: core: add sysfs attribute to suppress ready
 signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 1, 2020 at 10:20 AM Johan Hovold <johan@kernel.org> wrote:
> On Mon, Nov 30, 2020 at 08:27:54PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:

> > > +       ret = kstrtouint(buf, 0, &val);
> > > +       if (ret)
> > > +               return ret;
> >
> > > +       if (val > 1)
> > > +               return -EINVAL;
> >
> > Can't we utilise kstrtobool() instead?
>
> I chose not to as kstrtobool() results in a horrid interface. To many
> options to do the same thing and you end up with confusing things like
> "0x01" being accepted but treated as false (as only the first character
> is considered).

And this is perfectly fine. 0x01 is not boolean.

> Not sure how that ever made it into sysfs code...
>
> The attribute is read back as "0" or "1" and those are precisely the
> values that can be written back (well, modulo radix).

So, how does it affect the kstrtobool() interface?
You read back 0 and 1 and they are pretty much accepted by it.

> It's not relevant in this case, but tight control over the inputs also
> allows for extending the range later.

And kstrtobool() does it. So I don't see any difference except a few
less lines of code and actually *stricter* rules than kstrtouint()
has.

-- 
With Best Regards,
Andy Shevchenko
