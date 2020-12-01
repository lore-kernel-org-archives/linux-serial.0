Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC3C64E7B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD60E2085B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLAIVm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:21:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43642 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLAIVl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 03:21:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id 142so1431892ljj.10;
        Tue, 01 Dec 2020 00:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=acVfLOkdWoJC7KDjn7IA2m7Ws8ZjrdYl8Gt7Q0jLJnQ=;
        b=axjhgjhfVsn64B0ezlbQxOmbYyAKpRyZdgCD8fAlfDrrvjHyJ5OrUxOHlokk4djnf4
         np9gVacgxbO4AGID0er6LMTQJaOGrQw7BpDHMMQK0fxsa4x/wPra1XCmSeNeL078HUTm
         M4KKipwTPE9Xnva3MP+k9paXuXCdGRfyoocKFCBccgSI0aurgQMA7GiDzJyvxWuRos6h
         /RQQkqN1TTe62/2ouR0kSIMdO5wb3qN3FyvGn9e0u2qb63UTV2oxO7w0kfel03GEAQRk
         oDseHZ3u+PrzI7y1gt+ewj1QqtXbm7M3RvjfGzgrgtlWf7SktdQzaYDR3aQ57+3VNJxc
         Zg2A==
X-Gm-Message-State: AOAM53303sblAy1ahlO0IoFP9LXUmZ+Ijc99VPqk+n7JAIQSyqRyOz8Q
        /bKy3R1xNxvog3Tz00M6sPg=
X-Google-Smtp-Source: ABdhPJwKEFgG60heUDRAJu4xBG78Mv8Yr6B92yBiB8iem+B6hATW+kMOAXzDCWz5Y/lvPktN1ktvHg==
X-Received: by 2002:a2e:808b:: with SMTP id i11mr723754ljg.202.1606810858845;
        Tue, 01 Dec 2020 00:20:58 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id w2sm125729lfe.40.2020.12.01.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 00:20:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk0ud-0003C6-Kc; Tue, 01 Dec 2020 09:21:27 +0100
Date:   Tue, 1 Dec 2020 09:21:27 +0100
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
Message-ID: <X8X9B1jYujUIWXaK@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 30, 2020 at 08:27:54PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > Add a nordy sysfs attribute to suppress raising the modem-control lines
> > on open to signal DTE readiness.
> 
> Why not call it nomctrl ?

That was one of the candidates I rejected.

As I hinted in the cover letter (and patch adding the flag) I chose the
name to match the current termios flags (e.g. HUPCL and NOFLSH).

NOMCTRL is both too general and specific; HUPCL still controls the
modem-control lines on final close. Also, like HUPCL, I wanted a more
general name that can be used for terminal devices which can signal
readiness through other means (e.g. network).

Like the other termios flags it is terse, but once you learn the meaning
it's easy to remember. And I think there's value in keeping the same
name throughout (cf. termios flags and stty).
 
> > This can be use to prevent undesirable side-effects on open for
> 
> used

Thanks, I'll fix that up before applying or resending

> > applications where the DTR and RTS lines are used for non-standard
> > purposes such as generating power-on and reset pulses.
> 
> ...
> 
> > +static ssize_t nordy_store(struct device *dev, struct device_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +       struct tty_port *port = dev_get_drvdata(dev);
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       ret = kstrtouint(buf, 0, &val);
> > +       if (ret)
> > +               return ret;
> 
> > +       if (val > 1)
> > +               return -EINVAL;
> 
> Can't we utilise kstrtobool() instead?

I chose not to as kstrtobool() results in a horrid interface. To many
options to do the same thing and you end up with confusing things like
"0x01" being accepted but treated as false (as only the first character
is considered).

Not sure how that ever made it into sysfs code...

The attribute is read back as "0" or "1" and those are precisely the
values that can be written back (well, modulo radix).

It's not relevant in this case, but tight control over the inputs also
allows for extending the range later.

> > +       tty_port_set_nordy(port, val);
> > +
> > +       return count;
> > +}

Johan
