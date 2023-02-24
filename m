Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DF9C64ED8
	for <linux-serial@archiver.kernel.org>; Fri, 24 Feb 2023 22:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBXW6W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjBXW6W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Feb 2023 17:58:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797318AA2
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 14:58:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s26so3197483edw.11
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 14:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECYH+xNXgIZdg5nfy5FpWWMpLUNA2LuYDJ0eGM5JDgw=;
        b=SoSCooq75FTO7eU+0Mf28G19+EJcIDd9/RoXHXcLVbTCiBgdVussJe8sJlVdv/lfuY
         GI19OT/g/ohuTbRXOT43f88404lqC80pEOE9poB8U8hGq+AN+oFa1OWR0fF61uKXq53m
         l7FC+1nttdxXwlYaxb9D+cMPvb1zzF3SvI9aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECYH+xNXgIZdg5nfy5FpWWMpLUNA2LuYDJ0eGM5JDgw=;
        b=o0LMYpChT/0nf1Aqykat2iLxlAn1HHtMUpLDmQSI+xR0h72BXKeSfgbcwesEz43Mf6
         XVPjnivcK8Jz60eK0/Cb1Js34bwVKM/At/IWiygc9ynASzssL1SfMRZH3odyPuTBtKGv
         mKudmGYG5U4FbvfBM9jb/TDJhPaBZulTOkgvyXvhN6enTngjirUzobLBsoLnBvOx/xM4
         o2F3OZuZtRFxmMPBTTb5HsVUP5zqYQuzRm8NP4Dugk9opkGlNNF/PQrum4anIxxxT7zE
         G2I8/dGB4NmM3Ca1nqSPEiEAUpycM+CUy3p/xTt9dE3E/bAwNvR0lJ3tGlkbSvEMtOHO
         EyYA==
X-Gm-Message-State: AO0yUKWrQBGY/3ixT9uwgKssbrdQ07N/OSPnm+yCAzKyu6Z3ZIyo54X8
        fSVRkjEaL9xTJh/pjR8fq5RoQ0iLxdqYp/rDfOOqEQ==
X-Google-Smtp-Source: AK7set8wXtakLt3nSzfroJUWxKs5VmrQ7ZfIQL7clVT7COg6Ow0cAJ5G3GZ20f66xbM1dj4OwHlf2g==
X-Received: by 2002:a05:6402:48b:b0:4af:70a5:43ff with SMTP id k11-20020a056402048b00b004af70a543ffmr6719626edv.26.1677279496068;
        Fri, 24 Feb 2023 14:58:16 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id z9-20020a50cd09000000b004ac54d4da22sm223581edi.71.2023.02.24.14.58.15
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 14:58:15 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id da10so3381158edb.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2023 14:58:15 -0800 (PST)
X-Received: by 2002:a17:907:60cd:b0:8f5:2e0e:6dc5 with SMTP id
 hv13-20020a17090760cd00b008f52e0e6dc5mr927497ejc.0.1677279495053; Fri, 24 Feb
 2023 14:58:15 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com> <Y/k66v01i5z3kFMG@ZenIV>
In-Reply-To: <Y/k66v01i5z3kFMG@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 14:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDFKGABDe7w-=HsiUr7f=CpbmR3bPf2UL-1dPcWRYW9g@mail.gmail.com>
Message-ID: <CAHk-=wjDFKGABDe7w-=HsiUr7f=CpbmR3bPf2UL-1dPcWRYW9g@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 24, 2023 at 2:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > It's probably most legacy by now - it's a long time since I saw a
> > serial port being used outside of management ports, and even those are
> > often ethernet these days.
>
> Serial console is hard to replace

Yeah, but I don't think that should make it "default on" just because
somebody picked 8250.

I may have 8250 in my old config for my own legacy reasons, that
doesn't mean that when I upgrade a kernel, it should default new
drivers to be enabled too. My old legacy 8250 history does *not*
suddenly grow new hardware.

Side note: we have *truly* legacy things like that
SERIAL_8250_DEPRECATED_OPTIONS thing, which also - for historical
reasons - is "default y".

I guess that's just another sign of the whole "this is legacy" thing.

          Linus
