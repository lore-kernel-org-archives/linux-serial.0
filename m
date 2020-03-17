Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06535C10F29
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 07:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD22E20674
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 07:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poJxtgck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgCQHSl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:18:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51744 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQHSl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 03:18:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id a132so20214247wme.1;
        Tue, 17 Mar 2020 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1U9j3PtO2mElKN8AUdXKykOK+OIvnmu7fgDMV7+q8no=;
        b=poJxtgckMOoiNoSN0kNxMh0lQ8LEMJ3wsDzvPZPdJZSkX4KhXjFtJsJUq3dHEXHY8r
         BkcwF0MOpg/lCV92BezqinGwG4qVRhJ6ecb0/MJIgw6U6gz1BYh7sE4/fbqddA0lurGz
         GEhFhdIP9H5zUB+0LKvv067h3AO/D8aZGh4ASVVjg8l3EGY1rZ8oHYqY0dtCudFbH/7v
         JyyzcDzwdJmfZ8qbLykvya/EeStp/MtthzBPIF+71Krc6xQKK4nTF71HFjUqqgYR+iBR
         G9yjxUQXXl6DAo1NxiT64DzW+eod8jtqEGv+h4UZTeZwGK2fnSnF1yUPngDImUBgmiym
         gw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1U9j3PtO2mElKN8AUdXKykOK+OIvnmu7fgDMV7+q8no=;
        b=O0XpgLytOcUmuStJ11RqEsi+AjTMEcUI2ptUYEpHJUiFS0ejN1YkZcUVrGAC4ii3ky
         zYdbLKPW6/+M1nU4dJ9i+tpahPYxgzUxurdbuEljxzokaQZiN1qM33pBV7Y/BsOjQytq
         +CPy4aqAsK7j8YBriqktZVC6xE0KZjwqKO2lvNF5uyUfhZOhTq8GrADthewBwDXVV19Z
         +A1mxAzoRnT6LBDpMBVou9tAWssJ+9RflysWX02VEiGhP0bNoB+nJ4khyYzJHwQIR1xh
         8cyItlOjURq5/MJdd3KeoNmQfOcrkDNo61hpBSrZD3BISz4MxCa41nZLfaDkscbHkyIU
         IQDg==
X-Gm-Message-State: ANhLgQ1m0GVvZq6rh/KuE+mL4gGjihNnk/I0IZ94VL2hA3W+Y7a1uIGl
        YpSs/ktj5mtbPJ6bDlZ5+eRkgOJe708Uiy7wtNY=
X-Google-Smtp-Source: ADFU+vsAx0cCYbP/KfznP+ZJXp61CYN4h4vfOb4WraXaXDFM7TQRuyN4w6DkQ3eRNhzpfgxiXMtSKJE2TuSUTr00HaQ=
X-Received: by 2002:a1c:f615:: with SMTP id w21mr3575344wmc.152.1584429518588;
 Tue, 17 Mar 2020 00:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200316101930.9962-1-zhang.lyra@gmail.com> <20200316101930.9962-4-zhang.lyra@gmail.com>
 <CADBw62rjQMfNdxyDsNCbz-v7Ebz=MFu+CTMJEJORD3VXczVhtQ@mail.gmail.com>
In-Reply-To: <CADBw62rjQMfNdxyDsNCbz-v7Ebz=MFu+CTMJEJORD3VXczVhtQ@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 17 Mar 2020 15:18:02 +0800
Message-ID: <CAAfSe-vGjJY_+M7gSe3s4B9BnTxKq+D6TKxU5Q7e731a4Kw+pg@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: sprd: cleanup the sprd_port when return -EPROBE_DEFER
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 17 Mar 2020 at 14:22, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 6:19 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > cleanup the sprd_port for the device when its .probe() would be called
> > later, and then alloc memory for its sprd_port again.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> > index 914862844790..9917d7240172 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -1230,8 +1230,13 @@ static int sprd_probe(struct platform_device *pdev)
> >         up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
> >
> >         ret = sprd_clk_init(up);
> > -       if (ret)
> > +       if (ret) {
> > +               if (ret == -EPROBE_DEFER) {
>
> I think we can remove the condition and devm_kfree() here, just
> simplify the code as below?
> if (ret) {
>        sprd_port[index] = NULL;
>        return ret;
> }

Humm.. I admit that here's a little confused.
Let assume we don't have aliases for serial nodes,  and we set both
earlycon and console via bootargs, what will happen?
We can simplify the code like above and we have to ensure all
platforms have serial aliases in their devicetree, then we also can
simplify the process of getting port index with of_alias_get_id()
only.
We can discuss further offline, and also save community resource :)

Thanks,
Chunyan

>
> > +                       devm_kfree(&pdev->dev, sprd_port[index]);
> > +                       sprd_port[index] = NULL;
> > +               }
> >                 return ret;
> > +       }
> >
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         up->membase = devm_ioremap_resource(&pdev->dev, res);
> > --
> > 2.20.1
> >
>
>
> --
> Baolin Wang
