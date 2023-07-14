Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379A2EB64DC
	for <linux-serial@archiver.kernel.org>; Fri, 14 Jul 2023 14:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjGNO0X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNO0V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jul 2023 10:26:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AD1727
        for <linux-serial@vger.kernel.org>; Fri, 14 Jul 2023 07:26:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so3444666e87.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Jul 2023 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689344779; x=1691936779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1MktFbHOOv+Kn/FxXrHSBEsV3/kw33vL9amAL3fXC8=;
        b=CgcwxqQ/sADRzMb2kghXATgBzjxErwHL3/rP0GEyaHKS9a2SaTw1z/lzHUhFWg//kx
         ovGtIsIzXIq8QI+7d+tOR8tsXJDp5irssNG3JBYbe7V0UpSflSV9CNWOoaVcaHG0P2/2
         alhMQ4JPVp47GeQnN/T70wbulWefQdrEHyTe4B3fJBH9l7Sh730Tfm1r7fjPWURL4O+y
         YRtg6ckpJKoBgStEE+ViFfAshq6nRkbLMv/HBiunon6lZkZvt7sOpedXpVN70ZjEH6xG
         ueZqkWjH1QQK2QpRYIMXZmV5CJDZ0oPFiebC+VSBwwxeKe+wshtwUAZXKPyxz2Y8oRoc
         bCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344779; x=1691936779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1MktFbHOOv+Kn/FxXrHSBEsV3/kw33vL9amAL3fXC8=;
        b=Vwd7ioqI1NYofkh4LkrswQX46yYGrujw3tiJWMbXya7tzEV4uhwonGXIf+xNBWOsBD
         1pHj1pXuxeot6fvXHFTq04XlBz0D4RQzb0Rl7UrVTf9G+iyZifcN/PlXudaNYViAt1Z9
         MPTJrKJ/JkQ2YU8jGkZ0e5t+sXddi+N5rOTrhd6KLGulJvVQLLZSFaMT0OKsCaXfQlIc
         zV9xasIJWc+Q3KghT5IIdriav/6J9NaGOB8JhZv2n9gfwiQoNR6k67jwMmvgWVUODHPQ
         HiaCCFvv3eP07pf8Q2d0xiD/G0SklIGfIHuj9DEv/yZozmBJbokt24hZE1LZ16mxutq9
         Cqpg==
X-Gm-Message-State: ABy/qLYf+aK5FQSCxpemQmoljeIcvq/VxsU/VV8g7f6PHnIcsztEga4Z
        TLjvgG1f//nGdiVuF5ZfucVqezznSZ3Zz9KI4R0vtA==
X-Google-Smtp-Source: APBJJlHDSPIBujDxycbxSwnbbwHAuTOd5PJlJSnYMLtChpucdw9HiE87LhLhD1jRigM5LrXksOdm9A==
X-Received: by 2002:ac2:4e05:0:b0:4f8:7513:8cac with SMTP id e5-20020ac24e05000000b004f875138cacmr4256090lfr.48.1689344778900;
        Fri, 14 Jul 2023 07:26:18 -0700 (PDT)
Received: from [192.168.1.101] (abxj146.neoplus.adsl.tpnet.pl. [83.9.3.146])
        by smtp.gmail.com with ESMTPSA id w18-20020a19c512000000b004fcdea15de2sm186577lfe.309.2023.07.14.07.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:26:18 -0700 (PDT)
Message-ID: <d73d0281-14fc-222f-e28d-cd49aced8768@linaro.org>
Date:   Fri, 14 Jul 2023 16:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] serial: qcom-geni: clean up clock-rate debug printk
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230714130214.14552-1-johan+linaro@kernel.org>
 <20230714130214.14552-3-johan+linaro@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230714130214.14552-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14.07.2023 15:02, Johan Hovold wrote:
> Make the clock-rate debug printk more readable by using an equal sign
> instead of a dash as separator between names and values and adding some
> spaces:
> 
> 	qcom_geni_serial 988000.serial: desired_rate = 1843200, clk_rate = 7372800, clk_div = 4
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 8be896dbaa88..753ac68d03a6 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1246,7 +1246,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  		goto out_restart_rx;
>  	}
>  
> -	dev_dbg(port->se.dev, "desired_rate-%u, clk_rate-%lu, clk_div-%u\n",
> +	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
>  			baud * sampling_rate, clk_rate, clk_div);
>  
>  	uport->uartclk = clk_rate;
