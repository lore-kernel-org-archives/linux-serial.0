Return-Path: <SRS0=2UiA=ZG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC97C43215
	for <linux-serial@archiver.kernel.org>; Thu, 14 Nov 2019 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E726B2070E
	for <linux-serial@archiver.kernel.org>; Thu, 14 Nov 2019 17:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MUEXmgHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKNRks (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:40:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38337 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNRks (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Nov 2019 12:40:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so4725423pfp.5
        for <linux-serial@vger.kernel.org>; Thu, 14 Nov 2019 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:subject:to:user-agent:date;
        bh=BG4N3ZJy8QM1GTK7zwnsKQC3CcH+E5Rq/8uokPmQ3VU=;
        b=MUEXmgHb+I2XoY4p1O0wZ5ncgFwmZaBpjLqBzoczGC4bAsVoK1QfGaOLOL/rd7NVuV
         zx6cJ9PW930V4k9q3ZL2xAa86tNQ831rwD4y/BD8xDV60NoJ755PoUqFQLgxgrTz0DTn
         GtAB/2oVhjHzA7OuISc0NuUEh9v0MCCDi8QxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:subject:to
         :user-agent:date;
        bh=BG4N3ZJy8QM1GTK7zwnsKQC3CcH+E5Rq/8uokPmQ3VU=;
        b=c8hezGlvdVekMF1R7xUjFJK9a2fPHS5IEGhBR8YHaHCJkOQy/Th7+xQzQ2LhemOGT9
         N6nHvjVbLNVHP8Y6mgkbTUvy8ZZbBx/JU31iJgrqydKK6oUsL0Zxb9OTB7zHf/Kwmjzf
         EMJ+IRERJ7BraiLEQvKg3jEtj/tzcf9UXw/aGrt1HqmWZKumc27C8qL0NNNnx5oBpO8l
         mMrZqfZ/Bygn+n0UQvLW6TkESeKWPAANIl+wNzOKB+twAG4w7Xf/K2MKR4IpkNLR1YoI
         AbDJAz0fS4eqHE/g4qZCUrHWIpElw3flTyvGEpntmsKlS9W9pkp8TMlDMZR6w+bfN8KB
         dKeA==
X-Gm-Message-State: APjAAAW9qbtc0G9OdosMh56kc9pO7pKBt068FJcprjaof7xeL/Z3a3/b
        d1gxPt+sDCMRUbytqFO2YnfghA==
X-Google-Smtp-Source: APXvYqwGwpEkUJhyA7vGnWF8+iNWK6lc1W1AnQdEc2FA1gHsW8pFTWM8tPTQKG1RfOtLEhsUb/thRQ==
X-Received: by 2002:a63:4e5e:: with SMTP id o30mr11958597pgl.112.1573753246140;
        Thu, 14 Nov 2019 09:40:46 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y12sm6933105pjy.0.2019.11.14.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 09:40:45 -0800 (PST)
Message-ID: <5dcd919d.1c69fb81.1c304.2dc5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573642136-30488-1-git-send-email-akashast@codeaurora.org>
References: <1573642136-30488-1-git-send-email-akashast@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, msavaliy@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v5 2/3] tty: serial: qcom_geni_serial: Wakeup over UART RX
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Thu, 14 Nov 2019 09:40:44 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-13 02:48:56)
> Add system wakeup capability over UART RX line for wakeup capable UART.
> When system is suspended, RX line act as an interrupt to wakeup system
> for any communication requests from peer.

How does the RX line get remuxed as a GPIO interrupt here? Is that
through some pinctrl magic in DT or just via enabling/disabling the
interrupt?

>=20
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 634054a..56dad67 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1321,6 +1327,23 @@ static int qcom_geni_serial_probe(struct platform_=
device *pdev)
>                 return ret;
>         }
> =20
> +       if (port->wakeup_irq > 0) {
> +               /*
> +                * Set pm_runtime status as ACTIVE so that wakeup_irq gets
> +                * enabled/disabled from dev_pm_arm_wake_irq  during  sys=
tem
> +                * suspend/resume respectively.
> +                */
> +               pm_runtime_set_active(&pdev->dev);

We can always set this device as active regardless of wakeup interrupt,
right? Can we move this call outside of this if?

> +               device_init_wakeup(&pdev->dev, true);
> +               ret =3D dev_pm_set_dedicated_wake_irq(&pdev->dev,
> +                                               port->wakeup_irq);
> +               if (ret) {
> +                       device_init_wakeup(&pdev->dev, false);
> +                       uart_remove_one_port(drv, uport);
> +                       return ret;
> +               }
> +       }
> +
>         return ret;
>  }
> =20
