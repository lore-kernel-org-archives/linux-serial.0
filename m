Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23315C64E90
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45A4206F9
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 13:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3NyYGrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbgLANtR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgLANtR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 08:49:17 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2CC0613CF;
        Tue,  1 Dec 2020 05:48:31 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so1186787plt.1;
        Tue, 01 Dec 2020 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plSlSB8BWAYE/ztLDhWMxwjFWQWCkUimRFhmgFEUAfQ=;
        b=E3NyYGrdb0vHrL3gi/aN2z92fLeGyfn7i4T//KGcw+q76IES9ImWUlStjN4531WIqL
         nk2e5Qr4i+8oxK9XkyrCmgZngdMglLw5IusO20TVFr3QtDEgKM0IjFBfCn1hPWt1SxiF
         zlF2CtnlStwfHRKVjhmjT2Zo2F4Di2imgfApYSLPtpMb24nVjWv4mJ1rBORMFlqg0FrY
         Y4ZMuOGWTbGBOFVJyuhgIJNNTRKnDzfzC2x1vLUx2e/vIopLaVasNqX/SXFPEuRghmjH
         n3TBXbeQN7hBfDLXXTasaUvM731htT2YtWRIok/c6FPrYvYC0TDJkRAtdiH8PAUQvcda
         YPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plSlSB8BWAYE/ztLDhWMxwjFWQWCkUimRFhmgFEUAfQ=;
        b=m2UeyDZglD3fRjZGzdM2e3y6SDRxipRHJSwQAc7Xb3eR8oALETW8C1jMwHsip78gto
         5NpBRtc/vA1ftZyl70URZf0WAsKjA6lp6jG7UxpUgZl2hu3+uQGPaAiXVBBBwGQj4Rfe
         DcrJ+OLlrfjx9rxlYTfaSSTAwS2W+HvDIqYFlSOOiWDgTMjfGI7qbwbPXCMz4e/f9dPX
         7NU10Krc3H0ccuHiQKdBQgYEx0L6NCnPqt0jjRabF5TQbp3P250dk+pLwmzI7nlZJrvx
         xGUFqaFf5/4lOPhqj+myH9p+KntoHoATCj92Hsq9yr7LMUaqMpI1rFvlnTb2P3T0PRrA
         ke+A==
X-Gm-Message-State: AOAM530p2Qrgdi7MNYKwCcTfcbuLyR7Tczp+2QLOsWliqDTe+6H5VqCf
        bEYJv1xhKPoQYC5FWiaIAd1ucjtaTRZ5mlBuPpI=
X-Google-Smtp-Source: ABdhPJzkmW2Ov0TQgQn9vqGgt5zEseWGIXG1eQtc/CftuHj7IMouXix0R9fvXlc52UlTXSvDsI1NC0HJbKI8036ARAQ=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr2729806pjf.181.1606830510564;
 Tue, 01 Dec 2020 05:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20201130153742.9163-1-johan@kernel.org> <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
 <X8X9B1jYujUIWXaK@localhost> <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
 <X8Yjc0+Q7fM0nZP+@localhost> <CAHp75VdMcYj0H-HZcmyWFU5ROLwSy=8Pan7JABZxGimqXE35WQ@mail.gmail.com>
 <X8ZDfvuRbxqsKZMh@localhost>
In-Reply-To: <X8ZDfvuRbxqsKZMh@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 15:49:19 +0200
Message-ID: <CAHp75Vct+J7=BaUdzBktQvKvThCuC-HmyRP2s4LRJvgsE2A2UA@mail.gmail.com>
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

On Tue, Dec 1, 2020 at 3:21 PM Johan Hovold <johan@kernel.org> wrote:
> On Tue, Dec 01, 2020 at 01:19:30PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 1, 2020 at 1:04 PM Johan Hovold <johan@kernel.org> wrote:

...

> > > 0x01 is 1 and is generally treated as boolean true as you know.
> >
> > Depends how you interpret this. kstrtobool() uses one character (and
> > in some cases two) of the input. Everything else is garbage.
> > Should we interpret garbage?
>
> No, ideally we should reject the input.

We can do it by the way in kstrtobool() and see if anybody complains
(I believe the world is saner than relying on 0x01 for false and 123
for true.

...

> > > So why should a sysfs-interface accept it as valid input and treat it as
> > > false? That's just bad design.
> >
> > I can agree with this.
>
> Looks like part of the problem are commits like 4cc7ecb7f2a6 ("param:
> convert some "on"/"off" users to strtobool") which destroyed perfectly
> well-defined interfaces.

Oh, but the strtobool() in ABI was before that, for instance
 % git grep -n -p -w strtobool v3.14
shows a few dozens of users and some of them looks like ABI.

...

> > Somehow cifs uses kstrtobool() in conjunction with the wider ranges. Nobody
> > complained so far. But maybe they had it from day 1.
>
> Wow, that's pretty nasty.

I have checked, the wider range fits one character. So, basically they
had this kind of interface from day 1.

...

> > So, we have two issues here: kstrtobool() doesn't report an error of
> > input when it has garbage, the user may rely on garbage to be
> > discarded.
>
> Right, parsing is too allowing and there are too many ways to say
> true/false.
>
> The power-management attributes use 0 and 1 for boolean like I do here,
> and I'd prefer to stick to that until we have deprecated the current
> kstrtobool.

Okay!


-- 
With Best Regards,
Andy Shevchenko
