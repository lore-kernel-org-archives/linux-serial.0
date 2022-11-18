Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F101C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 13:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiKRNhs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbiKRNh0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 08:37:26 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64CE92098
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:35:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c1so8225377lfi.7
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 05:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj8yYZOqVCaFgmChHFtZrXYgiAp7+fvIrrm4iXS1zLs=;
        b=tfXgrddhNWtrKuF/6cMrvFuQcfLeciFVqSMUXBagxnkHYIXa2/xIzMOsXzUaFTuK3B
         clhVRgtmEkd1eMfTYDhNv4xE5aJ+2CncWk/l9erqyLhBLFqflic7Eg5AzdZjSWNTaFed
         /fIygYOOJ9X3SEDeRtV1QhSI0VKWF0vmiIhaAjxKRgfuW67AyN4ybWOpPZEBQAJoGlcr
         wTCYUU/ozs2PUu2LBJR4sVymfuXHytSaW80RLKDEHjzGgGTZrJsXFFhjjFSGiVlSMGjV
         fuQ3EosdU6OwhDIl+XZR23BcE/jr4lwHZ6vd/qvJDlU80Y2pKfDxhc6E9EJKeo++ZznA
         R30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qj8yYZOqVCaFgmChHFtZrXYgiAp7+fvIrrm4iXS1zLs=;
        b=rguUUbjeHAXyjvmQeDS8exkf1vfd8neiRWa6BpKkyW1IvWHhkhEq5NSb62ez6d5y4n
         KOLa6wivrxdBGVoT1GF8hB8WSt6BJUeZmvXFlNUdZ0Lt7YlDWOGyI+qEOik9yJy+++xH
         pmcQlp5/uZ5A+VgDZEj6fAhIuHlbWvoE1cysHdEoXhGbpwV8o1llYpXRYYMbl+Uz/KyI
         zZQBprKRTuuQRYL+jqzi8G+H97eFfOq+biaMQ9uOG0KGUtMXuvOpDNpULuY3c/vAjMA8
         5u/26gxj+cShE07r5qA0TkKLpahDFrFpJSPvOrp0Oac9QFyghXPAASteurOn08FBH/9c
         xrNg==
X-Gm-Message-State: ANoB5plXq3E/74Dh2F6DEbGRNDi/oSt9XPtc1HPcDpU10cspW95yzmlP
        dof9irRaazxcgq3cogE6NbbZWQ==
X-Google-Smtp-Source: AA0mqf6Ck/17r9Fqp2PsZX2kvXmYiBzUiRUecnEXFKbfah4OEG0WAWVfd+Pgdi6y+cQgbJdxD0mvnw==
X-Received: by 2002:a05:6512:2986:b0:4a4:2967:78eb with SMTP id du6-20020a056512298600b004a4296778ebmr2386104lfb.222.1668778526006;
        Fri, 18 Nov 2022 05:35:26 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b004a4754c5db5sm658815lfc.244.2022.11.18.05.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:35:25 -0800 (PST)
Message-ID: <416d2d7f-f0b7-87e1-c987-fd78efda7091@linaro.org>
Date:   Fri, 18 Nov 2022 14:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 14/15] soc: qcom-geni-se: add more symbol definitions
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
 <20221118122539.384993-15-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-15-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The following symbols will be used when adding support for SE DMA in
> the qcom geni serial driver.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
You might have added them along with the new users, but still:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   include/linux/qcom-geni-se.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index f5672785c0c4..400213daa461 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -103,6 +103,7 @@ struct geni_se {
>   #define SE_DMA_TX_FSM_RST		0xc58
>   #define SE_DMA_RX_IRQ_STAT		0xd40
>   #define SE_DMA_RX_IRQ_CLR		0xd44
> +#define SE_DMA_RX_LEN_IN		0xd54
>   #define SE_DMA_RX_FSM_RST		0xd58
>   #define SE_HW_PARAM_0			0xe24
>   #define SE_HW_PARAM_1			0xe28
> @@ -235,6 +236,8 @@ struct geni_se {
>   #define RX_SBE				BIT(2)
>   #define RX_RESET_DONE			BIT(3)
>   #define RX_FLUSH_DONE			BIT(4)
> +#define RX_DMA_PARITY_ERR		BIT(5)
> +#define RX_DMA_BREAK			GENMASK(8, 7)
>   #define RX_GENI_GP_IRQ			GENMASK(10, 5)
>   #define RX_GENI_CANCEL_IRQ		BIT(11)
>   #define RX_GENI_GP_IRQ_EXT		GENMASK(13, 12)
