Return-Path: <SRS0=uJPQ=3M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17215C33CB6
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D3E21835
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM+qRMYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAWQIo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:08:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42596 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAWQIn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jan 2020 11:08:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so1586898pgb.9
        for <linux-serial@vger.kernel.org>; Thu, 23 Jan 2020 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=td46G8H/xG3KwKZVoWzOjjmv0BfVbkqqajOdOX1P7gY=;
        b=lM+qRMYpFmvxGN+/4LhnZq4sqRW6FLBBMnhUm0cU5iKquVddBZxPgV/elfaSzzEO77
         vj3MsgXT9yuc/fP9pFOrTf+q0gQHGhRPHkoxFOhYkHqF6sCKpolIG+LqdkLSXFxQCh1c
         uLBvwDYe69yYr5Ab8NL9YcTU4dIQjwq7ctGUR/RKZ8jvjJddtbHpZFaK9eGVsAF+AsXR
         ZUOoCLEmDSHw6KuwivGzgSEpCB0BUXPv8GON4AkN/4lDqw2T8ObUpfi+vM5qE9uACjGh
         i7BKwexFGTKGtAhOgr6n6x6fd81CcOhuUpv+RrLuEz/wUcmxPEbQciYeMCw5jyTgIA5p
         ZFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=td46G8H/xG3KwKZVoWzOjjmv0BfVbkqqajOdOX1P7gY=;
        b=ZSq81vKdi8Qhn0NIV9cQX/qBDVGE6EL37YYjhE8t+lTYZPrI3OqlaaT1DSjgyViC2e
         0eyGIZepJVr6KqEYgZq6B1oZjoMSnV3+YXaGtORqLeGpJdJ1r9zxilOrs8DXBtbtOdb+
         9RbMh7v9X94xQz8kpZ7NCeYJS3ZtpR5EaiSMWmIcuPsZvgjsBbBre0UxjZsvx6sCRpDV
         ndbrPDHjsJukRCdQDFGnb+fxRs1P4qCfzwrZLE9whG8AO1rdxp50JzxrJW7WZsVU8okO
         +TyXhTQfCiuUJzToGaUddpll+Hx/hrekG28EwWcUQfLmjcYftn0FdZO4fcwdc9pii6ZN
         hlPg==
X-Gm-Message-State: APjAAAWDadkA+vwyjDiR1+ZLP0J8tc5EIUsseTYIDNQAVzjkW7PuIiE0
        4VmBrjoCNLKrT8tnGbWW2u1TAg==
X-Google-Smtp-Source: APXvYqyWFE/06GhooYKazl6pIep62Iz/i5wyCJpTVPsFAFVDTHngEfFdHOY7P3gqOAl2IQhW45vjSw==
X-Received: by 2002:a63:4006:: with SMTP id n6mr4591570pga.139.1579795722829;
        Thu, 23 Jan 2020 08:08:42 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u12sm3214680pfm.165.2020.01.23.08.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:08:42 -0800 (PST)
Date:   Thu, 23 Jan 2020 08:08:39 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        mgautam@codeaurora.org, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tty: serial: qcom_geni_serial: Configure
 UART_IO_MACRO_CTRL register
Message-ID: <20200123160839.GB3888@tuxbook-pro>
References: <20200123124802.24862-1-rojay@codeaurora.org>
 <20200123124802.24862-2-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123124802.24862-2-rojay@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu 23 Jan 04:48 PST 2020, Roja Rani Yarubandi wrote:

> Configure UART_IO_MACRO_CTRL register if UART lines are swapped.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index ff63728a95f4..24b862937c1e 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -24,6 +24,7 @@
>  
>  /* UART specific GENI registers */
>  #define SE_UART_LOOPBACK_CFG		0x22c
> +#define SE_UART_IO_MACRO_CTRL		0x240
>  #define SE_UART_TX_TRANS_CFG		0x25c
>  #define SE_UART_TX_WORD_LEN		0x268
>  #define SE_UART_TX_STOP_BIT_LEN		0x26c
> @@ -1260,6 +1261,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	int irq;
>  	bool console = false;
>  	struct uart_driver *drv;
> +	u32 val;
>  
>  	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
>  		console = true;
> @@ -1309,6 +1311,10 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  		return irq;
>  	uport->irq = irq;
>  
> +	ret = of_property_read_u32(pdev->dev.of_node, "qcom,pin_inverse", &val);

This needs to be documented in the DT binding document. And I assume
it's better suited as a bool property to be read using
of_property_read_bool().

Also avoid '_' in property names and make it a '-'.

Regards,
Bjorn

> +	if (!ret)
> +		writel(val, uport->membase + SE_UART_IO_MACRO_CTRL);
> +
>  	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
>  	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
>  			IRQF_TRIGGER_HIGH, port->name, uport);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of the Code Aurora Forum, hosted by The Linux Foundation
> 
