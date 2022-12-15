Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B6C10F1E
	for <linux-serial@archiver.kernel.org>; Thu, 15 Dec 2022 20:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLOUrL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLOUrK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Dec 2022 15:47:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB5D21E10
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 12:47:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so1463608ejb.6
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 12:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VxVyPZKSysf+HLi7nhh+VUixxCogFeRsVo86ZrnztgQ=;
        b=hxzxmAZbiyk38wc8gz9+Ee2T8BOYtvW5SiTPnrxwx4lOkojFHNVaj0lvh5AJI9zjSp
         z1LbbrCXSyJnMlxM2SWfndRjFiopwVhc7pMCfEsmD2JaOTOxR8rXZmrwBoHCKySl7Hvg
         dTFJBmC7oIU/73t9a6PjJcbym1vMucF0MPJdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxVyPZKSysf+HLi7nhh+VUixxCogFeRsVo86ZrnztgQ=;
        b=MmsSA00zeArG7YUFTYgcAJsIQylSb2TmUL//9uySRWTcdfe6FrvKS33W5DwcTzDOom
         oX0B8cvnAOU2VjFYDIb6WyMFYJ3Otyj27YVM8O2vbdy52d2WjD0ZumoCNCMvcNFKftxg
         oFTorbYRi0GBoLbqSnpLGy5Bz0c80+a/0QFQzoRwMmezbgLgS66Yw7vDPsgA2LSJEHF/
         iAjPCvBc/YC/bz/m8PLTRkY8mGG25XCttWxRMd/OTvGnjlSxd63EYQtgvbiCvt3v3yiX
         igvculzH4EJRyXJx3EwrI6DX0cnreSyou/ZpdlQ+c53eYHb3vxc+JuBh9khifxgyMp2A
         v4RQ==
X-Gm-Message-State: ANoB5pkFcLQGYMJ/zvtUSFXeSurekPlMwIXUvJtHZA8BlIENBSt11jVP
        ZlLTKwxZpLKSvpZyGrDdWZt34C8LdYp5IGMPVWs=
X-Google-Smtp-Source: AA0mqf4XQIDHj47y8NkxZ8NF6vRhmXjbjpMpTEIHFeFUUv1mEuHN/qbi//GHVFWm31khVp4EBVyUMg==
X-Received: by 2002:a17:906:f74a:b0:7c1:453f:1aae with SMTP id jp10-20020a170906f74a00b007c1453f1aaemr21784610ejb.37.1671137224294;
        Thu, 15 Dec 2022 12:47:04 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm57984ejy.138.2022.12.15.12.47.03
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 12:47:03 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so313550wml.4
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 12:47:03 -0800 (PST)
X-Received: by 2002:a05:600c:4153:b0:3d2:191d:2427 with SMTP id
 h19-20020a05600c415300b003d2191d2427mr176059wmm.188.1671137223155; Thu, 15
 Dec 2022 12:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20221215165453.1864836-1-arnd@kernel.org>
In-Reply-To: <20221215165453.1864836-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Dec 2022 12:46:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
Message-ID: <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni: avoid duplicate struct member init
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Aniket Randive <quic_arandive@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, Dec 15, 2022 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When -Woverride-init is enabled in a build, gcc points out that
> qcom_geni_serial_pm_ops contains conflicting initializers:
>
> drivers/tty/serial/qcom_geni_serial.c:1586:20: error: initialized field overwritten [-Werror=override-init]
>  1586 |         .restore = qcom_geni_serial_sys_hib_resume,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/qcom_geni_serial.c:1586:20: note: (near initialization for 'qcom_geni_serial_pm_ops.restore')
> drivers/tty/serial/qcom_geni_serial.c:1587:17: error: initialized field overwritten [-Werror=override-init]
>  1587 |         .thaw = qcom_geni_serial_sys_hib_resume,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Open-code the initializers with the version that was already used,
> and use the pm_sleep_ptr() method to deal with unused ones,
> in place of the __maybe_unused annotation.
>
> Fixes: 35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibernation feature")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index b487823f0e61..03dda47184d9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1516,7 +1516,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
> +static int qcom_geni_serial_sys_suspend(struct device *dev)

Officially the removal of "__maybe_unused" could be a totally
different patch, right? SET_SYSTEM_SLEEP_PM_OPS() already eventually
used pm_sleep_ptr() even without your change, so the removal of these
tags is unrelated to the rest of your change, right?


>  {
>         struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>         struct uart_port *uport = &port->uport;
> @@ -1533,7 +1533,7 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
>         return uart_suspend_port(private_data->drv, uport);
>  }
>
> -static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
> +static int qcom_geni_serial_sys_resume(struct device *dev)
>  {
>         int ret;
>         struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> @@ -1581,10 +1581,12 @@ static int qcom_geni_serial_sys_hib_resume(struct device *dev)
>  }
>
>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
> -                                       qcom_geni_serial_sys_resume)
> -       .restore = qcom_geni_serial_sys_hib_resume,
> -       .thaw = qcom_geni_serial_sys_hib_resume,
> +       .suspend = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> +       .resume = pm_sleep_ptr(qcom_geni_serial_sys_resume),
> +       .freeze = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> +       .poweroff = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> +       .restore = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
> +       .thaw = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),

Personally, the order you listed them is less intuitive than the order
that SET_SYSTEM_SLEEP_PM_OPS() lists functions. IMO it's better to
consistently alternate matching suspend/resume functions. ;-)

Both of those are nits, so I'm also fine with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
