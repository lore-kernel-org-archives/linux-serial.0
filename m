Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F5C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0AF61165
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 18:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhKFSjS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhKFSjS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 14:39:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4778C061570;
        Sat,  6 Nov 2021 11:36:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v11so42435959edc.9;
        Sat, 06 Nov 2021 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=319jAdOvybl/bZ8e86HpwcSlQ4SwCmYSJvn8ALxCgiU=;
        b=mp3gxqTKpH3JdF/Xrw6+3OthUUgHFEw4tctK412lAfgu7pkcOvKqiWvBfzhhzhkEKV
         De+mxclTEX/RX4L6B+bhNoTckfsvp438gV3H1hWQHfachrOjgJkIa74UGfSeYy3wdktg
         txvimuTkto+HG4cStio/F6XUr0AEz6j/GkDLe0nrZB9dir7+C1PKrVvwlkMNeuv3Geex
         Iod30nMT8b9EGX7VYyGI+sJZmue7u9hbtdpBELdow0mDHqcE4nkRKn9vOmxMV9gycvrM
         TIQh6CNl+AiXRnhn7eXIVN7WysMlNRJB/INVa94/AIxF2yRWKq6+caOWAVrkAoNlkfqS
         Mhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=319jAdOvybl/bZ8e86HpwcSlQ4SwCmYSJvn8ALxCgiU=;
        b=I7eSA5zge3VshkqaGzxd3j+dggVby6BiUG6q6zJQz2DrqMHz3ljGqudI1UBLiCSXnQ
         2Tc1CLShbW10Kff5+gZJYTc4FrhOxY55oRX3k2I8IJpPfCqAl1wwQA4O6jxp2FQ2OGLc
         dHZS23JNcLU9/Nh9idgCoOVNOzHJrX308R0oCS5OwuQ1Bc5nuDM9Ft65IYwVvMlbUHR6
         ZBYbU01BwHs1uTiKa37a0bBqECGEz1/IG2pbDNb3od5FV2a0BzuZN3reoQTziMxPs/xz
         ZhfXgF7H1Qy7mFsJIR7qssrhUmB5xn9fmyTlbY7B8dgWzPQzYrCSnObb3LJIAdyTh3zs
         /i8g==
X-Gm-Message-State: AOAM531vlZgZiBpZgNe4Jao/3yF3w15ia1v0FaKSu99bn9Gn6Zr59+Pg
        I7WUgxg3dE+5iPAw0IfXmKynB7VyY/KwtHhehpzZjk+mkVo=
X-Google-Smtp-Source: ABdhPJxbUmqqOioq2G2twnd6zUhqW8HioejtmLIURN042EoPu7dhjAwSxKKVE3gFiCsQR792shyiwEyPYiAuedUGIn4=
X-Received: by 2002:aa7:c44b:: with SMTP id n11mr69132735edr.238.1636223795294;
 Sat, 06 Nov 2021 11:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211106104053.98761-1-ajaygargnsit@gmail.com>
In-Reply-To: <20211106104053.98761-1-ajaygargnsit@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Nov 2021 20:35:58 +0200
Message-ID: <CAHp75VdY8aoF+dCm0j7EA-53BFaWdepvYYv7h5MVz2kVWagOOA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: vt: keyboard: initialize "kbs" so that kfree(kbs)
 runs fine even if kbs is not kmalloced.
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Nov 6, 2021 at 6:50 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
>
> v1 patch at :
> https://lore.kernel.org/linux-serial/YYZN30qfaKMskVwE@kroah.com/T/#t
>
>
> Changes in v2 :
>
>         * Changes as required by scripts/checkpatch.pl
>
>         * Checking whether kbs is not NULL before kfree is not required,
>           as kfree(NULL) is safe. So, dropped the check.
>
>
> For brevity, here is the background :
>
>
> In "vt_do_kdgkb_ioctl", kbs is kmalloced, if cmd is one of KDGKBSENT or
> KDSKBSENT.
>
> If cmd is none of the above, kbs is not kmalloced, and runs
> direct to kfree(kbs).
>
> Values of local-variables on the stack can take indeterminate values,
> so we initialize kbs to NULL. Then, if kbs is not kmalloced, we have
> kfree(NULL) at the last.

> Note that kfree(NULL) is safe.

Everybody who is developing for kernel may check this easily, no need
to have this in the commit message.

As I told you, NAK.
This is no value in this patch according to the commit message.

If you have a compiler warning you need to provide the command line
for `make` that makes that warning appear. In that case the better
solution would be to add default case because some compilers can make
(wrong) assumptions based on the absence of the default case.

Something like

default:
   kbs = NULL;
   break;

at the end of the switch.

But again, your current commit message does not sell.

-- 
With Best Regards,
Andy Shevchenko
