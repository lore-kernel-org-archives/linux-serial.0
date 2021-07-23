Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7EAC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52895600D3
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhGWJhq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhGWJhq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:37:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B664BC061575;
        Fri, 23 Jul 2021 03:18:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z26so1161169edr.0;
        Fri, 23 Jul 2021 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBPRKY3kAU7k5qQgFJyXkiaf1woJOD/WKKAjcqGHd5U=;
        b=hkYhqb+jNLAqV05N76rJ81VuMYz8g6RicGw00y/l3CFcIHdn7GaLggMFnHYy70sZYJ
         mTeZZ1a1OKe5GW27ABJqWKTACATxk+3V8P9iAvSzg9xzq/gBGNRKcwNqpTj2s6H/Ydgj
         1OUxVyw/RkETRVb8coSDiE+5+XAI0jfpXpZ2yDTfHbLDqdlhW8v/xFD/SXy+N+pWLo8c
         FaNFz4yBP2VA8LwWSZciw/W8B68pJn/ZSVph6OwF3So7crEVZXeatwvUszBzXqnllAaF
         TYgMrz/PxzIt0uVjJjALEiSTnm094dd1RtbaCPinu9Wr8EW9YqeOJJ88yvqVep5mv3Yc
         iixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBPRKY3kAU7k5qQgFJyXkiaf1woJOD/WKKAjcqGHd5U=;
        b=sHFtoWQAvJx4Eqh0VhUKLjYl3pzzsGJjEY2v22r8DBuL3Bn1gOzv0kCYz7m8/gwsmH
         kYmK7xAdkF39pYwLenKejER9pUBJsjG2Go8hs40YSnIT1t5vSxgrmRz9lLsug2iz9UHj
         8nK/0CD/9gzvACt9jHQ95kG75EDO+hOGeOrCvt1B+G4340raAaNNWnVGLCh7/jSznAEL
         YlMhP2voWY8iKC/Ou/TyH1bQJHXkfKiNQ9GCo6ci2619dz+kX1//zaP2hnJDByKkSIyy
         FRhtTQdsOxZ9mD11n4nv0NALeF7/PdnsmSwh5lBk0MKfUT1lLO6Oj8GboBgf2Cryk+UJ
         0/4g==
X-Gm-Message-State: AOAM533u4qDEVZ9GutJFH0wG9jS4l1K22lWaOjMl023RdUdmZpvvDAFv
        0+CiLHwvLaYpwJKX+zg3kZZa4r6990otI02Y15Q=
X-Google-Smtp-Source: ABdhPJw2Ynvl7onUFB8T7RfBl9YWi2ELmdwKrnUPYTZpXvVDDoy4Uf6lMGaBkm6qck3YoWSYv+Eb+kS9i2d9p7EoC8w=
X-Received: by 2002:aa7:c1ca:: with SMTP id d10mr4479428edp.107.1627035497315;
 Fri, 23 Jul 2021 03:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210723074317.32690-1-jslaby@suse.cz> <20210723074317.32690-2-jslaby@suse.cz>
In-Reply-To: <20210723074317.32690-2-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 23 Jul 2021 03:18:05 -0700
Message-ID: <CAMo8Bf+Hm+qg_oUjN6P8ATOqXxHFBPnXA3D9SG+X4P3+wDzPjw@mail.gmail.com>
Subject: Re: [PATCH 1/8] xtensa: ISS: don't panic in rs_init
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 23, 2021 at 12:43 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> While alloc_tty_driver failure in rs_init would mean we have much bigger
> problem, there is no reason to panic when tty_register_driver fails
> there. It can fail for various reasons.
>
> So handle the failure gracefully. Actually handle them both while at it.
> This will make at least the console functional as it was enabled earlier
> by console_initcall in iss_console_init. Instead of shooting down the
> whole system.
>
> We move tty_port_init() after alloc_tty_driver(), so that we don't need
> to destroy the port in case the latter function fails.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/platforms/iss/console.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
