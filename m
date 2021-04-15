Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77005C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489BE61153
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 10:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhDOKrR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhDOKrR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 06:47:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A001C061574;
        Thu, 15 Apr 2021 03:46:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u15so3276260plf.10;
        Thu, 15 Apr 2021 03:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oV4yvPzBl+8JFQ4FMZmRE08ppy67MX2UmEYPl8EhO50=;
        b=SyCpLMrBzeb3fwLhDpa8qxrbb//VUgy89Xbxe2C1+tWhCS9enUHbulLBHkcU6OX0y6
         aHxwV87N38c/JoUPRfl6OhhKdhUVhou/52XznXoo8Bx5Tu22pxYcEqRVukZs1IfA2tDd
         lNgirBp+nJPByNqRfO3W2SBS7jyrvI42Y0qbt8PZUL0CXTRAX+Fx3snanIKBTDexZDsV
         JMY4U2CzQt/F7Xgchoi+hcCzI8t+w7vHQgYlQ3PdPAtg6af3Otr+yAA5x94ts4Y1VodI
         7d73jN58s11sK0a6XN+8Ktwxv3EtNqBChHGjI1PBxgR5BmasC3dTi9SFfUzyAvZE1dIV
         9Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oV4yvPzBl+8JFQ4FMZmRE08ppy67MX2UmEYPl8EhO50=;
        b=Fq5o1UWfdxpF1762POLCJd1t/b/5zKhCwkWSvoxHUlDrht0BYQcF2wkL2yyd0aEZE+
         hGk5HR5GniWqSCF7t7O4msRId6cah/zcI0M9Brxd9Yy5hle9624Jah5l+SektASHEjkG
         rg0kebCaoYGpsf6eutA3BSWbSgNh+sOXVvjgWrpPwT3TsXT7xpvgTjshKgm0RT8DMNBA
         FQB8Athrb3slCr9zZkPmWfSB3jBkiDPOfGUefmWFsvijr2S9Ww1QLJTJoylsxIaL4WXe
         TPvVVDMgvJwuckCWo8PaRyTFuG9TrHvdsouKc1WTYJAbwjq026vybMysWjyoQOcBHTqr
         shmQ==
X-Gm-Message-State: AOAM532vTnG0H5GHpbZBIVMOr29sb5o3OZ4WNrbSBV/gL3fV7Tiumn12
        NXSbNZ/Stkw3GWiJIwoliGr7sQEkstNstY1XUs0=
X-Google-Smtp-Source: ABdhPJyJC4pTKN9cWqu158fTl9rbPrgh93CK4doD8LtZU92In9K69g4pbH9tiEeOcHlzTrh7Q8t7v8WNh6iO49fyHSo=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr3246929plc.0.1618483613936; Thu, 15 Apr
 2021 03:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210412034712.16778-1-zev@bewilderbeest.net> <20210412034712.16778-4-zev@bewilderbeest.net>
In-Reply-To: <20210412034712.16778-4-zev@bewilderbeest.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Apr 2021 13:46:37 +0300
Message-ID: <CAHp75VfCKRn+ER4bKf+PLhXHT0yZeN4JDufxfROa4UMf=Bc6bQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] serial: 8250_aspeed_vuart: add aspeed,lpc-io-reg
 and aspeed,lpc-interrupts DT properties
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 12, 2021 at 7:05 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> These allow describing all the Aspeed VUART attributes currently
> available via sysfs.  aspeed,lpc-interrupts provides a replacement for
> the deprecated aspeed,sirq-polarity-sense property.

One nit-pick below.

In any case it's fine.

> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 51 ++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 8433f8dbb186..3c239d98747f 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -28,6 +28,10 @@
>  #define ASPEED_VUART_ADDRL             0x28
>  #define ASPEED_VUART_ADDRH             0x2c
>
> +#define ASPEED_VUART_DEFAULT_LPC_ADDR  0x3f8
> +#define ASPEED_VUART_DEFAULT_SIRQ      4
> +#define ASPEED_VUART_DEFAULT_SIRQ_POLARITY     IRQ_TYPE_LEVEL_LOW
> +
>  struct aspeed_vuart {
>         struct device           *dev;
>         void __iomem            *regs;
> @@ -386,6 +390,18 @@ static void aspeed_vuart_auto_configure_sirq_polarity(
>         aspeed_vuart_set_sirq_polarity(vuart, (value & reg_mask) == 0);
>  }
>
> +static int aspeed_vuart_map_irq_polarity(u32 dt)
> +{
> +       switch (dt) {
> +       case IRQ_TYPE_LEVEL_LOW:
> +               return 0;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               return 1;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int aspeed_vuart_probe(struct platform_device *pdev)
>  {
>         struct of_phandle_args sirq_polarity_sense_args;
> @@ -393,8 +409,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>         struct aspeed_vuart *vuart;
>         struct device_node *np;
>         struct resource *res;
> -       u32 clk, prop;
> -       int rc;
> +       u32 clk, prop, sirq[2];
> +       int rc, sirq_polarity;
>
>         np = pdev->dev.of_node;
>
> @@ -501,6 +517,37 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>                 of_node_put(sirq_polarity_sense_args.np);
>         }
>
> +       rc = of_property_read_u32(np, "aspeed,lpc-io-reg", &prop);
> +       if (rc < 0)
> +               prop = ASPEED_VUART_DEFAULT_LPC_ADDR;
> +
> +       rc = aspeed_vuart_set_lpc_address(vuart, prop);
> +       if (rc < 0) {
> +               dev_err(&pdev->dev, "invalid value in aspeed,lpc-io-reg property\n");
> +               goto err_clk_disable;
> +       }
> +
> +       rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
> +       if (rc < 0) {
> +               sirq[0] = ASPEED_VUART_DEFAULT_SIRQ;
> +               sirq[1] = ASPEED_VUART_DEFAULT_SIRQ_POLARITY;
> +       }
> +
> +       rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
> +       if (rc < 0) {
> +               dev_err(&pdev->dev, "invalid sirq number in aspeed,lpc-interrupts property\n");
> +               goto err_clk_disable;
> +       }
> +
> +       sirq_polarity = aspeed_vuart_map_irq_polarity(sirq[1]);
> +       if (sirq_polarity < 0) {
> +               dev_err(&pdev->dev, "invalid sirq polarity in aspeed,lpc-interrupts property\n");

> +               rc = sirq_polarity;
> +               goto err_clk_disable;
> +       }

Why not to use the same pattern as above, i.e.

       rc = aspeed_vuart_map_irq_polarity(sirq[1]);
       if (rc < 0) {
               dev_err(&pdev->dev, "invalid sirq polarity in
aspeed,lpc-interrupts property\n");
               goto err_clk_disable;
       }
       sirq_polarity = rc;

?

> +       aspeed_vuart_set_sirq_polarity(vuart, sirq_polarity);
> +
>         aspeed_vuart_set_enabled(vuart, true);
>         aspeed_vuart_set_host_tx_discard(vuart, true);
>         platform_set_drvdata(pdev, vuart);


-- 
With Best Regards,
Andy Shevchenko
