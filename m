Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38959C5ACD7
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E3120771
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSFa5v9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCRKGU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:06:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45826 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgCRKGT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:06:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so5068075ljk.12;
        Wed, 18 Mar 2020 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UuCiA8JKhRxaU1nLZdyXYMY0WuhHIeJMRu3FGvnQdSM=;
        b=bSFa5v9vO4RjCyH/6Vr2naUreh5OZEwd5SePZgCRxdeVYaBRcWvQQuAdnSzzJieoje
         nz+8SE39jpEk99LZDX/cUSp/D2I+Wvk6T5h0x2nrqyG2tufOUaNijtYNUsWSzChYB+N9
         MLnGgePUc5Hu9f4NAJSao2ptBoin6YijFnKgAJQsjL/OEzaQNqk8dcMnAe3HVWrFb+R6
         TF7fdJeWUPFyTr8s7obI/AXg8saysTYNx60bt406QgSlLO/fF/Q0j+vVRvsaBE+KDJpV
         eevwa3fth5e9/rjYsdNar1gY8auBnsZIka1MbxzDUkphX2yEAIdEBQkYdp/IKn1iu9fh
         pWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UuCiA8JKhRxaU1nLZdyXYMY0WuhHIeJMRu3FGvnQdSM=;
        b=Z8JqQYz2CW57PGRy6yvj/PwCuDCb6dYUdtufWSp2tyfgCLt6ghA4gvFFsyMATsjjqs
         X2oZyGyt+TWJbrodqbBEVsmiJN70mcR0PniiWDfVvvNj0ZHlzJ8+up7eYCR0xYqTxCfL
         y6fpraVsbmbTK/J8+wRU/my3iKRAzHXOCXbdyg2tQjo8+rkeNQMKxggQ3ZrkLmrNaTGt
         LurDas+xIe0Wvlp6nM1wy33pLd67BgoJ7/usAOatNklVPYANgJsVze6Rrim0o9CTEE6T
         uP6sLxcwthbAd/BIcFX+v1o6irfmRVRMLAJfsB7NMd/1RvWbXICeDEZHAQoQ8sHvYHIi
         5N8A==
X-Gm-Message-State: ANhLgQ0q/B1sfQAEXMYIOpC/kcPMOdTOJP0yKBcDqyzn/dcw8MTRLSS7
        KljBmBZIq+dgjEL5PwVXDklJZQ3vD3CfD114KljPkA==
X-Google-Smtp-Source: ADFU+vsWwudt5eBWhr1rdGzWz7OwMzIpgdwbcYNNFSs/xQf4x4vDrVPfehvhcrXI3LciCmahO/qRZp85gldSZlaTD3c=
X-Received: by 2002:a2e:3a11:: with SMTP id h17mr1935816lja.110.1584525976990;
 Wed, 18 Mar 2020 03:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200318083120.13805-1-zhang.lyra@gmail.com> <20200318083120.13805-2-zhang.lyra@gmail.com>
 <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
In-Reply-To: <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 18 Mar 2020 18:06:05 +0800
Message-ID: <CADBw62pWhA8n5rAgX2Hud06k9cvF9b3KDfZmH7oX1HEz=MWzYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sprd: cleanup the sprd_port for error case
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 5:16 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Wed, Mar 18, 2020 at 4:31 PM Chunyan Zhang <zhang.lyra@gmail.com> wrot=
e:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > It would be better to cleanup the sprd_port for the device before
> > return error.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 9f8c14ff6454..54477de9822f 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -1204,8 +1204,10 @@ static int sprd_probe(struct platform_device *pd=
ev)
> >         up->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
> >
> >         ret =3D sprd_clk_init(up);
> > -       if (ret)
> > +       if (ret) {
> > +               sprd_port[index] =3D NULL;
>
> =E5=A6=82=E6=9E=9C=E6=88=91=E4=BB=AC=E5=BC=BA=E5=88=B6=E4=BD=BF=E7=94=A8a=
lias, =E5=88=99=E8=BF=99=E9=87=8C=E5=BA=94=E8=AF=A5=E4=B9=9F=E6=97=A0=E9=9C=
=80=E6=B8=85=E9=99=A4=E4=BA=86=EF=BC=8C=E5=9B=A0=E4=B8=BA=E4=B8=80=E8=BF=9B=
probe=E5=B0=B1=E4=BC=9A=E7=BB=99=E5=AE=83=E9=87=8D=E6=96=B0=E8=B5=8B=E5=80=
=BC=E3=80=82 =E8=BF=98=E6=98=AF=E6=88=91=E6=BC=8F=E4=BA=86=E4=BB=80=E4=B9=
=88=EF=BC=9F

Sorry, please ignore my previsous comment. I made a stupid mistake
when talking with Chunyan.

So what I mean is we should not add this clean up, cause we will
always get the correct index with aliases, and it will be overlapped
when probing again.

>
>
> >                 return ret;
> > +       }
> >
> >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         up->membase =3D devm_ioremap_resource(&pdev->dev, res);
> > --
> > 2.20.1
> >
>
>
> --
> Baolin Wang



--
Baolin Wang
