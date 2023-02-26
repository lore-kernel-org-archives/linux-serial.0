Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A051C64EC7
	for <linux-serial@archiver.kernel.org>; Sun, 26 Feb 2023 02:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBZCOd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Feb 2023 21:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBZCOc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Feb 2023 21:14:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33196113FB
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 18:14:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h16so12294081edz.10
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 18:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrheFcgQEPwZjvgo8TDr9t7WDxew84jDqDyy77Jx6U4=;
        b=LMXAOqzcMAN8M0lUbRtgYnlyXLIjveY033hYrk0yuyDTD16izAhROYfs6Dd2+iGxUl
         ri8t0ubJGiCGQKZMyPWaunCEEmpXQIGOTdBHG27Y5AbKBnuts8q1DedSkg5+wLf53rIB
         Ix7vxtPJdyIduJc/OL4K54Yie45HlYpHQ0HrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrheFcgQEPwZjvgo8TDr9t7WDxew84jDqDyy77Jx6U4=;
        b=2JC9uKMehkfri/hcPQp8jjLCyCPjs5l1DCYq7Ps5Y/84EWm4UbZWUCJXGJb9E6K/yW
         Xv/pa4uPDA2Z9767c+4OqomxE1HMRsHlMLhI1QfQmBcfJPnEt5CRPnXKJmypC8xjxnCe
         Y+V/U/lpNPPqs04B+sfcw7xUpcZ2AHRMWXn2EKpKCl7yF+undM3sGS/qH1BIw58Gmlb/
         avLzPD2oE8t4EbYQdw7frrMOKAQjyZiVUvvmsnJJZikYVf0+o1WHJjG6lXlRAT8DZSGZ
         V6EzeSITn3JgrTNW3h2bdNVRKPezGGV7ZRgcWZntT/mIkJlWne3qL5ldVHNZ60ah0vYs
         Iv7Q==
X-Gm-Message-State: AO0yUKVHDr1dEh6gZy7AEacAPIDZkAvZxFGtI0fpj903JXcXXSPYAS6D
        scdFaOQIpO8u2fQq9vHsI7HnZY7mQEyBbrADhHWHFQ==
X-Google-Smtp-Source: AK7set9HaLeCEMOYf999O52fE0PahK6MfQ36BbPsUlB7+JZQNRW1ok5G3lWcdNPAmjwt/1oqFWpICg==
X-Received: by 2002:a17:906:71c2:b0:88d:2a41:2a4b with SMTP id i2-20020a17090671c200b0088d2a412a4bmr27613216ejk.60.1677377669597;
        Sat, 25 Feb 2023 18:14:29 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id up22-20020a170907cc9600b008ee84860964sm1438730ejc.35.2023.02.25.18.14.28
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 18:14:28 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id s26so12263618edw.11
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 18:14:28 -0800 (PST)
X-Received: by 2002:a17:906:b55:b0:8f1:4cc5:f14c with SMTP id
 v21-20020a1709060b5500b008f14cc5f14cmr4302368ejg.0.1677377668178; Sat, 25 Feb
 2023 18:14:28 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com> <Y/qcXOxTVHTNDQbY@mit.edu>
In-Reply-To: <Y/qcXOxTVHTNDQbY@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 18:14:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
Message-ID: <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Feb 25, 2023 at 3:40=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> For what it's worth, in the VM world (e.g., qemu, AWS, GCP, Azure,
> Linode, etc.)  serial consoles are quite common way of debugging VM's,
> and as an emergency login path when the networking has been screwed up
> for some reason....

Everybody seems to be missing the point.

We don't make new drivers "default y" (or, in this case, "default SERIAL_82=
50".

It does not matter ONE WHIT if you have a serial device in your
machine. If your old driver was enabled and worked for you and you
used it daily, that is ENTIRELY IMMATERIAL to a new driver, even if
that new driver then happens to use some of the same infrastructure as
the old one did.

             Linus
