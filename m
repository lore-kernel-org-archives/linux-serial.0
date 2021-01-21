Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5534C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 17:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AE6207C5
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 17:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbhAURsg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 12:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389138AbhAURr6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 12:47:58 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF0C06174A
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 09:47:17 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id j3so3470169ljb.9
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kykA4foeTxbLS8CWzJvsbjzmd7nBL3addKFMK7SYEtY=;
        b=iMK3aw8mffMX36Y2EfAfZFJwILSWj2+hpckNL/ptc1M+mDKqVH7G2Xfr1xPz5MKBWT
         LzzZ0TZfDZ1vdcpvPg1LakBoHzZQR/oPP/dJSYoEjHwrolgId+nUmqluTElLkH2f+t9Y
         1pxoCYScqNMWRHqBZ2Opt52NmMZq6sI0K+NSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kykA4foeTxbLS8CWzJvsbjzmd7nBL3addKFMK7SYEtY=;
        b=ZhW9Sf3ci9b4mFuyVceMjRrYkkK/tvNRrrIdkJUp3NWmms8ja+eXkwtKu+zo6qEfhK
         PtwhcCfu6RvF07RsrItzRN4s9Gifeiu73jNK8B3/AlXupTWOyvksZOlJbrDBIe6BfbLr
         F4DGw69xvy0r1QskzJ8oV1+8Zcng2qMyeEAQOISsZDSAFI4QzPv/pITWuya0lz5T3YaK
         hgbizMC/FCPhRwKfB/fqw73d9aNQsMVe9BScgdG/lbYDg93Ued6zoevwHxBZMXTXwKiV
         1l5RTQoqHjiLPk0DfNrz7KGUq3sfbFcQUJH+1f6Q9MpY1bXn2j/4hze6rGdxb6jzQBL0
         q8MA==
X-Gm-Message-State: AOAM531++AYKc/BAJ3YE9kqKRtiwdTh8gW60pZSH33ER+ND9nK+bobKg
        Q5sbmdlbCWne+mIqRSVNTaotw2tjba6eZQ==
X-Google-Smtp-Source: ABdhPJxlSEObzno/sFduEOzn/T990082FhE6tlEMmJR7bxzv9mr4eREj2PVVtMzs1YVONlymD2TJgg==
X-Received: by 2002:a2e:9153:: with SMTP id q19mr217407ljg.173.1611251236054;
        Thu, 21 Jan 2021 09:47:16 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v63sm591554lfa.89.2021.01.21.09.47.15
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:47:15 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id j3so3470064ljb.9
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 09:47:15 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr214331lji.251.1611251234794;
 Thu, 21 Jan 2021 09:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <20210121090020.3147058-2-gregkh@linuxfoundation.org> <ff6709dc-bb42-1e52-b348-c52036960bdd@kernel.org>
In-Reply-To: <ff6709dc-bb42-1e52-b348-c52036960bdd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 09:46:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whMm=NM4=ch++YqFn3W=ceNDOhLTFqdP47nxayzVt41Qw@mail.gmail.com>
Message-ID: <CAHk-=whMm=NM4=ch++YqFn3W=ceNDOhLTFqdP47nxayzVt41Qw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tty: convert tty_ldisc_ops 'read()' function to take
 a kernel pointer
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 21, 2021 at 3:02 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> n_hdlc_tty_read will return EOVERFLOW when size is 0, so this EFAULT is
> never propagated, if I am looking correctly? n_tty seems to be fine
> (returns zero for zeroed size).

I'll fix that up too.

Greg - same question - do you want an incremental patch, or just a new series?

              Linus
