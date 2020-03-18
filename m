Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE54DC5ACD6
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8953220767
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 09:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHJQwj9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCRJyk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:54:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44244 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgCRJyk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 05:54:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id w4so11543567lji.11;
        Wed, 18 Mar 2020 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4zXY8OVID4kt8h/7gb/7G/AMBsckTZ49OvWpsrQBZ+Q=;
        b=SHJQwj9N/x0aU37xu17+m/Q+q/kgQ2FCAlVxwrh9OERA9Tt+ltZcT/DeLXYUykaFVr
         ey/+IibN3a4UkdZxZxbZ/cZ0M45+Lc0i1FbQqUu2gY+lXXZoWGBQ8gkiIaQz+PRgPz/O
         XZWQhXOWV03SV9BOmhmLYP0nH148K/Bs6XfBiuabffkRbPHivshG2nV2zzpDYeDEsvXt
         yl3irMxF18yliHUHF3l3iwinkFehCcuuykhC0zPzMp2jba8OqQKQj9CLGY+brGkJsBP4
         QZF3Eg1JsZokMX2BFjA6YoUZulGawsT0AZT0rxOzi4qQ4fczvYUGNSMDRZjqA45dB8uQ
         l/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4zXY8OVID4kt8h/7gb/7G/AMBsckTZ49OvWpsrQBZ+Q=;
        b=Afy4JQyD8AKYqeZ/czjaScWdbM5q7C+E+NQnINgaw02c2AFMA5YNayF6Wq5SWx44jr
         1p4KfMbOtdhmnEfgk+dbBvCGb1MXCDVQQoTKWJhYcOGIhRjlpJBwW55aZ9rC7z1019w4
         axG/bOpvwYQHdc84bJj/EIYqiY333cLgTqk0y17Ax+X1BxAOAfbOwrBCmiHpYqWOGPn9
         ULGrjojJMJQiYTT5LdzI3HlVzktmG2DNpwE1CLDAxWIABA2lj5IGkAi4UV8TgLgLb8Ap
         NePT8LW5KqLsfWEko7YN7Hqo0lpOA2ilizl72eLr5ayl35KjhJrChfdFRKl3Ql/Ulsad
         FNMw==
X-Gm-Message-State: ANhLgQ1fFf/RQbJTEjFY0z50iZH3l+zzyVtWWQzE2Dg62eyaedVfT8q5
        d+WRt31zubYeW5dDV+gUg+zUl15yJayTVAPPIrM=
X-Google-Smtp-Source: ADFU+vvoLTMmVa92d+8vVIhJg/Nk1WLgZ3K4LQD1jtOJKttEcVUWHPKKLw0DIUvVlgbBkOMk2I/Aj2zQlrnpZmF9XBQ=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr1950693ljs.126.1584525276064;
 Wed, 18 Mar 2020 02:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200318083120.13805-1-zhang.lyra@gmail.com> <20200318083120.13805-2-zhang.lyra@gmail.com>
 <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com> <CAAfSe-u-ui3SP8vnNPMuKHhB-iMCscc4OE16hoDWZ8xzsie+vQ@mail.gmail.com>
In-Reply-To: <CAAfSe-u-ui3SP8vnNPMuKHhB-iMCscc4OE16hoDWZ8xzsie+vQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 18 Mar 2020 17:54:24 +0800
Message-ID: <CADBw62pK6R2_voOMeShwzen2vUR_c4YS27r9xfXTwLD000p7ig@mail.gmail.com>
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

On Wed, Mar 18, 2020 at 5:48 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Wed, 18 Mar 2020 at 17:16, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > On Wed, Mar 18, 2020 at 4:31 PM Chunyan Zhang <zhang.lyra@gmail.com> wr=
ote:
> > >
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > It would be better to cleanup the sprd_port for the device before
> > > return error.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  drivers/tty/serial/sprd_serial.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sp=
rd_serial.c
> > > index 9f8c14ff6454..54477de9822f 100644
> > > --- a/drivers/tty/serial/sprd_serial.c
> > > +++ b/drivers/tty/serial/sprd_serial.c
> > > @@ -1204,8 +1204,10 @@ static int sprd_probe(struct platform_device *=
pdev)
> > >         up->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
> > >
> > >         ret =3D sprd_clk_init(up);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               sprd_port[index] =3D NULL;
> >
> > =E5=A6=82=E6=9E=9C=E6=88=91=E4=BB=AC=E5=BC=BA=E5=88=B6=E4=BD=BF=E7=94=
=A8alias, =E5=88=99=E8=BF=99=E9=87=8C=E5=BA=94=E8=AF=A5=E4=B9=9F=E6=97=A0=
=E9=9C=80=E6=B8=85=E9=99=A4=E4=BA=86=EF=BC=8C=E5=9B=A0=E4=B8=BA=E4=B8=80=E8=
=BF=9Bprobe=E5=B0=B1=E4=BC=9A=E7=BB=99=E5=AE=83=E9=87=8D=E6=96=B0=E8=B5=8B=
=E5=80=BC=E3=80=82 =E8=BF=98=E6=98=AF=E6=88=91=E6=BC=8F=E4=BA=86=E4=BB=80=
=E4=B9=88=EF=BC=9F
>
> =E6=98=AF=E4=B8=8D=E9=9C=80=E8=A6=81, =E6=89=80=E4=BB=A5=E6=88=91comment =
message=E9=87=8C=E5=86=99=E7=9A=84=E6=98=AFit would be better...
>
> =E6=88=91=E8=A7=89=E5=BE=97=E6=98=AF=E4=B8=8B=E9=9D=A2=E8=BF=94=E5=9B=9E=
=E7=9A=84=E5=9C=B0=E6=96=B9=E9=83=BD=E6=B8=85=E7=90=86=E4=BA=86, =E8=BF=99=
=E9=87=8C=E4=B9=9F=E6=B8=85=E7=90=86=E6=8E=89
>
> =E8=A6=81=E4=B9=88=E9=83=BD=E5=8E=BB=E6=8E=89?

=E6=88=91=E8=A7=89=E5=BE=97=E5=88=A0=E6=8E=89=E5=90=A7=EF=BC=8C=E4=BB=A3=E7=
=A0=81=E8=83=BD=E5=B0=91=E4=B8=80=E8=A1=8C=E6=98=AF=E4=B8=80=E8=A1=8C =EF=
=BC=9A=EF=BC=89


> >
> >
> > >                 return ret;
> > > +       }
> > >
> > >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >         up->membase =3D devm_ioremap_resource(&pdev->dev, res);
> > > --
> > > 2.20.1
> > >
> >
> >
> > --
> > Baolin Wang



--=20
Baolin Wang
