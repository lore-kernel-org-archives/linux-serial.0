Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B29C77B75
	for <linux-serial@archiver.kernel.org>; Fri,  5 May 2023 23:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEEXvS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 May 2023 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEEXvR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 May 2023 19:51:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334E59F1
        for <linux-serial@vger.kernel.org>; Fri,  5 May 2023 16:51:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso2698952e87.0
        for <linux-serial@vger.kernel.org>; Fri, 05 May 2023 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683330674; x=1685922674;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjqVzDbSdokuJC6mTOMnxxsNtmjmsehygGNPxKGCXGY=;
        b=hN2qCvmtLCe7wGeckPEGJDHXA6eSq/MigjzbBVVTNQzecbygZIBAGRj7TPE8Fan0xx
         Y3bUbJQn06wuCVpLSMTx89mJtF7bBAYOGz9SyjR17XmoWaiHJs2EKe+M8F+SNVY8p2sb
         R7GnNkkvfA51svet8Q+HqsRO1ldkLp9jAwTP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683330674; x=1685922674;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjqVzDbSdokuJC6mTOMnxxsNtmjmsehygGNPxKGCXGY=;
        b=Y9QTbL+P2Bto6I3vheu9JdnrKi8fXfNyf8evquE6tcd7OPyS0LPc5pnsLF3oHrsZXR
         jmazFCbDEpXrwt2AOfw554rY8kFB4NJFw7OQ3Q+ON/S9cXdvE8TG2z24RTQiLOpiUMan
         BUc5d1hVZFVjEQPs8zAkb3wm9FvcTlatr6M/7xEWNCc8G1TX9EX0ofs/hZnvX4vfweax
         TjGFluzccVNvdpiTMlo652Ur1QXJNKwS6OfCCvIY2jYdDT86cw/eqtEBCqHHElWTOAh4
         LesTygGZjeR4EOG29c+V5PKR3aGWBUmMj9RF55AjBfb3OkTJZzZm9hCOH1ZkL8j8E4nG
         D6FA==
X-Gm-Message-State: AC+VfDzqx+V2RdXw2VuIERpGd4ZCqst+udw8rSJI3UYh3ZgFDhtTLyze
        AhUQgCTYlxIdPuwJ9pSrrZWb3UupeoYgITl+2ew+/A==
X-Google-Smtp-Source: ACHHUZ5NZfYKYWBQrU0BEtZE7GYJKOY2rbcfUoPtPN7I+zGCcJekGogEeUwQD9Vt9dV7O7vzpBFyhQ+Drw3YQZHK5RY=
X-Received: by 2002:ac2:51b1:0:b0:4f1:4996:7e84 with SMTP id
 f17-20020ac251b1000000b004f149967e84mr839109lfk.34.1683330673904; Fri, 05 May
 2023 16:51:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 May 2023 18:51:13 -0500
MIME-Version: 1.0
In-Reply-To: <20230505152301.2181270-1-krzysztof.kozlowski@linaro.org>
References: <20230505152301.2181270-1-krzysztof.kozlowski@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 5 May 2023 18:51:13 -0500
Message-ID: <CAE-0n50jZ=EG29Gmr9zvjq0_qEXXSUBA+w65uE-P--+rxYGNiQ@mail.gmail.com>
Subject: Re: [PATCH] serial: qcom-geni: fix enabling deactivated interrupt
To:     Akash Asthana <akashast@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-05-05 08:23:01)
> The driver have a race, experienced only with PREEMPT_RT patchset:
>
> CPU0                         | CPU1
> ==================================================================
> qcom_geni_serial_probe       |
>   uart_add_one_port          |
>                              | serdev_drv_probe
>                              |   qca_serdev_probe
>                              |     serdev_device_open
>                              |       uart_open
>                              |         uart_startup
>                              |           qcom_geni_serial_startup
>                              |             enable_irq
>                              |               __irq_startup
>                              |                 WARN_ON()
>                              |                 IRQ not activated
>   request_threaded_irq       |
>     irq_domain_activate_irq  |
>
> The warning:
>
>   894000.serial: ttyHS1 at MMIO 0x894000 (irq = 144, base_baud = 0) is a MSM
>   serial serial0: tty port ttyHS1 registered
>   WARNING: CPU: 7 PID: 107 at kernel/irq/chip.c:241 __irq_startup+0x78/0xd8
>   ...
>   qcom_geni_serial 894000.serial: serial engine reports 0 RX bytes in!
>
> Adding UART port triggers probe of child serial devices - serdev and
> eventually Qualcomm Bluetooth hci_qca driver.  This opens UART port
> which enables the interrupt before it got activated in
> request_threaded_irq().  The issue originates in commit f3974413cf02
> ("tty: serial: qcom_geni_serial: Wakeup IRQ cleanup") and discussion on
> mailing list [1].  However the above commit does not explain why the
> uart_add_one_port() is moved above requesting interrupt.
>
> [1] https://lore.kernel.org/all/5d9f3dfa.1c69fb81.84c4b.30bf@mx.google.com/
>
> Fixes: f3974413cf02 ("tty: serial: qcom_geni_serial: Wakeup IRQ cleanup")
> Cc: <stable@vger.kernel.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
