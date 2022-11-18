Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A68C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 13:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiKRNXA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiKRNW7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 08:22:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140867123
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:22:57 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d6so8168347lfs.10
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y/NJMA9OU8Y7+Vna/eWr74ORgVoY2wrkfeVPZDTqqo=;
        b=BMf+lGvbMAauJWTVUrq2bdqs4miMKlJDqXvaWPOT8BO6Lbzi8SfTlypNJmHJZCAjJX
         Hn5ZDXQC3HO+zrML3lVpGGW3Ikb7tCGd2ZZsUqxLFZu4z1iDg7SQno7nOrfeWt1WXlmF
         syZROcYMbtMm/EplrF/GBggMTNaQG7dUo+2dPujdMwcNU2npeUlKk+TUaj4EzIhCLlZD
         nb1KwIew8VfcJLfspMX8VZV6p9+f7FFHgoO+UqyfVn1m0UAckolV9LX7TSkRxeShEI0I
         zRnzZDsCko7B3IBQ0Lex3rCHxrUgj+3RP+XsI4zPpFP9ebnUU5oa41+wOx+bNX7Ronvd
         QrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Y/NJMA9OU8Y7+Vna/eWr74ORgVoY2wrkfeVPZDTqqo=;
        b=vfjVgSHksUXrTF+xW7eTg2WaVfulFQ/xVT36YOAvLwT+hiS9ZB4otjogAEFPcBqz91
         exYi5GVVFGGZT5RHbCiexRTm7HGPBhAaaeh9SAFSrxnKhDrQsT4F7UXwQnltPX/OOZ26
         uVuHGDrMdNPSTTTrNs85MPmO9egu6NaBm8ibLXkUlh1ZkstaZjqFgkezHi09VweeTwNK
         6ywUa3Q9G9TONoHZpo34szs/BOUg2WLSThetftMKkA8mO+GHnpx78WZtOOnl4Z+Rqvqd
         FKEKcum25RhZo7oEBLMHc48BbD99cbkHLhKjV18HVDvh2Fpgh9+KkIHxIj7bSJgbcUyt
         Z6VQ==
X-Gm-Message-State: ANoB5pkWocj2xsw7Psbz5LDGvOZqho5fEF4UmNxIwMivw7f4hWXvB4v/
        jmaj9HTueEySOMNA26BQQV2xIg==
X-Google-Smtp-Source: AA0mqf4Kj8fmK3VTzmt0R20WCEFY6dsVfbQWr6dAgfmKGT4nwdQBHCuuPh3xLfqsFG9G8Tr5kSAf3Q==
X-Received: by 2002:a05:6512:32cb:b0:4ab:5a19:3455 with SMTP id f11-20020a05651232cb00b004ab5a193455mr2295741lfg.462.1668777776031;
        Fri, 18 Nov 2022 05:22:56 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id s10-20020a05651c048a00b002770e6c620bsm626793ljc.106.2022.11.18.05.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:22:55 -0800 (PST)
Message-ID: <4a448ef5-cba6-7159-1e73-2e5a2fa8791b@linaro.org>
Date:   Fri, 18 Nov 2022 14:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 04/15] tty: serial: qcom-geni-serial: simplify the
 to_dev_port() macro
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
 <20221118122539.384993-5-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The member we want to resolve in struct qcom_geni_serial_port is called
> uport so we don't need an additional redundant parameter in this macro.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 33 +++++++++++++--------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 97ee7c074b79..1db2795804e9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -133,8 +133,7 @@ static const struct uart_ops qcom_geni_uart_pops;
>   static struct uart_driver qcom_geni_console_driver;
>   static struct uart_driver qcom_geni_uart_driver;
>   
> -#define to_dev_port(ptr, member) \
> -		container_of(ptr, struct qcom_geni_serial_port, member)
> +#define to_dev_port(ptr) container_of(ptr, struct qcom_geni_serial_port, uport)
>   
>   static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
>   	[0] = {
> @@ -175,7 +174,7 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
>   static int qcom_geni_serial_request_port(struct uart_port *uport)
>   {
>   	struct platform_device *pdev = to_platform_device(uport->dev);
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	uport->membase = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(uport->membase))
> @@ -212,7 +211,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>   							unsigned int mctrl)
>   {
>   	u32 uart_manual_rfr = 0;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	if (uart_console(uport))
>   		return;
> @@ -253,7 +252,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
>   	struct qcom_geni_private_data *private_data = uport->private_data;
>   
>   	if (private_data->drv) {
> -		port = to_dev_port(uport, uport);
> +		port = to_dev_port(uport);
>   		baud = port->baud;
>   		if (!baud)
>   			baud = 115200;
> @@ -506,7 +505,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>   	u32 i;
>   	unsigned char buf[sizeof(u32)];
>   	struct tty_port *tport;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	tport = &uport->state->port;
>   	for (i = 0; i < bytes; ) {
> @@ -549,7 +548,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>   static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>   {
>   	struct tty_port *tport;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
>   	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
>   	int ret;
> @@ -598,7 +597,7 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>   {
>   	u32 irq_en;
>   	u32 status;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>   	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
> @@ -627,7 +626,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
>   	u32 last_word_byte_cnt;
>   	u32 last_word_partial;
>   	u32 total_bytes;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
>   	word_cnt = status & RX_FIFO_WC_MSK;
> @@ -649,7 +648,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
>   {
>   	u32 irq_en;
>   	u32 status;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   	u32 s_irq_status;
>   
>   	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
> @@ -687,7 +686,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>   {
>   	u32 irq_en;
>   	u32 status;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	status = readl(uport->membase + SE_GENI_STATUS);
>   	if (status & S_GENI_CMD_ACTIVE)
> @@ -707,7 +706,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>   static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>   		bool active)
>   {
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   	struct circ_buf *xmit = &uport->state->xmit;
>   	size_t avail;
>   	size_t remaining;
> @@ -803,7 +802,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>   	struct uart_port *uport = dev;
>   	bool drop_rx = false;
>   	struct tty_port *tport = &uport->state->port;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	if (uport->suspended)
>   		return IRQ_NONE;
> @@ -869,7 +868,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
>   
>   static int qcom_geni_serial_port_setup(struct uart_port *uport)
>   {
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
>   	u32 proto;
>   	u32 pin_swap;
> @@ -917,7 +916,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>   static int qcom_geni_serial_startup(struct uart_port *uport)
>   {
>   	int ret;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	if (!port->setup) {
>   		ret = qcom_geni_serial_port_setup(uport);
> @@ -1003,7 +1002,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>   	u32 stop_bit_len;
>   	unsigned int clk_div;
>   	u32 ser_clk_cfg;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   	unsigned long clk_rate;
>   	u32 ver, sampling_rate;
>   	unsigned int avg_bw_core;
> @@ -1288,7 +1287,7 @@ static struct uart_driver qcom_geni_uart_driver = {
>   static void qcom_geni_serial_pm(struct uart_port *uport,
>   		unsigned int new_state, unsigned int old_state)
>   {
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>   
>   	/* If we've never been called, treat it as off */
>   	if (old_state == UART_PM_STATE_UNDEFINED)
