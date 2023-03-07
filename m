Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1472C678D5
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 18:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjCGSrv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjCGSrW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 13:47:22 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A75370C
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 10:36:38 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 4so8937510ilz.6
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678214193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HRJ9QjT9ee3B3xI3WGpaSfom/i+pMrAR/AAlnFcX0Q=;
        b=eCgfHyQGkoLcQhkjJyae1CNsPuS1w5bv68jcVvSLVuSagXXJ2IWgyCMzptps1NAViB
         Uxwvmx6PFKUjpEElyFLpW0pZUAMQ/c5VwPRmADmAmJJViMe/pejFBpXnnlLdNhRMt25O
         dAS8YQq2bj0pTqvzB8pO5wq1hvdb9GcQ2P2uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HRJ9QjT9ee3B3xI3WGpaSfom/i+pMrAR/AAlnFcX0Q=;
        b=rmt7tf/yeZA4+TOQwPudkddQ/3i8LZhYFGQO1taUfcXr2dpieYjKarEf8Re/feDWWJ
         FSVnRpLwp55AGLYd2fXDp0Mt9iFk5DdSQ7IKM7kD3e8WisPUIcGKeNqLJ2+rP1J9MU2Q
         L9hr6cz14WLrwl9pGOIl9d/gQH/o+oHX1hSCDAAKd3bcuYtNvqPw4bdL+feoqltkS9mU
         0yjqAvfhFL2aX383qm5EH1+qhN96LC/iFOjmdmaGWrPQiAC/jSDIsrP9WEfeC0eqruQT
         L3VewwRxGZ/pLKQr6dvy4bkhHj/K2RogdhhooeyfsASP/oro81DOO4lVNTOFZoTAUefM
         CUJw==
X-Gm-Message-State: AO0yUKX4ekIK4BRBOlJuuVgFegoZK9Jzz+wolE4QYjpcQi2jplTo3+Uc
        pQeIzqN1HEtUKAScpStErXGCFi88b3XXxnl8AtY=
X-Google-Smtp-Source: AK7set8doym7f7+1Lr097DcbKIlEVCfNbIh27Qf7VjSk7i8FVOSmb7ePj6+4XREtS0W85A4ZbtvuMg==
X-Received: by 2002:a05:6e02:20c7:b0:315:4f67:7055 with SMTP id 7-20020a056e0220c700b003154f677055mr15504449ilq.1.1678214193236;
        Tue, 07 Mar 2023 10:36:33 -0800 (PST)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id m12-20020a02c88c000000b003bada974a13sm4322351jao.165.2023.03.07.10.36.32
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:36:32 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id k17so5783762iob.1
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:36:32 -0800 (PST)
X-Received: by 2002:a6b:6a0a:0:b0:745:b287:c281 with SMTP id
 x10-20020a6b6a0a000000b00745b287c281mr7254210iog.2.1678214192165; Tue, 07 Mar
 2023 10:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <20230307164405.14218-3-johan+linaro@kernel.org>
In-Reply-To: <20230307164405.14218-3-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Mar 2023 10:36:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UO2hnu0pt2OggyQ0L6onohhzxeGbmtX6BQL7B_vciNpA@mail.gmail.com>
Message-ID: <CAD=FV=UO2hnu0pt2OggyQ0L6onohhzxeGbmtX6BQL7B_vciNpA@mail.gmail.com>
Subject: Re: [PATCH 2/4] serial: qcom-geni: fix DMA mapping leak on shutdown
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
> Fix what appears to be a copy-paste error that can lead to a leaked DMA
> mapping on close() and failure to restart TX after the port is reopened.
>
> Note that rx_dma_addr is generally NULL when
> qcom_geni_serial_stop_tx_dma() is called as part of shutdown() (but
> tx_dma_addr need not be).
>
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for seri=
al engine DMA")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
