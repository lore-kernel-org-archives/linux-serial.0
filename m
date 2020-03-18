Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F4DC10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 09:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DD82076E
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 09:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a53AcudG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRJsb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:48:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39568 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCRJsa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 05:48:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so2456831wml.4;
        Wed, 18 Mar 2020 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kZWoyvaHJSGd73srWJBm6fxD7x19530bbjXoByZ4qR4=;
        b=a53AcudGGz6w3yGUUaIkUKc/2DADUIGgaeiEFOHYu9km7wuSMjqVT5ePukdJLlUj5r
         zYc6tYkJBqLGvRFNS7niMFtFmLS3N5vB7Ba05TkOdtmfDcbjx8Q0OE2TbwXbgzTXjGCz
         mhQI7z80kTOVifzTscM+FNwXEZCZyukNqWl64oqNac6SJYLiI/+SKw4i0ogJdP3/CzV8
         V6mgZ+i4BinPE5YYsA1/iaA6GwxyZVvDoCTuX2O7/Nu3As8+EJIe7fs7ieXe6Sx52+qc
         gt3MELJ/edUQhxUp/ycvxsE9kosBLKwuH4UsKq9uAW238nV7HnCO/xfrBV73mov2Asoy
         4Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kZWoyvaHJSGd73srWJBm6fxD7x19530bbjXoByZ4qR4=;
        b=V5Jq+7l0pAZL2y/pfcwM0aJwmxf0L+j7CW9ZOED/RcvV3wmQyKzVJVJGmVMk/wUlYY
         w6un0x6FOC2Z8sJatk/JqHIJff3SknSTgGh+R1Txwu2547L/70fw4I+6RcxF55zYN8r6
         /AwYvO8CBAkcmKZitxWcaMRSgbC3kucumVOphTPlDiZ5um0XMXEydVQIxyj2vV2GAveB
         Vnf6fKt2RD5Nk6tyBcoedy/U+Olmm6RMlL2pM+m1yZNH1Tw0Ky8B4rtrVoPm4GjWy8UF
         c6X7oeB3a58etKnVgK/QAtPk0aFB4WpMkXC1JutdVamYyBeNWZKa4SSk0C/VmEryGJGX
         9I7A==
X-Gm-Message-State: ANhLgQ1goLyBGLrmCdByDHHdzYFE4QC5gsRWgWQ7HzJNEMP6k397rQCu
        ZcLue+Cd1KxTkNnyf/mACbd4KuDcz6rm/Lz06dc=
X-Google-Smtp-Source: ADFU+vvt+aQ0K45DCFto4tqOEeYoZHwvLuJtLFWDetsV/skwz/0PCiKBEkPYkP6l0v7Mjcsa5dIpLDMp1MUZS8lonn0=
X-Received: by 2002:a1c:f615:: with SMTP id w21mr4276473wmc.152.1584524908962;
 Wed, 18 Mar 2020 02:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200318083120.13805-1-zhang.lyra@gmail.com> <20200318083120.13805-2-zhang.lyra@gmail.com>
 <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
In-Reply-To: <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 18 Mar 2020 17:47:52 +0800
Message-ID: <CAAfSe-u-ui3SP8vnNPMuKHhB-iMCscc4OE16hoDWZ8xzsie+vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sprd: cleanup the sprd_port for error case
To:     Baolin Wang <baolin.wang7@gmail.com>
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

On Wed, 18 Mar 2020 at 17:16, Baolin Wang <baolin.wang7@gmail.com> wrote:
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

=E6=98=AF=E4=B8=8D=E9=9C=80=E8=A6=81, =E6=89=80=E4=BB=A5=E6=88=91comment me=
ssage=E9=87=8C=E5=86=99=E7=9A=84=E6=98=AFit would be better...

=E6=88=91=E8=A7=89=E5=BE=97=E6=98=AF=E4=B8=8B=E9=9D=A2=E8=BF=94=E5=9B=9E=E7=
=9A=84=E5=9C=B0=E6=96=B9=E9=83=BD=E6=B8=85=E7=90=86=E4=BA=86, =E8=BF=99=E9=
=87=8C=E4=B9=9F=E6=B8=85=E7=90=86=E6=8E=89

=E8=A6=81=E4=B9=88=E9=83=BD=E5=8E=BB=E6=8E=89?


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
