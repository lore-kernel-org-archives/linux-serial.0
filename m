Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55EBC10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 09:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785B2076D
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 09:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9Q2/p1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgCRJQ4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:16:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37422 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRJQ4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 05:16:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so19688418lfg.4;
        Wed, 18 Mar 2020 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oMjrelN7v8/ZqdavfYXPrCXjsR94TXs+MjVK6ffTo4Y=;
        b=l9Q2/p1wPBFpbvCH3Y8l0Rc2kdKwh/hNNGEemdwQcm0COYbrB7gF9Srzo3me1sFxji
         lL8HQdFAJgPR2GbZFJlsPAo6ZijKAq79+vFzHRUc/BsuKxWW4Dj3tW5NG1RWo6kk1lB5
         po6ITZVZn5CNj8Eg4c6gngCkVljBUr3EwOXvGD+UH8Q2lRRWkszVZPhoWHrzXyBRsEnx
         mymYGf79Pg6xPUNMduOLAJGyfRlIJ/wjFVMDpLiN/17PWBza/L4a7JhogsQrfJ7lO1ZA
         H3N3AoATcc+nuzh/1VFOspfg8nT9vw55bHmC7JbIW2UABr1WSsHq590KbPsHI1F/EYYY
         MRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oMjrelN7v8/ZqdavfYXPrCXjsR94TXs+MjVK6ffTo4Y=;
        b=jq2JB/kR8ADTdeNp5BKSKMJ2ESXlcK6brmF47bFMZyAeubIlruyyCi/V+dYZjazEPg
         8OAApxGm02eYlr5sDFjqdzyi4B3Da0CwXkwxwXnQtF19m4ELOMMxltBvaVO0EAuf41eQ
         jBX8K4p7opz9yaGq/kNTyNvcNgFmwE4gzEIjljiwogztTwPGDZUUizuix7a9kOHFFktk
         /bKKAO2aMsJK6BEJWEmbP2HwieREkjZ3MaD8A2Ix0fZfFbVVDFztku59xYwoYCHYjxrY
         UJIf50VC+R6A+9gQjh+XLCYOem82lG9J+2agpmkXT87ah5cwaERUeviHWL3yFQfHYN/v
         j8sQ==
X-Gm-Message-State: ANhLgQ2+OSlICVAy1I3JwpHZgBeLyZvokGYR/MLErJOZl2y+z5xGcWKY
        1gW3YGB3W22Bh6OtO3Kgf35XfM5IJuGc0G3DYtQ=
X-Google-Smtp-Source: ADFU+vtq2o/3Rw6pnFs6kqQho7ithgJVO0QNl+QREgLJqIKgI7DxwyWmjuddi+fni8IKk6BkTHKLNSI5wGulJmyCoTc=
X-Received: by 2002:a19:6d0d:: with SMTP id i13mr2293970lfc.105.1584523012615;
 Wed, 18 Mar 2020 02:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200318083120.13805-1-zhang.lyra@gmail.com> <20200318083120.13805-2-zhang.lyra@gmail.com>
In-Reply-To: <20200318083120.13805-2-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 18 Mar 2020 17:16:40 +0800
Message-ID: <CADBw62rSE+MrQB_HSOwVNos_W=x-mHMEuVrZN=jU0Yt1KXFGvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sprd: cleanup the sprd_port for error case
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 4:31 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> It would be better to cleanup the sprd_port for the device before
> return error.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_s=
erial.c
> index 9f8c14ff6454..54477de9822f 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1204,8 +1204,10 @@ static int sprd_probe(struct platform_device *pdev=
)
>         up->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
>
>         ret =3D sprd_clk_init(up);
> -       if (ret)
> +       if (ret) {
> +               sprd_port[index] =3D NULL;

=E5=A6=82=E6=9E=9C=E6=88=91=E4=BB=AC=E5=BC=BA=E5=88=B6=E4=BD=BF=E7=94=A8ali=
as, =E5=88=99=E8=BF=99=E9=87=8C=E5=BA=94=E8=AF=A5=E4=B9=9F=E6=97=A0=E9=9C=
=80=E6=B8=85=E9=99=A4=E4=BA=86=EF=BC=8C=E5=9B=A0=E4=B8=BA=E4=B8=80=E8=BF=9B=
probe=E5=B0=B1=E4=BC=9A=E7=BB=99=E5=AE=83=E9=87=8D=E6=96=B0=E8=B5=8B=E5=80=
=BC=E3=80=82 =E8=BF=98=E6=98=AF=E6=88=91=E6=BC=8F=E4=BA=86=E4=BB=80=E4=B9=
=88=EF=BC=9F


>                 return ret;
> +       }
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         up->membase =3D devm_ioremap_resource(&pdev->dev, res);
> --
> 2.20.1
>


--
Baolin Wang
