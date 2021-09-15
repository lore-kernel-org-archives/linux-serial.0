Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76517C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE35610FF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhIOIMy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbhIOIMG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 04:12:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB27AC0613E5;
        Wed, 15 Sep 2021 01:10:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o20so4294714ejd.7;
        Wed, 15 Sep 2021 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVFyY2V27y/UeArEwcODznJwknUl0TaYdAnTamBxHAw=;
        b=koAf1/HE5zAgwbf9qStT7LXz8vxwVFIBcA+b43uHnMKR8OxWOtIrdUCrWc4cUTBsqq
         Bt8cfVOBzIsLlZtILynLGbJLAb6OCqwUGGQh6D/vj0F6AAmkeWUmapF2Sl3SK8pROkzQ
         iph4GCjiPgqNxBetgFB8izA1B9VI9HCrPHqUw8xOW+lxA+EklwhaVn9l22V+f9L7htnJ
         FFqkvnSIsGdyuNNAhbxIDcGZaRbg2x8jHFCabFrrXEn4ZxQKFnURIeVsIBT/W1mjiq20
         h/b4KZho//fRjyvXTuTDM9tthvqrUoVAuzITEUzB77AEgzdssYB+ZVDULwhTihlDSl+z
         ROGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVFyY2V27y/UeArEwcODznJwknUl0TaYdAnTamBxHAw=;
        b=G7QeJj2j1D/e6hlmOzElml/nffmp3W1LYgykiOzzK+gjKkQAcDTPvEfGWUKPZpDXI+
         NdoGUSZHAdJSrFBiDABDM0iydSVX1eznNf09fwcuWXfyvL1Ck6cLH4EuT/nIaK+/4XpK
         yNk6AhWQRgH3v5CumF1pKXmDx9LzXmQFFhqCkgasMG3a54QJjPmHf7Ngy1SJAdHnpO+l
         pWvMg0EhIgr4WeudHmTIyXiZWwzWv1rrDhVL29qnGMRlOYiwMyJBQTf8GN1kdZpwTNGH
         esBKgrr9KbndCbdELji8eib2EzQqcEw8V865g5YOPTiCNB+zZuto/vrqQTQtENlFNJ3S
         y8Lg==
X-Gm-Message-State: AOAM531+6Uv+hUu22j4wpeZjO67rWU0r9Tmd7i9X7cAPiSmT6lSNE/lM
        VCkn6xaR2rde75S7owRcqY6U2YWkNaMb/AOijFY=
X-Google-Smtp-Source: ABdhPJwcmv6EgSdHJnibcbLmqURiWSWrF2pUoqr/JXaT8CAFUkSiBYz/TDLqlzgGEehjVnqwzZsHZ5InM4Y3GGUNsQk=
X-Received: by 2002:a17:906:7208:: with SMTP id m8mr23644303ejk.82.1631693442497;
 Wed, 15 Sep 2021 01:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210914091134.17426-1-jslaby@suse.cz> <20210914091415.17918-1-jslaby@suse.cz>
 <20210914091415.17918-5-jslaby@suse.cz>
In-Reply-To: <20210914091415.17918-5-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 15 Sep 2021 01:10:31 -0700
Message-ID: <CAMo8BfKasYTwB935oxvuJjpv_yBhkxbo8P3nzxaq1_1QgZHUBw@mail.gmail.com>
Subject: Re: [PATCH 12/16] tty: arch/, stop using tty_flip_buffer_push
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 14, 2021 at 2:14 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
> going to remove the former, so call the latter directly in arch/.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> ---

>  arch/xtensa/platforms/iss/console.c | 2 +-

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
