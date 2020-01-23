Return-Path: <SRS0=uJPQ=3M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81EAC2D0DB
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 17:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D53C21D7D
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 17:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R/b7Clp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAWRcy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:32:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44338 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgAWRcx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jan 2020 12:32:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so1620377plo.11
        for <linux-serial@vger.kernel.org>; Thu, 23 Jan 2020 09:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cn2kDStsAggWDVeBBXF5FEcvF6C1Xy8Sn1IsJbRSZpQ=;
        b=R/b7Clp2J+T/A56VYmhp5pO07BPp9f4ap3hcckjzvXsFPBAnt5kOIkdHpR4Tjhsan+
         IIMulA4tlWvPMdz9A8iFJ+UjsaC3m7/PTQfviOI1rIKbydKZbM9QJJN+WjQMBrYQU35d
         L38ojc0zwdcey5hY1awXwvGNgnskBm0LxNRoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cn2kDStsAggWDVeBBXF5FEcvF6C1Xy8Sn1IsJbRSZpQ=;
        b=gcKhvLBxnIjlTkjXDdwmDVI7yYxky2TrbKb3oAgLzZRjIlvN66Yg0hFaYIJmt2mbvx
         4pmZmXwRDWXMd0fBOw1bebQe2naXAeqhnGRwlPSFQIiKbu64yPUf+qEFY23DZn4UXmjT
         yVaa0yz6ziAhAl2zbfDQyTlTvqAyCFjAbJvu5TNgIXTHxhHdgqd72DDcM5Ivw/mmt7Ht
         L+HFf/00UhRmXFzm8+j9HzbqOLqleywLRUIVRKXR+KkXN5timnPldMpHhp16IKQBjjeu
         cacCylzTm1B+L3DO71TLRVTHdUE7s0dMOWs/7ZSXXCRxlOFmqLvAnSkfiQMXdhhctmKG
         R+1g==
X-Gm-Message-State: APjAAAXOfKrXQwJMDIUK84+AvMYvsrLUIGpi96xMn0YEP8xJzfHQ4Rgi
        o0Tz5fvW2PaBNPPs+nj5Ri0Azg==
X-Google-Smtp-Source: APXvYqzQTSHmkg4ULZgug15BPjQThRPOX+QNUcDexASCQIbIXIYZLBu+6TAU8pQlmQZrNjTotZlMlQ==
X-Received: by 2002:a17:90a:eb14:: with SMTP id j20mr5678665pjz.95.1579800773170;
        Thu, 23 Jan 2020 09:32:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x18sm3504185pfr.26.2020.01.23.09.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:32:52 -0800 (PST)
Date:   Thu, 23 Jan 2020 09:32:50 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        mgautam@codeaurora.org, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/1] tty: serial: qcom_geni_serial: Configure
 UART_IO_MACRO_CTRL register
Message-ID: <20200123173250.GX89495@google.com>
References: <20200123124802.24862-1-rojay@codeaurora.org>
 <20200123124802.24862-2-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200123124802.24862-2-rojay@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Roja,

On Thu, Jan 23, 2020 at 06:18:02PM +0530, Roja Rani Yarubandi wrote:

> subject: tty: serial: qcom_geni_serial: Configure UART_IO_MACRO_CTRL register

Something like 'Support pin swapping' would be more useful.

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
> +	if (!ret)
> +		writel(val, uport->membase + SE_UART_IO_MACRO_CTRL);
> +

Which pins are/can be inversed only RX/TX or also CTS/RTS? If both pairs can be
inversed individually it would be nice to support that.

As Bjorn commented, it's probably better to have boolean properties and keep the
magic values in the driver.
