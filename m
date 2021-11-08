Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C1C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C76125F
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 08:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhKHI62 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 03:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhKHI61 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 03:58:27 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C73C061570;
        Mon,  8 Nov 2021 00:55:43 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id o4so26523470oia.10;
        Mon, 08 Nov 2021 00:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SV3uFGpOzk0BYk1mAzH96zrfSdq37VAR6UZ0MqQ4GoU=;
        b=UK1MMZ6z8OPre7kMt+zn9ejRtioNXNZLQFiXiKPh2SEW53hzW1jDK2KWVoJsp6Dsdo
         tph6iYO5pAXMm0b51I0E/9bddNz/udFDP9/vOnT+gc7Hl13bjC4l/lJFEI9A59rntZkn
         t438WnsLH7SlCX50FaA3pRMPcqupSBKrSsAJYPJGrsDWyRBWrGsBu6/jfbI20uPZ/mfR
         /K8X7eNp96PExQANMNjv1Q4pHYypB9T7Y8QBTw8wbzyDpo6kg88+BfS6ITumoB/b68uS
         GwJWQrYrCf2bXCT94YNFWXaWpAgL97BfYIfoceF/wwOyk0IOjcO/G0WuWZB6eiJ2rHeI
         FHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SV3uFGpOzk0BYk1mAzH96zrfSdq37VAR6UZ0MqQ4GoU=;
        b=mU1FXwTLclJekEcda/p2QqhnoEuDI0QFRruH73zMpdZXRm9mZFKllBluFLahPPXOkc
         m1scejp/qR0dsNNRU0XU/oQzC4BD2j2Ag3TgLo9+w08EWGa+4bNF/+EJfUdLpb/ueDy3
         u14aUz7DaaqsdzKAVm+zOtJKJpEZCQ5Qxni/e/WSKov4yzYXjD39c2T0AP7J0lgc7T1x
         eQd+OuQWNMt6XY4alUcg57D+VGVLLlz+6mzoJsyIqavyLd1Q8oW5jLYwzx7GjocyIugw
         l9h5dL6DO/aO2Z3MgaNUIZtcw44bwGqIns7msXCXW0RO49jgDJX28GsQHkFQz0bUmXdG
         RNLg==
X-Gm-Message-State: AOAM530uMKlgAiORKqH4YCUGJ1WmyggR2zVeJY/TAMxmGa4xKLTfgtr7
        X/kesbDq7GIayYIwQtqr9PhMQDdJiPAd3pFkwYU=
X-Google-Smtp-Source: ABdhPJy+bq7yS+jdw18APNSEBFLhed8rpYasNh8x1Yvye6eV1kPPJEJhIV3a3Q6IgZr+9BaWJ6Li73heuS2nmmLm620=
X-Received: by 2002:a54:4499:: with SMTP id v25mr35931259oiv.71.1636361743154;
 Mon, 08 Nov 2021 00:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20211107031721.4734-1-ajaygargnsit@gmail.com> <CAHp75VcacFAvsW6zmHe8fbnetcZq4xY_LZunZjBDG3ZdfS9NRQ@mail.gmail.com>
In-Reply-To: <CAHp75VcacFAvsW6zmHe8fbnetcZq4xY_LZunZjBDG3ZdfS9NRQ@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 14:25:31 +0530
Message-ID: <CAHP4M8XWbxVDAeN=4YGX93gNLDDWE0GS8_sKkNv2p_-yBjjHVg@mail.gmail.com>
Subject: Re: [PATCH v4] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > This usually happens when switch has no default case and static
> > analyzers and even sometimes compilers can=E2=80=99t prove that all pos=
sible
> > values are covered.
> >
> >
>
> One blank line is enough.
>
> > Many thanks to the following for review of previous versions :
> >
> >         * Pavel Skripkin <paskripkin@gmail.com>
> >         * Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> >
>
> Ditto for each such case.

Ok, will take care of this in all my future-patches.


>
> ...
>
> > +       default:
> > +               kbs =3D NULL;
>
> > +               ret =3D -ENOIOCTLCMD;
>
> Why is this? How is it supposed to work?

If there is no match for a cmd, causing the default-case to be hit, we
must return an error ret-code to the client.
The -ENOIOCTLCMD error ret-code has been chosen, on the same lines as
"vt_do_kdskled" method.


Thanks and Regards,
Ajay
