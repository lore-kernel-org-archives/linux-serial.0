Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD2C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08FF6112D
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 20:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhKFUdL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhKFUdK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 16:33:10 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37331C061570;
        Sat,  6 Nov 2021 13:30:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso18676715otv.3;
        Sat, 06 Nov 2021 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kk4+sY4PyOZ0E6z5TupIgLPxMwCgecCXulMckUme6/4=;
        b=QkmcBXdhcIDF8s5zpPDLFoZysnj7hb3iajTaIKuy+uDRFsqYmWogcqnCHWxSQsqaan
         OIXnCJdMjgXBmRAj4kfB762rUmCn/FEVXYAmdN6d9ma+Kjt8b1KLhVLiG7uKuLylibG5
         4ZoL4VQWOQAaqTom+bSCgVSy7+u6peKcGvLbFKiQV+SHy7lg0wfSOe9B8VytwzuzhsQh
         IT+qN2MW/hNJB+GM5flZf7aAI7ndgGeMuSXx+7EUM9pMx+/my8yaDDFEp6AkabzXrttK
         mwskVc/y7ue//Uqqnd/tieTFnZVCWFg2y9y+D4GNA18WzTP094/UDKqVDOf5fiXA8ark
         eoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kk4+sY4PyOZ0E6z5TupIgLPxMwCgecCXulMckUme6/4=;
        b=4W86NW1HsQhQu5clHPw9MJ/cm0hP7FHm+Bw952fqQRIVflyIQokwuWa5bZNY84Mrrw
         AseAoDaYkaNhYVh29lyHQtEn9n579oHsxayHAXsOkpQ2rv7lr33i8/GQPDnHpwipzDPk
         8YaygXCu5Zy+1QAxBn1i4lGLt72aY1kHJPyegxjwkKkE0oqGYy5+855F0DDf+BRmcTCT
         2QoSoVIG2YOD8qZk9GUhfDinqBxWk2HbOqoINOEY+LCSHnSER/bh+o7mKmqEMPzbpR+O
         2nBByM8UJSiG71KbGFyaRBOFp5HtHctQ7uqCEipoUeY/6GhN8WkE07zY/R/SQkryIkAc
         lHow==
X-Gm-Message-State: AOAM5336fCDN7XEfgwJGKjRwd9WaZcPeIx5AoyOHNlWMMBMEiTvoEw+9
        tyrH2wpQ7vPjqMGw0HOIzKONXScu4PQPS6xxL2pWtShK7vk=
X-Google-Smtp-Source: ABdhPJzp5CghRBI9cDFyyLn8eOpaZd6BpdWsiDtOjjfMHdYd989clkEMK1dbVvav7czOWVOK90CpY9CEf0OdAQx6v/M=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr1749399otq.173.1636230628533;
 Sat, 06 Nov 2021 13:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com> <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com>
In-Reply-To: <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 02:00:16 +0530
Message-ID: <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
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

> > 2.
> > == Calculate the actual length of kbs, add 1, and then copy those many
> > bytes to user-buffer ==
> >
> > ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
> >                          -EFAULT : 0;
> > =>
> > ret = copy_to_user(user_kdgkb->kb_string, kbs, strlen(kbs) + 1) ?
> >                          -EFAULT : 0;
> >
>
> But isn't strlen(kbs) is guaranteed to be equal to strlcpy() return
> value in this case? As I said in previous emails,
> strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string) by design of
> this function.

That's the whole point of the discussion :)

The method "vt_do_kdgkb_ioctl" does not manage "func_table[kb_func]".
Thus, the method does not know whether or not
strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string).

The intention is to make the method itself robust, without relying on
any external "chances" :)

>
> Do we need extra strlen() call here? Let's see what more experienced
> people think about it :)

Yep, let's wait for more feedback ..
