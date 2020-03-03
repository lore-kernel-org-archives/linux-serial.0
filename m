Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603A9C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E220866
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583261265;
	bh=lSa7np7Lnx2hwojjbDQUicjfMs6ZAecuviJeb+Mjxno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rF48S13b3tm/BlLfwAYJNmlyDx9s5UceYqVY96zlWiXRH2/YmqNd00ktqiF/fyPaM
	 dDbg8X7+QrQaCX9sYVC3YCoVoGhOItNBn/N94U9JU3RnxBLQihIu2RyVt+T/vXe8kN
	 wGiB33OBdWIqV9jjEhKHJxGrWsAdoZGKPjYA1szM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgCCSrm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:47:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39430 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCCSrl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 13:47:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id x97so4082438ota.6;
        Tue, 03 Mar 2020 10:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V16aal7zag3kMsr09Mn6Pwm+yaS63ymnYzw5shFWl8o=;
        b=hPPd8kp79gKGNtyGE61o3kO8/xGa4wfSN3K9mSGqWCAuX5YjJl9JxKZfNSNkQyukGY
         xmoawkOIa7R97kUou2yF+hYqHRU++xU90KvpDYN/dxDT+MbOX/vsd0VJOvwSQYjUkwI2
         tx8y0lc1kRM/D/GIBr8ee/0I6XcnnlldgpUEZisVaPo3cFDeTB2/bdVowCP56XtZUlHT
         y7jHymiZFOK1/DDA0ocsUTQoEgzm9gcadgyVZ59bx363QHN6luHtiKoPffFuzk+ZMruA
         iJWySNHhe/SkbvfwAQZJKNGOWDK0hX5FiIbjtZ5b7VmNnqY1lL2W/QuB/UNqZlww+fGr
         87CQ==
X-Gm-Message-State: ANhLgQ1tXVTvr/fMzxrTM9KbRV4BLFvw+oKAuhSO688q+kSWOl83ID3Y
        s8LH3NfOTG2F9l1auIoeyQ==
X-Google-Smtp-Source: ADFU+vtZ2kBjLYMbCupGtxnCYEydzNp//c2n2ytmjC5DrFRFmsm+XNsR1sLMnsSr9bp4FbQOOdzObw==
X-Received: by 2002:a9d:5e82:: with SMTP id f2mr4317186otl.240.1583261259115;
        Tue, 03 Mar 2020 10:47:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s2sm766013otp.35.2020.03.03.10.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 10:47:38 -0800 (PST)
Received: (nullmailer pid 20625 invoked by uid 1000);
        Tue, 03 Mar 2020 18:47:37 -0000
Date:   Tue, 3 Mar 2020 12:47:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>
Subject: Re: [PATCH v3 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for
 DMA
Message-ID: <20200303184737.GD26191@bogus>
References: <20200303174306.6015-1-michael@walle.cc>
 <20200303174306.6015-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303174306.6015-4-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 03, 2020 at 06:43:00PM +0100, Michael Walle wrote:
> The DMA channel might not be available at probe time. This is esp. the
> case if the DMA controller has an IOMMU mapping.

The subject should be updated as this doesn't involve deferred probe any 
more. 

> There is also another caveat. If there is no DMA controller at all,
> dma_request_chan() will also return -EPROBE_DEFER. Thus we cannot test
> for -EPROBE_DEFER in probe(). Otherwise the lpuart driver will fail to
> probe if, for example, the DMA driver is not enabled in the kernel
> configuration.
> 
> To workaround this, we request the DMA channel in _startup(). Other
> serial drivers do it the same way.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 84 +++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c31b8f3db6bf..0b8c477b32a3 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1493,36 +1493,63 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
>  static void lpuart_tx_dma_startup(struct lpuart_port *sport)
>  {
>  	u32 uartbaud;
> +	int ret;
>  
> -	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> -		init_waitqueue_head(&sport->dma_wait);
> -		sport->lpuart_dma_tx_use = true;
> -		if (lpuart_is_32(sport)) {
> -			uartbaud = lpuart32_read(&sport->port, UARTBAUD);
> -			lpuart32_write(&sport->port,
> -				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
> -		} else {
> -			writeb(readb(sport->port.membase + UARTCR5) |
> -				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> -		}
> +	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
> +	if (!sport->dma_tx_chan) {
> +		dev_info_once(sport->port.dev,
> +			      "DMA tx channel request failed, operating without tx DMA\n");

Might be useful to print the errno too.

Rob
