Return-Path: <SRS0=2UiA=ZG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBC2C432C3
	for <linux-serial@archiver.kernel.org>; Thu, 14 Nov 2019 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB91205C9
	for <linux-serial@archiver.kernel.org>; Thu, 14 Nov 2019 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g80wO05/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKNRgi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:36:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36404 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfKNRgi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Nov 2019 12:36:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id d7so2928537pls.3
        for <linux-serial@vger.kernel.org>; Thu, 14 Nov 2019 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:subject:to:user-agent:date;
        bh=C6YP6a5qaQZIPYsi+5V8cI3C9omvPfi1Xs6RxG615gE=;
        b=g80wO05/V1QnUyEPrXevIPKGCUs0gl81OsgscFqoJh8MJk38dzhMsUyZYyV11xC+zR
         95aneAPJNR1Mow8cIT7r20ItAnxRlvlA0UPxr4lR/k3agU26LKOi6SAqED+8CIX4uDOK
         n5/Y49376nXCYndXL7xwNjvzPyglvSRZy9RNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:subject:to
         :user-agent:date;
        bh=C6YP6a5qaQZIPYsi+5V8cI3C9omvPfi1Xs6RxG615gE=;
        b=AnrAIRu5jpsJlOGM70Roh7bjaNKAmIGF/18AR4WvZ1Y4IvA/qEvXrJL4iSxB2h6JxT
         IBpQpfLgA9NvLNy7HIiRIVTjq3AAK+PC1A/rsvUiKispLRoitWosPdyCb4pWAjN+UUL9
         gNeIcz8Am2y91QIcquPvgEFIeTIr6iRrofA7zEzeV32QGtHdjgdJL8ggFCOmtS726hW+
         LhUH0nc+2Vr5+lqaw22O0K9Fc6iYkR2xTPoMgV1uzSqDIenXWh/EafxSimrsuMA/6TwV
         /pN9/qJehJ5p5KpqyVI3LnGOu5EKe95GawrQu7adE1FEXESiN0b1wPWoovm64bY2YC1S
         Etzw==
X-Gm-Message-State: APjAAAXhwKngfafsPqZDZzLuE8Nya/L9kMQVUzLUMBMqt58vkzMCRtwS
        Lc4aM5e1pyLwU4skz700Tm+lGA==
X-Google-Smtp-Source: APXvYqzde3guieFZj9+8mSsqy0440HPz5f29QmZ7BKL214xHYlzSXiamcCVgzJoQJMNpGAJl76WmWw==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr10751055pls.104.1573752997461;
        Thu, 14 Nov 2019 09:36:37 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 82sm7131673pfa.115.2019.11.14.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 09:36:36 -0800 (PST)
Message-ID: <5dcd90a4.1c69fb81.757a7.37e8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573642161-14189-1-git-send-email-akashast@codeaurora.org>
References: <1573642161-14189-1-git-send-email-akashast@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, msavaliy@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v5 3/3] tty: serial: qcom_geni_serial: Remove sysfs file
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Thu, 14 Nov 2019 09:36:36 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Please update the subject. This patch does more than remove the sysfs
file. "Move loopback support to TIOCM_LOOP"?

Quoting Akash Asthana (2019-11-13 02:49:21)
> Remove code from the driver that create and maintain loopback sysfs node.
> Instead use the ioctl TIOCMSET with TIOCM_LOOP argument to set HW to
> loopback mode.
>=20
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V5:
>  - As per Greg's and Stephen's comment on v4 patch, removed loopback sysfs
>    file related code.
>=20
>  drivers/tty/serial/qcom_geni_serial.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 56dad67..52f5ea2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -238,10 +214,14 @@ static void qcom_geni_serial_set_mctrl(struct uart_=
port *uport,
>                                                         unsigned int mctr=
l)
>  {
>         u32 uart_manual_rfr =3D 0;
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport, uport);
> =20
>         if (uart_console(uport))
>                 return;
> =20
> +       if (mctrl & TIOCM_LOOP)
> +               port->loopback =3D MAX_LOOPBACK_CFG;

How does this work? The loopback is supposed to be the max all the time
and not match some qup number or something?

