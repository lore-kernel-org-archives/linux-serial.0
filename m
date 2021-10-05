Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEBCC433F5
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 09:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B6A6137D
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 09:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhJEJuQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhJEJuP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 05:50:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4AC06161C;
        Tue,  5 Oct 2021 02:48:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v18so74983945edc.11;
        Tue, 05 Oct 2021 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eG8e9Uk1W9GSBqcgDiTroWFBkz64SIsFxYG5rFb/vd8=;
        b=SE4duXLzwA25k01iGgWFP2fR8dQHXfMyk6EhJ3QKkOOK67Q7Xb0vIdsgc/wf2PyQ4K
         NPUIDD6Cr0fuxiNGEkVhLUdWQREqMqSBNKwSNilx/RTXfZ1HOS5IcZ8J5NwQMYEoGNX2
         teD6TkrgPImaZVrvMzmfO3NQt7Qlc6u4DCCCjtMUscZ9fUMchR38Qive93Hhdb5ETOGk
         a0IIEW2T5m3st5b4skT46eqJjViqrGHcI/czQE8Z+PgHBdmc/4FiCCfXnvgTM2PwYOmq
         y8L8awV44LxAWiO7p0QP95VsuKegWzr1QQwNFcJ+Ip61cjxR/J7CuWXtnURVivTMxu5V
         Frww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eG8e9Uk1W9GSBqcgDiTroWFBkz64SIsFxYG5rFb/vd8=;
        b=eONaug122+yUeJH1cZhaIE/hSF6JAtmFZlGZTXc7FBVE0ab0GcTTJKysDof//8hym7
         M/24ookqZO+eC2rLRZQ2OS5kBN4e6I5V04shommvD3ik6kRdA5gWjfko631+8lyVwKJf
         D22t2VUqfHsOXVPUpwa9/PNw4LseL4lx7ySXaThqLvsMn7i37PiUjaJImgasRYSIaRFS
         B+hqCtvWlwDFr3bsVWRxl9nRfQQAymu+6JfCikRkulgjENRrFmlGMwrfWCcrs2PLjI3K
         F5LxSBGqRfL0UMcRFb9kLlBj5Qmg8b6iPSU0Ibd+XvKdgih5scQQ800+sjSvfof9yPTn
         FXRw==
X-Gm-Message-State: AOAM530FSqf1wiBNGMruzfUqKgKWBJfd4h3/i/B8Eyct9J4nT6P/gefF
        OlzOdQqfqVQLWTckUwqWxQHuggpQpm2P4FT6pN8=
X-Google-Smtp-Source: ABdhPJwkKMftU9jYk4o4DLrKZdpmpAizkinnNgweahIJMDBLU7PntuXpqEztqIWiFLfX8D0CIFqMVmr0TAEppSSflLo=
X-Received: by 2002:a17:907:62a2:: with SMTP id nd34mr2187647ejc.356.1633427303304;
 Tue, 05 Oct 2021 02:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
 <YVSY8L6A6H71DvM5@smile.fi.intel.com> <2b37141fcb1067f9322bca5f6d83818d380b7c6a.camel@microchip.com>
In-Reply-To: <2b37141fcb1067f9322bca5f6d83818d380b7c6a.camel@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Oct 2021 12:47:47 +0300
Message-ID: <CAHp75VdYqOVNGY7-FdNkTy8hLn-2OWVEZrPuXDYufEC-yOM=BQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] serial:8250:Add driver support for MCHP PCI1XXXX
 UART module
To:     LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Zev Weiss <zev@bewilderbeest.net>, Vignesh R <vigneshr@ti.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 5, 2021 at 11:49 AM LakshmiPraveen Kopparthi
<LakshmiPraveen.Kopparthi@microchip.com> wrote:
> On Wed, 2021-09-29 at 19:48 +0300, Andy Shevchenko wrote:

...

> > Please, do not add this to 8250_pci.c. Use separate quirk driver as
> > it's done
> > in plenty of examples:
> >
> >         8250_lpss.c, 8250_mid.c, 8250_exar.c, ...
>
> Thanks for pointing the examples. I have looked into these examples and
> the required functionality can be achieved with a separate driver. But
> I would like to know the reason for not adding this to 8250_pci.c.

Maintainability. And we may check, btw, the LOC difference when you
will be ready with a separate driver.
In some cases it would even be a good win.

-- 
With Best Regards,
Andy Shevchenko
