Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3B2C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 05:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BAAC6135C
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 05:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhEUFLa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 01:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbhEUFLa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 01:11:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4BC061574;
        Thu, 20 May 2021 22:10:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t24so3099942oiw.3;
        Thu, 20 May 2021 22:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6OeTIPD5d8+6QhQeDTSSu4pXpzUgcgHUDk9Koberlc=;
        b=TQedDVNsFVntkEo6UHAGyWqOMGsGp+bIEzoxmBF33H6amp9RmsLn7EedixL/lv7RuL
         Pmb1N2OfeeM1ExO/Hh+Bi7U1F1nZiSJFg0GWhKBDd2r2cW6jLPObtYKw3X5QMMmAgfyP
         kldSf9aXASXFjsVglb9VNFhCyxG7nka6Hivuv5y063lDGgeTowkomoeXktlaa0/e6R2v
         i4LG8u8vJFHUWPf0Y+jKVyOkKXRPDN3G2t3OArGIJRUJr6vkhpLs7q4/4BifiCjE7x5f
         NcYNtYrqTGUc17lCVGKYaUcBRx9WT+DMLPEmlMLDYC4at0IH74QFO68N+rNHLS1MRF6p
         VU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6OeTIPD5d8+6QhQeDTSSu4pXpzUgcgHUDk9Koberlc=;
        b=Om8wAaqfdiyL2dNnwxxstflhyrtAG0fyJ06fjIiCt3u+FEt0N9WSE+mrQVq10LHWzH
         AiAyl+I8H4Qs07ODdWiG4WbnfcFNsNQEocmXmkpPH/IczxGcRj51u8NbvJfo7XhaCMNb
         0dyhsDz42v8xq75JMu26pbmXQqsEJq3cA0UoQo7rSSSSGK3BqA4WQuE2lpzVbnKxSUCC
         no7+eMB8da4HqlEazNlLcCQ+WAgvCee/hYyP+xiq02whGjZSmIRQhZ9MBKsPnBod69iM
         XSAk56ArdU2iAjjptrGtwK/J6fkjI3ZbmqZ757Dd2oij6ajWt5izIqMgwYSKfMBF/Ivq
         k2OQ==
X-Gm-Message-State: AOAM531PcgcbMeRm0WGNzMbq/8132oaeDKWetjdJ8ouLAiMqoMf8Axea
        i6RjgcJwXs+yv8x6T8Fz7h7jS4Ln5a+rxx8EXw==
X-Google-Smtp-Source: ABdhPJzGNHgvjfx2/SJv1V29F1ki+uaDoYT0B4fiVVGLTAEu7ihjU5PkR+9TGYgsragEQR6DWK/GUn6ijoE2nM07Rxg=
X-Received: by 2002:a54:4690:: with SMTP id k16mr790538oic.57.1621573807131;
 Thu, 20 May 2021 22:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <1620991027-25856-1-git-send-email-zheyuma97@gmail.com> <YKZybdcwoI1eMbzj@kroah.com>
In-Reply-To: <YKZybdcwoI1eMbzj@kroah.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 21 May 2021 13:09:55 +0800
Message-ID: <CAMhUBjmtkDfbgVR9iPuVPC249h1Gx57kzNpo2j=hWkiFj5B9Jg@mail.gmail.com>
Subject: Re: [PATCH] serial: rp2: disable interrupt in rp2_probe():
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cernekee@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 20, 2021 at 10:30 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 14, 2021 at 11:17:07AM +0000, Zheyu Ma wrote:
> > In 'rp2_probe', the driver registers 'rp2_uart_interrupt' then calls
> > 'rp2_fw_cb' through 'request_firmware_nowait'. In 'rp2_fw_cb', if the
> > firmware don't exists, function just return without initializing ports
> > of 'rp2_card'. But now the interrupt handler function has been registered,
> > and when an interrupt comes('rp2' may shares an interrupt line with other
> > devices), 'rp2_uart_interrupt' may access those ports then causing NULL
> > pointer dereference or other bugs.
> >
> > Fix this by disabling interrupt after registering 'rp2_uart_interrupt',
> > and enable it in 'rp2_uart_startup'.
>
> What prevents an interrupt from coming in right after callin
> rp2_uart_interrupt()?  The driver has to be able to handle that.  Why is
> the interrupt being registered before the firmware is loaded?  That
> should be the proper fix as once you register an interrupt, the driver
> HAS to be able to properly handle it.
>
> thanks,
>
> greg k-h

Thanks for your comments, I will reconsider this patch and send the
second version of the patch.

Zheyu Ma
