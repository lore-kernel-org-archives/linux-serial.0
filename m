Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B8C64E7B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 11:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D81F2080A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 11:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgLALFi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:05:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39294 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgLALFh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 06:05:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id j205so3313897lfj.6;
        Tue, 01 Dec 2020 03:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZjTqWQg2jIPQhER2sb7NQwX/zIXr+mOf1RdttZR1ro=;
        b=RYT3N2Iwj2+8Xkp4ch1LGRZ6k5OezEHJSghKb4UqfVPImb/uXwWr5ewWMNTVkDoxM8
         bH5d/ceRIjOuowe/uIV5cQiQywe5f6tLwLv3rgSvJK8fT5Oi2858qhxHscvvtY7le5PR
         G3kmNJwKQ33VW7Qx67L0PLTPmW74fssONHmg93vKWoVuoIYx/6wO2nUdSdKyfmYNjp+J
         oF0w7BnAbelMAI9MW8ZH5TtYjSq4Lj2RXCi6KrjynQMO9a+mhJrNZbzkZD4r18M97Sjv
         6Xri6KZIHgQnOC1lYxkbTPwNHTKw3V/Rueus2Tu3UpThfC02u67fFT+HtUzbtnTQOhmB
         2Xaw==
X-Gm-Message-State: AOAM5313tuaKhpeChaZJooD60ok13S+2eVe4KW4horEtUsZOWh7drrDO
        F/uKheMANmv1M88gOubAQCg=
X-Google-Smtp-Source: ABdhPJyh8cybXM/HYJz+NxigWFIexVLJjuUx8E9eZpx1SXTPfsYPSA/LATO9eFKq44PSpQq5k2i62w==
X-Received: by 2002:a19:f504:: with SMTP id j4mr967582lfb.163.1606820695097;
        Tue, 01 Dec 2020 03:04:55 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id d19sm164950lfc.139.2020.12.01.03.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 03:04:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk3TH-0007KC-GI; Tue, 01 Dec 2020 12:05:24 +0100
Date:   Tue, 1 Dec 2020 12:05:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] serial: core: add sysfs attribute to suppress ready
 signalling on open
Message-ID: <X8Yjc0+Q7fM0nZP+@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
 <X8X9B1jYujUIWXaK@localhost>
 <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 12:55:54PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 1, 2020 at 10:20 AM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Nov 30, 2020 at 08:27:54PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:
> 
> > > > +       ret = kstrtouint(buf, 0, &val);
> > > > +       if (ret)
> > > > +               return ret;
> > >
> > > > +       if (val > 1)
> > > > +               return -EINVAL;
> > >
> > > Can't we utilise kstrtobool() instead?
> >
> > I chose not to as kstrtobool() results in a horrid interface. To many
> > options to do the same thing and you end up with confusing things like
> > "0x01" being accepted but treated as false (as only the first character
> > is considered).
> 
> And this is perfectly fine. 0x01 is not boolean.

0x01 is 1 and is generally treated as boolean true as you know.

So why should a sysfs-interface accept it as valid input and treat it as
false? That's just bad design.

> > Not sure how that ever made it into sysfs code...
> >
> > The attribute is read back as "0" or "1" and those are precisely the
> > values that can be written back (well, modulo radix).
> 
> So, how does it affect the kstrtobool() interface?
> You read back 0 and 1 and they are pretty much accepted by it.
> 
> > It's not relevant in this case, but tight control over the inputs also
> > allows for extending the range later.
> 
> And kstrtobool() does it. So I don't see any difference except a few
> less lines of code and actually *stricter* rules than kstrtouint()
> has.

You miss the point; kstrobool accepts "12" today and treats it as true.
You cannot extend such an interface to later accept a larger range than
0 and 1 as you didn't return an error for "12" from the start (as someone
might now rely on "12" being treated as "1").

Johan
