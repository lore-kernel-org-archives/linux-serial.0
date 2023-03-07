Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70459C6FD1A
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 16:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCGQwK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCGQvu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 11:51:50 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0F12BF3E
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 08:47:45 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id e82so12017527ybh.9
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678207658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+b420gW8EvDq5mtxL/dde8yBN+aFEeDMlpeU8M2B68=;
        b=q05+e5MmNr1ul7D03tP0p/MXc7tVHR0I5rxWn95iyrvA/T40k2SwqSDbakgBJOQKsp
         ONN27cqeFoXTX4CY/MbLXSWMHDRrx9p/lMgSrsqpHzv5hDJ0caPXi++whsuXqyo3rgGx
         oZaIoVXKHQ7l1nqhjnQ3zublfIiNuIuH2NpZzT8V2PGdzN1RXzZSflhTtxBFdJHMW22r
         NyKZxc5hhjRc4zFj1nP1htgUlBcA2gWCu4S7OsCn0gONMKYMdsCPhBXQb/FDZgu27EHS
         Ja6ACCUqVq/j0oX7gR/BLiSjklR8o6FtdbVklsVre7D1D/FjDBj/k6NiIQQWIZW2Sd0B
         nrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+b420gW8EvDq5mtxL/dde8yBN+aFEeDMlpeU8M2B68=;
        b=NdnQx/NDAqNqrRFU/F9qSQPUlv2L42WkQ3dgQZVI+fCg4kjFYTTL0CRewhvRSWnHCj
         JTTxTme51BAAvAkDIdNcFZHvoRbysOcNDINBNcD+RvJSJiyf4dcyAEb6j2k6L/XCvBQD
         luyClJ0seIP+95QBeffcg7hnvHyPZcvjZ8P2jVbxSp+YtP0AWXOvaHBsiuMBfmRnOHAn
         4ZHe7yW2JbaGL8rQAdxQWZukOI4/g/f39ND356e97WG5/lJDMSx8x6HkX7zJt6PJxrey
         aWGYU0XW5bvFr0tBk7bcgtnbpjU6oYmD4u2Qr9vA6H007MxQcMIZdHghnkBRempbN5KL
         VJaw==
X-Gm-Message-State: AO0yUKV1GtpOEL5VJqB9EAMNqtPCp1EAnf2/IC+YySlvcIqpXzBvKS7c
        Rqmiy5i3yfZGAJYb2H0KKuCUK1yAILIHhsK8HpN8Kg==
X-Google-Smtp-Source: AK7set9ITIlXcKiPBX7mIBhFoF8sgK/EPHcgfTAk/YTpopZ8SEIfEN0OooNEuok6S589ITq05t0K4xgaMQpkW2PNIdA=
X-Received: by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr8920750ybr.6.1678207658437; Tue, 07 Mar
 2023 08:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <CACMJSes3usJUvCsrMBR_9dDGCbo2y7JqA8-B5mP28H2Cjg-v6A@mail.gmail.com>
In-Reply-To: <CACMJSes3usJUvCsrMBR_9dDGCbo2y7JqA8-B5mP28H2Cjg-v6A@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 7 Mar 2023 17:47:27 +0100
Message-ID: <CACMJSesztZbB53QPaiLg+GKghJ-8MbiS60t8CbN_m8Wcph3-9g@mail.gmail.com>
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 7 Mar 2023 at 17:44, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Tue, 7 Mar 2023 at 17:43, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > This series fixes some of the fallout after a recent series adding
> > support for DMA transfers to the Qualcomm geni serial driver.
> >
> > Most importantly it fixes a hang during reboot when using a serial
> > console and the getty is stopped during reboot.
> >
> > Doug just posted an equivalent fix here:
> >
> >         https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
> >
> > but the commit message only mentions the regression with respect to
> > kgdb, which is not as widely used serial consoles generally, so I
> > figured I'd post my version for completeness.
> >
> > Either version of that fix should address the immediate regression, but
> > fixing the underlying problems which have been there since the driver
> > was first merged is going to be a bit more involved.
> >
> > The rest of the series fixes a few bugs in the new DMA support that I
> > found while investigating the console regression.
> >
> > Johan
> >
> >
> > Johan Hovold (4):
> >   serial: qcom-geni: fix console shutdown hang
> >   serial: qcom-geni: fix DMA mapping leak on shutdown
> >   serial: qcom-geni: fix mapping of empty DMA buffer
> >   serial: qcom-geni: drop bogus uart_write_wakeup()
> >
> >  drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > --
> > 2.39.2
> >
>
> Hey Johan,
>
> Douglas and Srini beat you to these fixes but thanks!
>
> Bart

Nevermind, I read your other message now. And also patch 3/4 looks right.

Bart
