Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E5C6FD1A
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 16:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCGQTt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCGQTY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 11:19:24 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B78FBEF
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 08:19:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bi9so17821295lfb.2
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678205945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H+ZN9OLeA0/ZCnSrIPhMAdnIB2BziPIyfYKYdHQ0+0=;
        b=YCm6kNCGPK1W0qmWKKUU2mwfxxnSid1jyLNFUM+ogXtQkTgGkO8oBRfz4LM4kWQSoy
         J/OqmX34CvnoIxp9xaUKCshlRRHCVz92C5GwqIi3dCAHIPYojukbiGIO9b8uKbBd6C+W
         00JRgd3mlyPB8Vu7W9OMn2w6BDv/x3P2s3WhajiESWo2+AcnxNqhIwNfsMJQsK9xE5NU
         dbwVhycL99YbC4qj6sDwBB6cl66DNKQo9I1P54rUuSet69rXFfCssKUccg4auxN+QAHg
         oRQfsAIjL4xAlSEhISnGdSkYdTVrr/SCCZ9iO109i5U2Aubp+wQL3AB6318Bb8Mxn7AQ
         hoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678205945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H+ZN9OLeA0/ZCnSrIPhMAdnIB2BziPIyfYKYdHQ0+0=;
        b=2G0aKlWxMmzAiWmUumiBaMIubRVh/KTKPVnqfIlWaNl2J1EEhSDl8NHui31c6Na8EQ
         w0CRasTuQ0TSeFzKoa0E4ysjWtot4p1Y2WGZlFrfJ+uaMNJI5wrIAMoOUcSctgdawLra
         AzE6/Y9bVzrQLl1IJVNGuU+koohxd2J6HX8mW4cD9oNPI+tdsLFuH2IWH+x0wnEt55rB
         ny0jPKXC6DLTU8OnjezCPWD8KPZW4S1+Kf1AODpGLNpwQmZxXO66LEzlzij3WrMAa5Mu
         1O1QVWZsAlROLr3vI52RjRH7ICHkvSNcIJqQaO1H9JU6c2BWzVE9AfnscrtaaVagcbpj
         IZ9Q==
X-Gm-Message-State: AO0yUKVG43tVb1Iaohz8ajqjzY+Ki/d7UDSEGaarWUijjtlZbK2RNS3f
        6QsbW1rFA0EeD2ln7d/S8ww/lX16e5eUwAhUGbY=
X-Google-Smtp-Source: AK7set+ocIWUpDOgeFtUce9WvuyYOBDDQsDPp3s6GYZPyOW1EvXNtf3C/zBbm2kpKzTKWoB8rzEdLw==
X-Received: by 2002:ac2:48aa:0:b0:4db:38a2:e989 with SMTP id u10-20020ac248aa000000b004db38a2e989mr4046350lfg.63.1678205945548;
        Tue, 07 Mar 2023 08:19:05 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id x20-20020ac24894000000b004b6f00832cesm2064327lfc.166.2023.03.07.08.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:19:05 -0800 (PST)
Message-ID: <aca0e83b-3ad9-6153-f51e-f522cbe979d6@linaro.org>
Date:   Tue, 7 Mar 2023 17:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] tty: serial: qcom-geni-serial: check correct dma
 address before unprep
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org, gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7.03.2023 16:55, Srinivas Kandagatla wrote:
> looks like there was a typo while checking validatity of tx_dma_addr, the
> code was checking rx instead of tx.
> This can potentially lead to memory leak, this patch fixes the typo.
> 
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index d69592e5e2ec..5972b5c317d3 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -596,7 +596,7 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>  	if (!qcom_geni_serial_main_active(uport))
>  		return;
>  
> -	if (port->rx_dma_addr) {
> +	if (port->tx_dma_addr) {
>  		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
>  				      port->tx_remaining);
>  		port->tx_dma_addr = 0;
