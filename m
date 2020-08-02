Return-Path: <SRS0=oHof=BM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C964AC433E0
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 11:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991322075B
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 11:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa0GbdGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgHBLRK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgHBLRJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Aug 2020 07:17:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1BC06174A;
        Sun,  2 Aug 2020 04:17:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s15so6826876pgc.8;
        Sun, 02 Aug 2020 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/SAAS8ZjrLaboM06g8Fjn6MZH5XRvOwa+XyUTUtB4Y=;
        b=sa0GbdGmE4ZQqECUjR1TN/yQak1ZpkaJKAzcd0vxWTsdqllyYfBgBvU/L6GNyzB5wq
         hpApMPUbAHzOrkWFJFN9E9lOp5VZS8hy9eFNdEn4GXUqyj6SkybZNA+1CSht4k/wmB2I
         yiVmDcmzXTrhl6FGLSUaESBvBT14B7ZZPxQB5Rtc4YFGn+Gs2FZ+1osK3+1X/ZRYv0Pw
         8b3sP2XJ/BVRMNjO91Dx0OhaTSgVvza99qMwFrKnYpVIx7q5nC4SOQHR8V+HOlzto3tu
         8J9V54tMUXQGUlGPh96B9FzOrF5404V/aaFd6dAmVNq4R6nn4pSr7VyOVx2LuFE0R7eB
         OeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/SAAS8ZjrLaboM06g8Fjn6MZH5XRvOwa+XyUTUtB4Y=;
        b=T3IC2wZcndg2FKKqVxnpnTEc7kGC778wGhEdt1YgM7Z42ryZsd62Yd0M88+mchY1pc
         SyY8EYz87g+UVW6tQ9wjCpc6v08IfNCxUCSUfXERMhbTuXM8o+C//70Tz2T1cWj+eZIR
         XGZHNWJKzOtdFwSXPCNM6rJ43x7EC/J9DW/HEE8AAxHp6pTioIfI+z4FVpyaZkQNohTm
         6KcaayAv5sCiLfdvh18+SerZvjKk27j8DkJLtLCR3OzIuKxFqnynF8g6lGmaOmc4eEq2
         thYwjr/DZx6C585aCbXSYUq0YC2WKZ/nKJZapYNhmBUInKcfvqJWvvD/cdEo53UMZR+v
         0Sew==
X-Gm-Message-State: AOAM532kXEyn1uQY/8WG14uN6Na/HINpkYCOr2K34oUlgBt8cDKS5JAt
        5Yj1U4gpQIuGx4nSQNd8nuSmaTfed2tGxXJysl/Ql/6X
X-Google-Smtp-Source: ABdhPJy85UXpNV7LLuS8CX7kB8eHreGVZA8G9R+hdj1BAnhdpIP53PuHE8bfCunM1hWC+Kehx+VXBeyxLz1UbPNSAj0=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr10910952pfc.130.1596367028479;
 Sun, 02 Aug 2020 04:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200802054852.GR23458@shao2-debian> <CAHp75Vcdwz2RynZ0KVCDMFyO_GPREgGdCNVNGqosjf6iV0_uog@mail.gmail.com>
 <20200802105808.GA164531@kroah.com>
In-Reply-To: <20200802105808.GA164531@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 2 Aug 2020 14:16:52 +0300
Message-ID: <CAHp75VdAHGi3OtTe34TgpgBp_5=i0K6wa3vygaxHQv3OO=bA1Q@mail.gmail.com>
Subject: Re: [serial] 679193b7ba: BUG:spinlock_bad_magic_on_CPU
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 2, 2020 at 1:58 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Aug 02, 2020 at 01:50:29PM +0300, Andy Shevchenko wrote:
> > On Sun, Aug 2, 2020 at 8:54 AM kernel test robot <lkp@intel.com> wrote:

...

> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Thanks for the report. I didn't see it on real hardware though. Maybe
> > because of timing (race?) differences.
> >
> > Greg, I think the best is to revert the change until I will have better one.
>
> Can you send me a revert patch with the reported-by: set up?

Done.


-- 
With Best Regards,
Andy Shevchenko
