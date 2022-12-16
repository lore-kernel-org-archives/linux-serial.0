Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EFCC4167B
	for <linux-serial@archiver.kernel.org>; Fri, 16 Dec 2022 15:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiLPPWP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLPPWN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Dec 2022 10:22:13 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960A566FB
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 07:22:11 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x22so6859581ejs.11
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1M1Auh5G/AH8zrzqrUo78l1/L8UKrPHpkrS7qTWMoPQ=;
        b=eCAKBd2GEPcD9z3O/VbJsdTHBC/NWu5QjQR1loE+CJeaXnZ1LPp+rYIzdu6hAWHSnA
         QvQnm/xpuBMc3cU8TT4UxsqtqATr/tAlbtIYB8csAXVfbezmD6EpICkqfThcwzxVsOzE
         dzL6mBbYO2qFyuYKsd+SE7x7p+UFoGld9uBks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M1Auh5G/AH8zrzqrUo78l1/L8UKrPHpkrS7qTWMoPQ=;
        b=AbJQbpJlZ8r4X5vSACflLuc4wSYZ0AaqUn3IHsSj2Q0qVF42KF3JdESzoeW7fcpAm/
         NiYQRWlQHW+Hh1dObQJBwYND9eXvhPPnIz36TKTZBIvnDJKwBOfqjJEogKDtmNPbt6ew
         dX4t1PPLSIPdO0jgWPr3SfhxTjmsR3V6SOaaUywBYbZoGNeKxU4VGOgvAlFENMG9e4U1
         pbzyXwYZv+zEFfYDZUVxbj8jFmfdBwNCxTDyLjmd/1Hh4w1FbzkHSdgYLlRrpp6+wc7r
         c9L9B9i5G20xsyQW+Xl4JTBeqXlCP0ObREbnGagdBFmseIxk3gKHj0HLFTjUfIec1V99
         IPVA==
X-Gm-Message-State: AFqh2kp4SQ/9WuXl0CCmH1AC0JgF+um1Y5yZ0C7y2UFC3GcwMf3GP+Wn
        kYNM3+cB68tAZK2AyOAoCRHvY+Poto7QHvG3cJ0=
X-Google-Smtp-Source: AMrXdXupIywHOaybK1IDY9eFLgZajHrS0QB4tK2LA8ki0ecXPgyPzC28hWdIMSb0Ev3NEnfdyoCAVQ==
X-Received: by 2002:a17:906:3c17:b0:7c0:dfb7:4476 with SMTP id h23-20020a1709063c1700b007c0dfb74476mr2271729ejg.57.1671204130249;
        Fri, 16 Dec 2022 07:22:10 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id n25-20020a170906379900b007c0dcade045sm957078ejc.43.2022.12.16.07.22.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:22:08 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id h12so2806727wrv.10
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 07:22:08 -0800 (PST)
X-Received: by 2002:adf:fd89:0:b0:242:1f81:7034 with SMTP id
 d9-20020adffd89000000b002421f817034mr27601061wrr.617.1671204127894; Fri, 16
 Dec 2022 07:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20221215165453.1864836-1-arnd@kernel.org> <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
 <02b4b94c-aa0d-4878-906d-ecd947553f16@app.fastmail.com>
In-Reply-To: <02b4b94c-aa0d-4878-906d-ecd947553f16@app.fastmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Dec 2022 07:21:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VF9BBmq_+9HhN-1Wi=LjWsZv=Um6EzezswFestbD3bwA@mail.gmail.com>
Message-ID: <CAD=FV=VF9BBmq_+9HhN-1Wi=LjWsZv=Um6EzezswFestbD3bwA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni: avoid duplicate struct member init
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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

On Fri, Dec 16, 2022 at 2:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 15, 2022, at 21:46, Doug Anderson wrote:
> > On Thu, Dec 15, 2022 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> >> index b487823f0e61..03dda47184d9 100644
> >> --- a/drivers/tty/serial/qcom_geni_serial.c
> >> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >> @@ -1516,7 +1516,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
> >>         return 0;
> >>  }
> >>
> >> -static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
> >> +static int qcom_geni_serial_sys_suspend(struct device *dev)
> >
> > Officially the removal of "__maybe_unused" could be a totally
> > different patch, right? SET_SYSTEM_SLEEP_PM_OPS() already eventually
> > used pm_sleep_ptr() even without your change, so the removal of these
> > tags is unrelated to the rest of your change, right?
>
> It's a little more complicated: SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr()
> to avoid the need for a __maybe_unused(). The depreacated
> SET_SYSTEM_SLEEP_PM_OPS() is based on SYSTEM_SLEEP_PM_OPS() these days,
> but still retains the old semantics of using an empty definition
> without CONFIG_PM_SLEEP, so it still leaves the function unused as
> far as gcc is concerned.
>
> There could be an intermediate step of open-coding the
> SET_SYSTEM_SLEEP_PM_OPS(), but that would result in the rather
> silly
>
>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> #ifdef CONFIG_PM_SLEEP
>        .suspend = qcom_geni_serial_sys_suspend,
>        .resume = qcom_geni_serial_sys_resume,
>        .freeze = qcom_geni_serial_sys_suspend,
>        .poweroff = qcom_geni_serial_sys_suspend,
> #endif
>        .restore = qcom_geni_serial_sys_hib_resume,
>        .thaw = qcom_geni_serial_sys_hib_resume,
> }
>
> which makes no sense to me, as I think you either want
> all the members or none of them.

Ah, I guess I didn't trace through all the similarly named macros
quite correctly. ;-) Thanks for explaining.


> >>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> >> -       SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
> >> -                                       qcom_geni_serial_sys_resume)
> >> -       .restore = qcom_geni_serial_sys_hib_resume,
> >> -       .thaw = qcom_geni_serial_sys_hib_resume,
> >> +       .suspend = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> >> +       .resume = pm_sleep_ptr(qcom_geni_serial_sys_resume),
> >> +       .freeze = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> >> +       .poweroff = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> >> +       .restore = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
> >> +       .thaw = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
> >
> > Personally, the order you listed them is less intuitive than the order
> > that SET_SYSTEM_SLEEP_PM_OPS() lists functions. IMO it's better to
> > consistently alternate matching suspend/resume functions. ;-)
>
> Makes sense. I kept the order that we already had here, but
> I could redo this patch if anyone cares.

I wouldn't worry about it.

-Doug
