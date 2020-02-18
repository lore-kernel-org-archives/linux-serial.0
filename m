Return-Path: <SRS0=X3gT=4G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0822C34031
	for <linux-serial@archiver.kernel.org>; Tue, 18 Feb 2020 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12EC24656
	for <linux-serial@archiver.kernel.org>; Tue, 18 Feb 2020 22:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdvCc28G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRWez (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:34:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53650 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRWex (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Feb 2020 17:34:53 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so1666866pjc.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2020 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2eKXLdS2SZDwMdln7XhHDX3a3+819OaM4/wB+easctg=;
        b=UdvCc28GYQs6m40ZXxJ3q6FDb0m33BsrjUc/CPdR1o9n5xyA+FAgsxOGOBAWTUdDWe
         n1SFmNeodzj4qU3RuxrvUWvAtj7oAtKcOS59IHI4M9ySisy3rZtLt4NkRXSjv7NoBYRJ
         moTU3/iM4xOtiA8zT8vT/PoO19KfiXP/2iKGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2eKXLdS2SZDwMdln7XhHDX3a3+819OaM4/wB+easctg=;
        b=GV8DNwBHp2LyKDZRFBpuEmZ/2CR7U5jo4sYUVl33BDLCSp7RGO7sXg9vo9LKkK3/8G
         lMbPc5V0ZhUOOgev1e5zacTtStviWQlFb6D7m9eXdbGqaVdeHYBQB8wtTISch3OOxWO4
         KVPmpEkxAzKnhhPJX5Q9RBP6Ed3Y87UV7dZ+4pDlTlryRHwJf4qkNbB1QaP78IsoaZ0a
         clTOpz1S86JXmXvtGdVDn8WH1N1N0C8kieeqevUhvPeSHmMHbREgB6+ZM+q1m18Q9r47
         W50ik5mjnKOzKmLAf0WNMJO6QtcOghSsGymX6UhLvdYs9PCTGUahFl2LlWrSfC/LGabz
         HprQ==
X-Gm-Message-State: APjAAAW2+jxfj4wKxpO4aQz+Vxv5Vw+coqhfi9CMvOAqewY2cui9p+Wj
        a/rlTaBNfEJJjQtF7uwBO14n8A==
X-Google-Smtp-Source: APXvYqzber3G1fDzSXxp/hMZGp+hlW3bIrQzQO+2dgbacLrctSydXRQwbTAiQI7JCjGq8z+fCcnjDQ==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr5507545pjv.15.1582065292004;
        Tue, 18 Feb 2020 14:34:52 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id f3sm5781941pga.38.2020.02.18.14.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 14:34:51 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:34:50 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH 2/6] tty: serial: qcom_geni_serial: Add interconnect
 support
Message-ID: <20200218223450.GE15781@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 17, 2020 at 07:00:01PM +0530, Akash Asthana wrote:
> Get the interconnect paths for Uart based Serial Engine device
> and vote according to the baud rate requirement of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 84 ++++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 191abb1..a8fb2b7 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -174,6 +174,35 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
>  	},
>  };
>  
> +static int geni_serial_icc_get(struct geni_se *se)
> +{
> +	if (!se)
> +		return -EINVAL;
> +
> +	se->icc_path[GENI_TO_CORE] = of_icc_get(se->dev, "qup-core");
> +	if (IS_ERR(se->icc_path[GENI_TO_CORE]))
> +		return PTR_ERR(se->icc_path[GENI_TO_CORE]);
> +
> +	se->icc_path[CPU_TO_GENI] = of_icc_get(se->dev, "qup-config");
> +	if (IS_ERR(se->icc_path[CPU_TO_GENI])) {
> +		icc_put(se->icc_path[GENI_TO_CORE]);
> +		se->icc_path[GENI_TO_CORE] = NULL;
> +		return PTR_ERR(se->icc_path[CPU_TO_GENI]);
> +	}
> +
> +	return 0;
> +}
> +
> +void geni_serial_icc_put(struct geni_se *se)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(se->icc_path); i++) {
> +		icc_put(se->icc_path[i]);
> +		se->icc_path[i] = NULL;
> +	}
> +}
> +
>  static int qcom_geni_serial_request_port(struct uart_port *uport)
>  {
>  	struct platform_device *pdev = to_platform_device(uport->dev);
> @@ -949,6 +978,12 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  	ser_clk_cfg = SER_CLK_EN;
>  	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>  
> +	/* Put BW vote only on CPU path as driver supports FIFO mode only */
> +	port->se.avg_bw_cpu = Bps_to_icc(baud);
> +	port->se.peak_bw_cpu = Bps_to_icc(2 * baud);
> +	icc_set_bw(port->se.icc_path[CPU_TO_GENI], port->se.avg_bw_cpu,
> +			port->se.peak_bw_cpu);
> +
>  	/* parity */
>  	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
>  	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
> @@ -1179,11 +1214,20 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  	if (old_state == UART_PM_STATE_UNDEFINED)
>  		old_state = UART_PM_STATE_OFF;
>  
> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
> +		/* Put BW vote for core clocks and CPU */
> +		icc_set_bw(port->se.icc_path[GENI_TO_CORE],
> +			port->se.avg_bw_core, port->se.peak_bw_core);
> +		icc_set_bw(port->se.icc_path[CPU_TO_GENI], port->se.avg_bw_cpu,
> +			port->se.peak_bw_cpu);
>  		geni_se_resources_on(&port->se);
> -	else if (new_state == UART_PM_STATE_OFF &&
> -			old_state == UART_PM_STATE_ON)
> +	} else if (new_state == UART_PM_STATE_OFF &&
> +			old_state == UART_PM_STATE_ON) {
>  		geni_se_resources_off(&port->se);
> +		/* Remove BW vote from core clocks and CPU */
> +		icc_set_bw(port->se.icc_path[GENI_TO_CORE], 0, 0);
> +		icc_set_bw(port->se.icc_path[CPU_TO_GENI], 0, 0);
> +	}
>  }
>  
>  static const struct uart_ops qcom_geni_console_pops = {
> @@ -1274,15 +1318,30 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
>  	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>  
> +	ret = geni_serial_icc_get(&port->se);
> +	if (ret)
> +		return ret;
> +	/* Set the bus quota to a reasonable value */
> +	port->se.avg_bw_core = console ? Bps_to_icc(1000) :
> +		Bps_to_icc(CORE_2X_50_MHZ);
> +	port->se.peak_bw_core = console ? Bps_to_icc(1000) :
> +		Bps_to_icc(CORE_2X_100_MHZ);
> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
> +	port->se.avg_bw_cpu = Bps_to_icc(1000);

I guess you mean 'peak_bw_cpu'?
