Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96EBC433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25726120A
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhKFWJa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 18:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhKFWJ3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 18:09:29 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC83C061570;
        Sat,  6 Nov 2021 15:06:48 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g25-20020a9d5f99000000b0055af3d227e8so14492371oti.11;
        Sat, 06 Nov 2021 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZgnklXkGuSQOSxi3Q0vVQn+K+Oi7U4D51Q01YW0d9Rc=;
        b=dUeIgp8c1Jt58DEjh4bg07kvJ6RUOaYY5woZse3NTGS/YDJfrxIxK36UTUhJqxFQK9
         MTZbyq+M+ewYfZHYtJErKLABetMzGA09+/5PReAduUuf8eoUdq53mbfujqD8RpuBOF70
         GzjT2eAypjWXC8qa/mD39SOWZe7i4kLYo7P4BjlYP4FirZHsgERD3Oc07XYMIcA+4iXQ
         MU+noSSjrjiesWvJ8ooYJJfG29LzWNeqjQede76JzE4sS4+T+XFguK5spr+LYq29s+UJ
         WRLb4GxPbxZDhHhG+vnjV8n+2I7kfhsKNhSWRuTW2N3vS78NziCxPSg3TCZoBH5IkDcp
         XqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZgnklXkGuSQOSxi3Q0vVQn+K+Oi7U4D51Q01YW0d9Rc=;
        b=ZM/VXAdf2Mr6ZfmVvdY1J/07Zu6C0q4KN5gyYVX25Cym+myxcB0yUBOKnnfItz2tXk
         meLi4Snl2ys9tizi+L/ciBHuY4UMk6fhQa2AfN4qLHLtjRnGTwtad/ZBLFivhsnLc8pp
         gFK+COkSR3Hm0TgmQVuhGiVrAxqVSXwR2yjfxr6TYfQiKe00P35soihTiMoiv4fm4CJT
         BKfXnrdrYg0sXa9EOfN+1EdDcBlhuRVKZw/X0SZ7Ql+/koLQ6HpICzsc5XuttrLBbPas
         mfLTVK49FMizBMmZzKubGEfpN0gYKu58LW1e1F/0/WDsZ/5VLb2m7a8ZJxdMsp6eleRx
         JwrQ==
X-Gm-Message-State: AOAM532RniwYaj2mXuYc7g/8lI1XES0JVm7hJk7rULxYx6MuKtPz7bpU
        rIVAT3QPDuvkkChsvvhU5fx39jUQw2X/TokAkeo=
X-Google-Smtp-Source: ABdhPJz2yKTAUTaAFA1mfOIFa1UyfCFR0PX6wl3o5hhS/gQbFLoxEEUVvcmdP0kXzXvTQs5Hitackz4PfCx5LW7Mpkg=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr37127394otl.351.1636236407692;
 Sat, 06 Nov 2021 15:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211106104053.98761-1-ajaygargnsit@gmail.com>
 <CAHp75VdY8aoF+dCm0j7EA-53BFaWdepvYYv7h5MVz2kVWagOOA@mail.gmail.com>
 <CAHP4M8Vdj4Eb8q773BeHvsW9n6t=3n1WznuXAR4fZCNi1J6rOg@mail.gmail.com> <CAHp75VcZArNXhY2T5RmSmrFrAvd4YGRfpByBb4hYLccNwGDyVA@mail.gmail.com>
In-Reply-To: <CAHp75VcZArNXhY2T5RmSmrFrAvd4YGRfpByBb4hYLccNwGDyVA@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 03:36:35 +0530
Message-ID: <CAHP4M8WYR5QvEoc8PRQ8CYFa0C4hx=_Fy4PTiqmpqFkXc59jXA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: vt: keyboard: initialize "kbs" so that kfree(kbs)
 runs fine even if kbs is not kmalloced.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thanks Andy, v3-patch has been posted at :
https://lore.kernel.org/linux-serial/20211106220315.392842-1-ajaygargnsit@g=
mail.com/T/#u

Many thanks to Pavel and Andy for the review/help throughout.
Let's continue on the v3-patch thread-link.

>
> It=E2=80=99s fine to add default case as I suggested. The problem with yo=
ur contribution is in the commit message. Selling point would be (according=
 to the below) the smatch complain with the idea of having default case  in=
 general.
>
> So something like:
> =3D=3D=3D
> The smatch tool gives a warning on the code in ...
>
> warning: ...
>
> This usually happens when switch has no default case and static analyzers=
 and even sometimes compilers can=E2=80=99t prove that all possible values =
are covered.
>
> ...
>
> =3D=3D=3D
>
