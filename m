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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68434C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509D860EB6
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhGWJn3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhGWJn2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:43:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46BC061575;
        Fri, 23 Jul 2021 03:24:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k15so1078692edq.13;
        Fri, 23 Jul 2021 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/djCiTbrGETxvYGjnVxeVMMBE7bXoe7yIRvnCe48DE=;
        b=HIuHnT8wYqA3ahyCSoMC6gdXQnV2KbabsexS/cLWPqdHVFrvWMoVDxKESPmBKQ/Svq
         ssVl2LBjIow3tvsQY82gaZ4T6UGmco/t1VHsB5pGAZPeJ70r9KlLcU+lOfpV8anfBfhb
         klUu+RJIyC9toQY3JhoUvz/MeR2J4gceyMZzNMhj0OwkGUsXZcHAQypWDNZe05kj7sDB
         TaiBdZlFW5HA/G6jjZ/sFVrPOTbW5pYb65w6rqPVb+eqQRBiq7bVrC6vs8wzIwZhmakF
         8AO6G82RB793w34TSO3+gcPDAM9T4gQKq4GQsCJf6l2SREsUGxUilVSTG70QCt6DItaO
         4OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/djCiTbrGETxvYGjnVxeVMMBE7bXoe7yIRvnCe48DE=;
        b=GPk4IYu69Ip4P2xnjxnTHMYxBxkM2lwB+I+j+ASs4FOx3qYVlaVss/7kW2MGdM86by
         m4IZxQmatDtYtxrl9J76fCXsy1X6ZX1c1FeGgcaJKkM5sdFgYy6NbAziRxvDjEExjzLh
         APyz//NJKkqkrhPRySeIkWV9UpZF3VFjudvwW0Ss/yZb4x5A6i/+CWalYjsUzguzeG95
         v8GOnwAnvB93cVfyIXUhQyr4OH5kbifc/c/FYECk43rRKSJmLBYJz4qJuvvbEJ1POOCe
         pzKSkoWaRFSHCrj7IzO/xuAPp7SdVPOG27qPhkJETWyxGoeuDhoUU+x9r7qzXOWGyhKm
         OXSw==
X-Gm-Message-State: AOAM530LlABoN9QzUsAyMusbSvMMOAF1U6jkAhXAFmYOP+wlfJ9nr3gm
        1pprHv5II446Yy0hZBKOrnEN0mrS3FSTpleBkDU=
X-Google-Smtp-Source: ABdhPJzW/Pavt35ZV25HSu6FsacPXhUnDfottT67NYpmEreLNKrQR+1UUmDXXHM0tn05dOuGXXkJGxC7WgzbzV+ijDo=
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr4711094edd.237.1627035839567;
 Fri, 23 Jul 2021 03:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210723074317.32690-1-jslaby@suse.cz> <20210723074317.32690-4-jslaby@suse.cz>
In-Reply-To: <20210723074317.32690-4-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 23 Jul 2021 03:23:48 -0700
Message-ID: <CAMo8Bf+8QNqmGHeL5pOdEjWpMRUGG+D9YbDeWMn8Dvygd5HgUw@mail.gmail.com>
Subject: Re: [PATCH 3/8] tty: don't store semi-state into tty drivers
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 23, 2021 at 12:43 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> When a tty driver pointer is used as a return value of struct
> console's device() hook, don't store a semi-state into global variable
> which holds the tty driver. It could mean console::device() would return
> a bogus value. This is important esp. after the next patch where we
> switch from alloc_tty_driver to tty_alloc_driver. tty_alloc_driver
> returns ERR_PTR in case of error and that might have unexpected results
> as the code doesn't expect this.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> ---
>  arch/m68k/emu/nfcon.c                  | 27 +++++++++++---------
>  arch/parisc/kernel/pdc_cons.c          | 28 +++++++++++----------
>  arch/xtensa/platforms/iss/console.c    | 33 +++++++++++++-----------
>  drivers/tty/amiserial.c                | 35 ++++++++++++++------------
>  drivers/tty/ehv_bytechan.c             | 28 ++++++++++++---------
>  drivers/tty/hvc/hvsi.c                 | 35 ++++++++++++++------------
>  drivers/usb/gadget/function/u_serial.c | 32 ++++++++++++-----------
>  7 files changed, 119 insertions(+), 99 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
