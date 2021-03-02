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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B93C4332E
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411EB64E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348599AbhCCCRZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349258AbhCBG6C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:58:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4DC06178A;
        Mon,  1 Mar 2021 22:57:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p8so6808519ejb.10;
        Mon, 01 Mar 2021 22:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKUeJiCjz76ZYfYznUcE/FJF+AgYNAVfjdNl+41kQHM=;
        b=DSJUrWolKcsUJPc/uOpsS82Fd5ta60KGvcOI5BhLQJhg4BRNQknqSbQl89mvmiaGzW
         a6NGhlfgMwndx9LH/PVebtAwVtxdafFmRePToI2HugybUOS52TllZMb1EVav1ggkY5iL
         lw/PWq3eo/8KIebucPB+Rr/xSCCsc2DURjnDcF9wEJ8LZBsWQ/ODeHLqlJL/3/8t2s5s
         O4i62GN2i2/GSLIwh1bLypX0H5AnocVcjU98WiAEJHGJ2ttH9xWOkeyT2KNO/Ro6u/9p
         qSBStt5DOeUrlSJn4RDUMjZZCBp5TcrfB5FE7i1YBQ7A3KbniDC3FB7mDwOjR+WiN5xP
         54ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKUeJiCjz76ZYfYznUcE/FJF+AgYNAVfjdNl+41kQHM=;
        b=ezQlFiYYhqtTONl2f/RAIGdBinefGmbW+s6LovWEqMtUlMXi7WwRrjUaZaH7PFt+bu
         99rdRLTabxKEcZoJO/kM9ZaY1QqGbSC6I0lAYK5wJh4WL2KtGfbiNURCcHXwonw1P6+n
         lg8D4Rb81oVq2ZUIxL1YvNMFXXHRcYnPKHpWPE11w9w4XQLGBba+IobHIq1P2rtHM8jZ
         20jdI6Kwn7GXiN8xmdourKixNTYOI7D1hbxdFXPQPNZKLiDxKUxfktESEYHd+94y+nia
         LSbjvnjUH+FCfOQ16fuubCPMUm2EzIzwdcDtCoZ9dhMH1UDZ7wh+Q2CgzyD26UbVi2Eg
         Nzxw==
X-Gm-Message-State: AOAM532hjJaYyUozibjoiUmTOzcJHOuncmYZy5UG1GNx/CkWd/5F+oht
        2xJBOLwuvFhG39pc9dl7+7fibd4ZF0TqxLhvGqk=
X-Google-Smtp-Source: ABdhPJyZ11FjQVbO8yuH7NZDCm0O4aX40diBY4KJiBSEC2ZlV/UhSlNjI03TY9W42r4dQE6y8dFTRFb3y0R42Q+tJuM=
X-Received: by 2002:a17:906:5ac2:: with SMTP id x2mr19485321ejs.486.1614668241339;
 Mon, 01 Mar 2021 22:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20210302062214.29627-1-jslaby@suse.cz> <20210302062214.29627-34-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-34-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 1 Mar 2021 22:57:10 -0800
Message-ID: <CAMo8BfKCY2TP43y=EM5CHxoGwRLykUVELvLyCos94PRj6t5RMg@mail.gmail.com>
Subject: Re: [PATCH 34/44] tty: do not check tty_unregister_driver's return value
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 1, 2021 at 10:22 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> These drivers check tty_unregister_driver return value. But they don't
> handle a failure correctly (they free the driver in any case). So stop
> checking tty_unregister_driver return value and remove also the prints.
>
> In the next patch, tty_unregister_driver's return type will be switched
> to void.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> ---
>  arch/xtensa/platforms/iss/console.c | 6 +-----
>  drivers/tty/amiserial.c             | 8 ++------
>  drivers/tty/ipwireless/tty.c        | 7 +------
>  drivers/tty/moxa.c                  | 4 +---
>  drivers/tty/serial/kgdb_nmi.c       | 4 +---
>  drivers/tty/synclink_gt.c           | 5 +----
>  6 files changed, 7 insertions(+), 27 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
