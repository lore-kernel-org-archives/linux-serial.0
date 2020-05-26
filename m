Return-Path: <SRS0=Q4jN=7I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA09C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 17:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF14F208C3
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 17:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BkNpRVV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgEZRgR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 May 2020 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389449AbgEZRgR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 May 2020 13:36:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C492BC03E97A
        for <linux-serial@vger.kernel.org>; Tue, 26 May 2020 10:36:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci21so84979pjb.3
        for <linux-serial@vger.kernel.org>; Tue, 26 May 2020 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bl//2pYHj3csa8N7S/mTuxuIBaa/b+phWcHwiPQzkOw=;
        b=BkNpRVV/r0N3GqR1VZDQH7oKI+aSLYpW+DUKMWD8EO9crlNX+d6/gzNWbQUMRCUbrv
         SvhMa7XoTvfvnOIdJqBGdbQSnBg0Vb2yOi4erDEQqgCj3ifVWq6VHG5GY/0MN1h8Fj7j
         M3qZRyHRctXoZITEL6GOVvZs5fmtLKWtZikc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bl//2pYHj3csa8N7S/mTuxuIBaa/b+phWcHwiPQzkOw=;
        b=RKEunnCGoR4gcDBU1s+95nLFbTEkiihcCrs7bXRTMw0LlhIrE+FN/QER8V7HgH2DPC
         XcxTfxlcg0SG8ZFF5qPh0Ru8EGr5MZFIHzyx1xCUmgPWQoxLNta+RFXHyDOON9Qh+6yi
         A4sopGFnJHKAODxFF23jsYWCnVIjSaN14jftCalN79m5VvqJfIFNgkcdPMVPoh4DlRPe
         haZBLA9Lyw9PdR70Ir48C9QOO2j9vBUSSdj6dfDrwKhhjfaCooy/0AEGJSZMaEs8bdzc
         A7UE/BWH3PUAkHtTcxxs+wYlN7FTLORWLiCqRaDr/H1rUHL2PFzxB15URI4OYetwaW0h
         S7DQ==
X-Gm-Message-State: AOAM530cU9m0BsoViP3j/mHWUg02gYoqr9gZQHGdhst4R2b7ueM0YFG9
        JXNRPWlmfzwFvJCPqj7sh4KM6g==
X-Google-Smtp-Source: ABdhPJyzUgvTne5XzQDrFY8l1KASpKHwXP04J+NhScYWwbDrv+H8LoktzSM90MIjDWKJ7/+vEh9tmg==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr335118pjb.103.1590514576158;
        Tue, 26 May 2020 10:36:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id u45sm112166pjb.7.2020.05.26.10.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 10:36:15 -0700 (PDT)
Date:   Tue, 26 May 2020 10:36:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        msavaliy@codeaurora.org, evgreen@chromium.org
Subject: Re: [PATCH V7 6/7] spi: spi-qcom-qspi: Add interconnect support
Message-ID: <20200526173613.GF4525@google.com>
References: <1590497690-29035-1-git-send-email-akashast@codeaurora.org>
 <1590497690-29035-7-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590497690-29035-7-git-send-email-akashast@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 26, 2020 at 06:24:49PM +0530, Akash Asthana wrote:
> Get the interconnect paths for QSPI device and vote according to the
> current bus speed of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>    path handle
>  - As per Matthias comment, added error handling for icc_set_bw call
> 
> Changes in V3:
>  - No Change.
> 
> Changes in V4:
>  - As per Mark's comment move peak_bw guess as twice of avg_bw if
>    nothing mentioned explicitly to ICC core.
> 
> Changes in V5:
>  - Add icc_enable/disable to power on/off call.
>  - Save some non-zero avg/peak value to ICC core by calling geni_icc_set_bw
>    from probe so that when resume/icc_enable is called NOC are running at
>    some non-zero value.
> 
> Changes in V6:
>  - As per Matthias's comment made print statement consistent across driver
> 
> Changes in V7:
>  - As per Matthias's comment removed usage of peak_bw variable because we don't
>    have explicit peak requirement, we were voting peak = avg and this can be
>    tracked using single variable for avg bw.
>  - As per Matthias's comment improved print log.
> 
>  drivers/spi/spi-qcom-qspi.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..092ac27 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>  
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -139,7 +140,9 @@ struct qcom_qspi {
>  	struct device *dev;
>  	struct clk_bulk_data *clks;
>  	struct qspi_xfer xfer;
> -	/* Lock to protect xfer and IRQ accessed registers */
> +	struct icc_path *icc_path_cpu_to_qspi;
> +	unsigned int avg_bw_cpu;

I should have noticed this earlier, but the field isn't needed now that
we have icc_enable/disable(). The bandwidth is set in
qcom_qspi_transfer_one() and that's it.

From my side it would be fine to remove the field in a follow up patch,
to avoid respinning the series yet another time just for this.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
