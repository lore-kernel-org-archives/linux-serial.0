Return-Path: <SRS0=O7Uh=46=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC17C4CECE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 21:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD5920767
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 21:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggDjeYlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCMV2h (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:28:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43141 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCMV2h (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Mar 2020 17:28:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id c144so6020747pfb.10
        for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2020 14:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ry88+WJ8l0zWh9VRcHO/WsgTmwawfbzUY5Sw04fN+Yo=;
        b=ggDjeYlGjr6G0AJm0Zxysz575eO62jPbvdaICQoeCJ5IGHTMeQzePj2ysK0BS6LCqs
         SC647aPJJqcGyGBZBw6pUVQvAJtoiEC46JBlSlDO+610X0NKreH+BLpUqvtIY60mS45f
         ocVCeNv/bGgOluQS1qH4cHDDpbZKucXC2R8iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ry88+WJ8l0zWh9VRcHO/WsgTmwawfbzUY5Sw04fN+Yo=;
        b=UczvYPxlE8fSVW3thSp0ucXey7gn8rKWx+Upkn1mw2mwfbZ3mzppND4XFDrMTvHPh/
         jhEOEwEnR7aoW3rdV4dyDMgi0Tvk/CrBsbqkN5VfSZ9WSoJziVP+4u1mY4ilyOEjkSG5
         8vedDA0omoin7P6WRck0zDt6vP5EbcXcr2mi2lSS1sapLQ70U3bwHc+cr8kSO6QyOP/u
         j6r7ks2Tq3bNKaWLoMS29MlpxnoZBR7jBMdZvTIjvmufderSaqBPr3PTNQGS106JmARE
         b/XIAT4JLJNR4QZBJwaA8EopJRC7D02cG84wi7I6wn8LlYtTZIsSa95EWcY6ixvVR2fb
         MJsA==
X-Gm-Message-State: ANhLgQ2pQCxhEbA7tr60Y1rdnmuoNRl3JPgMlXM8jVNYo/vk0G6YW+UR
        3SQ1WKxAwkpKQpZgQwPVxZfozA==
X-Google-Smtp-Source: ADFU+vucKwFZgC8dkfJ9UvKffgEL6ZoV8n8BdGBDjTsqiUyK9EqnqQYB/EWe1+STtFklrWlFl90CNQ==
X-Received: by 2002:aa7:83cb:: with SMTP id j11mr13454955pfn.241.1584134915113;
        Fri, 13 Mar 2020 14:28:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z3sm59387463pfz.155.2020.03.13.14.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 14:28:34 -0700 (PDT)
Date:   Fri, 13 Mar 2020 14:28:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
Subject: Re: [PATCH V2 4/8] tty: serial: qcom_geni_serial: Add interconnect
 support
Message-ID: <20200313212833.GK144492@google.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-5-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1584105134-13583-5-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Akash,

On Fri, Mar 13, 2020 at 06:42:10PM +0530, Akash Asthana wrote:
> Get the interconnect paths for Uart based Serial Engine device
> and vote according to the baud rate requirement of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment, removed se == NULL check from geni_serial_icc_get
>  - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
>  - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>    path handle
>  - As per Matthias comment, added error handling for icc_set_bw call
> 
>  drivers/tty/serial/qcom_geni_serial.c | 69 +++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 272bae0..c8ad7e9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -184,6 +184,19 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
>  	},
>  };
>  
> +static int geni_serial_icc_get(struct geni_se *se)
> +{
> +	se->icc_path_geni_to_core = devm_of_icc_get(se->dev, "qup-core");
> +	if (IS_ERR(se->icc_path_geni_to_core))
> +		return PTR_ERR(se->icc_path_geni_to_core);
> +
> +	se->icc_path_cpu_to_geni = devm_of_icc_get(se->dev, "qup-config");
> +	if (IS_ERR(se->icc_path_cpu_to_geni))
> +		return PTR_ERR(se->icc_path_cpu_to_geni);
> +
> +	return 0;
> +}
> +
>  static int qcom_geni_serial_request_port(struct uart_port *uport)
>  {
>  	struct platform_device *pdev = to_platform_device(uport->dev);
> @@ -962,6 +975,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>  	unsigned long clk_rate;
>  	u32 ver, sampling_rate;
> +	int ret;
>  
>  	qcom_geni_serial_stop_rx(uport);
>  	/* baud rate */
> @@ -983,6 +997,18 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  	ser_clk_cfg = SER_CLK_EN;
>  	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>  
> +	/*
> +	 * Put BW vote only on CPU path as driver supports FIFO mode only.
> +	 * Assume peak_bw as twice of avg_bw.
> +	 */
> +	port->se.avg_bw_cpu = Bps_to_icc(baud);
> +	port->se.peak_bw_cpu = Bps_to_icc(2 * baud);
> +	ret = icc_set_bw(port->se.icc_path_cpu_to_geni, port->se.avg_bw_cpu,
> +			port->se.peak_bw_cpu);
> +	if (ret)
> +		dev_err(uport->dev, "%s: ICC BW voting failed for cpu\n",
> +			__func__);

Should this return an error? The port might not operate properly if the ICC
bandwidth couldn't be configured


> +
>  	/* parity */
>  	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
>  	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
> @@ -1208,16 +1234,40 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  		unsigned int new_state, unsigned int old_state)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> -
> +	int ret;
>  	/* If we've never been called, treat it as off */
>  	if (old_state == UART_PM_STATE_UNDEFINED)
>  		old_state = UART_PM_STATE_OFF;
>  
> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
> +		/* Put BW vote for core clocks and CPU */
> +		ret = icc_set_bw(port->se.icc_path_geni_to_core,
> +			port->se.avg_bw_core, port->se.peak_bw_core);
> +		if (ret)
> +			dev_err(uport->dev, "%s: ICC BW voting failed for core\n",
> +				__func__);
> +
> +		ret = icc_set_bw(port->se.icc_path_cpu_to_geni,
> +			port->se.avg_bw_cpu, port->se.peak_bw_cpu);
> +		if (ret)
> +			dev_err(uport->dev, "%s: ICC BW voting failed for cpu\n",
> +				__func__);
> +
>  		geni_se_resources_on(&port->se);
> -	else if (new_state == UART_PM_STATE_OFF &&
> -			old_state == UART_PM_STATE_ON)
> +	} else if (new_state == UART_PM_STATE_OFF &&
> +			old_state == UART_PM_STATE_ON) {
>  		geni_se_resources_off(&port->se);
> +		/* Remove BW vote from core clocks and CPU */
> +		ret = icc_set_bw(port->se.icc_path_geni_to_core, 0, 0);
> +		if (ret)
> +			dev_err(uport->dev, "%s: ICC BW remove failed for core\n",
> +				__func__);
> +
> +		ret = icc_set_bw(port->se.icc_path_cpu_to_geni, 0, 0);
> +		if (ret)
> +			dev_err(uport->dev, "%s: ICC BW remove failed for cpu\n",
> +				__func__);
> +	}
>  }
>  
>  static const struct uart_ops qcom_geni_console_pops = {
> @@ -1308,6 +1358,17 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
>  	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>  
> +	ret = geni_serial_icc_get(&port->se);
> +	if (ret)
> +		return ret;
> +	/* Set the bus quota to a reasonable value */
> +	port->se.avg_bw_core = console ? Bps_to_icc(1000) :
> +		Bps_to_icc(CORE_2X_50_MHZ);

Why different settings for console vs. non-console?

> +	port->se.peak_bw_core = console ? Bps_to_icc(1000) :
> +		Bps_to_icc(CORE_2X_100_MHZ);
> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
> +	port->se.peak_bw_cpu = Bps_to_icc(1000);

'Bps_to_icc(1000)' is a recurring theme in this series, could it be worth
to have a constant for that? Could be GENI_DEFAULT_BW or similar.
