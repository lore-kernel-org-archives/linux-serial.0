Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15189C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC30A613C1
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 13:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGNNjE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhGNNjE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 09:39:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04CEC06175F;
        Wed, 14 Jul 2021 06:36:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id my10so1522261pjb.1;
        Wed, 14 Jul 2021 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r8rf2O/45yj1RALgOIqdf32BOBJWpRrDU+lYRG2lttI=;
        b=bQtMtAvI0Z/YmPs8EPQvMyVhFWYyZxlB6CHVdgcJTtc/pJDlDiLz1YUW9CB89dwEYQ
         /F5m3r0Ar6JLPAsVICIGlR9/71zhZiTZwJAOwFFQ/bFcBR7fr9oZgT/LHpLRCqXge3bO
         667+dbc4R0Jo6P9olYMnhsQjZrWjd5GFaeIKmcf73we32G3AeT54WQX/SvFXsfkcZMWB
         XdXLGmc9p5ECEQrxNyUJ4M+S6VJekUJH8d8x38K8dwkSpA5DuKqzidrXBQSI8zeICmiT
         q5G85Kn00NfZ5tj9bOo8nsIJHtRvGyYwyliBu36HhIZNZQF38EuFTp5I9LRt1eluQ7wY
         OnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r8rf2O/45yj1RALgOIqdf32BOBJWpRrDU+lYRG2lttI=;
        b=RzbZgqTjg6X8kgtd/uNwgwkXw9/LpSxLMpUgOC0cJCrXVdZcCjKOM2D8Iv9x2qWpw/
         6Z215YYWbLjw+MwLuhmWrcKJIuipKvzCMpdByDusRn3hE0Rdiq8WkoByHnQ4g6nv1uzm
         uU9zUEQ431CLHD5BIuhR+VNPR3msTvTUbk5tW6W+R63IOxCY5TIApINNm+al5mJZFFle
         7tOZxAds2QhFdsPOV379tcHepksMLO76GxPFeLrX0aiqb54SyXSFBWbesZhdcAiRi1FH
         I+TC/+PLbhXMuARs+M6edfPK2yb4wJhHSAZwCGRKPAg7l1qioGFJnmzaKPARUblmPXmP
         LkWQ==
X-Gm-Message-State: AOAM530LG/GBATqP6jlnKHEIeN0eq4/RzenE/dWAl4lJPPD+KRgnN3lB
        mVspP8v42CBlsl64t7F+3z5B0xzgeKuPjNujcEU=
X-Google-Smtp-Source: ABdhPJxezE5KBs6D/+ePsTzKwWRKo7P7kKcKrhHjRzBXt7gm1cnoVqpPOa2AaqPPZNjU8ZIIfjPDgGK30kE6FDhf1to=
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr3874618pjq.129.1626269772407;
 Wed, 14 Jul 2021 06:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org> <784629f9-677e-ee53-aceb-89397ce0951a@oth-regensburg.de>
In-Reply-To: <784629f9-677e-ee53-aceb-89397ce0951a@oth-regensburg.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jul 2021 16:35:33 +0300
Message-ID: <CAHp75VdoaE7hCOzsRvuf=7A4mmv0NWBmwqK_mM8vO-K3YZKTUQ@mail.gmail.com>
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

On Wed, Jul 14, 2021 at 3:56 PM Ralf Ramsauer
<ralf.ramsauer@oth-regensburg.de> wrote:
> On 14/07/2021 08:54, Jiri Slaby wrote:
> > On 13. 07. 21, 12:40, Andy Shevchenko wrote:

> > Hmm, have you checked the commit which introduced the whitelist?
> >
> >     Nevertheless, this needs to handled with care: while many 8250 devi=
ces
> >     actually claim to support MSI(-X) interrupts it should not be
> > enabled be
> >     default. I had at least one device in my hands with broken MSI
> >     implementation.
> >
> >     So better introduce a whitelist with devices that are known to supp=
ort
> >     MSI(-X) interrupts. I tested all devices mentioned in the patch.
> >
> >
> > You should have at least CCed the author for an input.
>
> Yep, back then I was testing three different 8250 pci cards. All of them
> claimed to support MSI, while one really worked with MSI, the one that I
> whitelisted. So I thought it would be better to use legacy IRQs as long
> as no one tested a specific card to work with MSI.

Can you shed a light eventually what those cards are?

> Don't do that=E2=80=A6 And don't convert it to a blacklist. A blacklist w=
ill
> break users until they report that something doesn't work.

White list is not okay either. MSI in general is a right thing to do.
preventing users from MSI is asking for the performance degradation
and IRQ resource conflicts (in case the IRQ line is shared).

Besides that, shouldn't it be rather the specific field in private (to
8250_pci) structure than constantly growing list?

--=20
With Best Regards,
Andy Shevchenko
