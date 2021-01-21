Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C357C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 21:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DB922BEF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 21:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbhAUVMG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbhAUVK7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 16:10:59 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B90C06174A
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 13:10:11 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e7so4111104ljg.10
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNDrIesQBMT+L7yI5WzMZVksP2sWpDQawNGFxdnXsVc=;
        b=YH89x/0HgEErWXoTAUXprkP3EHdeEN46kljJDNBHcff7MrXy7u4CRasLq//STK5KYg
         NiErWYVfHmqNO+Ee5yf7schI12GFshlJ1YfEvUy5R4K9gVQJxXQaiMsviiyQQd2RgENj
         orniTEbi/3tc2vtYG8Va0woM+RDTwwca2RihY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNDrIesQBMT+L7yI5WzMZVksP2sWpDQawNGFxdnXsVc=;
        b=eMLDDie++Ybo2UZ9qyymzpG5TPGaapY5wUyh1WvK+A8ggmR9/l1Z9aGEpXiEdQfQJg
         EKBvBNKtkTru8iFybdASiKiJ5Y7kPje5nFm0IvkqgJ3skAYf/LR6kiAiOeNXfzSeh93P
         JfQqGa97XItniVi7Y8smVgcrLRnM0xJ1svAmRClbqcfvu2K7HYPFR+lomLv65piTQYrH
         zcoQVGOAcRE0O7XB3I5APY3yLV9YglJKHpFIVDwd36q2XkJgG8NRmxsPNHU+CG6+bKMF
         SNw/rjy+gb7zVfK/lBVHKlJIx6IXWGGvlUPhKn52oFG1LmLXielnDUtvj7IUJc9da9LW
         i4Bg==
X-Gm-Message-State: AOAM531L5IA2LfagiJ3UKe/WV8zod1iOzkkJy/DZHjAYBhCNaKQDFVDO
        6No4NMhZtWgON6zPO+deuhd9XQRQNsbWCA==
X-Google-Smtp-Source: ABdhPJxoIdQuJjIcXF64fpv89Ug/qdIeMEszPsFQvqKBWjnWoPyutuBN6umG7LcGsx8znGhrQ8rWjA==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr620639lji.126.1611263409789;
        Thu, 21 Jan 2021 13:10:09 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y23sm10857lfe.179.2021.01.21.13.10.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 13:10:08 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id u25so4583340lfc.2
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 13:10:08 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr124334lff.201.1611263407882;
 Thu, 21 Jan 2021 13:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org> <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
 <YAnAfNcE8Bw95+SV@kroah.com> <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
 <YAnZaYj1ohUNinaf@kroah.com>
In-Reply-To: <YAnZaYj1ohUNinaf@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 13:09:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfEiuxr6QbVXV3PXCBq35V_xVt8xMMBV3kTR4SarToSg@mail.gmail.com>
Message-ID: <CAHk-=wgfEiuxr6QbVXV3PXCBq35V_xVt8xMMBV3kTR4SarToSg@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: implement write_iter
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 21, 2021 at 11:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This works, thanks for these.  I'll wait for Jiri to review them before
> applying them to my branches...

Let's hope Jiri sees them, since he had some email issue earlier..

I'll add his suse address here too.

           Linus
