Return-Path: <SRS0=h7F0=YD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A4C10F14
	for <linux-serial@archiver.kernel.org>; Thu, 10 Oct 2019 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FA320B7C
	for <linux-serial@archiver.kernel.org>; Thu, 10 Oct 2019 14:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SPBQw/gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfJJOTj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:19:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41568 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfJJOTj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Oct 2019 10:19:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so3997804pfh.8
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2019 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=Vc0Op+2XXi9qqSr1cgopFMg1Ji4quSb7jKDmcOqTucc=;
        b=SPBQw/gKsxCWYeSfzVUZnPfWLQPwwGYwoez6jizU3S/GiP5Ex3o7xBmgn7rLkOgNUM
         i52Lyk4vr+jSDeRQnOtXL8mBrMOkwsroOEKNJGsibyF0iVtB7Ev4Md/Ui0PlAoTEcxRo
         Bs0Q502JcbzimSZzRhbtl0jnD767Z9ukhW3yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=Vc0Op+2XXi9qqSr1cgopFMg1Ji4quSb7jKDmcOqTucc=;
        b=QQ5i0qFTPFr/XRECAVuMBSCvGWS4VCPk+8rAFR92jgck9779IhqyqTwCNkUVuxnyLI
         Z8SP/c7H7i3jejwLUuUpVbeM1ONpsxr9x9/90i6uTMrkCrlMjOsuVnhFgoxd6hhiz5k0
         bQDj0ihsnEXLU2rTRuj2xpBSGgVEy3bWw4U6IRms4lpMLC/+sdThff7V+ZPs8XFhDhXo
         pK+/9KNkdjgZ12NJw22/DYXLBbtIpJ06E4cxE+d4w4IgYybojN9vNFOZKhQAyQTtQjux
         fLVJwhy15drQskEZH0kpSOxHpe5olyEQt7BolL6w+Vd9LKqr9BhfAuH4J0S1JVHEc/GT
         c7pw==
X-Gm-Message-State: APjAAAXHhF8ZVVvLxKHdIZ/FN+zFv1HwepGF9z7SeCoiHBIumGC1H6/A
        ruIS3R9xsHq3jcd7UY+H3IQvEQ==
X-Google-Smtp-Source: APXvYqzNVgo7MCrZFWrruov4wjonCct9rl5v9+n6GCVglexqUTYjJZs6lcifdtyRpRYffCMk+ykFmg==
X-Received: by 2002:a65:62d2:: with SMTP id m18mr11160172pgv.117.1570717178731;
        Thu, 10 Oct 2019 07:19:38 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l6sm5619583pje.28.2019.10.10.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 07:19:38 -0700 (PDT)
Message-ID: <5d9f3dfa.1c69fb81.84c4b.30bf@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1570700763-17319-1-git-send-email-akashast@codeaurora.org>
References: <1570700763-17319-1-git-send-email-akashast@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, bjorn.andersson@linaro.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 1/2] tty: serial: qcom_geni_serial: IRQ cleanup
User-Agent: alot/0.8.1
Date:   Thu, 10 Oct 2019 07:19:37 -0700
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-10-10 02:46:03)
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 14c6306..5180cd8 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1297,11 +1291,21 @@ static int qcom_geni_serial_probe(struct platform=
_device *pdev)
>         port->rx_fifo_depth =3D DEF_FIFO_DEPTH_WORDS;
>         port->tx_fifo_width =3D DEF_FIFO_WIDTH_BITS;
> =20
> +       scnprintf(port->name, sizeof(port->name), "qcom_geni_serial_%s%d",
> +               (uart_console(uport) ? "console" : "uart"), uport->line);

Drop useless parenthesis. Also, it might make more sense to make this a
devm_kasprintf() call now.

>         irq =3D platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
>         uport->irq =3D irq;
> =20
> +       irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);

Is there a reason why we can't always leave the irq enabled and request
it later once the uart structure has been fully initialized?

> +       ret =3D devm_request_irq(uport->dev, uport->irq, qcom_geni_serial=
_isr,
> +                       IRQF_TRIGGER_HIGH, port->name, uport);
> +       if (ret) {
> +               dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
> +               return ret;
> +       }
> +
>         uport->private_data =3D drv;
>         platform_set_drvdata(pdev, port);
>         port->handle_rx =3D console ? handle_rx_console : handle_rx_uart;
