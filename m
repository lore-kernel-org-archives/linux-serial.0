Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59452C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jun 2022 09:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbiFTJPu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiFTJPs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jun 2022 05:15:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5E10576
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 02:15:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g12so5111830ljk.11
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=31qkXAXhXqRrqe1Ii07YlWIoTPQBDDXJrZ60sbRxsaY=;
        b=Eyp+EzpsAzGvQb7f/hNtXEbNC89BQQPPsKzbWnZbH1baSLMfxHEcXFPHWGnucCRp8p
         8ql7Vo2CqkmMOyc/szhOJwpUG/D610TIBzKvgZO9RLQ7/SQkckZpqpUIIm5G2I7a5gVc
         WCSFKAxQjGRz4ImOaxsKDS1I/mdb1rpkX8XbqxOICCGybDxOccT1ODiIHdA2oIBs0/Gd
         fU6OQ9wDIo7M3T3euit5yZO0gLHSDcCSlJ8xgEMGJJg8gSbYYc99lsaBtUM7TSektkD3
         dT6EAVYwucRgF0dzbVpCtWlQg7sXjz9sdTzB7Z9q1QHxCjbSb6amFYVP1H/LSHoyG0iD
         q3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=31qkXAXhXqRrqe1Ii07YlWIoTPQBDDXJrZ60sbRxsaY=;
        b=fz73g654Dv3RjoVmDhPRo2zHDIq6cqeTUyd+l1RaAPFKyJ8T8n5G13KAkcNibU0fey
         ezBxpcpB7hu7tAzm6LYNxPKTgikCRhAWR86GTv9khBa7a7cfwP2oyJHpriMrns8usyAN
         9xbunvWDJMM5oAIag6BwNHYmES/l9+6Y7hdnxla1jzb4QK6oLdgu+QaLBZ7WrdnDTWAO
         wKRwPbmzys5LEB/NEumqoM0LY6OnXd9trsgc+pLnxW032DlsYa63RLaxWuG0n1oz4ff3
         0NhbUf2CvFH4qJ6TdoBIndGyUPH6De2uBsuTUwBdp5vBBEwRwIXlNXHlUsCPYAESTivi
         WSOQ==
X-Gm-Message-State: AJIora9SAZLbM+HgjU+s5z+cm5z7eT3G0mdxClwVS7srY1SsyGfFOuPg
        B+vIgG1E8Nw4mcSR19wfB1Ui6QO5NGDZ/zLWg5HS8Q==
X-Google-Smtp-Source: AGRyM1scJeYRnEptSEw+aDwE2zYqQ0smNaOHKei8pgrcY2y0euZ7LG3AkBkwGMXH7gtqBkToRQOX+5tmPMjZGX0b+VE=
X-Received: by 2002:a05:651c:514:b0:25a:6232:dbd4 with SMTP id
 o20-20020a05651c051400b0025a6232dbd4mr5074084ljp.5.1655716540417; Mon, 20 Jun
 2022 02:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220619074030.1154429-1-mw@semihalf.com> <4dcc3bb4-ea76-527d-701b-289d1d24d73c@linux.intel.com>
In-Reply-To: <4dcc3bb4-ea76-527d-701b-289d1d24d73c@linux.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 20 Jun 2022 11:15:27 +0200
Message-ID: <CAPv3WKd=TVuW5j4-A81SpHPTqjcasAvHbibC7a6dnOwUH5soqA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: dw: enable using pdata with ACPI
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

pon., 20 cze 2022 o 09:31 Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> napisa=C5=82(a):
>
> On Sun, 19 Jun 2022, Marcin Wojtas wrote:
>
> > Commit 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata"=
)
>
> That commit id is not correct, please fix.
>

Will do, thanks for spotting.

Best regards,
Marcin

> Other than that,
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> > caused NULL-pointer dereference when booting with ACPI by unconditional
> > usage of the recently added pdata.
> >
> > In order to fix that and prevent similar issues in future, hook the
> > default version of this structure in dw8250_acpi_match table.
> >
> > Fixes: 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata"=
)
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 24 ++++++++++----------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index f57bbd32ef11..3b79bd5c9c9d 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -773,18 +773,18 @@ static const struct of_device_id dw8250_of_match[=
] =3D {
> >  MODULE_DEVICE_TABLE(of, dw8250_of_match);
> >
> >  static const struct acpi_device_id dw8250_acpi_match[] =3D {
> > -     { "INT33C4", 0 },
> > -     { "INT33C5", 0 },
> > -     { "INT3434", 0 },
> > -     { "INT3435", 0 },
> > -     { "80860F0A", 0 },
> > -     { "8086228A", 0 },
> > -     { "APMC0D08", 0},
> > -     { "AMD0020", 0 },
> > -     { "AMDI0020", 0 },
> > -     { "AMDI0022", 0 },
> > -     { "BRCM2032", 0 },
> > -     { "HISI0031", 0 },
> > +     { "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
> > +     { "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
> >       { },
> >  };
> >  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
> >
>
> --
>  i.
