Return-Path: <SRS0=N/nd=YI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026D9C10F14
	for <linux-serial@archiver.kernel.org>; Tue, 15 Oct 2019 20:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75D12083B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Oct 2019 20:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qm5KveM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfJOUKV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:10:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45160 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfJOUKV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Oct 2019 16:10:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so11613034pgj.12
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2019 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=yxjs1RvXnbn1IZBgaNqgR5bQ9+stKTuRJlL019UWCRA=;
        b=Qm5KveM00WDQPp4pK8aE3SWqNiZl+ACQSVu64EPYprz81eVox+SaWcBCvyNhb4cSVR
         r9awCxhEces9anLtucD6llKsQBMGQvGyOir0bvw+JHhcPJ+568dUJrTQxjsiFaMTdEes
         aE/LjYbFPN86X+t+JKkhBtIfzQvu12WIjlGpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=yxjs1RvXnbn1IZBgaNqgR5bQ9+stKTuRJlL019UWCRA=;
        b=MpnBxIbrzcFWDpB32G/D0RyNyal3pm4xNVO8vLdqQS5h3sA7l3ae9fNkfyKrIBV8Wu
         nWuanVwDkttTRHbPd0EKX1C10Mnag14xADYEo3oc/ULt+8pdh2R6/gqKpD70sR54qj5w
         YlLUOT3BQQkelkeRDvhRR9Zi1JHtk6boH3VxMa9tkG3Xvao1EZwYCxBa8OiSWSzfhhc6
         XxC1Meo4XGD1VHWL+g2sNGDsPos48yco4gp7/ndKJxk8V5y7aHzlyOh729g/8B40EN4r
         rt378Xq1feL2RUC6QVSn4kpiT+/RdsWs7CRyGhLHsII63vFOB9WSvGomdqJJ0aPEcHWA
         Getg==
X-Gm-Message-State: APjAAAXMcCfVcoocnuUnWO6VpMaGgyFdiV25wRi//qUemBOtIGRrdbch
        AP/uTszaeuuRrJ3I81QvfioVXA==
X-Google-Smtp-Source: APXvYqxQYkIuEQpbk0mFhe3JVUXLFIUm1OCu5Ltes0M3GteYJ2gUoWmBllyjB+oNfbeZTzAMIl+fCg==
X-Received: by 2002:a65:66c6:: with SMTP id c6mr26343960pgw.250.1571170219131;
        Tue, 15 Oct 2019 13:10:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h1sm23712189pfk.124.2019.10.15.13.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:10:18 -0700 (PDT)
Message-ID: <5da627aa.1c69fb81.e2d51.203d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a7dabb1d-b6af-acc5-ba4e-923ee5fc6ee3@codeaurora.org>
References: <1570700803-17566-1-git-send-email-akashast@codeaurora.org> <5d9f3f4f.1c69fb81.5120f.b90e@mx.google.com> <a7dabb1d-b6af-acc5-ba4e-923ee5fc6ee3@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH V2 2/2] tty: serial: qcom_geni_serial: Wakeup over UART RX
User-Agent: alot/0.8.1
Date:   Tue, 15 Oct 2019 13:10:17 -0700
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-10-11 02:48:42)
>=20
> On 10/10/2019 7:55 PM, Stephen Boyd wrote:
> > Quoting Akash Asthana (2019-10-10 02:46:43)
> >> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/seria=
l/qcom_geni_serial.c
> >> index 5180cd8..ff63728 100644
> >> --- a/drivers/tty/serial/qcom_geni_serial.c
> >> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >> @@ -1306,6 +1317,29 @@ static int qcom_geni_serial_probe(struct platfo=
rm_device *pdev)
> >> +               if (port->wakeup_irq < 0) {
> >> +                       dev_err(&pdev->dev, "Failed to get wakeup IRQ =
%d\n",
> >> +                                       port->wakeup_irq);
> >> +               } else {
> >> +                       irq_set_status_flags(port->wakeup_irq, IRQ_NOA=
UTOEN);
> >> +                       ret =3D devm_request_irq(uport->dev, port->wak=
eup_irq,
> >> +                               qcom_geni_serial_wakeup_isr,
> >> +                               IRQF_TRIGGER_FALLING, "uart_wakeup", u=
port);
> >> +                       if (ret) {
> >> +                               dev_err(uport->dev, "Failed to registe=
r wakeup IRQ ret %d\n",
> >> +                                               ret);
> >> +                               return ret;
> >> +                       }
> >> +
> >> +                       device_init_wakeup(&pdev->dev, true);
> >> +                       ret =3D dev_pm_set_wake_irq(&pdev->dev, port->=
wakeup_irq);
> > Why can't we use dev_pm_set_dedicated_wake_irq() here?
>=20
> If we use this API then handler "handle_threaded_wake_irq" uses device=20
> specific pm_runtime functions to wake the device and currently this
>=20
> driver don't support runtime PM callbacks. Also, we want to register=20
> "qcom_geni_serial_wakeup_isr" as our IRQ handler for wakeup scenario.
>=20

Why can't we make this driver use runtime PM?

