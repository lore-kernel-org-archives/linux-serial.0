Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4330C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 13:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiKRN1S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbiKRN1O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 08:27:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275585A3A
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:27:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g12so8220815lfh.3
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb+SwYsu46wttKtERbGl06o8mw6wcmAJG3y7WTEqJgM=;
        b=LGWJY5OcVIgYmrgPT635tYwh7YyerAwyfo4NKcT05MTRTX+6wCdshy8MEs2yY3BCBp
         6nbpwyu1cuwknY6xVSygjntz7X4Kze+vYFZZ/0OdBA6dD4fOsXgORcJkVPen9orgJ0VR
         y/RJZ2XL4wvHKvSYb26v/pJC4a3kydo5EtGFk2GYCVFSXiNLzYqR1u8tnsaYopjsclqJ
         GV8eCNoC7tM63SvZSQ48WXJRZjW98a45NddqKq5W7irawHizWcs1DtOnj5SaFFInr1ht
         i3nfkCcpOSTsItjYVwhGicMFAF4OC6bU8NOLMFD42CZyaZUrWeoktdrmJi2uyyRAB20s
         fgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pb+SwYsu46wttKtERbGl06o8mw6wcmAJG3y7WTEqJgM=;
        b=WdYV/JrQUUtS+DdP4lLdy6mkI3UQdtzhyf0q6Yna2yPKXb8KpTpB0YHnifoSBW26+J
         OtZ3xhvz7ld+fzgo73ZFCX05TJxqndh5l5tcCyEsGMTbC6vmHPYUySevq9MRYr3gZLJb
         1fCvXY6bdwFfO8T48UPknQiY9NBX8smmt+YIbC5vRfzkv7yIxRe+ZUf06rtbmia6vt2U
         nr5+bOm5We2doD5s5843WDSxnv+crJJzKanvgeUcKJjzxzhHPpAZ5V4+ZYndXlfHtZk3
         o5TFV+uK/ZfK82NT6Zg2YpPvFhqzp3iBK0o7quq1PfesN3zFcrdOIZGRz8AjI/FjXaiz
         zlyQ==
X-Gm-Message-State: ANoB5pmVOCqTusIQjmups1PqosFwZhE2/AWC7wvrW1LULL4EYzT2Gizw
        veAnezqTpfBOxfhv1am367UygA==
X-Google-Smtp-Source: AA0mqf48HjEBueln40TrF7hdJp8v3REaMkCfFZLfFIfNZ2tcnoOGLlb9dgnOseF8Xhbjg2nQC9b0pA==
X-Received: by 2002:a19:5047:0:b0:4ab:7f8d:46c with SMTP id z7-20020a195047000000b004ab7f8d046cmr2298905lfj.383.1668778030685;
        Fri, 18 Nov 2022 05:27:10 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id z8-20020a056512370800b00497a3e11608sm654209lfr.303.2022.11.18.05.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:27:10 -0800 (PST)
Message-ID: <2ccecd72-0c6e-1268-0406-8f147d4b1091@linaro.org>
Date:   Fri, 18 Nov 2022 14:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 08/15] tty: serial: qcom-geni-serial: split out the FIFO
 tx code
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20221118122539.384993-1-brgl@bgdev.pl>
 <20221118122539.384993-9-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-9-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> qcom_geni_serial_handle_tx() is pretty big, let's move the code that
> handles the actual writing of data to a separate function which makes
> sense in preparation for introducing a dma variant of handle_tx().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 60 +++++++++++++++------------
>   1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 39041538e5d2..4b155ca0ac74 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -701,19 +701,48 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>   	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>   }
>   
> +static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
> +					    unsigned int chunk)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct circ_buf *xmit = &uport->state->xmit;
> +	size_t remaining = chunk;
> +	int i, tail = xmit->tail;
> +
> +	for (i = 0; i < chunk; ) {
> +		unsigned int tx_bytes;
> +		u8 buf[sizeof(u32)];
> +		int c;
> +
> +		memset(buf, 0, sizeof(buf));
> +		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
> +
> +		for (c = 0; c < tx_bytes ; c++) {
> +			buf[c] = xmit->buf[tail++];
> +			tail &= UART_XMIT_SIZE - 1;
> +		}
> +
> +		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
> +
> +		i += tx_bytes;
> +		uport->icount.tx += tx_bytes;
> +		remaining -= tx_bytes;
> +		port->tx_remaining -= tx_bytes;
> +	}
> +
> +	return tail;
> +}
> +
>   static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>   		bool active)
>   {
>   	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   	struct circ_buf *xmit = &uport->state->xmit;
>   	size_t avail;
> -	size_t remaining;
>   	size_t pending;
> -	int i;
>   	u32 status;
>   	u32 irq_en;
>   	unsigned int chunk;
> -	int tail;
>   
>   	status = readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
>   
> @@ -732,7 +761,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>   	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
>   	avail *= BYTES_PER_FIFO_WORD;
>   
> -	tail = xmit->tail;
>   	chunk = min(avail, pending);
>   	if (!chunk)
>   		goto out_write_wakeup;
> @@ -747,29 +775,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>   					uport->membase + SE_GENI_M_IRQ_EN);
>   	}
>   
> -	remaining = chunk;
> -	for (i = 0; i < chunk; ) {
> -		unsigned int tx_bytes;
> -		u8 buf[sizeof(u32)];
> -		int c;
> -
> -		memset(buf, 0, sizeof(buf));
> -		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
> -
> -		for (c = 0; c < tx_bytes ; c++) {
> -			buf[c] = xmit->buf[tail++];
> -			tail &= UART_XMIT_SIZE - 1;
> -		}
> -
> -		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
> -
> -		i += tx_bytes;
> -		uport->icount.tx += tx_bytes;
> -		remaining -= tx_bytes;
> -		port->tx_remaining -= tx_bytes;
> -	}
> -
> -	xmit->tail = tail;
> +	xmit->tail = qcom_geni_serial_send_chunk_fifo(uport, chunk);
>   
>   	/*
>   	 * The tx fifo watermark is level triggered and latched. Though we had
