Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73327C07E95
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 15:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426DA6128C
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 15:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbhGPPFT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhGPPFT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Jul 2021 11:05:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BFBC06175F;
        Fri, 16 Jul 2021 08:02:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so9020180pju.4;
        Fri, 16 Jul 2021 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTNfCanVuMDv0YAtWhLerL5+C1xCvNyWoo4wS8Mr6Vg=;
        b=pKnKwYi5pbyE2W300C0RlHhuZNTN9q9ktdzWRkJgr6WVu6Lz1+t26bWlJYkGbT6Ch9
         kZyAV/6fZnT7qfrSk2SvB32a1pQoghzWmjzCLoT0bl5EQh6SzDU82JMblpLFrHEGlOOQ
         SfHcErZUZIJUXZX7sMFS/1qV3s76NVuuFPUv5No3/gF3kGXTtzN5j5vB/gUIclZbYvnX
         Cb9JZEJ00UvCjjZtmk2V5drh3eY/yskl5uPsy3s/Kx4dlVOurQg2NObX+KOO8ad4GGzE
         ZsiZ5vcVK06K7vxT6YasC2DiCxpQO0HelnbDmnkmOSMJ1afYT7TOmstiFAdKn2MsYHtU
         cteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTNfCanVuMDv0YAtWhLerL5+C1xCvNyWoo4wS8Mr6Vg=;
        b=Jw6Z0hpHu+Ef/0eX6H739lWf/LjF0Wy6iaXffwVFolqmYCpAwT0dPIAUdqPMTQmOw2
         lAjOUYH7+RmYaaG4YkC7+CrCyLxFYrA/qUc2wOJOxWeonXGO6AmXQvtTVnG45M2Wfqig
         8nCY6TiPo43SqqYDTg8LH9rtC7ekX/kQ6YQ7k3ZPRVWiUxF29lSAzxvV/ZcDVg/gGgL9
         haysEzB2rBx9W9g3q3ie1B4L4jbl41Hr5JhTsM25Oh4ku3r92GMkitPQ7mZYhtIZlrWb
         OAkGpF+5GtPXmVQSpw59aL8jz/6OWD8GXvGA3WYOhVsJdwvSxs39oN59zWjmPqVRcbyP
         fMCQ==
X-Gm-Message-State: AOAM531XlJrYgsOelyEluEKMn0B3iKqVCawDECXOzZMzdlxqfKLypSnD
        91I27JaeDzjaQ9f3Zf0MyWXpfYjx7lw8ziJ/nBg=
X-Google-Smtp-Source: ABdhPJygsInJnjOo8WP0Unvb4e9uyiKrSXrWbxdoqKurRtdOovAcviK9LB48+kktk/kAC/p4kP0j4ZSldVjPeud+qGI=
X-Received: by 2002:a17:902:b198:b029:11b:2246:e374 with SMTP id
 s24-20020a170902b198b029011b2246e374mr8161599plr.17.1626447742450; Fri, 16
 Jul 2021 08:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org> <784629f9-677e-ee53-aceb-89397ce0951a@oth-regensburg.de>
 <CAHp75VdoaE7hCOzsRvuf=7A4mmv0NWBmwqK_mM8vO-K3YZKTUQ@mail.gmail.com> <ac8ac10e-aa43-93a1-d36e-6304643375ae@oth-regensburg.de>
In-Reply-To: <ac8ac10e-aa43-93a1-d36e-6304643375ae@oth-regensburg.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Jul 2021 18:01:42 +0300
Message-ID: <CAHp75VcLicxAz5BjP+Lp2yHxEGiKcT9OUZbPeRUgZVcYLdY0FA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 16, 2021 at 4:07 PM Ralf Ramsauer
<ralf.ramsauer@oth-regensburg.de> wrote:
> On 14/07/2021 15:35, Andy Shevchenko wrote:
> > On Wed, Jul 14, 2021 at 3:56 PM Ralf Ramsauer
> > <ralf.ramsauer@oth-regensburg.de> wrote:
> >> On 14/07/2021 08:54, Jiri Slaby wrote:
> >>> On 13. 07. 21, 12:40, Andy Shevchenko wrote:
> >
> >>> Hmm, have you checked the commit which introduced the whitelist?
> >>>
> >>>     Nevertheless, this needs to handled with care: while many 8250 de=
vices
> >>>     actually claim to support MSI(-X) interrupts it should not be
> >>> enabled be
> >>>     default. I had at least one device in my hands with broken MSI
> >>>     implementation.
> >>>
> >>>     So better introduce a whitelist with devices that are known to su=
pport
> >>>     MSI(-X) interrupts. I tested all devices mentioned in the patch.
> >>>
> >>>
> >>> You should have at least CCed the author for an input.
> >>
> >> Yep, back then I was testing three different 8250 pci cards. All of th=
em
> >> claimed to support MSI, while one really worked with MSI, the one that=
 I
> >> whitelisted. So I thought it would be better to use legacy IRQs as lon=
g
> >> as no one tested a specific card to work with MSI.
> >
> > Can you shed a light eventually what those cards are?

> So I found a no-name el-cheapo card that has some issues with MSI:

Win Chip Head (WCH)

> 18:00.0 Serial controller: Device 1c00:3253 (rev 10) (prog-if 05 [16850])
>
> The card comes with two serial lines. It comes perfectly up, if I enable
> it to use MSI in the whitelist:
>
> serial 0000:18:00.0: Using MSI(-X) interrupts
> serial 0000:18:00.0: Setup PCI port: port 40c0, irq 104, type 0
> 0000:18:00.0: ttyS6 at I/O 0x40c0 (irq =3D 104, base_baud =3D 115200) is =
a
> XR16850
> serial 0000:18:00.0: Setup PCI port: port 40c8, irq 104, type 0
> 0000:18:00.0: ttyS7 at I/O 0x40c8 (irq =3D 104, base_baud =3D 115200) is =
a
> XR16850
>
> After loading 8250_pci, lspci -vvs 18:0.0 tells:
>
>         Capabilities: [68] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
>                 Address: 00000000fee000b8  Data: 0000
>                 Masking: ffffffff  Pending: 00000000
>
> Looks good so far. Now let's echo to the device.
>
> $ echo asdf > /dev/ttyS6
>
> -- stuck. The echoing process stucks at close():
>
> write(1, "asdf\n", 5)                   =3D 5
> close(1
>
> Stuck in the sense of: the echo is still killable, no crashes. The same
> happens if I try to access the device with stty. So something is odd
> here. However, the Netmos cards that I whitelisted do a great job.

Can you share somehow the `lspci -vvv -xx -nk; lspci -t` with and
without MSI enabled? (I want to understand what is going on with it)

> So I can't tell if I was just unlucky to grab a card that has issues
> with MSI, and this is an exception rather than the rule=E2=80=A6

--=20
With Best Regards,
Andy Shevchenko
