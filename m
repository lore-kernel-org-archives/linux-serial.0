Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01677C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 13:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbiKRNP4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiKRNP4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 08:15:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE258BD7
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:15:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so8147335lfi.7
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpS6OMnQNzpe68kFFlCyxNNNW9Y6K3sTbRgRVryIroI=;
        b=wy31Hv1A0votwZrng1GvjOLZpRWAKnjM256KulQs63nZjWRyzP3FFMf8U0eiZRR9NB
         NRzU2H5ludSP+Vf+/xeNNPu1NlOS16apkXvCeuvJJNOQN3S/2tuoPOBwA/FENqOLaSYI
         W7rg13KDhpVSKsiJ++Y3vPxn0cXucX2EuEInwiV0IFYQHJ6NRt8maqgVFSC0o6FKtHtO
         ELtHfQr6o+6BVpE7XI2t7RUg/4ASWFHcamAEi8QyABAuvJZ+OW9h6u00MyibLtCJn9Yi
         rXpN3Qj7FrCe7i27YKTBuwxoUcix8BUs3P+WM5DJIUat8mOjFowSiMq/CRx0xoa3qL1Q
         R50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wpS6OMnQNzpe68kFFlCyxNNNW9Y6K3sTbRgRVryIroI=;
        b=taAf49nNssja4P2w85D54yAwCE10Zr7L7LBowlj0d6cDPHs5m4Hb0q1d4YHt5Wi/u1
         77A1cwGYvUwt1RVfG8wMp9xN/GuRSYhiya3iAs94qenyEXVlEFjCC88OwiFScScwydkQ
         u9wM2UfFHYH3EVmk4GaHJaV+agLVxjLRtiF0Oxz+x5azCVsXIzhpk+wa0yE1upfn7ejA
         3247Ly8f38+SsfxWSGsFinCGZS2bZ45RPQYMX1jvkxxFOyhmmc2bQRf1Mu6egmemJHBV
         CzvCnVZfYKAhP1ESJPRuOrnHDiGfAE0onqKyYuBCJwUD7w9VchO5aQAXx6XFb6h1QUxM
         fiDw==
X-Gm-Message-State: ANoB5plyobE/EnDjQemXngOtFeArAfp9HVqzbHp/QLcO7nVXWugPzhSm
        nAjxhr21JbKe1g+8AiEZXIDhgQ==
X-Google-Smtp-Source: AA0mqf6rBOGCcJ6yg04xLjx+/G5hymu/0t4M+/TgKCHQf6JtIwRZvVqK7MeDFC53MZaBj71KJyDlSw==
X-Received: by 2002:a05:6512:34c7:b0:4a2:2b23:f17f with SMTP id w7-20020a05651234c700b004a22b23f17fmr2270089lfr.688.1668777352677;
        Fri, 18 Nov 2022 05:15:52 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id by30-20020a05651c1a1e00b002771057e0e5sm650613ljb.76.2022.11.18.05.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:15:52 -0800 (PST)
Message-ID: <129d2b3b-1cca-5737-efd9-629cbee341f9@linaro.org>
Date:   Fri, 18 Nov 2022 14:15:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 01/15] tty: serial: qcom-geni-serial: drop unneeded
 forward definitions
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
 <20221118122539.384993-2-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> If we shuffle the code a bit, we can drop all forward definitions of
> various static functions.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 79 +++++++++++++--------------
>   1 file changed, 37 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 83b66b73303a..9f2212e7b5ec 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -147,11 +147,6 @@ static const struct uart_ops qcom_geni_console_pops;
>   static const struct uart_ops qcom_geni_uart_pops;
>   static struct uart_driver qcom_geni_console_driver;
>   static struct uart_driver qcom_geni_uart_driver;
> -static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop);
> -static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop);
> -static unsigned int qcom_geni_serial_tx_empty(struct uart_port *port);
> -static void qcom_geni_serial_stop_rx(struct uart_port *uport);
> -static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop);
>   
>   #define to_dev_port(ptr, member) \
>   		container_of(ptr, struct qcom_geni_serial_port, member)
> @@ -590,6 +585,11 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>   	return ret;
>   }
>   
> +static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
> +{
> +	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
> +}
> +
>   static void qcom_geni_serial_start_tx(struct uart_port *uport)
>   {
>   	u32 irq_en;
> @@ -635,25 +635,29 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>   	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
>   }
>   
> -static void qcom_geni_serial_start_rx(struct uart_port *uport)
> +static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
>   {
> -	u32 irq_en;
>   	u32 status;
> +	u32 word_cnt;
> +	u32 last_word_byte_cnt;
> +	u32 last_word_partial;
> +	u32 total_bytes;
>   	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>   
> -	status = readl(uport->membase + SE_GENI_STATUS);
> -	if (status & S_GENI_CMD_ACTIVE)
> -		qcom_geni_serial_stop_rx(uport);
> -
> -	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
> -
> -	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
> -	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
> -	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
> +	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
> +	word_cnt = status & RX_FIFO_WC_MSK;
> +	last_word_partial = status & RX_LAST;
> +	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
> +						RX_LAST_BYTE_VALID_SHFT;
>   
> -	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
> -	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> +	if (!word_cnt)
> +		return;
> +	total_bytes = BYTES_PER_FIFO_WORD * (word_cnt - 1);
> +	if (last_word_partial && last_word_byte_cnt)
> +		total_bytes += last_word_byte_cnt;
> +	else
> +		total_bytes += BYTES_PER_FIFO_WORD;
> +	port->handle_rx(uport, total_bytes, drop);
>   }
>   
>   static void qcom_geni_serial_stop_rx(struct uart_port *uport)
> @@ -694,29 +698,25 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
>   		qcom_geni_serial_abort_rx(uport);
>   }
>   
> -static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
> +static void qcom_geni_serial_start_rx(struct uart_port *uport)
>   {
> +	u32 irq_en;
>   	u32 status;
> -	u32 word_cnt;
> -	u32 last_word_byte_cnt;
> -	u32 last_word_partial;
> -	u32 total_bytes;
>   	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>   
> -	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
> -	word_cnt = status & RX_FIFO_WC_MSK;
> -	last_word_partial = status & RX_LAST;
> -	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
> -						RX_LAST_BYTE_VALID_SHFT;
> +	status = readl(uport->membase + SE_GENI_STATUS);
> +	if (status & S_GENI_CMD_ACTIVE)
> +		qcom_geni_serial_stop_rx(uport);
>   
> -	if (!word_cnt)
> -		return;
> -	total_bytes = BYTES_PER_FIFO_WORD * (word_cnt - 1);
> -	if (last_word_partial && last_word_byte_cnt)
> -		total_bytes += last_word_byte_cnt;
> -	else
> -		total_bytes += BYTES_PER_FIFO_WORD;
> -	port->handle_rx(uport, total_bytes, drop);
> +	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
> +
> +	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
> +	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
> +	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
> +
> +	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> +	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
> +	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>   }
>   
>   static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
> @@ -1122,11 +1122,6 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>   	qcom_geni_serial_start_rx(uport);
>   }
>   
> -static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
> -{
> -	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
> -}
> -
>   #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
>   static int qcom_geni_console_setup(struct console *co, char *options)
>   {
