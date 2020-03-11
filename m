Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66377C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 02:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB25208C3
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 02:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iHJbBStr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgCKCZR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 22:25:17 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38766 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgCKCZR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 22:25:17 -0400
Received: by mail-vs1-f66.google.com with SMTP id k26so352584vso.5
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6o9zvEt6IYrwE+ElnVDn48jnHKonftzRMbou+m4VFt4=;
        b=iHJbBStrT5lCa9wZXnmyeoPZDOfvkfGvFnrSpTnUNDpI8FHGkaSafTKOZRZv+o4uFD
         jxW1iNcwui6ka32A8R1FnFHB89096I16to1pL+OZScW0nm+K1MgkyN6OL1d1Kr2U6jOe
         KGkPOgmwUDwrPWOx4HIWvUDc4byDfuMvq2Vok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6o9zvEt6IYrwE+ElnVDn48jnHKonftzRMbou+m4VFt4=;
        b=frK2AXnFt5zJ590qwF2lTsJZ4UdpWcmLKIhR0WaPeVV3pVM8mGlrng9/lC0cjQNRLX
         sna2bLwxLtCoiQ+OiZGBOkYxzq9MOS5eDfRGIwO0ZLkiNUP8t7MgS5xu6Rn7Ne1AHBlE
         hIO/fBG/nZlQ+Qj32I6i4k/Y8HCQcJ5j/QtOUiTGHdUPjwgA3DTcBOpwI2dziewP96r+
         FNt2O8w1u/Ek+0pS4wDImCDnj6g8ZcnmvmLjtjYAW+6Navz+p6V5eAMdUAPExn4fjagT
         ctUdv3LcFG30EesZRtRJdxZxRpw0OtYb2BtF2cfxPah4Dn8cyWo0dbiWfECUafknEDoT
         NrPA==
X-Gm-Message-State: ANhLgQ0Hv4xw207aoVmV6IFMjTA65sZlvK5HpYms+9HUYXrGiPirkfRJ
        q9enh4d5u6N0weIeLYm2W8M/lXDOEuDAEUhll3H3nQ==
X-Google-Smtp-Source: ADFU+vtp5uLMl3WlytXh2yLahHytv4h0LV7sRnFZjXVDDtC6hDZ6kgnPVr90KVcnWc7bMzZnT4KXS33RQ5WJ6PjFIdU=
X-Received: by 2002:a67:fe05:: with SMTP id l5mr620139vsr.186.1583893515541;
 Tue, 10 Mar 2020 19:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <1582707225-26815-1-git-send-email-changqi.hu@mediatek.com>
In-Reply-To: <1582707225-26815-1-git-send-email-changqi.hu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 11 Mar 2020 10:25:04 +0800
Message-ID: <CANMq1KBE4kn-VamAMh71rLecy6VAE=66_4brTf811VrTcc4obg@mail.gmail.com>
Subject: Re: [PATCH v4] serial: 8250-mtk: modify mtk uart power and clock management
To:     Changqi Hu <changqi.hu@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Claire Chang <tientzu@chromium.org>,
        linux-serial@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 26, 2020 at 4:54 PM Changqi Hu <changqi.hu@mediatek.com> wrote:
>
> MTK uart design no need to control uart clock,
> so we just control bus clock in runtime function.
> Add uart clock used count to avoid repeatedly switching the clock.

This patch does a lot more than that:
 - Adds a busy loop in mtk8250_runtime_suspend
 - Changes how you do pm_runtime stuff.

These probably need to be split to different patches, and can you
please describe why you are making those changes in the commit
message?

> Signed-off-by: Changqi Hu <changqi.hu@mediatek.com>
> ---
>
> Changes in v4:
>  Modify commit-message
>
> Changes in v3:
>  Merge patch v1 and v2 together.
>
> Changes in v2:
>  Enable uart bus clock when probe and resume base on v1 patch,
>  but miss v1 patch itself.
>
>  drivers/tty/serial/8250/8250_mtk.c | 50 ++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 4d067f5..f839380 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -32,6 +32,7 @@
>  #define MTK_UART_RXTRI_AD      0x14    /* RX Trigger address */
>  #define MTK_UART_FRACDIV_L     0x15    /* Fractional divider LSB address */
>  #define MTK_UART_FRACDIV_M     0x16    /* Fractional divider MSB address */
> +#define MTK_UART_DEBUG0        0x18
>  #define MTK_UART_IER_XOFFI     0x20    /* Enable XOFF character interrupt */
>  #define MTK_UART_IER_RTSI      0x40    /* Enable RTS Modem status interrupt */
>  #define MTK_UART_IER_CTSI      0x80    /* Enable CTS Modem status interrupt */
> @@ -388,9 +389,18 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>  static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
>  {
>         struct mtk8250_data *data = dev_get_drvdata(dev);
> +       struct uart_8250_port *up = serial8250_get_port(data->line);
>
> -       clk_disable_unprepare(data->uart_clk);
> -       clk_disable_unprepare(data->bus_clk);
> +       /* wait until UART in idle status */
> +       while
> +               (serial_in(up, MTK_UART_DEBUG0));

No timeout?

> +
> +       if (data->clk_count == 0U) {
> +               dev_dbg(dev, "%s clock count is 0\n", __func__);
> +       } else {
> +               clk_disable_unprepare(data->bus_clk);
> +               data->clk_count--;
> +       }

The clock core already does reference counting for you, so I don't
think you need this.
https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk.c#L1004

>
>         return 0;
>  }
> @@ -400,16 +410,16 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
>         struct mtk8250_data *data = dev_get_drvdata(dev);
>         int err;
>
> -       err = clk_prepare_enable(data->uart_clk);
> -       if (err) {
> -               dev_warn(dev, "Can't enable clock\n");
> -               return err;
> -       }
> -
> -       err = clk_prepare_enable(data->bus_clk);
> -       if (err) {
> -               dev_warn(dev, "Can't enable bus clock\n");
> -               return err;
> +       if (data->clk_count > 0U) {
> +               dev_dbg(dev, "%s clock count is %d\n", __func__,
> +                       data->clk_count);
> +       } else {
> +               err = clk_prepare_enable(data->bus_clk);
> +               if (err) {
> +                       dev_warn(dev, "Can't enable bus clock\n");
> +                       return err;
> +               }
> +               data->clk_count++;
>         }
>
>         return 0;
> @@ -419,12 +429,14 @@ static void
>  mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
>  {
>         if (!state)
> -               pm_runtime_get_sync(port->dev);
> +               if (!mtk8250_runtime_resume(port->dev))
> +                       pm_runtime_get_sync(port->dev);
>
>         serial8250_do_pm(port, state, old);
>
>         if (state)
> -               pm_runtime_put_sync_suspend(port->dev);
> +               if (!pm_runtime_put_sync_suspend(port->dev))
> +                       mtk8250_runtime_suspend(port->dev);
>  }
>
>  #ifdef CONFIG_SERIAL_8250_DMA
> @@ -501,6 +513,8 @@ static int mtk8250_probe(struct platform_device *pdev)
>         if (!data)
>                 return -ENOMEM;
>
> +       data->clk_count = 0;
> +
>         if (pdev->dev.of_node) {
>                 err = mtk8250_probe_of(pdev, &uart.port, data);
>                 if (err)
> @@ -533,6 +547,7 @@ static int mtk8250_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, data);
>
> +       pm_runtime_enable(&pdev->dev);
>         err = mtk8250_runtime_resume(&pdev->dev);
>         if (err)
>                 return err;
> @@ -541,9 +556,6 @@ static int mtk8250_probe(struct platform_device *pdev)
>         if (data->line < 0)
>                 return data->line;
>
> -       pm_runtime_set_active(&pdev->dev);
> -       pm_runtime_enable(&pdev->dev);
> -
>         data->rx_wakeup_irq = platform_get_irq_optional(pdev, 1);
>
>         return 0;
> @@ -556,11 +568,13 @@ static int mtk8250_remove(struct platform_device *pdev)
>         pm_runtime_get_sync(&pdev->dev);
>
>         serial8250_unregister_port(data->line);
> -       mtk8250_runtime_suspend(&pdev->dev);
>
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
> +       if (!pm_runtime_status_suspended(&pdev->dev))
> +               mtk8250_runtime_suspend(&pdev->dev);
> +
>         return 0;
>  }
>
> --
> 2.6.4
