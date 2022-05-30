Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B4AC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiE3QFU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiE3QFD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 12:05:03 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20E42A31;
        Mon, 30 May 2022 09:05:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso114140887b3.9;
        Mon, 30 May 2022 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pe4wAzVYxqg5WekITDQBOiq/fINp+amMz9SrvCT87Wo=;
        b=i3g7zKbdj0aMiQJtGNKCxMFvJP8OaYq2leIpbLV9qyh1hqeYPwnfN6YxdB+YQODCGI
         lw5MsGVGpAq4AyvXnXWOVOY07TkYoMCBK+JAINLg7Sy+9OTq7QT/3J8X2DoqACeBviYy
         SO6EZwnnIZhbO4IKHIiG/EOFu1+J2mQDs7rMcg+XitSIs4vE1ms3cRM9CrOCEIYFkK9t
         2yLm1/ci4WEQEQ1oAtVbR47BYVP2jPEx1GEZLk0+2kZuYN9DNgJfIROO/JJ6NsV/S3Zl
         cXjqdoocPrVcOLp2UbKWUdmSTAWP2UH1lC7g1diMIfQHqp8WNedaSlFM3EEpFhckoWm3
         //pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pe4wAzVYxqg5WekITDQBOiq/fINp+amMz9SrvCT87Wo=;
        b=ZcUW1z/lYA7I0GFxnyiAeGiZIIMnw369SAaAdvpqSFqgS7EUZPi8FROUQOu4l7xnEH
         wxi6kvIDL8Uuu4bTX5/IC0XCb97S39uF7nv2ztp+O0mALcn+7oXTrK4to7hiL+vo6K8Q
         qVOI40GQm4HmVn00T/0c6rmmkpP0p7om94MX77wjUwfhhQEZrinR8mWo9Pdm4jVRcaar
         EkA6/SmZiI3wC0S5CbYxF6nJZdrC4ahCNxJoKrYWPTDf+DMslvnThJHSV4nfShQXxfSU
         7PfPBQx1OnMjkeszLKW+/G6J3ZQgjUqJfnE08XDlcSDngc33AZP57imDc41fi/DaDckE
         VOdQ==
X-Gm-Message-State: AOAM533+u8zETouZF7RMmpNbfCUd3picLnB0hZM4V4TtJ8AWZuvOgkrS
        sWY44Yzd9DTF8V4I5We1tF8N25IL5C2x4tUHFdXTL/Ml
X-Google-Smtp-Source: ABdhPJwNfEJ654ExMmybhU42+N/p25X9gXWpsYedTNlfDvjCxtif6qiKSC+kVq9hODdRBVdm6tTNCIcGScnjBD4iQXA=
X-Received: by 2002:a81:4420:0:b0:30c:3a84:3617 with SMTP id
 r32-20020a814420000000b0030c3a843617mr7695081ywa.23.1653926701369; Mon, 30
 May 2022 09:05:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7aa7:0:0:0:0 with HTTP; Mon, 30 May 2022 09:05:00
 -0700 (PDT)
In-Reply-To: <YpTGF1dh2RafcFT2@kroah.com>
References: <20220527222703.BA4D3374020E@freecalypso.org> <YpTGF1dh2RafcFT2@kroah.com>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Mon, 30 May 2022 08:05:00 -0800
Message-ID: <CA+uuBqbAz0SL88HTsg1m-80i9eHS7EjnRyrKE=GWrXA7u1GB_A@mail.gmail.com>
Subject: Re: [PATCH 0/6] serial ports: add ability to suppress raising DTR &
 RTS on open
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg K-H wrote:

> To ignore the public, accepted, standard is to become an operating
> system that does not follow the standard, which would not be a good
> thing at all.

So is FreeBSD 13.x a bad OS then, because it offers an *option* of
suppressing this particular standard-mandated behaviour?

> Again, that is the standard, why wouldn't you want to do that?  To not
> do that would be to break interoperability with millions of devices out
> there (remember modems?)

I don't need to "remember" modems, I use them almost every day in my
test lab - but none of my proposed patch versions (nor FreeBSD's recent
CNO_RTSDTR feature addition) break interoperability with anything,
instead both FreeBSD's solution (for their OS) and my proposed Linux
patches merely provide an *option* for more specialized hw devices
that require different handling.

> > The solution implemented in FreeBSD relies on a feature of that OS
> > which does not exist in Linux: initial-state devices.
>
> Linux dropped those a long time ago for good reasons, let's not revisit
> that design decision again please.

Dropped?  Are you saying that Linux once had them at some point in the
past?  If so, I was unaware of such history - I thought Linux never
had them to begin with, just like Classic UNIX (4.3BSD etc) never had
them either.  But in any case, was I ever asking for ttyXX.init
devices to be added to Linux?  No, I was not - instead I was merely
pointing out why a naive "straightforward" port of the new CNO_RTSDTR
termios flag from FreeBSD to Linux wouldn't work.

> From what I recall with the original patch series, Johan is the author
> of these, not you.  Rebasing and forwarding on is great, but please
> never drop original authorship of patches, that's just rude, and in
> some cases, ripe for legal worries.

In the case of the 3 patches which originate from Johan (1/6, 2/6 and
4/6), I submitted them with the following attribution:

From: me
[...]
Co-developed-by: Johan
Signed-off-by: Johan
Signed-off-by: me

My reading of Documentation/process/submitting-patches.rst told me
this was the correct protocol - but if I got it wrong, what is the
correct way then?  Specifically, what is the correct protocol when
(in this chronological order):

1) Developer A prepares a patch, and then drops it, i.e., does not
continue fighting to get it mainlined;

2) Developer B picks up A's patch and makes further modifications to
it, modifications which A might disagree with.

> Can you fix that all up, tone down the "this is all wrong" verbage, and
> properly resend the series as a joined patch series (your emails are not
> threaded properly at all and our tools can not find them correct, just
> use 'git send-email' and that would solve it.) and then after the merge
> window, I'll reconsider this series.

Please accept my apologies for missing the thread-linking headers - I
didn't realize until after I sent the series that they were critical
for reviewers.  I can resend the series with those thread-linking
headers added, and also changing the cover letter comments to be more
in line with your worldview - but first I need a clarification on the
authorship attribution issue above, as it is one thing which, if wrong
indeed, would need to be fixed right away.

> Also please document what has changed since Johan's original submission
> to now, and why it should now be accepted when it was rejected then.

The main change is not in the patch code, but in circumstances: in
between then and now, I have discovered that FreeBSD's solution
actually works correctly (unlike Johan's superficially-similar-sounding
termios flag proposal for Linux) in that it does NOT tell users to
"please suffer just once" on the very initial open of a freshly
plugged-in USB serial device.  Also FreeBSD's release process is
slower than Linux', and as a result of this slowness, the feature
addition in question only appeared in a release in 2021-04 - some
months after my previous attempts here - even though it was committed
to FreeBSD HEAD in 2019.  This new development in FreeBSD shines a
flashlight at Linux being the backward one here, and I was hoping that
this new change in circumstances would help create an impetus for
making the fix in Linux too.

As far as actual code changes between Johan's original patch version
and my current modified version, there is just one code change and one
significant comment change:

Code change: I have renamed the sysfs attribute from nordy to
manual_rtsdtr, with a similar name change for the internal flag, which
IMO makes it clearer what it is actually happening and why/when this
special mode might be needed.

Comment change: I removed all references to the termios flag idea
(which was Johan's repeatedly-stated longer-term goal and desire), as
that one can never work acceptably for the present problem in Linux,
or in any OS that lacks initial-state devices.

Oh, and there was one place in the code (DTR/RTS assertion in
serial_core.c, applying only to "hard" serial ports and not USB) which
Johan missed in his patch series, an omission which I only noticed
when preparing my current series - hence patch 3/6 is my original
work.

M~
