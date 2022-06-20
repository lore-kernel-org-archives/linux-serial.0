Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3992C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jun 2022 09:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiFTJOg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiFTJOe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jun 2022 05:14:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328DDEF0
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 02:14:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s21so5673202lfs.13
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=25hmf64AtM02B6nNj/TV8Umh4cSFCTOUhtvEJ9FZAt8=;
        b=iBs2N+lj79EdBT4fbZcs+ad3zR//NT+BihYFx1mRQXwcaKfLbykuaTvdABM2/ws/6W
         zBAQsWRQt2noo0YfjyvuOrIUQG3OMaVt095CpyzA0NpFEn8l4n4pDHNsNLr8B/+eWznO
         6eL5+/Xdod+bz/ZbM80IpR5MwoFoPxIkSJoFpm3IWK3PhfkU0FygLD5PHb1MaJ8tyC9w
         pP5wokZvhM0OC8NYAyzhw0k7kMKWtQJPCcWHGIGfGl3qjPOUYADfj1zNzDv9/g1XKil+
         0ZO0IaNbJTUUXgQYW5zS6Tk6wsjlWjSgwgcTVPp5Ypn+ckZ9awulD+sdTRv6wbG2cbiF
         IcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=25hmf64AtM02B6nNj/TV8Umh4cSFCTOUhtvEJ9FZAt8=;
        b=xFvzaMC4QCZuZOW3B3J7uZXl6v+eTOE4fWNsAQ0YCt/d9StylMsT6XHPsvUORbwgeO
         4YTxKfqfUrFnpAWN/3jThfcLsoFPT5LBmbn+m/z/AXUN543xisufcJDs4+EEd7A0C8F7
         aDeRR6NE799JxY10dufGlXn4BNbpzfQK7nM/cEWs6kZQhpbIIDrVj4dv9p0Ife19Y8BO
         7aNWeiunod4AjmikjZOgeVPEdQHA8n55VrsKRtqOhWUuhD6dLKcB+7Zy95ZX+8Mcn3Mq
         Ej30xhVW9HO/zvyuVPnbHQ/gMjZeMCiGlHZaROcJft+VlZ3B402DBgG6zE/VAdKsFjWT
         CN5Q==
X-Gm-Message-State: AJIora+RADxNviCMFBcby9JTCJg8/S8mr4Tg3tQ7PQA11z7EUU7efBmt
        wiABWyk7ix1NYDJCuXMZHZ8+2D67NGWDZcww68EXzA==
X-Google-Smtp-Source: AGRyM1u2PN2DigPJLdEcs8Zrx0RChWZX7/KAE+WxV7OTOoR/Qa3zGkzvncu7SoxUsBQL8/aQkHP9W86ijSsi4M3OCr0=
X-Received: by 2002:a05:6512:a90:b0:478:f288:f1b5 with SMTP id
 m16-20020a0565120a9000b00478f288f1b5mr12524062lfu.614.1655716471289; Mon, 20
 Jun 2022 02:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220619074030.1154429-1-mw@semihalf.com> <CAHp75VdmtFJe5k_6biofS0HtgqC7HQuNzrM=9cMhM1uz1p5Eng@mail.gmail.com>
In-Reply-To: <CAHp75VdmtFJe5k_6biofS0HtgqC7HQuNzrM=9cMhM1uz1p5Eng@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 20 Jun 2022 11:14:18 +0200
Message-ID: <CAPv3WKeR+iVE5KObWHmsSxDZtCqCbcCkoLWksmwhiu9E=ZcOxQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: dw: enable using pdata with ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

pon., 20 cze 2022 o 10:01 Andy Shevchenko <andy.shevchenko@gmail.com>
napisa=C5=82(a):
>
> On Sun, Jun 19, 2022 at 9:43 AM Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > Commit 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata"=
)
> > caused NULL-pointer dereference when booting with ACPI by unconditional
> > usage of the recently added pdata.
> >
> > In order to fix that and prevent similar issues in future, hook the
> > default version of this structure in dw8250_acpi_match table.
>
> Thanks for the report and fix! One proposal below.
>
> ...
>
> >  static const struct acpi_device_id dw8250_acpi_match[] =3D {
> > -       { "INT33C4", 0 },
> > -       { "INT33C5", 0 },
> > -       { "INT3434", 0 },
> > -       { "INT3435", 0 },
> > -       { "80860F0A", 0 },
> > -       { "8086228A", 0 },
> > -       { "APMC0D08", 0},
> > -       { "AMD0020", 0 },
> > -       { "AMDI0020", 0 },
> > -       { "AMDI0022", 0 },
> > -       { "BRCM2032", 0 },
> > -       { "HISI0031", 0 },
> > +       { "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
> > +       { "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
> > +       { "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
>
> Since you are touching all of them, please keep the order
> alphanumerically sorted by the HID.

Sure.

Thanks,
Marcin
