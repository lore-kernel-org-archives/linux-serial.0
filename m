Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13187C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E571B61396
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhGNJS6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbhGNJS5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:18:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389CC06175F;
        Wed, 14 Jul 2021 02:16:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n11so1198241plc.2;
        Wed, 14 Jul 2021 02:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqq4wN8QDeSEWFTLSBBUZmKIr6mpKClIb1WpfjF4Q+k=;
        b=aey7v3ZOh0MMLYdfNMzqu7PRcBUY9yKTzJJH31SWAuZLDkQl/tQTyn7PoOHZVjJ5PT
         56hwXO5GPv9kJuZkX2xWwjwGaM3jeA3GQn2Ed5C2UJxeM7nCaZlcVh6QR888IrImrOFu
         M5Sahu2IcIgTqekEjquz6uU5wHjreJ3nmy4dzRTAV7/Zn1lihSeHoCtNn6jAfgpgIedG
         /af5TCZMjs6MYEO9A9HpgiqSDnfjqIv/jJDF3tNBuHTy+Rt0VaE0sINEGg7kVEXsRv/S
         2gzH4x1XgP4j9FcIIyG4WcSMbsx3s1rks0u8P7gncYakhENIOjeav4ymEv8BOJtqVh6j
         Gp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqq4wN8QDeSEWFTLSBBUZmKIr6mpKClIb1WpfjF4Q+k=;
        b=bb1xp969snCG98C52dWCSCsRDVCgJL+lPSGwD08om0bgUGsKWXoSZigWpnxUwYCTDu
         KtfepZ6fFG7kx9UGvtoV9BjizWOSzYjKNuckFPwop/I2gqiptMw7/0KZcUL7FpFrpRwN
         BfiaKA1F+zKqT8PviQS7aHnc1L2N8rdYGELnBqPRv0w7KL+6/J0ixMC9xoCptggiD+aN
         C8WBje1njnxj/DQu5Hk+DNZB4jCPA6ru+JzZ2Spq89nftyXBFC7WZcNvkhtJW7eG6xp6
         DWcAcbYCMG7TWUpqxj6TG9ZomR8cECNvwGhztQY25K6EA3jDouJZH5stpqgGsUOhKTPE
         P/8A==
X-Gm-Message-State: AOAM5320LL1ZXZAjCXXbsj2l8ejqJbpVeyq+mAU0t6ymVJkxOFIUnzp0
        OA96euqRXYdIJkWtdrHAN2vfozc2I1MB9WhJzlU=
X-Google-Smtp-Source: ABdhPJxbhqa9FnlKYPe9ads46cXv/QtRH6yzLeD7LfqpLoOmX6VGy8Q0SzoujEELuo2onErHXjeYsnDJm4gsnjDTVuk=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr8898309pjb.228.1626254165248;
 Wed, 14 Jul 2021 02:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com> <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
In-Reply-To: <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jul 2021 12:15:25 +0300
Message-ID: <CAHp75VeuG08M9nURpEmW79euKSJkYvLnFiUe+6cGpRHL4zUOfw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
To:     Jiri Slaby <jirislaby@kernel.org>, Randy Wright <rwright@hpe.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 14, 2021 at 9:55 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 13. 07. 21, 12:40, Andy Shevchenko wrote:
> > There is no need to try MSI/MSI-X only on selected devices.
> > If MSI is not supported while neing advertised it means device
>
> being
>
> > is broken and we rather introduce a list of such devices which
> > hopefully will be small or never appear.
>
> Hmm, have you checked the commit which introduced the whitelist?

Nope, my bad.

>      Nevertheless, this needs to handled with care: while many 8250 devices
>      actually claim to support MSI(-X) interrupts it should not be
> enabled be
>      default. I had at least one device in my hands with broken MSI
>      implementation.
>
>      So better introduce a whitelist with devices that are known to support
>      MSI(-X) interrupts. I tested all devices mentioned in the patch.

Thanks, but I still think that blacklisting is better. All drivers I
have split (or participated in splitting) from 8250_pci have enabled
MSI for the entire subset they serve for.

> You should have at least CCed the author for an input.

Thanks. I also added Randy, who extended the list.

...

> > +             pci_set_master(dev);
>
> But bus mastering is not about MSIs.

Strictly speaking it's not, but MSI won't work without DMA.

>  I *think* it's still OK, but you
> need to document that in the commit log too.
>
> Actually, why the commit which added this code turns on bus mastering?

-- 
With Best Regards,
Andy Shevchenko
