Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB7C71156
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB4B20870
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 17:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgLARnW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 12:43:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41434 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLARnW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 12:43:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id y7so4330271lji.8;
        Tue, 01 Dec 2020 09:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3OqCrRcXaOGImpl3brdE8L65SCR5lmtKJXYjgl2sOKo=;
        b=WGDqXbOOvHZMUxWytfnleZdViam+5EcPuewU3BAI9t1pfm3vPf2ZdkbN690KcqUKsz
         iMgO0IQa2JdZmelmox76KkaiAp2pER3KOtFhXJ+GgyK9LBJohbi0ZrLGrGN07js3FpEL
         7hgFlGKDDhC42UtpXWWppnloejLbRV2H2dTA/kxHb2DDYz3YizQdSeXqqHbRCrrfSncL
         xhbE4tmJN5uIoQn4JGO8YRWJDZT6JVTlpCyveaBJQ5uM2mmhAnda9SYyqaZGaQTZqhAV
         xfrEmMsWUIpFgZFRpeKAJ3fsJpBr0bcBZbwFpaoDMvmq7yZ0/fnkRVEAiAttEOOWtvHK
         HGNg==
X-Gm-Message-State: AOAM530p/0U0I2whroKn/pIOUUqoObcY5KgjJYJvymYjHkvk0rsh+NPw
        OfzhMhNxOmuWT674JnpNiXw=
X-Google-Smtp-Source: ABdhPJwhlQaDwmDBpHEmz3WRv5ekXzO+n+XO2iJyREtQl4wg1I93I1kcjkZdb+GqL5vpeItA3siy1Q==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr1965743ljj.312.1606844559186;
        Tue, 01 Dec 2020 09:42:39 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x23sm15253lfa.219.2020.12.01.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 09:42:38 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk9gC-0004r0-5v; Tue, 01 Dec 2020 18:43:08 +0100
Date:   Tue, 1 Dec 2020 18:43:08 +0100
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
Message-ID: <X8aArEe49HKdW6GC@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
 <X8X9B1jYujUIWXaK@localhost>
 <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
 <X8Yjc0+Q7fM0nZP+@localhost>
 <CAHp75VdMcYj0H-HZcmyWFU5ROLwSy=8Pan7JABZxGimqXE35WQ@mail.gmail.com>
 <X8ZDfvuRbxqsKZMh@localhost>
 <CAHp75Vct+J7=BaUdzBktQvKvThCuC-HmyRP2s4LRJvgsE2A2UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vct+J7=BaUdzBktQvKvThCuC-HmyRP2s4LRJvgsE2A2UA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 03:49:19PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 1, 2020 at 3:21 PM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Dec 01, 2020 at 01:19:30PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 1, 2020 at 1:04 PM Johan Hovold <johan@kernel.org> wrote:
> 
> ...
> 
> > > > 0x01 is 1 and is generally treated as boolean true as you know.
> > >
> > > Depends how you interpret this. kstrtobool() uses one character (and
> > > in some cases two) of the input. Everything else is garbage.
> > > Should we interpret garbage?
> >
> > No, ideally we should reject the input.
> 
> We can do it by the way in kstrtobool() and see if anybody complains
> (I believe the world is saner than relying on 0x01 for false and 123
> for true.

I bet someone is using "YEAH!" just because they can. ;)

> ...
> 
> > > > So why should a sysfs-interface accept it as valid input and treat it as
> > > > false? That's just bad design.
> > >
> > > I can agree with this.
> >
> > Looks like part of the problem are commits like 4cc7ecb7f2a6 ("param:
> > convert some "on"/"off" users to strtobool") which destroyed perfectly
> > well-defined interfaces.
> 
> Oh, but the strtobool() in ABI was before that, for instance
>  % git grep -n -p -w strtobool v3.14
> shows a few dozens of users and some of them looks like ABI.

Indeed, it apparently goes further back than strtobool(). The series
introducing strtobool() explicitly mentions the lax parsing and for that
reason wanted to keep it distinct from the other kstrto* function by
dropping the k-prefix:

	The naming is still distinct enough from kstrtox to avoid any
	implication that this function has the same tight parameter
	passing that those functions have.

	https://lore.kernel.org/lkml/1303213427-12798-1-git-send-email-jic23@cam.ac.uk/#t

And it was more recently renamed kstrtobool() anyway.

Let's call it a feature then.

Johan
