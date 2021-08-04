Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDE8C4320A
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EF460200
	for <linux-serial@archiver.kernel.org>; Wed,  4 Aug 2021 08:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhHDInt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhHDIns (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Aug 2021 04:43:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278FC0613D5;
        Wed,  4 Aug 2021 01:43:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a8so1939440pjk.4;
        Wed, 04 Aug 2021 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oW+GDmMj//ijbjsYF0zjYC9Z9Pk4KeNX2PsNcadswrU=;
        b=hL/6xcOiVFf0f4rOLkHXv6Z30M371+aGvdCpMhtuTJRCO/GBW3tQ+eyFbmHYHDw7dQ
         YR8ixV9IrbgVa+VJmoiiD39NRMsl3r6Xb4UJqwFs/pMFBtV/wQKFVuPqI017bpw26KIq
         vERnm6nYVYUCRp7dHGSSFLQDLPDaEzxk9XCmwDoD0hcJSVLN7hw54AgJd5aM2gj8qpyH
         t6V6ks0ENk83f/8JYzeBB630Ym6yIDoagMrViQ/qdsy7eLqmPJGgRl0DHpK+0cNxRzv/
         dL9dLLBT96fdgOgYKX9O7GYHlUhERb/T+8gDzrRHdHO/Q3dMGxId0taVmRmP8ZbiCZBC
         jCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oW+GDmMj//ijbjsYF0zjYC9Z9Pk4KeNX2PsNcadswrU=;
        b=I+i2pjDSfh5yZpZzDc6cpnGEX7tTBZXYZ9p5p5cBIZpqaMetY3mbDaByE/rl4Y13XM
         ie3RsMkQJYe489xwy1aUX1d4sdIlgr+ZTYnVZEaqXnPKQ2CU3RNNVA/KKF5p5cW/ppgW
         8UtXC7zwxESKW93qEAKgFRqJTRplEeANTuUrRg7EvpvDIyj8qR8fLBcXqU2/cZz9lrmB
         JApzQs1BI5tMaMmc+Kpk+aK0y5L83tuPt+HDLoo+M2QupcOqgw6qp0bANOCC6dDpzEYm
         amKkMIhbdyjy0vJE7euZO+K+60LllkBxJl5PZC1MlETsfOFM1mfhmoOxjbjMZNcbuUTP
         a1ww==
X-Gm-Message-State: AOAM532OWNW3RQUJ+Vq2wvedQCZmZbm7TJYmDXrqZRiZ/TRgkVtMbbNM
        w0qS/PT+CYBH7G+JcCtzp7ZSfWTFmtV0/2iQhaA=
X-Google-Smtp-Source: ABdhPJzw+QdIxnDMcvJSaQ25lyChZPzDNhJYsaw4kg7EOXIGKej3ucDqNqjZ2jUa8Uox8Xb1RXCTYqBC0HnSUScC67I=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr8838159pjq.181.1628066615126;
 Wed, 04 Aug 2021 01:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
 <20210803192905.72246-3-andriy.shevchenko@linux.intel.com> <87778067-5b45-8e83-b624-545b39a0e00d@redhat.com>
In-Reply-To: <87778067-5b45-8e83-b624-545b39a0e00d@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Aug 2021 11:42:55 +0300
Message-ID: <CAHp75VfLLpmz1b1suHuzLK-oMz89EN-Kce2nBrLfaC983y8bug@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] Bluetooth: hci_bcm: Use serdev_acpi_get_uart_resource()
 helper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 4, 2021 at 11:13 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 8/3/21 9:29 PM, Andy Shevchenko wrote:
> > serdev provides a generic helper to get UART Serial Bus resources.
> > Use it instead of open coded variant.

...

> > +     if (serdev_acpi_get_uart_resource(ares, &uart)) {
> > +             dev->init_speed = uart->default_baud_rate;
> > +             dev->oper_speed = 4000000;
> > +     }
> > +
>
> You are replacing a nice switch-case which handles all relevant resource
> types with still having a switch-case + a separate if .. else if .. else if ...
> (also taking patch 4/5 into account).
>
> This does not help the readability of this code at all IMHO, so NACK
> from me for this patch as well as for 4/5.

I guess it's a matter of style. The main idea is to try avoiding the
spreading of the customized ACPI resource extraction here and there.
Probably I should have started with cleaning up the EXTENDED_IRQ case,
which seems not needed here in the current form.

-- 
With Best Regards,
Andy Shevchenko
