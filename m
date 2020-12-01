Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B03BC83019
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C617022250
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 13:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgLANW0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:22:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39844 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbgLANW0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 08:22:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id o24so2832404ljj.6;
        Tue, 01 Dec 2020 05:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyomTbeXHwoWL2hrAF8S1rI5kbguY96zuSzDzrQnHfg=;
        b=KRLnhTZ3Q50AANnSCOEB07DkWRWvRsewIxk3efJfpAfL8VTO+KQBZUNRyeF4OzWcYz
         JSUG0s8F0/EgBzfzOlzkej7abSDW2zZFFzZ3lbFrEtUb/Gyx/V+o+OyJ1M2hvy5sbV5Y
         Lhaz9eojFZVGKi189DzgkiIC6EJYm4o0BTxuAvp3IZHLctIIlDP7S0gzvumTuLb2fmnD
         V8xrKvqPZzfJu43gVFNIEO3N/sc8Hwg6EOmDOfrBzahU4ri3384GYsnpuk67YFGq2mzT
         lOyptyARmJ1vgQsrUMoZ7Kh+Waowe57ohLN8i/wEsRgefNeaKdAqAKcvtU0oOMQ7I73i
         HYCg==
X-Gm-Message-State: AOAM530SGjYmAEfHGQYC4GLmfJj4I/8qeqnDn7+CD4s5MMUNiZtMUYjj
        aglWAJXRS0rKZH2/WqqvDAs=
X-Google-Smtp-Source: ABdhPJziLALFQnI9UjteLCD0+I/+HOaKArjvgiWnIFvbgaGJseEjKVR9YmsHQ+btGB6fCrElGpwzFQ==
X-Received: by 2002:a2e:8346:: with SMTP id l6mr1239463ljh.132.1606828897528;
        Tue, 01 Dec 2020 05:21:37 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n28sm199545lfh.272.2020.12.01.05.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:21:36 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk5ba-0007dK-PP; Tue, 01 Dec 2020 14:22:06 +0100
Date:   Tue, 1 Dec 2020 14:22:06 +0100
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
Message-ID: <X8ZDfvuRbxqsKZMh@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
 <X8X9B1jYujUIWXaK@localhost>
 <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
 <X8Yjc0+Q7fM0nZP+@localhost>
 <CAHp75VdMcYj0H-HZcmyWFU5ROLwSy=8Pan7JABZxGimqXE35WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdMcYj0H-HZcmyWFU5ROLwSy=8Pan7JABZxGimqXE35WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 01:19:30PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 1, 2020 at 1:04 PM Johan Hovold <johan@kernel.org> wrote:

> > 0x01 is 1 and is generally treated as boolean true as you know.
> 
> Depends how you interpret this. kstrtobool() uses one character (and
> in some cases two) of the input. Everything else is garbage.
> Should we interpret garbage?

No, ideally we should reject the input.

> > So why should a sysfs-interface accept it as valid input and treat it as
> > false? That's just bad design.
> 
> I can agree with this.

Looks like part of the problem are commits like 4cc7ecb7f2a6 ("param:
convert some "on"/"off" users to strtobool") which destroyed perfectly
well-defined interfaces.

> > You miss the point; kstrobool accepts "12" today and treats it as true.
> > You cannot extend such an interface to later accept a larger range than
> > 0 and 1 as you didn't return an error for "12" from the start (as someone
> > might now rely on "12" being treated as "1").
> 
> Somehow cifs uses kstrtobool() in conjunction with the wider ranges. Nobody
> complained so far. But maybe they had it from day 1.

Wow, that's pretty nasty.

> So, we have two issues here: kstrtobool() doesn't report an error of
> input when it has garbage, the user may rely on garbage to be
> discarded.

Right, parsing is too allowing and there are too many ways to say
true/false.

The power-management attributes use 0 and 1 for boolean like I do here,
and I'd prefer to stick to that until we have deprecated the current
kstrtobool.

Johan
