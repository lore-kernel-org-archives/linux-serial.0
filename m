Return-Path: <SRS0=U7OZ=5Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E21DC2D0F2
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAE12145D
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 17:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8M8ls/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCaRwM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:52:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33670 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaRwM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Mar 2020 13:52:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id g18so8410403plq.0
        for <linux-serial@vger.kernel.org>; Tue, 31 Mar 2020 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8b3WnZTTNBaPOMDMuIqGibWI1hhFOK4GHv2gbbqH4E4=;
        b=Y8M8ls/Tz7mnjRLag509mDzeltvzbPfcMsTSXBMrI+rpRmUwjDK1+CkgdTXqyfEhYg
         bZEmgXc4O3cx/xXKnPBfH/o2pWD2O/S4zuGQxn0PpL3D29pjVHIayEPExxJPcBvm/j+Y
         ds26z93uo/7QI7TKsqvz0V98b+PNUYfX8DFiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8b3WnZTTNBaPOMDMuIqGibWI1hhFOK4GHv2gbbqH4E4=;
        b=JHY1WVdo0A5kyeuMY/bg9lCYksGk9TmOxJT+rmAb6vgv+7E3G/vyv5a+IbIw6OrJZ2
         4MRBCNsIrkwUhdVHwV2Ac0qBFwz1qdiY5etsrcpy9+JLcSnzdG3yF+VUFiHp31Zzk/c1
         gdAm1jJm7n8lWAbYuj/I9xXrVRgPX1V+E3Kul+iY2aDycqyO+xhBn4Oj2KxyWBSPEDF9
         IaW2dGWA2QZvNlfptQbwFTlL+lSCCjdWqOPaxdH+5zPLYtTd9Yvr1nl7tA6FHLJqxhot
         u9VKodF3rXharHFC0vEIZIoxnmXbMXAra0N+Br/Grmq1ITk3s8L7m+MEAYvqQuGh1IbW
         hRTg==
X-Gm-Message-State: AGi0Puae5UH224Ppe9bgJ71XtmQ/ytItWQ28S/9WwdmzDab7BdwhGI6v
        cygiDVFBB7dPzYcQ0PID7+VSVA==
X-Google-Smtp-Source: APiQypLEDWt9naJrmZKRq7qNu/KyQtF3te2IOlxl2ISxISRKDGfkLLJ/GDPPR5qiBNFBaLE8bdDXAw==
X-Received: by 2002:a17:90a:e398:: with SMTP id b24mr16072pjz.113.1585677129802;
        Tue, 31 Mar 2020 10:52:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id i187sm12910140pfg.33.2020.03.31.10.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 10:52:09 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:52:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
Subject: Re: [PATCH V3 2/8] soc: qcom: geni: Support for ICC voting
Message-ID: <20200331175207.GG199755@google.com>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-3-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1585652976-17481-3-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Akash,

On Tue, Mar 31, 2020 at 04:39:30PM +0530, Akash Asthana wrote:
> Add necessary macros and structure variables to support ICC BW
> voting from individual SE drivers.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment dropped enums for ICC paths, given the three
>    paths individual members
> 
> Changes in V3:
>  - Add geni_icc_get, geni_icc_vote_on and geni_icc_vote_off as helper API.
>  - Add geni_icc_path structure in common header
> 
>  drivers/soc/qcom/qcom-geni-se.c | 98 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/qcom-geni-se.h    | 36 +++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 7d622ea..9344c14 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -720,6 +720,104 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
>  }
>  EXPORT_SYMBOL(geni_se_rx_dma_unprep);
>  
> +int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
> +		const char *icc_ddr)
> +{
> +	if (icc_core) {
> +		se->to_core.path = devm_of_icc_get(se->dev, "qup-core");
> +		if (IS_ERR(se->to_core.path))
> +			return PTR_ERR(se->to_core.path);
> +	}
> +
> +	if (icc_cpu) {
> +		se->from_cpu.path = devm_of_icc_get(se->dev, "qup-config");
> +		if (IS_ERR(se->from_cpu.path))
> +			return PTR_ERR(se->from_cpu.path);
> +	}
> +
> +	if (icc_ddr) {
> +		se->to_ddr.path = devm_of_icc_get(se->dev, "qup-memory");
> +		if (IS_ERR(se->to_ddr.path))
> +			return PTR_ERR(se->to_ddr.path);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(geni_icc_get);
> +
> +int geni_icc_vote_on(struct geni_se *se)
> +{
> +	int ret;
> +
> +	if (se->to_core.path) {
> +		ret = icc_set_bw(se->to_core.path, se->to_core.avg_bw,
> +			se->to_core.peak_bw);
> +		if (ret) {
> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for core\n",
> +						__func__);
> +			return ret;
> +		}
> +	}
> +
> +	if (se->from_cpu.path) {
> +		ret = icc_set_bw(se->from_cpu.path, se->from_cpu.avg_bw,
> +			se->from_cpu.peak_bw);
> +		if (ret) {
> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for cpu\n",
> +						__func__);
> +			return ret;
> +		}
> +	}
> +
> +	if (se->to_ddr.path) {
> +		ret = icc_set_bw(se->to_ddr.path, se->to_ddr.avg_bw,
> +			se->to_ddr.peak_bw);
> +		if (ret) {
> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for ddr\n",
> +						__func__);
> +			return ret;
> +		}
> +	}


With an array of 'struct geni_icc_path' pointers the above could be
reduced to:

	for (i = 0; i < ARRAY_SIZE(se->icc_paths); i++) {
		if (!se->icc_paths[i])
			continue;

		ret = icc_set_bw(se->icc_paths[i]->path, se->icc_paths[i]->avg_bw,
			se->icc_paths[i]->peak_bw);
		if (ret) {
			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed\n",
						__func__);
			return ret;
		}
	}

similar for geni_icc_vote_off()

It's just a suggestion, looks also good to me as is.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
