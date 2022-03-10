Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF1BC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 10 Mar 2022 00:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiCJAPe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbiCJAPe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Mar 2022 19:15:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C55BD38
        for <linux-serial@vger.kernel.org>; Wed,  9 Mar 2022 16:14:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b15so822223edn.4
        for <linux-serial@vger.kernel.org>; Wed, 09 Mar 2022 16:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YOi63Y4UP1PxQIOJspMhCwWLw9KtU08nAJtSydjZYc=;
        b=ndLnV1n/Cj/VOOqVdnS1BUd+irOj0yq6+IhyDGRmeUD7EdPsTQEL0tSrZjhbJDKx5v
         HKwiDEpH4dZd1KSzFoOc1+usH/ySFbHje/5+3KfuIxLocRKXPGtD287yO40DXZCx/hJh
         TtDAT0zyBfLi10li350C7mskcVtQIQ6KYd1Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YOi63Y4UP1PxQIOJspMhCwWLw9KtU08nAJtSydjZYc=;
        b=LNeFh3QSzFCu4o9SKYY684MliNX1+Zd001KaKLZWQpeJmqyLGY76zTwDQ1JoOH3S3L
         8+qZFR19H65KfbA36xXiQ7aRHo0OPYzw9lQK4PadeC4mzOw1v6BpD4+KHs20kSxLc2rY
         bzdX+jmesW0j+JlRHovK4BZN13LHVvFjL2vSBE56CgSt+Y8Dz7LLa41IdyfxxhPrKKwQ
         8wvJNe+LF6OhD67tSLPoVNL+2pfl1zLniFCX6NPNvr9pTeBVmvAPqDKR/4wsgQ+NQrqI
         3uoqOu7UvnxYb0h1OyTh1JCerie3mgOGkhiL3a+qQW/LU1ktUcgCl3vKmUrblxCe5bF6
         QlCg==
X-Gm-Message-State: AOAM531u5JZHv0Vq6sua0AacoVXdCcpcKhGVmrdkfujHdWH7vnpciTCM
        c4633DBKHE+NPyjhS9DiG3dLl2US3UjfZhcu
X-Google-Smtp-Source: ABdhPJwNjydCkviRZQVDjHK8bAb3jbnpnyPie8SZbRt8nRiM2M8vCJQlonf0gO7KV8D1qrdwX2yeCQ==
X-Received: by 2002:aa7:d403:0:b0:40f:739c:cbae with SMTP id z3-20020aa7d403000000b0040f739ccbaemr1858040edq.267.1646871272739;
        Wed, 09 Mar 2022 16:14:32 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id h12-20020a1709060f4c00b006b4ec988cc3sm1254630ejj.4.2022.03.09.16.14.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 16:14:31 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so2410362wms.4
        for <linux-serial@vger.kernel.org>; Wed, 09 Mar 2022 16:14:31 -0800 (PST)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr9408784wmc.29.1646871270537; Wed, 09
 Mar 2022 16:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20220309033018.17936-1-rdunlap@infradead.org>
In-Reply-To: <20220309033018.17936-1-rdunlap@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Mar 2022 16:14:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=ViPnSnoSYHSJFvyzkJ+Q+w7JuZFWS7u5BQxN6KHquGyw@mail.gmail.com>
Message-ID: <CAD=FV=ViPnSnoSYHSJFvyzkJ+Q+w7JuZFWS7u5BQxN6KHquGyw@mail.gmail.com>
Subject: Re: [PATCH v2] kgdboc: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        He Zhe <zhe.he@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Mar 8, 2022 at 7:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) environment strings.
> So return 1 from kgdboc_option_setup().
>
> Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc7
>   kgdboc=kbd kgdbts=", will be passed to user space.
>
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc7
>      kgdboc=kbd
>      kgdbts=
>
> Fixes: 1bd54d851f50 ("kgdboc: Passing ekgdboc to command line causes panic")
> Fixes: f2d937f3bf00 ("consoles: polling support, kgdboc")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-serial@vger.kernel.org
> ---
> v2- correct Fixes: tag(s) (thanks Doug)
>   - drop Cc: Laura Abbott <labbott@redhat.com> (bouncing)
>   - add a reference to init/main.c::obsolete_checksetup()
>
>  drivers/tty/serial/kgdboc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
