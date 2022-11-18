Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772A2C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 13:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiKRNZo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRNZm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 08:25:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCE77219
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:25:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g12so8214707lfh.3
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kapE2v0JHZ02uPRIVgcnwVxONruhv1mLma4lDZtjiEY=;
        b=OHwDoo02uokIDLnPvOVtvTnpKIMNMMhALrAvNb33Cu4xUwcksguGzcgQq5VREzrXy8
         ttRx2CYhUniEGztgoEI2dgohx4KtlC6G9UGDb38BusYNh5lC1Sw0gLevpzw775xkv4mu
         qw5nrSgoy5YkvSPgDxoDaRUfJS3hTmHnkyy8ydNOuCgeh/KKyZoPSChIhk5U8fC0OL42
         7JYdBA+TqeY8eFAL5Gg6zmvohjn+UmBkZ8W3pPcMm497im2UCQHsGhWr/etziebTaBTr
         Y0H/CXcdJ1XmR8f4C2sdijrtHlZFN6nwASIFSG7YkY3aQZm6GZIX2z6AiZBkVJzBG33Y
         H7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kapE2v0JHZ02uPRIVgcnwVxONruhv1mLma4lDZtjiEY=;
        b=c7awtVd7vWowtWJSppblwGb2MRXFpNEO0JOYQXhM/LpSf5d7OajXBtl6ApsmIn6DvH
         bXl51aM5diGdEPYgZI5tcNqiL5ySZGaPQpq+xOpGfjNNS+e1FbPU5PbME0zCCUYJ+qP1
         el9YTsNBU5mV2JVIroJfgxJBEhzmttka1yBQRnL/fYPGxqBpd7P8sTIsrw1kvN97xLvt
         hX5B0KNyMEAVClhlhF9P+x6jJPB28hLPym9tKhAUkEYVMK4Mynh4Y/eV8oG3bNN9oIVU
         IuD83sk8l7RekbS/f8XtzdWOAi+/3wmpGiPRIQFqjIK+C7Mb5fKvj8MSMc0pmBo7NC/k
         fCPg==
X-Gm-Message-State: ANoB5pkLN8A3cFN7Ltq+rkcuVYFsPQA1qQLvg7zE5LuMPwUGXruSST1V
        FWvBxJZYcQQnUSEjNN5yxHr1IA==
X-Google-Smtp-Source: AA0mqf5CN40n3DpardgQJrh0reklw6pNVlXFRZU2ODOjtE+Aesqg8qbKiQtpENZvULHSNciz4rGgbA==
X-Received: by 2002:ac2:434a:0:b0:4a2:46f8:24bc with SMTP id o10-20020ac2434a000000b004a246f824bcmr2333336lfl.180.1668777939898;
        Fri, 18 Nov 2022 05:25:39 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id n4-20020ac24904000000b00492d064e8f8sm656734lfi.263.2022.11.18.05.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:25:39 -0800 (PST)
Message-ID: <cf1dcebb-d56e-c222-0e08-e0e658ba41ab@linaro.org>
Date:   Fri, 18 Nov 2022 14:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 07/15] tty: serial: qcom-geni-serial: remove unneeded tabs
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
 <20221118122539.384993-8-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-8-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Remove redundant indentation in struct member assignment.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 22c1869c60f4..39041538e5d2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -138,26 +138,26 @@ static struct uart_driver qcom_geni_uart_driver;
>   static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
>   	[0] = {
>   		.uport = {
> -				.iotype = UPIO_MEM,
> -				.ops = &qcom_geni_uart_pops,
> -				.flags = UPF_BOOT_AUTOCONF,
> -				.line = 0,
> +			.iotype = UPIO_MEM,
> +			.ops = &qcom_geni_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.line = 0,
>   		},
>   	},
>   	[1] = {
>   		.uport = {
> -				.iotype = UPIO_MEM,
> -				.ops = &qcom_geni_uart_pops,
> -				.flags = UPF_BOOT_AUTOCONF,
> -				.line = 1,
> +			.iotype = UPIO_MEM,
> +			.ops = &qcom_geni_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.line = 1,
>   		},
>   	},
>   	[2] = {
>   		.uport = {
> -				.iotype = UPIO_MEM,
> -				.ops = &qcom_geni_uart_pops,
> -				.flags = UPF_BOOT_AUTOCONF,
> -				.line = 2,
> +			.iotype = UPIO_MEM,
> +			.ops = &qcom_geni_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.line = 2,
>   		},
>   	},
>   };
