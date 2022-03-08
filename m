Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3316C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  8 Mar 2022 16:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245571AbiCHQFj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbiCHQFh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Mar 2022 11:05:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C60473BF
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 08:04:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g20so25137082edw.6
        for <linux-serial@vger.kernel.org>; Tue, 08 Mar 2022 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPdkQphM15Eo5SdM94J/CTEkuLTXrgrE/iujWZfOFDM=;
        b=aEkBiyYVtzRXNJrAwcqq5Cwk5JilhiTWgJi0SCpBkYO4Fiat+SModSUH3HKB3MwIVt
         M4do+kkcYvc+Hi/On7MZ173vl9tapETKN5+r8i8Q1TTXLM8AxNSBVbDLs1z4eeGhOmfB
         wWL4ES7pxhENQhDd4uNDCD8b/YcftTftn6DYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPdkQphM15Eo5SdM94J/CTEkuLTXrgrE/iujWZfOFDM=;
        b=AP4rsrRIry2te12XW2Zvvb4b7LOUsw4VYQ8K+YLibiAx6fgV77lo+28BYBZDdhVhRq
         xfSwQFeceK8E+L4CDM36tSWwzDUFrYbhtxd0cvgJHtAf7akmBfy/6bWsQwfxeaK8kBFc
         XpDLZjfDMsNWlthZ3YpFtVi/ENLkg8Yw+NYm7wivK0aaKejTlGWrUhyf100pPSsg1wr9
         SX6Q7+vGfpCsPVLWDv1nIc5sHqv3/7ul37QI/tOGOcCAgFRI0KYtdK87UsDfkvww/929
         f/9Sb4+DitDeMbTD9jlYtLoupZqwbh19Mz4wIA00D5JE1aGW7fhph0MJmZks2i+Mo9r0
         oESQ==
X-Gm-Message-State: AOAM532NLUReALpkMEdNJqGnV1V62WREBA2HC6feqtYo2ifBvMki2NNl
        fkbGeq1MnJJjU1J/vbomstNrUktSr1abx3bk
X-Google-Smtp-Source: ABdhPJyXyn3L09W60lh/IJIWydxpgiCT38PTj6RUhGFzRFiZW+l2sQ9ZNSKlPAJaQUDD1l9f3wfntA==
X-Received: by 2002:a50:fd8e:0:b0:415:fe34:f03 with SMTP id o14-20020a50fd8e000000b00415fe340f03mr16775935edt.310.1646755478219;
        Tue, 08 Mar 2022 08:04:38 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090608c700b006cef23cf158sm6047747eje.175.2022.03.08.08.04.36
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:04:36 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id k24so19841572wrd.7
        for <linux-serial@vger.kernel.org>; Tue, 08 Mar 2022 08:04:36 -0800 (PST)
X-Received: by 2002:a5d:490f:0:b0:1f0:6791:a215 with SMTP id
 x15-20020a5d490f000000b001f06791a215mr13078257wrq.422.1646755475774; Tue, 08
 Mar 2022 08:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20220308033241.22099-1-rdunlap@infradead.org>
In-Reply-To: <20220308033241.22099-1-rdunlap@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Mar 2022 08:04:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
Message-ID: <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Laura Abbott <labbott@redhat.com>,
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

On Mon, Mar 7, 2022 at 7:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> __setup() handlers should return 1 to indicate that the boot option
> has been handled. A return of 0 causes the boot option/value to be
> listed as an Unknown kernel parameter and added to init's (limited)
> environment strings. So return 1 from kgdboc_option_setup().

This took me about 20 minutes to trace through the code to confirm,
but it appears you're correct. It's pretty twisted that early_param()
and __setup(), both of which add things to the same list, work exactly
opposite here. :( Any chance I could convince you to:

1. Add a comment before the definition of __setup_param() explaining
that 0 means error and 1 means no error. There's a comment next to
early_param() that _implies_ that setup is the opposite(), but it'd be
nice to see documentation of __setup(). I know __setup() is supposed
to be "only for core code", but still seems like we could document it.

2. Add something to your commit message helping someone find the place
where the return value is checked. Basically just mention
obsolete_checksetup() to give people a hint.


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
> Fixes: 1cd25cbb2fed ("kgdboc: Fix warning with module build")

Are you certain about this "Fixes" line? That commit was just code
motion to move the code inside the #ifdef. It sure looks like it was
broken even before this.


> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/kgdboc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- lnx-517-rc7.orig/drivers/tty/serial/kgdboc.c
> +++ lnx-517-rc7/drivers/tty/serial/kgdboc.c
> @@ -403,16 +403,16 @@ static int kgdboc_option_setup(char *opt
>  {
>         if (!opt) {
>                 pr_err("config string not provided\n");
> -               return -EINVAL;
> +               return 1;

Shouldn't it return 0 in the error cases? If __setup() functions are
supposed to return "1" no matter what then what was the purpose of
having a return value in the first place?
