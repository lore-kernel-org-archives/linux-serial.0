Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2ACC432BE
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 08:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B281360EC0
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 08:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhHEIVz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 04:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhHEIVz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 04:21:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CEC061765;
        Thu,  5 Aug 2021 01:21:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so12909196pjb.3;
        Thu, 05 Aug 2021 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KN00QyUePsg/nfcJcgy2UYBcl0jMuOx+ehoRGZbZcX4=;
        b=Zjl8qznF1QgqiUJuycxBpGxXHqxwRQhTCI3RXTSfNUoaXb6q6QBOaQNYzesrJKl20b
         UAqWwZY0fx6/3hG63OJUH+fLSg/onSppLd3kYf7A3zrB5cFWKym37DdIYC+NEHrgk5sx
         fSIjlzcQ9zV7Rar/GhB0X4Lmjlw+pSlSVMVrdfq+K2MCIeF6JjVY7hFCi81M9a8BH263
         Hz8kha5k2kF+WgayGmw3ZjwAPKutYm4H11BG+l2dAgxHaESdGWoLj6Ab0ujXSpvfcMQv
         XPjdKXSnwF4k4UPyDOIAhUVE7j1UpWB0RfWhu4+PUrA7RsHcFCIpNlx4ca5TuI+GIzF4
         X9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KN00QyUePsg/nfcJcgy2UYBcl0jMuOx+ehoRGZbZcX4=;
        b=Je/F5/Z7ly8W9NMv3zEE48Tb1P3C6pwTwBmvtWZNZrGKMgDgN4hyLp4Y670F2aqRzA
         K4RKyUYTsxQnTtsShPoeqXLo7vHPDrxJX0EKTr/kJtvX5VinnTl+lC8AS6NkO1mufoUR
         NBTZ/1iHPI2vUNj5mSeyh1k4lirpiCzI8TrG6FKuh5+GVzCmi1YOYZx1V1dE5MKdPr+H
         BRn0RyX9UapG3EUXHGeBwGmpwagII/T6e1RU3dAkG7Y9oXhhAvql7Ah2cnjvwN6fRDkH
         9T/pxU1HDYocz63NgpDZhAUJRW+5ZxqxstiljbJbakIKyW3rwtJgEaZ5K+GPBlrFA0si
         GK9w==
X-Gm-Message-State: AOAM5319YmHaAXMw04xPtoZj2Tpl0j2InHypP5Bp2f7pMJFizk7ByAoI
        xL57rndS2lTPLkJZCb529t1zWpg2fPWZmvqHKVc=
X-Google-Smtp-Source: ABdhPJztRzTRnYhc1zuSCEMBALMx9NoK8WeoBL24jmVXJI6AnTZaiOOAeBp4l+SSdKjI/j0TRotXmkWbiyz+f6FXF/I=
X-Received: by 2002:a17:90b:912:: with SMTP id bo18mr3531824pjb.228.1628151700671;
 Thu, 05 Aug 2021 01:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210804142959.67981-1-andriy.shevchenko@linux.intel.com> <e34fdf56-4fdb-b422-17d6-0b35779e37b7@kernel.org>
In-Reply-To: <e34fdf56-4fdb-b422-17d6-0b35779e37b7@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Aug 2021 11:21:01 +0300
Message-ID: <CAHp75VfSt=vibmiSEVP68UkAHmkDJ3tXt0W7yxmQ8UH-CTYCAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serdev: Split and export serdev_acpi_get_uart_resource()
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 5, 2021 at 10:36 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 04. 08. 21, 16:29, Andy Shevchenko wrote:

...

> > +/**
> > + * serdev_acpi_get_uart_resource - Gets UARTSerialBus resource if type matches
> > + * @ares:    ACPI resource
> > + * @uart:    Pointer to UARTSerialBus resource will be returned here
> > + *
> > + * Checks if the given ACPI resource is of type UARTSerialBus.
> > + * In this case, returns a pointer to it to the caller.
> > + *
> > + * Returns true if resource type is of UARTSerialBus, otherwise false.
>
> Better to write:
>   * Return: True if resource type is of UARTSerialBus, otherwise false.
> which is recognized by sphinx.

Will fix it in v3.

> > + */

...

> Why don't you return NULL, or sb, thus eliminating the parameter?

1. That's how other similar APIs are done.
2. It will save a line of code in the callers. Usual pattern
  if (...get_res(..., &sb))
   return ERR_or_so;

With your proposal

  sb = get_res(...);
  if (!sb)
    return ERR_or_so;

> > +}

-- 
With Best Regards,
Andy Shevchenko
