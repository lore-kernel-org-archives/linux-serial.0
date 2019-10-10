Return-Path: <SRS0=h7F0=YD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51226C10F14
	for <linux-serial@archiver.kernel.org>; Thu, 10 Oct 2019 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288C1214E0
	for <linux-serial@archiver.kernel.org>; Thu, 10 Oct 2019 14:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCQusiDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfJJOZW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:25:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJJOZW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Oct 2019 10:25:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so4008990pfh.8
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2019 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=YAcuX9sdYOddUPgFNugc5Dj+a9XzYn2J9DA/qBs9moA=;
        b=kCQusiDpXLFqPztUgrKD36WQ2tqWdsow+SYKMnfNNazMyEFA4NpOC7riHKCLi6vLEW
         2LOTFQtt89ARZVd0OfUR6tDysoN73HA+ZAR4DoH0WaNXJUJ4B95q5Etxyoug06o1qIJX
         +Tab4oP8YqmdfgxrpTKDOir48GdkuaZa9cdj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=YAcuX9sdYOddUPgFNugc5Dj+a9XzYn2J9DA/qBs9moA=;
        b=V/3j+usZwArhlkTtU5O1ZB7qN/IEzY9q/ZmWDYdq9LS+w5k8BwWQHrwpJqQB2aTpQG
         z0cDhKfrHsS7uVvz1JH3i4uz7fSIukCfvklWP4t/KGzXvA/U/e42CS/2EHELWQeIfKI8
         scZKqDJbKqSs5DqOx0YrQfRlgDtSWCbI0dXkjJ9gv4mKncBCGEgGJxUZMTE4JN7Rs3Rc
         Ki5kyMBWKTw3+AGPCfaOVJABiblEKgXEEjU1YCxd2tKQ6SpyUEbDCcCzWQwa6S9EmBaV
         gNFTBQXWl06AH5pkrgiaMg7n8c4aYSEYnDnn4ZSR9Gq6J9nDXJbAIcrwi0SZ2HBuM2mz
         58MQ==
X-Gm-Message-State: APjAAAXEAwkgHUt1QKC9CPRKp41qUNZV6u4L6j9fZ0eVgvp+H9HWfBjT
        OMyDUb7NWFQWu3aREx+vw2mb7w==
X-Google-Smtp-Source: APXvYqyMxxvMlXGdvXkq0FvqPJxREczTm3WwKvf3Usyb8IoOIIKQFlLZC3zO6iUoypX0NHIakZBlew==
X-Received: by 2002:a17:90a:bb0a:: with SMTP id u10mr12007008pjr.14.1570717520153;
        Thu, 10 Oct 2019 07:25:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f14sm9577813pfq.187.2019.10.10.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 07:25:19 -0700 (PDT)
Message-ID: <5d9f3f4f.1c69fb81.5120f.b90e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1570700803-17566-1-git-send-email-akashast@codeaurora.org>
References: <1570700803-17566-1-git-send-email-akashast@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, bjorn.andersson@linaro.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 2/2] tty: serial: qcom_geni_serial: Wakeup over UART RX
User-Agent: alot/0.8.1
Date:   Thu, 10 Oct 2019 07:25:18 -0700
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-10-10 02:46:43)
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 5180cd8..ff63728 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1306,6 +1317,29 @@ static int qcom_geni_serial_probe(struct platform_=
device *pdev)
>                 return ret;
>         }
> =20
> +       if (!console) {
> +               port->wakeup_irq =3D platform_get_irq(pdev, 1);

Should use platform_get_irq_optional() it seems.

> +               if (port->wakeup_irq < 0) {
> +                       dev_err(&pdev->dev, "Failed to get wakeup IRQ %d\=
n",
> +                                       port->wakeup_irq);
> +               } else {
> +                       irq_set_status_flags(port->wakeup_irq, IRQ_NOAUTO=
EN);
> +                       ret =3D devm_request_irq(uport->dev, port->wakeup=
_irq,
> +                               qcom_geni_serial_wakeup_isr,
> +                               IRQF_TRIGGER_FALLING, "uart_wakeup", upor=
t);
> +                       if (ret) {
> +                               dev_err(uport->dev, "Failed to register w=
akeup IRQ ret %d\n",
> +                                               ret);
> +                               return ret;
> +                       }
> +
> +                       device_init_wakeup(&pdev->dev, true);
> +                       ret =3D dev_pm_set_wake_irq(&pdev->dev, port->wak=
eup_irq);

Why can't we use dev_pm_set_dedicated_wake_irq() here?

> +                       if (unlikely(ret))
> +                               dev_err(uport->dev, "%s:Failed to set IRQ=
 wake:%d\n",
> +                                               __func__, ret);
> +               }
> +       }
>         uport->private_data =3D drv;
>         platform_set_drvdata(pdev, port);
>         port->handle_rx =3D console ? handle_rx_console : handle_rx_uart;
> @@ -1328,7 +1362,12 @@ static int __maybe_unused qcom_geni_serial_sys_sus=
pend(struct device *dev)
>         struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
>         struct uart_port *uport =3D &port->uport;
> =20
> -       return uart_suspend_port(uport->private_data, uport);
> +       uart_suspend_port(uport->private_data, uport);
> +
> +       if (port->wakeup_irq > 0)
> +               enable_irq(port->wakeup_irq);
> +

Then this is hopefully done automatically?

> +       return 0;
>  }
> =20
>  static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
