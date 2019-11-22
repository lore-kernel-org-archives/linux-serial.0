Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E769C432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0C2068F
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZK5vufmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKVSWv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:22:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43409 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVSWu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 13:22:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id 3so3837757pfb.10
        for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2019 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=QO/pxZNRQHl3Qo/n2ceXv96kjzOvi8W+JyZM4+1PLSg=;
        b=ZK5vufmDalcHrG0n+TiAVvpySwmhneQu6Uhn+V1lN1pTnn+oK0iVC4veifFP0e5yv4
         ItOIjcNrbro+Nb1XSso2WyO1P6uOF6fofJvMOQ3H9S7DR70ZsXFp+hwcaT9W07yzstAK
         7BRJeB2b4G4EY1uC+SifxJ1TOUGeonhylxdo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=QO/pxZNRQHl3Qo/n2ceXv96kjzOvi8W+JyZM4+1PLSg=;
        b=ZrRiA59I0+xtvnCArv8GpyEynELdha+9OujG1nuTB4Tv1SWVewAlozbTxs9AzFUaJQ
         5AE488JkTV+8nTNMm9T1TYkCcm1xPyWLOe9zhXcNc2QGw3BhiVHSETDhh3PMeRd5lIUN
         N3V/W2RsZ18BwBOyij0sV8YXthNofwI8hbOZ5DrrsCXp/T2YBcnOqTBoGxmWOLIJqyru
         FskI5SiGFaQd794dnJo15ukRPYTvqzReW+DbQIgYKXRdGZzdkAfdTr0u1CWZOxlV9sud
         0IbQwJ84Yetvmk6S8wmrKQPv0bNK6t7EbU69nBjLsitzoNu1eP5OwmobPHekKRNx6CIh
         qONA==
X-Gm-Message-State: APjAAAWnhSZipb9D0qYjICQca0ejA/e2TtXkVZImQdnikp6+VW5qKdjI
        ZWbrYZrzAl3xVswuiNRE5Kjnng==
X-Google-Smtp-Source: APXvYqwAqwt6xENnn01835Nc7UcTVS401B+p8Mxy8RIewsuVXuee9EswcADVgrtT8miyldbW01XWLg==
X-Received: by 2002:a63:ff0b:: with SMTP id k11mr18061258pgi.274.1574446969779;
        Fri, 22 Nov 2019 10:22:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b1sm3526572pjw.19.2019.11.22.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:22:49 -0800 (PST)
Message-ID: <5dd82779.1c69fb81.c1de1.90e5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016e937a5b83-1c5c4e0e-ae63-447a-8724-52477b11dff4-000000@us-west-2.amazonses.com>
References: <1574432266-20732-1-git-send-email-akashast@codeaurora.org> <0101016e937a5b83-1c5c4e0e-ae63-447a-8724-52477b11dff4-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v6 4/5] tty: serial: qcom_geni_serial: Wakeup over UART RX
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Fri, 22 Nov 2019 10:22:48 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-22 06:18:19)
> Add system wakeup capability over UART RX line for wakeup capable UART.
> When system is suspended, RX line act as an interrupt to wakeup system
> for any communication requests from peer.
>=20
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

One question below.

> @@ -1330,6 +1354,10 @@ static int qcom_geni_serial_remove(struct platform=
_device *pdev)
>         struct uart_driver *drv =3D port->uport.private_data;
> =20
>         uart_remove_one_port(drv, &port->uport);
> +
> +       device_init_wakeup(&pdev->dev, false);
> +       dev_pm_clear_wake_irq(&pdev->dev);

Should this order be swapped? Usually remove is done in reverse of probe
order, so clear_wake_irq, init wakeup, and remove uart port. I'm not
convinced it will actually matter though so maybe this isn't a problem.

