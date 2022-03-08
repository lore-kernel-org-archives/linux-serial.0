Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE63BC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  8 Mar 2022 22:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiCHWNt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiCHWNs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Mar 2022 17:13:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD12B241
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 14:12:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x5so501568edd.11
        for <linux-serial@vger.kernel.org>; Tue, 08 Mar 2022 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q667ThhdkxL8AUOuU2qYFbGa17GC7zYlSfkMfKxv3/4=;
        b=NusUdDknL66lGLdEP5FNX3LOWWrWLPuP37qgc1opFNmna8r1+mPTnGkGut+szDcFa/
         g2D3r9SMSZRg66H5SIzcejOYlji2wOURANJzlFKjsk/PS2e7FWmhTkUb8u8CDBkM67p8
         4ySDCD9CGHFSObrQ6khjnN5ALk0dIGbg/2xbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q667ThhdkxL8AUOuU2qYFbGa17GC7zYlSfkMfKxv3/4=;
        b=epQtKy8MbGgbwEpXATpEV0SPGDHAL8q+XQZNX0r9wctpP8paDG1+pV5qvDrOfHwgiV
         402gzCJrb4bZ86ViUVbRMDu23lLO1iMBHoDeC0iU8cmz6/wzUMKyXNC0O5BYm4N7S5fJ
         VLhmZ93L+Z2hpXvxnbTrbbR3aL5VlQ26z789vOih9gLx2UM9bXa2EK7KaPhkvqVcojLe
         0JVve4uCzOzTz3XHL0K5sXlLHglA/XDnZbmg0bCQBlsLhGIRigBz69rkZnlTDW5eNcXf
         5lpctbKISzzNqc6T9PFReWPzm5CXLwuHggxM4oVkyCf2hwEQNJMFm6+ZVW7q9iBVVr9o
         ISxA==
X-Gm-Message-State: AOAM531DLOYNlV6vC1ysPXiDQcIL7Srxxw2kaia/e7ygj9pULmZrF2cT
        gZKDFhHWVFl9njRPHh+jaQ20lIkGoQmtVWu+
X-Google-Smtp-Source: ABdhPJzszK7HXMC0BooOtJD9lfU0K994ZmQnvGa22/k34Is9WlijFjLUC0j0cj0TQJI6iY1hI5tZ3Q==
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id ds1-20020a0564021cc100b004132b12fc49mr18223428edb.118.1646777568400;
        Tue, 08 Mar 2022 14:12:48 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id w10-20020a17090652ca00b006c605703245sm19683ejn.43.2022.03.08.14.12.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 14:12:47 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id q14so257525wrc.4
        for <linux-serial@vger.kernel.org>; Tue, 08 Mar 2022 14:12:47 -0800 (PST)
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id
 u5-20020adfeb45000000b001ef60707641mr14280334wrn.301.1646777567076; Tue, 08
 Mar 2022 14:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20220308033241.22099-1-rdunlap@infradead.org> <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
 <2c693cb8-f4b8-a723-c804-9492d9cc4881@infradead.org>
In-Reply-To: <2c693cb8-f4b8-a723-c804-9492d9cc4881@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Mar 2022 14:12:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X004_55zOovjazkqqZ_EXQ-QCYS1o4VxdCvEjt3+7Tbw@mail.gmail.com>
Message-ID: <CAD=FV=X004_55zOovjazkqqZ_EXQ-QCYS1o4VxdCvEjt3+7Tbw@mail.gmail.com>
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

On Tue, Mar 8, 2022 at 1:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Doug,
>
> >> Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc7
> >>   kgdboc=kbd kgdbts=", will be passed to user space.
> >>
> >>  Run /sbin/init as init process
> >>    with arguments:
> >>      /sbin/init
> >>    with environment:
> >>      HOME=/
> >>      TERM=linux
> >>      BOOT_IMAGE=/boot/bzImage-517rc7
> >>      kgdboc=kbd
> >>      kgdbts=
> >>
> >> Fixes: 1cd25cbb2fed ("kgdboc: Fix warning with module build")
> >
> > Are you certain about this "Fixes" line? That commit was just code
> > motion to move the code inside the #ifdef. It sure looks like it was
> > broken even before this.
> >
>
> Yes, but I am not enough of a git user to be able to backtrack
> to see where this code was added. :(
> (help?)

I always just chain back w/ git blame. In this case:

git blame 1cd25cbb2fed~ -- drivers/tty/serial/kgdboc.c

...then search for __setup there and it finds:

Fixes: f2d937f3bf00 ("consoles: polling support, kgdboc")
