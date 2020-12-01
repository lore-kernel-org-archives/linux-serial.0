Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D52C64E7A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 11:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F01A20809
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 11:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1dlrjqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgLALT2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgLALT2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 06:19:28 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF2C0613D2;
        Tue,  1 Dec 2020 03:18:42 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k5so958642plt.6;
        Tue, 01 Dec 2020 03:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvnthXGSvQ19sOb1hbG53K4nwxtYJ0GEDqTMot4FUAI=;
        b=T1dlrjqOF4FsZAicQ03sUdkDH6B3l+0EbhU9/3qC6IrXN8cUTO6c3Dqx3qHvxNLEt+
         dQyon/vWWwBtug5QXC/0p49JwRIcrwP1EkJiEAF1BoHMO98cviR3jw6pea0XkQqXwUId
         H0iGlAtzlgXznux0vQFXOURKFPwYRNKVwf0C6Wf9xsox3LSqgd+JCllgDgJjtFpyzHvx
         ScZGgGPDeRGb+1Na9g+Y1NHhNTLjf6WBYG24EAa49+yeGpJ/TanlUsPutCIGCz+4qRMF
         3DsbbMqtPkZBQl8tmhLDs0YqIwgKDBs4sHHIrNtK/5pT9zunqQSsbgy55EWJi5YCvK5p
         9ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvnthXGSvQ19sOb1hbG53K4nwxtYJ0GEDqTMot4FUAI=;
        b=YgLcIUa5w5QFwfmfIsLw89zXrc23Weuu3zhEQv7KDC21H/QM+4dhEouBn7VVWsBrU/
         Dob9T+IPNiH5XvfwbMEX+6vEZMdA6FT1x4X2c16G/YsujemZcuDdE9V68ndHJ105eK3e
         dAaGs99DsDfxzAr5PIQxgiId1U7QR8pHbErsvxp00HvzBkSRwHB+Os+iLXA9oDsesHcn
         CMT8HMKo0iAdM5O3MiEGM6Vqk6jngfJUKUFUORlNGvaPmjMAO+V/2xdfMBmYvtN4zQMI
         V7Gd123ap/7x3PoA4lRl4gAK71YLibe/GkesV9t+1aOCY7yI2XNvSqznWJbPH8bssKDk
         49YA==
X-Gm-Message-State: AOAM53352wuFtqP3/o4EVnIHVYh20N3bPpVVbfFg+eMc7DSqUrj4jsbJ
        4wcoUnFJYo5SEIJFKASjOhWRXicyGOJxeDw1xqM=
X-Google-Smtp-Source: ABdhPJzcgglChZ/Gucnho8qMogmYAhcFUR6gh2/woMnR0hu9cZlJKK3uunLMTUDOaQBp8x8mK6YKuRXV5Gc8yWR+SEI=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr2207002pjb.129.1606821522196;
 Tue, 01 Dec 2020 03:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20201130153742.9163-1-johan@kernel.org> <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
 <X8X9B1jYujUIWXaK@localhost> <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
 <X8Yjc0+Q7fM0nZP+@localhost>
In-Reply-To: <X8Yjc0+Q7fM0nZP+@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 13:19:30 +0200
Message-ID: <CAHp75VdMcYj0H-HZcmyWFU5ROLwSy=8Pan7JABZxGimqXE35WQ@mail.gmail.com>
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

On Tue, Dec 1, 2020 at 1:04 PM Johan Hovold <johan@kernel.org> wrote:
> On Tue, Dec 01, 2020 at 12:55:54PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 1, 2020 at 10:20 AM Johan Hovold <johan@kernel.org> wrote:
> > > On Mon, Nov 30, 2020 at 08:27:54PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > > +       ret = kstrtouint(buf, 0, &val);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > >
> > > > > +       if (val > 1)
> > > > > +               return -EINVAL;
> > > >
> > > > Can't we utilise kstrtobool() instead?
> > >
> > > I chose not to as kstrtobool() results in a horrid interface. To many
> > > options to do the same thing and you end up with confusing things like
> > > "0x01" being accepted but treated as false (as only the first character
> > > is considered).
> >
> > And this is perfectly fine. 0x01 is not boolean.
>
> 0x01 is 1 and is generally treated as boolean true as you know.

Depends how you interpret this. kstrtobool() uses one character (and
in some cases two) of the input. Everything else is garbage.
Should we interpret garbage?

> So why should a sysfs-interface accept it as valid input and treat it as
> false? That's just bad design.

I can agree with this.

> > > Not sure how that ever made it into sysfs code...
> > >
> > > The attribute is read back as "0" or "1" and those are precisely the
> > > values that can be written back (well, modulo radix).
> >
> > So, how does it affect the kstrtobool() interface?
> > You read back 0 and 1 and they are pretty much accepted by it.
> >
> > > It's not relevant in this case, but tight control over the inputs also
> > > allows for extending the range later.
> >
> > And kstrtobool() does it. So I don't see any difference except a few
> > less lines of code and actually *stricter* rules than kstrtouint()
> > has.
>
> You miss the point; kstrobool accepts "12" today and treats it as true.
> You cannot extend such an interface to later accept a larger range than
> 0 and 1 as you didn't return an error for "12" from the start (as someone
> might now rely on "12" being treated as "1").

Somehow cifs uses kstrtobool() in conjunction with the wider ranges. Nobody
complained so far. But maybe they had it from day 1.

So, we have two issues here: kstrtobool() doesn't report an error of
input when it has garbage, the user may rely on garbage to be
discarded.

-- 
With Best Regards,
Andy Shevchenko
