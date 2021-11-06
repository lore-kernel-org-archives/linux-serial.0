Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3713DC433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1647860F41
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhKFUK0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhKFUK0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 16:10:26 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461CC061746;
        Sat,  6 Nov 2021 13:07:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso447317ooa.6;
        Sat, 06 Nov 2021 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdTYFujjwLADyUlxwHtcQ7DYIHzD91NyqxtAXDYdeaM=;
        b=ZNRKqF3ByES7hiKALKWZC2nQmd+5n7S8pi8ChmgD3YYcPLIuLQ97qG5SQTAuE6yw+Q
         FxuVH8bCpYSO8v1c/3UixuQOwJBOIQKGTiKIbpN6hCTKpKJpbgC513zdKJDLSzTNAYGF
         z/7PkwXBi3vhC2qNNK0CtCLSZ0kfkRiMeLLk/G/r00xUO3FwqXZTLSQpVaLHNFCUG9I0
         234+AfUWTnPeirLgx0wYL8YYMZnVTRj4vl3CkJDok9aXrGTDdN1vX1U3W8h9zB9TbLgx
         6F2uMjrSwdIQEq6Av+vaWudW4VpjF48XVxbvpnRqw2XeQ3OPeoaNnOvJTbg161EiDmrx
         2FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdTYFujjwLADyUlxwHtcQ7DYIHzD91NyqxtAXDYdeaM=;
        b=ndvlPByU3a+7IYJEUIMrMseJnFKeT731o/suH5ELw68zdhqslNE1CGUjUzAVc+n1mI
         ZBHQoZTc/Yg44w1HmHcppvCQ7XOHH/iLtEiRCm1/VtWo+Af7av8o27GfUvHQy3hUqeTQ
         h5j66mMGVIvN9xOACN2NqERbvwta+5kGYt1qgG7miwPXt51CUoaJ5eyB8HSvsDPOyHSx
         HMK8L5MpzrJeVu0kCJdDJ5dcCdAmlMw80iI93xZFwhzgtt/iLfARba2ATnqRFwCQPd98
         D+1vHKtSsFkz7VOGkrXgnceMEa5gc71W+IPJa/0x+zLiEMbHFAJLClQqFxgqjoSYPREo
         n2SQ==
X-Gm-Message-State: AOAM532Xszb/0nhVVrQmfAeKnQgK4EByXgNujo1t3IqJpIDPvbO5LeuD
        5/Rr1Tx1FB9e0x8epbcgah8ldg89LnpuHCgFPvV2ATby
X-Google-Smtp-Source: ABdhPJx8jOuS01rDZt1PIO/f+bUbVylm8LxL1I2j7/AweU1NE/HWsU0OoK4kzQ2absSRU5JnlRv0KFNy7ofQnkc9iWU=
X-Received: by 2002:a4a:c304:: with SMTP id c4mr14435636ooq.34.1636229264046;
 Sat, 06 Nov 2021 13:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com> <58f5cf69-3b3b-62f2-9f73-49c51176a534@gmail.com>
In-Reply-To: <58f5cf69-3b3b-62f2-9f73-49c51176a534@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 01:37:31 +0530
Message-ID: <CAHP4M8VXpGha1gs9GrY5JGFXLOCWHFMS7ZHbeDFQz0DW14TQ7A@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk, David Laight <David.Laight@aculab.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 7, 2021 at 1:26 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 11/6/21 22:20, Ajay Garg wrote:
> > I vote for David's strscpy "fix", as it is simple, and does away with
> > the dependency on the length of "func_table[kb_func]".
> >
>
> strscpy fix sounds reasonable to me. just to be save in future.
>
> There is only one thing I am wondering about: translation table entries
> are set by user using this struct
>
> struct kbsentry {
>         unsigned char kb_func;
>         unsigned char kb_string[512];
> };
>
> it means entries cannot be longer than sizeof(kbsentry::kb_string) - 1
> at all. Do we need extra branching with strscpy() or do we need to do
> anything else here?

Hi Pavel,

Please see my latest comments in the last reply.


>
>
>
> With regards,
> Pavel Skripkin
