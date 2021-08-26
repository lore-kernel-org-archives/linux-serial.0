Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B94C432BE
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A24161076
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 14:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhHZOKD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhHZOKC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 10:10:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0AAC061757;
        Thu, 26 Aug 2021 07:09:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x4so3206769pgh.1;
        Thu, 26 Aug 2021 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHu9tR/6Cya7biP79tZOJnTzvsP2TvD1XGVXSlWQptc=;
        b=nOxTMSOthtkjbNfMJmiDbRBqwR99W6NY3um9pitOe/YvF8Pesoqc3KYuvI4jKAq9lW
         Mhc/Danh+eSy4aK6FNWZMrAJ/azsGr8x1yUHM4YB/R0HbBAgD/LmJbyxopQxKsUSp9la
         8HoXUT/gI8ZK3UiSnY4xt47YDXyTiN+Q7xEmgLZXlso26skqrAHmpJBcX7r6Iu4aukXh
         pcVbQ5R1RONsrj3/5VOVsG+FlVEgK532l/tHTgGUuap8A9h7IAWHY+1skfFGILmMFM+a
         4bWN+iJo0wPiZHsrM5IYdlBhF9EJyZFlxfqlEaL4Ofq9Q+chfhWpi4DozZHl/+jJ+/UZ
         IVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHu9tR/6Cya7biP79tZOJnTzvsP2TvD1XGVXSlWQptc=;
        b=CRqY9FGpyuGW0szhxkIWNPS43R1ecfqAT2QVE7V5ztzUdO+dFyt9aPLU1431oGtChe
         7iApdRMweZdSUM0kVpaGY3S8L5EcssgIuhwlVHrBmccJYuXn84EHxU7yALnxdxS+FEv3
         i3LeaouRuOPnGyj5dWF6J1W21HvPEuPDzhudygSt7tBAeYV4mXpDVSINHGJShTLVWIi2
         /u+fJ08LRAk/JcqCLaDTtblDXGnICdy0bdKD+6zjgoyOoLROpxN78a4DgUL+9OfpPhK3
         RCZ/r0xVYsewMxVrAt6C9ZQX889iL+74wmKjPqP4RE2i3DNuPNHq4GlgY2aPIwZJ1TLt
         01YQ==
X-Gm-Message-State: AOAM5323iwAqWRcMFXW35a7kcn7aykae9PTjMhhZiMwy90e5The0fnLY
        r89hl2s0MNt0iL8F+HvZgJJhI/xU1Iuh8J68lMaiHhjm5pd3eg==
X-Google-Smtp-Source: ABdhPJwdW5JDTSv7/6D2pbzvuhN3sHFkC2wCg7ta7mwBvl1yqMkNzMe2+t9z1HROcwNl3zJWpalmuWHvOcP29Ak1JBo=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr3861506pfi.7.1629986955001; Thu, 26 Aug
 2021 07:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081401.3440-1-utkarshverma294@gmail.com> <YRuyoWujcSB6zKl5@kroah.com>
In-Reply-To: <YRuyoWujcSB6zKl5@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Aug 2021 17:08:35 +0300
Message-ID: <CAHp75Vev9=mkNxi__eH3Lj+a9_rNBQ8M90EGgvsjbtQ_OqcOtg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_mid: Use pci_irq_vector() to get IRQ
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 17, 2021 at 3:59 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Aug 17, 2021 at 01:44:01PM +0530, Utkarsh Verma wrote:
> > Instead of a direct assignment, use pci_irq_vector() to get the
> > Linux IRQ number.
>
> Why is this needed?

It's not.

> > +     uart.port.irq = pci_irq_vector(pdev, 0);
>
> What problem does this solve?
>
> Do not describe what you are doing, but rather, _why_ you are doing it.

I think I know what was the motivation here, but actually there is no
problem with current code. Indeed, when we enable MSI we have to
update the vIRQ line, but this is done in the platform related
->setup() callbacks (for example, dnv_setup() does it). So we have two
scenarios:
 1) there is no MSI enabled and in this case pdev->irq is correct;
 2) we have MSI enabled and we need to update previously saved pdev->irq.

What you, Utkarsh, are doing in the patch has no effect, because at
that point MSI will never be enabled and pci_irq_vector(pdev, 0) will
return the very same value as kept in pdev->irq.

-- 
With Best Regards,
Andy Shevchenko
