Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B921C678D5
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 18:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjCGSqb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjCGSp7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 13:45:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9155AF745
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 10:35:28 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id g6so5762968iov.13
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678214082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RhnCKRU3FrFy7owXRxJ4GDyF7xXRyM56M4QHIhHLjc=;
        b=kORW+pIlMebspso2CmKvb21/4EqcQ8FIywmJ6n2OsiGtF9JQJZfIrSK27w18Y2LbKd
         mlqKKcA3pIoJ70sfqa9x8lfSHzGwjs6SqxIzgUlgN7XYNAXNfvBMJKFFS2ZKP6g/2FFM
         f8MMJ/XDDlw95a2zcZraK7Av6SQkPt3YHSYaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RhnCKRU3FrFy7owXRxJ4GDyF7xXRyM56M4QHIhHLjc=;
        b=NjvNUaWB3NvdM1Usk/rbLq5jhoFXukk6AoZkE1djzTS6ODNzyxbJSFJ251R07GqF6D
         8ZT7VU5i7WzQpu3QU6fxS3lsfsEJfhinms9MbYSVElQfzENoYJsWHReaGzf/IU9dBbgK
         MiW1uh4ViN8qixFDC/0ThpUzgL9+w2jDCEIV/HeklsCraIf6uEfHl6J3ImFD3mTCdim+
         +X7ZEE/cq3EeMXcufHMpj0GGgZhyUZEZ2ffhJMyq6Nns1N6tKI5iMdy/IJKHwegnB0lQ
         BMoUarBBZJJW3w0B6+o6DjF406bfN/mLhemtBsQw8X0OEziVXvSlq3nibIzLZTC80ea1
         /wZw==
X-Gm-Message-State: AO0yUKWkSwb4U8lP1XRCTEws3DRSrwFMfxHBIJSW5WqOY5m2JsDIbf3L
        0XlRlIAjZEonYu75ZARLHaappW2X4SFDkJ2Mj8M=
X-Google-Smtp-Source: AK7set8X6U/Of0aZOc+JRpdn4W4rKZeh0328CYLlnjaDDE2h30HWKxAoalWxHruvKYLUqMVfsS5YsQ==
X-Received: by 2002:a6b:5b0a:0:b0:74c:b15c:1bae with SMTP id v10-20020a6b5b0a000000b0074cb15c1baemr8960223ioh.5.1678214082486;
        Tue, 07 Mar 2023 10:34:42 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id y5-20020a02c005000000b003c41434babdsm4267749jai.92.2023.03.07.10.34.41
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:34:41 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id t1so5073496iln.8
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:34:41 -0800 (PST)
X-Received: by 2002:a05:6e02:1241:b0:316:f93f:6f83 with SMTP id
 j1-20020a056e02124100b00316f93f6f83mr7914002ilq.6.1678214081396; Tue, 07 Mar
 2023 10:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <20230307164405.14218-2-johan+linaro@kernel.org>
In-Reply-To: <20230307164405.14218-2-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Mar 2023 10:34:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ud3hBV===AeeSsPYN9YD_gNniQAeQ2sZ=cGSpMCzq-HQ@mail.gmail.com>
Message-ID: <CAD=FV=Ud3hBV===AeeSsPYN9YD_gNniQAeQ2sZ=cGSpMCzq-HQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: qcom-geni: fix console shutdown hang
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 8:43=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A recent commit added back the calls top stop tx and rx to shutdown()
> which had previously been removed by commit e83766334f96 ("tty: serial:
> qcom_geni_serial: No need to stop tx/rx on UART shutdown") in order to
> be able to use kgdb after stopping the getty.
>
> Not only did this again break kgdb, but it also broke serial consoles
> more generally by hanging TX when stopping the getty during reboot.
>
> The underlying problem has been there since the driver was first merged
> and fixing it is going to be a bit involved so simply stop calling the
> broken stop functions during shutdown for consoles for now.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)

I'm fine with either this change or my change [1] landing.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20230307073155.1.Iaab0159b8d268060a0e131ebb27=
125af4750ef99@changeid
