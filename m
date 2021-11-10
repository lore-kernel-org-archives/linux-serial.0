Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE59DC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D08861207
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhKJJfx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJJfw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 04:35:52 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4249DC061764;
        Wed, 10 Nov 2021 01:33:05 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso3003401ots.6;
        Wed, 10 Nov 2021 01:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NT36o1TT6gO3eu24HBfCreHbOh0bR7dnTg7ei4RVaEY=;
        b=EIKyjA8D/COvBJOGljKxHWT4Uv/JOojxatmaxY5m6WPDvKOyKdxJ5vwAnuWaAT8u2y
         TrLLw3rIETTAYXQM6+KrEi1QXFyUsW2GGhnDWBqN7R+pZej4vyKuvBnrVf6mQc8Okejb
         eZNiIFLbIADSnoxtMy+8agNF68IayJHngEQ61jyzUkuegLa05KNY0OlahkOye4R5SJ2u
         /pIFFYmabpl/EFQQPG4uuG7M+2vzWARqRlzNYnta4OvegycsUzmrvEIm89tcTQcrh2Pj
         C40LQV97PuDiydmuPWba1vja7BGGgXtf9pPpZe5xJsQV6kt1KhMY7ZfuBaW0TZRVRyjp
         +fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NT36o1TT6gO3eu24HBfCreHbOh0bR7dnTg7ei4RVaEY=;
        b=sdbCJhXD7bffXOhKu4P0eA+8ndGh8OUcFqazf+CY2BtcJIct9c2F4QtnoWF6+kbveK
         XO2JRheDfRTmTBBd0Zjl9vpdfSYO3BfdzIV0TmtlMcyXByeRfCzK305GhsekSJmkYWkI
         /nkuoVqx2LMppC5V1Ll4y51BAEn3Omno4HMyvF00KyxA1Ymftv6FeZ1S4facH+2k2+lB
         0wTk5V4Cf/NKckLDM99307hn/oitpfnRBzf20T/0d0ChoZIfbPE+IJQasGIF2/gVoSiS
         wnXHNExJq182Q7TtpR9yc8edXPi1imzqHmq809lKd8dVcwf78BRxXMj/LsqLKU1o91OJ
         3hfw==
X-Gm-Message-State: AOAM5336D58ZhihULByDeL+1dBXv9ipndZf4cXqbOIlf+Obqb8IYQ+n+
        M1EFs275f2bdaJqKsT+3uZKgFhVueeSqWC6eGzg=
X-Google-Smtp-Source: ABdhPJxp+m4v8Lo033EZ/0qgigH+4zUXLIMUZGt8IiIOaUxrlmQCzZuPnMi4QmFkiul0owRmE/hTg9oVMtiSrUCcXH0=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr11317514otl.351.1636536784623;
 Wed, 10 Nov 2021 01:33:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
 <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com> <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
 <9717b429-597f-7778-c880-94361bcdee7f@gmail.com> <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
 <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com> <08c9e717-4367-5316-87cd-90b5ceb13ed9@kernel.org>
 <1305bb43-b4bf-e129-af6e-957d1f30f269@gmail.com> <CAHP4M8XfCJ8btBCf42GEZGWm_4ywhPKyXtxoBbHR4U190=gg_A@mail.gmail.com>
 <YYuLmMxbKLqHD+ZW@kroah.com>
In-Reply-To: <YYuLmMxbKLqHD+ZW@kroah.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Wed, 10 Nov 2021 15:02:52 +0530
Message-ID: <CAHP4M8VjsZqncVKjaLqE0Hb0b5pia7qo6Vz0hHnBUcbJm1fNeg@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, kernel@esmil.dk,
        David Laight <David.Laight@aculab.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> >
> > That's right Pavel.
> > Every function must work correctly as it "advertises", instead of
> > relying on "chancy correctness" of the calls leading to the method.
>
> That is not how the kernel works, sorry.  Otherwise every function would
> have to always verify all parameters passed to them, causing slow downs
> and redundant checks everywhere.
>

Hmm, agreed. Every cycle saved in the kernel is performance gained.

That's why, the RFC for strlscpy [1] makes all the more sense, as it
would save cpu cycles by removing the requirement to check the
return-value for overflows/underflows (including the "issue" I am
trying to address in this particular thread, and which actually lead
to the RFC for strlscpy].

P.S. :

I am not an egoistic person, who wants to get into unnecessary fights
just to upheld one's ego.
All I am trying is to suggest improvements, that

* make things faster.
* keeps code to as minimum as possible.
* makes developers' lives as comfortable as possible.


[1]
https://lore.kernel.org/linux-hardening/CAHP4M8WnLA0780yN+bpuuCtir+DLJRxe0atAiLbZO0bTGf6J-Q@mail.gmail.com/T/#m4a3f524eefe283a42430905fa4c0dfc2c37b2819


Thanks and Regards,
Ajay
