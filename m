Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29510C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE1460EFF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 15:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKAPfi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 11:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhKAPfh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 11:35:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD016C061764;
        Mon,  1 Nov 2021 08:33:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id k22so8446477ljk.5;
        Mon, 01 Nov 2021 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wqdz10Mm65EnzR0Kq/J40aB1E0ruzup8GrITfXt/gHw=;
        b=LMQCTDmKquUkDoRBW4/w9msneoKGEK4Sg97eheYEjNxBcgNXHAQ7Bz/bmZ/kzUVxmJ
         9xie+NpSUTyz8kMsMVd7/sozTnS5HXErInextPkNRzdy4hTCy3Kr81jo0j1msNhuxOEh
         43RT8zIeW+LOZ8DqTcDvWhE150LKBJbq4SPV92z3lH+dBG54kCVPzxqbDTWN/XV8xPok
         UMbMslC8camT4/3O7kf7uZKoWAjNhPIHLFpmey/cEv6Z/31uxk7+FO+JfvUXkV72VbWM
         kL6f3vcJlU/Umzb3pzGVWuEpWi0vsZGinoe01bFljRn2jrihzFDeFFHMgXJJkOkcieAv
         ce5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wqdz10Mm65EnzR0Kq/J40aB1E0ruzup8GrITfXt/gHw=;
        b=i6++8BbLVP+6tcozKi/z+EBP9omYhvo//zu6+L/Xt4ik9TD3m+4YZFTq+8VHjisi/y
         9SZG4lfVEM2IoaK0CC3aUc5s5q34YYXxV2t0TtvvP+CAVC60X2lusNZYib44gI5ZEExa
         q+WgdAqzJDh3u/ZQdfvuyZnpc3r2W9c4PPz5ZJd/hjRotRjdKRqTVPZhUXTatYbzifVE
         Iz1tNqWgyHfUEUtWwl4ejc8YplrQFwF6GsHeoUADd4/CDyF8pKE0ZzVwlKYiLl7qxwxL
         XRG6j9FOT/wnfeH1V8MIVb/09VwFauaepoJ5tKeXv78T/cKlO1rZOEQVRfXUZQtlRths
         a6dQ==
X-Gm-Message-State: AOAM533cw5P1ylGID9fvOlijBGa2WQ5JrihL1oDxmNdMhhBEpiteWXYO
        RPd9BB4RL9ekhtWvGKBde5kCPv3Mishrksbm89w=
X-Google-Smtp-Source: ABdhPJwR4i9Q6F+HLALUGEx6B5XFNOtLBdNxGvh4qMQmH4ULwWfrWX8uMoQ1K4g1AowWLfCj1gCD2kXNerR4xOydnME=
X-Received: by 2002:a05:651c:b07:: with SMTP id b7mr32549252ljr.166.1635780782030;
 Mon, 01 Nov 2021 08:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211029201402.428284-1-wander@redhat.com> <CAHp75VeZBp4gKvGBDzaD=EpGRDZ1-wTvD8K9Ui6Q59kDjmkXmQ@mail.gmail.com>
 <CAAq0SUmzHqEzNk3aw3SEgYVWRukQeHK1WtcJ3MjXcQKJrbC1Dw@mail.gmail.com>
In-Reply-To: <CAAq0SUmzHqEzNk3aw3SEgYVWRukQeHK1WtcJ3MjXcQKJrbC1Dw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Nov 2021 17:32:12 +0200
Message-ID: <CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Wander Costa <wcosta@redhat.com>
Cc:     wander@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 1, 2021 at 5:22 PM Wander Costa <wcosta@redhat.com> wrote:
> Em s=C3=A1b., 30 de out. de 2021 04:41, Andy Shevchenko
> <andy.shevchenko@gmail.com> escreveu:
> > On Friday, October 29, 2021, <wander@redhat.com> wrote:

...

> > I don't see any links.
>
> Oops, sorry about that. I must have accidentally deleted it while
> editing the commit message.
> Here it is https://github.com/walac/serial-console-test.
> I will update the patch with the link.

Thanks!

...

> > On how many different UARTs have you tested this? Have you tested oops =
and NMI contexts?
> >
> I only tested in a half dozen machines that I have available. I tried
> it in panic, warnings, IRQ contexts, etc. Theoretically, this change
> should not be affected by the context. Theoretically...
>
> > What I would like to say here is that the code is being used on zillion=
s of different 8250 implementations here and I would be rather skeptical ab=
out enabling the feature for everyone.
> >
> I did my homework and studied the 16550 datasheets, but yes, there is
> always this risk. Maybe people more experienced with PC serial ports
> than me might think the patch is not worth the risk of breaking some
> unknown number of devices out there, and I am ok with that. It is a
> valid point.

Here is a translation of my comment to a roadmap.

1. Introduce yet another UART quirk or capability (see corresponding
UART_CAP_* or UART_*_QUIRK definitions)
2. Add your patch conditionally based on the above
3. Enable it on UART(s) you _have tested_

--=20
With Best Regards,
Andy Shevchenko
