Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28414C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 08:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1292661205
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 08:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhKJJAg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKJJAg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 04:00:36 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9DC061764;
        Wed, 10 Nov 2021 00:57:48 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so2911300otj.5;
        Wed, 10 Nov 2021 00:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNAhI7CSQmz7QpgQGUaWZTNs+orZfVJ9zpLu0/GLqlo=;
        b=k7OzgszVJehWaeHzhP2ip5n9J/fhlbgI9iM8uUlcNMokat9pvz4I4OBgWlsKpC0X0t
         lJLgcfLoQTJTIdm567ahiScOcb4sLAh2dsQoutfTIaeVhR1qZ3JUalSHaBUV7UWZ92ne
         FZCQpLEs/HSkseOF2kGWj0xu+vOhtfSYKPrnL4OP1jg/N2if9YZJ4FJNofg9xdM7E8VL
         HY1FIJPt5KHRGp+PmugTassyoPHcPF+f53VfsAhPYmBZ+4IbCnzwMY8QePSxmzInulUP
         OetLlaTCSiknLIOrTR3qrAa3jfBWPhbfZaiNlhGHexplVEUygyTj3X87v+2oRFHmPhEW
         WPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNAhI7CSQmz7QpgQGUaWZTNs+orZfVJ9zpLu0/GLqlo=;
        b=oxGLnF2Xt4AOplf4QdkP9Acn/Bcp2K7pD0CGjzMGNJO3LSV6LH4uwcnjbnmwsaKlND
         lvgyPzfR2CSUsmHBkZjLzrK3SMFFsUHDHvvzzT727fJB7X3ZYyrPzexKPkgSvGbSd4UI
         gL9Sb8W0y5VpAVMRr+mliQi3i+Z9C2qwvtGCUKMYfqTBT4SJ3FkSyH2cOD9HFDx13Ppu
         u0Bk5KPU6admxhjH6ferLhmRc8GYVSugdHBWdy5QwjIL2ofn+RqlZ0c/j5eaW9P4yfIJ
         DdKTY2JUuANQUhpohHp91JYLNlcb09yLEKt7q91TJQPAU7jwoEAe523/NM8FIIP8JVbr
         hfRw==
X-Gm-Message-State: AOAM530i2kVqSQn4EetOce7kKzm9h/XfR4m1CFcJdhIYTQeW1O6OBVYT
        NxtviLIi0ZvxqwZ3sSTUnjF91WiVnZJoBPI9J2ObNLB1
X-Google-Smtp-Source: ABdhPJzGgF7d4SuhfvCiQ9lIJq2yEtOmA7GirINiHnC5wGlnzYUbmHX2S1N/2LMlQFP5ydVqPQOtcmBqjMMX4HKjW1A=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr11177292otl.351.1636534668336;
 Wed, 10 Nov 2021 00:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
 <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com> <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
 <9717b429-597f-7778-c880-94361bcdee7f@gmail.com> <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
 <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com> <08c9e717-4367-5316-87cd-90b5ceb13ed9@kernel.org>
 <1305bb43-b4bf-e129-af6e-957d1f30f269@gmail.com>
In-Reply-To: <1305bb43-b4bf-e129-af6e-957d1f30f269@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Wed, 10 Nov 2021 14:27:36 +0530
Message-ID: <CAHP4M8XfCJ8btBCf42GEZGWm_4ywhPKyXtxoBbHR4U190=gg_A@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, kernel@esmil.dk,
        David Laight <David.Laight@aculab.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

>
> Ajay wants to be safe and he thinks, that relying on fact, that
> strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string) is not good
> approach, since it's external for vt_do_kdgkb_ioctl. (I hope, I've
> explained his idea in the right way)
>

That's right Pavel.
Every function must work correctly as it "advertises", instead of
relying on "chancy correctness" of the calls leading to the method.
