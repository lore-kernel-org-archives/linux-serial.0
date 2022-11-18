Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7BFC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 13:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiKRNXQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbiKRNXN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 08:23:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476479924
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:23:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so8201807lfv.5
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGk0T32TBu5Feib+GN4MZpX75E7t6+QlVj5xDhxgrhg=;
        b=ZeZyveJTXKuuJzzddyWhZo73GbwQMoPxOHdUyzaykfPA3crzFwOqn5rM/6f+iGZXPE
         x0hE/kYfF1LZzsKr4FCvtmVn98l+eF77HP4adbZl7m5t2skDhKDZyn4AhfWoYM8ial9k
         yrertMFJdaT8RgpC0wfFKUNkwRViEkCXp7GioMGZa0kOZhGQPWdC9XLfqnndPEMIOX+w
         CsKxv55UoOw5456X4mD6vWma/r1w91Px3cEprtHEVytrS9bkwCMJqyGrZEuQ6dGVY+Tc
         XChNCZF+xYK1wcz5qBUqeGbSALbM98DNQsfXOfObdDa4wFLEGg7FDpljobYqLiCjUps3
         YBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGk0T32TBu5Feib+GN4MZpX75E7t6+QlVj5xDhxgrhg=;
        b=M6w+30641xIgnYRiN6l0FvkVFOvotvWgZpyFNbPvq5lWDUftAEKAspHJxXTNa1wYfn
         +yrcQpF9jqx73eTlzRZw/3DUiR7FqrnQ/1IsiTJsgVongDnN6JXfGqEsWIxujfAoj34+
         Wbc9RClCr6rJsqzcirhLTurUuNzasaO0ugHyPI6YSWGKetVItzrpOmNEnf/RgDCY8m63
         dP8zoMpKCqpjuqYG4cZ5qKaQXUphOqN9kcGvJ3aKMGtEvINBCid0LmypPRpjvPaGLx+t
         TAZ70xe0NCep8ANQ+Q1GNf88qgFPcXJ16t7dYfKeJR9hrrLpQw4ivR2BzQHiBhqQHEHO
         4yIA==
X-Gm-Message-State: ANoB5pmNCfAuFb5ikTuVtOzBR+XvVcyMzXTHHYtdPay/0TO6CDnsbKhJ
        xmy0liz1QCKZTMYrweV4odkSkA==
X-Google-Smtp-Source: AA0mqf5v7a49GTkiDgFNOAvwfh1TRTOts9M5NJut4SRWEqdzvDgbQrEVjFmPcwaEz5mpvodWykTJEw==
X-Received: by 2002:ac2:5593:0:b0:4b0:40e5:6c2f with SMTP id v19-20020ac25593000000b004b040e56c2fmr2280738lfg.301.1668777789954;
        Fri, 18 Nov 2022 05:23:09 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id i16-20020a198c50000000b0048afb8b8e53sm659911lfj.80.2022.11.18.05.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:23:09 -0800 (PST)
Message-ID: <1d8459b6-e4d3-3e6b-7e6f-bc55bd9bfa8b@linaro.org>
Date:   Fri, 18 Nov 2022 14:23:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 05/15] tty: serial: qcom-geni-serial: remove stray
 newlines
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
 <20221118122539.384993-6-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Remove stray newlines around #ifdefs for consistency with the rest
> of the driver code.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 1db2795804e9..dd1491a72deb 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -317,7 +317,6 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
>   }
>   
>   #ifdef CONFIG_CONSOLE_POLL
> -
>   static int qcom_geni_serial_get_char(struct uart_port *uport)
>   {
>   	struct qcom_geni_private_data *private_data = uport->private_data;
> @@ -542,7 +541,6 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>   {
>   	return -EPERM;
>   }
> -
>   #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
>   
>   static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
