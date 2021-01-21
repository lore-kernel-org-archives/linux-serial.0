Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00D3C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E4121973
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbhAURp3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 12:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388889AbhAURpS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 12:45:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7090C061756
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 09:44:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so3717263lfg.4
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 09:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U81V49ur3dHeNfR2mGmxG8g2lxIGYuZqdyDFav7Wwus=;
        b=acVqVBvFfDkHfeYSjKNJ6xB8y93f3kYfkMTXljxH7MyxPeRHY0TsRnB7hCRJfyB1/q
         ODqjEM7rcckOjtzdAhrWVHfMEqBPH3j+jZUgBGmPd381zNTat4Xucm95Y7pQ55wC/mlb
         xyRRvPQ+uPWM07UC+J/SoxVCBsDpkTC+4Ynbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U81V49ur3dHeNfR2mGmxG8g2lxIGYuZqdyDFav7Wwus=;
        b=kWOQFgEv3z6ESZZ0hgLn6UqaXK01iIA5UBxGLld5EIEcuOykO1BYCacBEkqWy/C2nD
         GR52HqULjfNcDJKZRCKdaBoXudZaxOBYDToRuoqt32igxaprOemx0mZyGPNMKCOGwdO5
         Hi2U8jfk9VvHCczj3TGVT4oY+ajeTCyINvruWDH5J4N8y+3eCofdTzIXszMsEfvMGPxa
         YVmPJcJkc14z0j7vtmk15O05hdgHW+glpp+YgLzGhDZw+iIadJQrS7r9NAoghUyjWSfz
         mM275yUPWiJabKlgKVOwy8/aKnmrkthxy3OPue5UDboy31i4d4/jbcWJWJN1V25qD+t8
         Pa0A==
X-Gm-Message-State: AOAM531m8Zfz4ywyxLfKwPbPH1Jgyfdh7eEgWXSGkcCUlyLg3BeESZ3s
        ZBNvQa5+ufDU5YSuy7MVJM2/voxPZc8weQ==
X-Google-Smtp-Source: ABdhPJyelr8THLoEjOztDB6j/LTITAl9fL3Y8OS6aC3yS0jyw0N3IE8ff3XcuKhjVduynUWoTdpmmw==
X-Received: by 2002:a05:6512:2145:: with SMTP id s5mr171986lfr.98.1611251076068;
        Thu, 21 Jan 2021 09:44:36 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d11sm590955lfe.115.2021.01.21.09.44.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:44:34 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id o13so3721098lfr.3
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 09:44:34 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr163317lfu.40.1611251074190;
 Thu, 21 Jan 2021 09:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org> <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
In-Reply-To: <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 09:44:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
Message-ID: <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: implement write_iter
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

On Thu, Jan 21, 2021 at 1:40 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Ok, here belongs my earlier note: "if ld == NULL => crash here." That is
> if hangup happens during the ldisc wait, the kernel will crash in
> tty_ldisc_deref.

Right you are, good catch.

> Is there a reason not to convert hung_up_tty_fops too and leave the
> return hung_up_tty_write here intact? This would also solve the comments
> above.

No, no reason. I started out just changing that one tty_write, then
noticed that I had to change the redirect case too, but never then got
to "yeah, I should have changed the hup case as well".

Greg, do you prefer a new series, or incremental patches?

               Linus
