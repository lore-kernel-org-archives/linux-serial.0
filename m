Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE36C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D1D20768
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpzExXNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgCRKy6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:54:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44046 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKy5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:54:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id y2so5157861lfe.11;
        Wed, 18 Mar 2020 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xYnSIevbhNbhlaEfUVlQM5r+iKMh42FpHIsghlt6Qk=;
        b=TpzExXNgXs3n4hx1sfupzdGlzGj/NK42IQUiyIn1GILR2PUQBBALXGgc8Qw9rrg4/+
         EQPCK4xibXigrPdQZiAz4kaMd6wynmnAziuj38IFoCRB62mTwAVb/KlcS3H3LpRBIXxk
         SZogYP9DG2RbKtbjdAn8mEX0gUd3Uv0a9zraxLW/KXaCH3fmSek9OU9mnD1lfkj8q6XD
         fHFtkAbD4tGQELrHERqnsOWn+r0n9IAk9Vf2PpBFllHfR1mqZQ/zNk5Sp4q4WhGBDC8c
         ODtaWKmp7ulBGd0epWvzQy1hi6rV29Nz73mIzjgkWvay+4V74VvjCgo1l1AxwBK2FRB6
         V22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xYnSIevbhNbhlaEfUVlQM5r+iKMh42FpHIsghlt6Qk=;
        b=pvde2adlTleIgf3PJJ+ABPZYKIDm3gyNBr1TdflrkX/3AbzPU09AKtANdCd2BdLLBT
         Wlney4OB3AsCgyhP4uBfGPVVualhElMEKSiD98Ee5PodisfgthTD4sznljuy7pjPdkPw
         xtbTeAEFjgdRN1Kl/fJHe40y5U54O2eeF1hLVTX0cnUnWTSuzDxCOel1OIU2tCLIjgOQ
         UjgVZGljCrJJPDVdSie9NVMac/M3yrwV9GcXWwqMA9wCe/RPD523KG0Nf8gLrWtK0j6U
         dEy0Rupkf2on6Q6Ugx55VqYdO4kAEcK5wOUWw3tR6KW7L/dZZViBKJyc1IYHfwLxLETw
         bt3A==
X-Gm-Message-State: ANhLgQ288oa7WLgU6ylEn2B2CNxojkNmtE4420QvHMX76kZKHczcFV+a
        TzunJZry8fYYWYuvyoYYrl6xI8YxhCYie9MbmIE=
X-Google-Smtp-Source: ADFU+vtllWzzPtPE+oKkSoP/ygPrDGwzNVO51dEi3XGB68042PTzFrzlKSCf0KkOszs+u9ju2VEV1cKgx0LecYxGd44=
X-Received: by 2002:a19:c1d2:: with SMTP id r201mr2496625lff.13.1584528894126;
 Wed, 18 Mar 2020 03:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200318105049.19623-1-zhang.lyra@gmail.com> <20200318105049.19623-2-zhang.lyra@gmail.com>
In-Reply-To: <20200318105049.19623-2-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 18 Mar 2020 18:54:42 +0800
Message-ID: <CADBw62oxwX5QYLKPCD61hLk8c7WhnV6MUEFWXxYUq-YH3tHgAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] serial: sprd: getting port index via serial
 aliases only
To:     Chunyan Zhang <zhang.lyra@gmail.com>
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

On Wed, Mar 18, 2020 at 6:51 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> This patch simplifies the process of getting serial port number, with
> this patch, serial devices must have aliases configured in devicetree.
>
> The serial port searched out via sprd_port array maybe wrong if we don't
> have serial alias defined in devicetree, and specify console with command
> line, we would get the wrong port number if other serial ports probe
> failed before console's. So using aliases is mandatory.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Looks good to me.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 36 +++++---------------------------
>  1 file changed, 5 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 914862844790..e9d148d47bec 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1102,29 +1102,6 @@ static struct uart_driver sprd_uart_driver = {
>         .cons = SPRD_CONSOLE,
>  };
>
> -static int sprd_probe_dt_alias(int index, struct device *dev)
> -{
> -       struct device_node *np;
> -       int ret = index;
> -
> -       if (!IS_ENABLED(CONFIG_OF))
> -               return ret;
> -
> -       np = dev->of_node;
> -       if (!np)
> -               return ret;
> -
> -       ret = of_alias_get_id(np, "serial");
> -       if (ret < 0)
> -               ret = index;
> -       else if (ret >= ARRAY_SIZE(sprd_port) || sprd_port[ret] != NULL) {
> -               dev_warn(dev, "requested serial port %d not available.\n", ret);
> -               ret = index;
> -       }
> -
> -       return ret;
> -}
> -
>  static int sprd_remove(struct platform_device *dev)
>  {
>         struct sprd_uart_port *sup = platform_get_drvdata(dev);
> @@ -1204,14 +1181,11 @@ static int sprd_probe(struct platform_device *pdev)
>         int index;
>         int ret;
>
> -       for (index = 0; index < ARRAY_SIZE(sprd_port); index++)
> -               if (sprd_port[index] == NULL)
> -                       break;
> -
> -       if (index == ARRAY_SIZE(sprd_port))
> -               return -EBUSY;
> -
> -       index = sprd_probe_dt_alias(index, &pdev->dev);
> +       index = of_alias_get_id(pdev->dev.of_node, "serial");
> +       if (index < 0 || index >= ARRAY_SIZE(sprd_port)) {
> +               dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
> +               return -EINVAL;
> +       }
>
>         sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
>                                         GFP_KERNEL);
> --
> 2.20.1
>


-- 
Baolin Wang
