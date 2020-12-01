Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D7AC64E7B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A64207FF
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 17:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLARYy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 12:24:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33285 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLARYx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 12:24:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22so4277883ljk.0;
        Tue, 01 Dec 2020 09:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mlHRW9UPKO3o7VPnYVMMboelnc6s1lalbLbpElQIU5A=;
        b=TN8RC1KP7QK4eydmjPsG+4VWJOQR28wxVATTqWOhrpypAgE6e4FkWlt06K35r4uSpZ
         6Oxxonw0GwOmWe50sJRXLwotRqMD6XxAlu1YFQC+iplpUfM3cBAa86PbUqSGhv1yID+r
         eU7PcvEmTIDizpOe/jtrbqp+QiRJeuyy9KDEZbJc3Jcc41p187/GLdwmHudcwOVDzwHW
         VKet4Efa+pBlKAskQ9AcGdh8RKqp5f6+MbIG4gBdKl9sI3iEY7MmKN6QAT9yH9VRwqqf
         78Oap72inqow3Pd8R6wE7ZzYH5DIqHwBfkb9Ha62LZ5IpY4O4cw4RLrnNYnA5+mE3Igw
         mANQ==
X-Gm-Message-State: AOAM5329nMWX/B/Vlo3tAoZe8rTyDy++UpNRMONV6T8utpzP9jG5O+SR
        FdXj0w2txxT37cLMQ4nS42I=
X-Google-Smtp-Source: ABdhPJzRe/awtLzk0fTmyPTz0ZcLe4DbG0Ns+nhIxuwDmu0JtxnwvvQTq52HsF6JERx+5yKxprranQ==
X-Received: by 2002:a2e:9b58:: with SMTP id o24mr1935094ljj.84.1606843450751;
        Tue, 01 Dec 2020 09:24:10 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h7sm9707lja.115.2020.12.01.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 09:24:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk9OK-0004m9-FD; Tue, 01 Dec 2020 18:24:40 +0100
Date:   Tue, 1 Dec 2020 18:24:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] serial: core: add sysfs attribute to suppress ready
 signalling on open
Message-ID: <X8Z8WAp3ma4hpVwq@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
 <X8X9B1jYujUIWXaK@localhost>
 <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
 <X8Yjc0+Q7fM0nZP+@localhost>
 <X8Zy2uVyhzZfseUd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8Zy2uVyhzZfseUd@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 05:44:10PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 01, 2020 at 12:05:23PM +0100, Johan Hovold wrote:
> > On Tue, Dec 01, 2020 at 12:55:54PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 1, 2020 at 10:20 AM Johan Hovold <johan@kernel.org> wrote:
> > > > On Mon, Nov 30, 2020 at 08:27:54PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:
> > > 
> > > > > > +       ret = kstrtouint(buf, 0, &val);
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > >
> > > > > > +       if (val > 1)
> > > > > > +               return -EINVAL;
> > > > >
> > > > > Can't we utilise kstrtobool() instead?
> > > >
> > > > I chose not to as kstrtobool() results in a horrid interface. To many
> > > > options to do the same thing and you end up with confusing things like
> > > > "0x01" being accepted but treated as false (as only the first character
> > > > is considered).
> > > 
> > > And this is perfectly fine. 0x01 is not boolean.
> > 
> > 0x01 is 1 and is generally treated as boolean true as you know.
> > 
> > So why should a sysfs-interface accept it as valid input and treat it as
> > false? That's just bad design.
> 
> The "design" was to accept "sane" flags here:
> 	1, y, Y mean "enable"
> 	0, n, N mean "disable"
> 
> We never thought someone would try to write "0x01" as "enable" for a
> boolean flag :)
>
> So it's not a bad design, it works well what it was designed for.  It
> just is NOT designed for hex values.

I'd still say it was a bad idea to accept just about anything like
"yoghurt" or "0x01" as valid input. And having some attributes accept
"0x01" or "01" as true while other consider it false as is the case
today is less than ideal.

For sysfs we should be able to pick and enforce a representation, or
three, for example, by adding a 1-character length check for the above
examples (which have since been extended to accept "Often" and
"ontology" and what not). 

> If your sysfs file is "enable/disable", then please, use kstrtobool, as
> that is the standard way of doing this, and don't expect 0x01 to work :)

A quick grep shows we have about 55 attributes using [k]strtobool and 35
or so which expects integers and reject malformed input like "1what". So
perhaps not too late to fix. ;)

But ok, I'll use kstrtobool().

Johan
