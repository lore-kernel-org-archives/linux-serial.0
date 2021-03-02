Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF78AC28E86
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9069A64E7C
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348969AbhCCCR0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836816AbhCBHVD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 02:21:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3489C06178A;
        Mon,  1 Mar 2021 23:12:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so23834854edb.11;
        Mon, 01 Mar 2021 23:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFPfuv+YOm+k4DkSctX34qa+OTvzsdZXK2vjFfw1Tm0=;
        b=S+JgmgnHbH90N1HKUqeQ8Ew6otkHcSonG1aR/anE8nDB8d+/JSrnIw0cAhBEC8BVq/
         kMjmMdEUwb5hPNJKX8x3iXHlplNGC4CvUuOTaleLTBpTGngbrTgMIAMbs8IP2qW4Jkck
         GKec9aQBiT1xpE8kX7CaZ0Ibp85vzRvpkobBvQtWrAJ67WdZZFDEfHXKI1AtuPIPuSoc
         CnKdgAOmn8VuruQPAtWpv1ZAEBz3Asako335glZHIoToRXkTcUp04EMNF9D8xb9dcdvc
         HQxzZUB1mTXJXYeP0z7UZ6bGTRdykeNYwaIKxJiO0bjqGDFbRu71FXnZs8jeusysVsPJ
         X0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFPfuv+YOm+k4DkSctX34qa+OTvzsdZXK2vjFfw1Tm0=;
        b=olDccLxc1bHG/n0APMv1VaTiyiFFupESqyvOm0tohbgz5cW2e+xt1wP3zsp3/E7r82
         UgoL5MxGSIdv0Ksz8lSZPUBxaM0WFaDyPsF+1nza8nzxT1fBEWTSlRRyzMswpMrf9B+W
         1+Bo6+j2h+1fLPx9bxTuyUsfTICwaOeyOAvwJIBZlBHr+UBwA485Coj3P+b60sHtlB+i
         6uBqAs7t+tKoGfusIrIom2meo+5eRqgKFByVMeghBSOl7UrXM7y0+m7xJgY2sL5T+YG5
         VIEJn0kLTm3//tgRD50ZNzaKsjJa53lTtQ0nL/i7yB8TEJA+Zu5c2ZMgB7hRPK7UkjdC
         AIDA==
X-Gm-Message-State: AOAM530c8OMFNqTWRmzSdXlYKY2iuAxtEi0f21TovfkvRsK8IO8N3cPQ
        hCiraZ8rWfN2z+dNx5Nz3fZbuZqxiCm++E9h/YE=
X-Google-Smtp-Source: ABdhPJy7opFJLI5d73Hqpi8Cv4/3I+seAygBh3QYLYVMuD5pEdzAuf6uvBUmy2PBrlAtB7jJvHh88gZ9YwZuW7j1DH0=
X-Received: by 2002:a05:6402:888:: with SMTP id e8mr11730080edy.51.1614669155407;
 Mon, 01 Mar 2021 23:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20210302062214.29627-1-jslaby@suse.cz> <20210302062214.29627-30-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-30-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 1 Mar 2021 23:12:24 -0800
Message-ID: <CAMo8BfL0Frrd6A=j+LXmExAkcKRLBm5a_3rM1hyz+W6p9i91xQ@mail.gmail.com>
Subject: Re: [PATCH 30/44] tty: xtensa/iss, don't reassign to tty->port
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

On Mon, Mar 1, 2021 at 10:22 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> We already do tty_port_link_device in rs_init, so we don't need to
> reassign a port to tty->port. It would be too late in tty::ops::open
> anyway.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/platforms/iss/console.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
