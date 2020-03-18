Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67CBC5ACD6
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4AE2076D
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9GVXd7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCRKRW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:17:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34953 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCRKRV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:17:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so2602912wmi.0;
        Wed, 18 Mar 2020 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H1EcxEfJM49avse1S2eIURNhiFA3z+ms1VeEZrzjwZo=;
        b=d9GVXd7A+zm3/unbzuaX7CJe8B6oWEJRw+AxrHUCpCFDd81d8XWPSiUvAmeAoJNYm0
         ZVZhJ/FmDvvqqYzaGmV3Gv6tFvigfoo4Mmk9cHKssyEXX0iHzDrD6T4Dxgl+dcqaW/V2
         q3EOeQHiGIIxvgwkbwwGJSsOev25jfisRaItl+UGdrpgDwkrpFWr1opeqOqGqoIMsHdx
         Ckpz9sSJPxc2v1KkyXMaOfEHVmfsjIRkHKlTSurm4QkgRNErzr4wJdpu0O23BO0jfizp
         U/GGS0WFTBlmWCNlIkWDEz7Qj6ebbiQnGCOihy7C7oW4xxZMhKGliCmqDuvZk+SwGZxd
         wHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H1EcxEfJM49avse1S2eIURNhiFA3z+ms1VeEZrzjwZo=;
        b=dYOQyr9WZ2UWNF0E614/nLV276nd9QZXS79d/X/xPFWULqUBrzPKysKZ9l47TeDOMQ
         PprcIuHbVRzhBhSNpPcO3Qy1PtxI09xP4IoTifeRxoJfCGS7JiIbqOy5thp/cLJq5Lzq
         1rXtpIHk22ucOQ6VAW1fheJYdM2WapOvY1kjhwP/XtQE0zuGzkSmmB/eKwIgU5+vvGm6
         EVIzuzYiIvcY/+b/ay16Ucis2B0xrtvYkLnPpAMgzzKTO83DoJdaYKwWZYTL3ust+Toe
         tqoej3+ML+DvP73V4KTT7PpbQqMrL+nboFCfq36xAcQ8jkJyIpSD/kdE+o+00tS2TdEw
         rvWg==
X-Gm-Message-State: ANhLgQ1JAEckCv5TQP9nL0PnLMN01lJMZDyF2q01gZ0T7woCiU6PouwH
        Yh5DIKYCRHSSeyYGBRKyXMHD5N0MOA7zVX+uvsdWfA==
X-Google-Smtp-Source: ADFU+vu50GxlzsJlMPTfvmSeWgwJl4UJQOc8H4AxuzLJ3PtQNJCYc/ZJ9Cgtq7nUhgAU+Oom6rijjQtlReLkmpvwr6A=
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr4368871wml.26.1584526639622;
 Wed, 18 Mar 2020 03:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200318083120.13805-1-zhang.lyra@gmail.com> <20200318083120.13805-2-zhang.lyra@gmail.com>
 <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
 <CADBw62pWhA8n5rAgX2Hud06k9cvF9b3KDfZmH7oX1HEz=MWzYA@mail.gmail.com> <20200318101340.GA2081481@kroah.com>
In-Reply-To: <20200318101340.GA2081481@kroah.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 18 Mar 2020 18:16:43 +0800
Message-ID: <CAAfSe-t7e0Cd3Lm_x9u=OhuBBtTexx3+qyg-+F71LK=C1V5pNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sprd: cleanup the sprd_port for error case
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, Jiri Slaby <jslaby@suse.com>,
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

On Wed, 18 Mar 2020 at 18:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 18, 2020 at 06:06:05PM +0800, Baolin Wang wrote:
> > On Wed, Mar 18, 2020 at 5:16 PM Baolin Wang <baolin.wang7@gmail.com> wr=
ote:
> > >
> > > On Wed, Mar 18, 2020 at 4:31 PM Chunyan Zhang <zhang.lyra@gmail.com> =
wrote:
> > > >
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > It would be better to cleanup the sprd_port for the device before
> > > > return error.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  drivers/tty/serial/sprd_serial.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/=
sprd_serial.c
> > > > index 9f8c14ff6454..54477de9822f 100644
> > > > --- a/drivers/tty/serial/sprd_serial.c
> > > > +++ b/drivers/tty/serial/sprd_serial.c
> > > > @@ -1204,8 +1204,10 @@ static int sprd_probe(struct platform_device=
 *pdev)
> > > >         up->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
> > > >
> > > >         ret =3D sprd_clk_init(up);
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               sprd_port[index] =3D NULL;
> > >
> > > =E5=A6=82=E6=9E=9C=E6=88=91=E4=BB=AC=E5=BC=BA=E5=88=B6=E4=BD=BF=E7=94=
=A8alias, =E5=88=99=E8=BF=99=E9=87=8C=E5=BA=94=E8=AF=A5=E4=B9=9F=E6=97=A0=
=E9=9C=80=E6=B8=85=E9=99=A4=E4=BA=86=EF=BC=8C=E5=9B=A0=E4=B8=BA=E4=B8=80=E8=
=BF=9Bprobe=E5=B0=B1=E4=BC=9A=E7=BB=99=E5=AE=83=E9=87=8D=E6=96=B0=E8=B5=8B=
=E5=80=BC=E3=80=82 =E8=BF=98=E6=98=AF=E6=88=91=E6=BC=8F=E4=BA=86=E4=BB=80=
=E4=B9=88=EF=BC=9F
> >
> > Sorry, please ignore my previsous comment. I made a stupid mistake
> > when talking with Chunyan.
> >
> > So what I mean is we should not add this clean up, cause we will
> > always get the correct index with aliases, and it will be overlapped
> > when probing again.
>
> So ignore this patch and only take patch 1/2?  If so, can I get your
> acked-by for it?

Hi Greg,

There's something I need to modify on 1/2 as well, I will send the
whole patch-set later, please ignore these two patches.

Sorry for the noise!

Thanks,
Chunyan

>
> thanks,
>
> greg k-h
