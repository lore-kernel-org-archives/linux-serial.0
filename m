Return-Path: <SRS0=lGjV=7D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E82C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 17:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF52720759
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 17:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFVtLzwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEURS1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 May 2020 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgEURS1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 13:18:27 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47ECC061A0F
        for <linux-serial@vger.kernel.org>; Thu, 21 May 2020 10:18:25 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b28so2437365vsa.5
        for <linux-serial@vger.kernel.org>; Thu, 21 May 2020 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpkOZJGzlOyjMi6E4aGEVw8elxqv6cvMyDakUdm0E6w=;
        b=bFVtLzwvUKDWNkBK6dWkJEda5wjM89UHYfYNcjTYN4P+nB39oDCq/kKc6ofSZmqeHb
         tYGLDZacFX5B7LUfcjyoApF8wnLcDU72LTunks9leoZ7KG9aU5PYcikSU0WRj1soGSZ0
         o9xx2KoC3JM4VZSOcSG9U3hJuNoLmnM21QhfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpkOZJGzlOyjMi6E4aGEVw8elxqv6cvMyDakUdm0E6w=;
        b=A3M49g0STK8+Rh/PTNXAThUBN+NVxnvIsY2f/aXwl5a84mmwO2mG1z9Io2Eroc4V41
         vsktJOg3hFLmk0LXgksHq8d6GAxQ7fPpm9g3USdAoah/ZiD0z73iViGpAVbArIShS+rw
         oUO40oCzJMpbtcChQIpgt/+uesQEqIpnBZXhpGAK7UI3mEW9OHZWIk/2ArxtykM4CJKe
         qL9K/Cp1HSjm66Bu7LHDqmRzAFzKERe2GVjOduQDmnvPIp1OVuIqRY/aw5K8DDjWOEiY
         Xr0sSHCol543Xpbq/ZqoJ01/Kgzz4elmjVyY9S+z2MnasdPpUPO5IKdLnluaMeJZ5VXG
         utkw==
X-Gm-Message-State: AOAM5328yr11u1dqrAlmA8Cz9qTXpNMmTiIWEaH7dD8DhQ2f6o/JmrBG
        xXM6bmOBRNlZa89XmPhQ8F+gOb1/PsQ=
X-Google-Smtp-Source: ABdhPJz1d7euXdAo1Gx+lK1ywX52Z51psY4a8fhqIqgC/q0/WC0Y5025OlS36IjRMzIJxR6vfaMA/A==
X-Received: by 2002:a67:8bc5:: with SMTP id n188mr7904178vsd.78.1590081504428;
        Thu, 21 May 2020 10:18:24 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id g29sm582832uah.5.2020.05.21.10.18.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 10:18:23 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id c17so2820437uaq.13
        for <linux-serial@vger.kernel.org>; Thu, 21 May 2020 10:18:23 -0700 (PDT)
X-Received: by 2002:ab0:69cc:: with SMTP id u12mr7668622uaq.22.1590081503114;
 Thu, 21 May 2020 10:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200429170804.880720-1-daniel.thompson@linaro.org>
 <20200430161741.1832050-1-daniel.thompson@linaro.org> <CAD=FV=U64XLRFkTyTi1qDZjTYQKJ9WVBf3OoULpw6yncOQURTg@mail.gmail.com>
In-Reply-To: <CAD=FV=U64XLRFkTyTi1qDZjTYQKJ9WVBf3OoULpw6yncOQURTg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 May 2020 10:18:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xut=5y-MyJSu+ERdMRkKbSf8SGMhUHg5OP=y8zA1N-xQ@mail.gmail.com>
Message-ID: <CAD=FV=Xut=5y-MyJSu+ERdMRkKbSf8SGMhUHg5OP=y8zA1N-xQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: kgdboc: Allow earlycon initialization to be deferred
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 9:47 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 30, 2020 at 9:18 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently there is no guarantee that an earlycon will be initialized
> > before kgdboc tries to adopt it. Almost the opposite: on systems
> > with ACPI then if earlycon has no arguments then it is guaranteed that
> > earlycon will not be initialized.
> >
> > This patch mitigates the problem by giving kgdboc_earlycon a second
> > chance during console_init(). This isn't quite as good as stopping during
> > early parameter parsing but it is still early in the kernel boot.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >
> > Notes:
> >     v2: Simplified, more robust, runs earlier, still has Doug's
> >         recent patchset as a prerequisite. What's not to like?
> >
> >     More specifically, based on feedback from Doug Anderson, I
> >     have replaced the initial hacky implementation with a console
> >     initcall.
> >
> >     I also made it defer more aggressively after realizing that both
> >     earlycon and kgdboc_earlycon are handled as early parameters
> >     (meaning I think the current approach relies on the ordering
> >     of drivers/tty/serial/Makefile to ensure the earlycon is enabled
> >     before kgdboc tries to adopt it).
> >
> >     Finally, my apologies to Jason and kgdb ML folks, who are seeing
> >     this patch for the first time. I copied the original circulation
> >     list from a patch that wasn't kgdb related and forgot to update.
> >
> >  drivers/tty/serial/kgdboc.c | 41 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
>
> Thanks, this looks great!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Are you planning to rebase this patch atop what landed?  It seems like
a useful feature.  If you want me to give a shot a rebasing, let me
know!

-Doug
