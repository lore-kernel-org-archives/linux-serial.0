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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EBFC433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 11:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5701861157
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 11:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhEELw7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhEELw6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 07:52:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D6C061574;
        Wed,  5 May 2021 04:52:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bf4so1634372edb.11;
        Wed, 05 May 2021 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4SSAwHPBoZlDvDFrCeXzoT6Ev+sJfif2JM2Vh2Peds=;
        b=ibOfNCJmlO9GjP9XA7RyhPnTE3cz/VbO+kZyT8tbzlzuUf9Ama5KXBjtPcaY02ShGn
         p4NaSlb8KiBrF8SEWcE0kcm+Y4Hj6SeR+6dqy5RW4+hL/3dMq0Qo559owdprwX2Tv/VR
         JqqkAVqTBeQMIMIc9pd2zqItdSzfkhviBCUVbgg7e3Lp16t7YbPoH+gDdKeoYAqT9lSC
         Tt2xIHzcobRROmXcFYBihGx23me9ZmXlhlFAQY0OP5QEB4VO19kRV5msqoK9m3J1RHWa
         cNpDIVrmvKVq06HbJXO//lntK/vp88IdP1OP8OYg46Be7hBeaVy8oFwrRLWFcyjtI1aG
         vyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4SSAwHPBoZlDvDFrCeXzoT6Ev+sJfif2JM2Vh2Peds=;
        b=qwSXN7UVoVdc667NRWaFPM1lABZK8wU6Xi35D9lKJrMLTUTUHyhtUq+qUlFgmGyZhk
         9z9+qMkeWcNZZS5QKBUm5Y1gsJjrQWyTD8xUAPgRLHBgGfxpXMl8sri+4FHbdt8PrrKx
         Mhz6vygfLN9IwvKg51fLgcWTl5zikTFBXQr/VRuk9E+gy1Kw83S6X2nXOiL1yxWDT5yM
         /XN8e1Keverl/lCzSY2msSuCx1+kKKvrpAdUjtB80iJQwhdvhSBWyMNitsFuTT5gziB6
         QwsG5WO2PR0m3ctOQR0uL/KUpIu6MdkYdo1aRQ6bI+1une6zA5yPNWWjpbOrKsVMk+jE
         APUw==
X-Gm-Message-State: AOAM530XWDKLgdmE4BhJMkiTU86IOf9RrBeVPYSjQoiINp1PPKn4M2gB
        lhKffVIAcfd+KgYdb8zXETB3tNPh0fxVpf/U+NrAD89JFlE=
X-Google-Smtp-Source: ABdhPJw/3XIaMwJJQ+xVfe/fhKbmLvdMsqVVK383RjxOPa6oLisFthQ9ApMYbaxxyLyWr+2Ciz6vmfK4G9F8EO+T/v4=
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr32329093edu.350.1620215520075;
 Wed, 05 May 2021 04:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210505091928.22010-1-jslaby@suse.cz> <20210505091928.22010-26-jslaby@suse.cz>
In-Reply-To: <20210505091928.22010-26-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 5 May 2021 04:51:48 -0700
Message-ID: <CAMo8Bf+Zz2P6vL=GY4LyAjL2j1V-wOTK4LaCmjnAhtXaZrWkaA@mail.gmail.com>
Subject: Re: [PATCH 25/35] tty: remove tty_operations::chars_in_buffer for non-buffering
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 5, 2021 at 2:19 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> The only user of tty_ops::chars_in_buffer is tty_chars_in_buffer. And it
> considers tty_ops::chars_in_buffer optional. In case it's NULL, zero is
> returned. So remove all those chars_in_buffer from tty_ops which return
> zero. (Zero means such driver doesn't buffer.)
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> c: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/alpha/kernel/srmcons.c         |  7 -------
>  arch/parisc/kernel/pdc_cons.c       |  6 ------
>  arch/xtensa/platforms/iss/console.c |  7 -------
>  drivers/s390/char/tty3270.c         | 12 ------------
>  drivers/tty/pty.c                   | 17 -----------------
>  drivers/tty/vt/vt.c                 |  6 ------
>  6 files changed, 55 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com> # xtensa

-- 
Thanks.
-- Max
