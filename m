Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0B28315A
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031944; cv=none; b=iR/Q61ED9otFgz2AGTFR0oK9sg+mg03M+J2KuDXH+BiDEhS/wwF4GIOrGoysv2xDwinG+Ygeu8nTIepxuN1UXrzMEHBaS680i7fjdP8td3oWyV2p/DMR51NRDf+c3cB82eBVgXEI2RYY7vRVoti/HB+dpXNPhXtPdTIQK3tVoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031944; c=relaxed/simple;
	bh=fVduY9ChM+XTiJ/WxOZb5vLjE0k0RtwqZkyUiEW8pZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoB6YuhvL/xprn+TGQlqY80B61moraAgO6dALWe3+yWyXsEfaIpRmj4opz9T+z8+iARgjXfl0GTFd3QTEdUftIV94qGQEnNbjsgPS3I0xYERjY1HfmUiJiShM4zFll8usniiFdPz4VgIFspWHZm8JCE9r6NvtxglWWdHox1xU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOCGnvwg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOCGnvwg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso33508815e9.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758031941; x=1758636741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ihTrH7t7gLzKRumooOOczb4IBjokkGyHJ2+QxNRMxY=;
        b=mOCGnvwgcrU5KMtGEYRdZSbfkuz1xSxEYBDr0cn6QPZPfHN3Ekbdo2d4sqORAIe5Md
         BWG3CUqFvXoePD6D2vMNjzRJMlxt/DDkXlXbSKT3p5XRGysYXw98oGzaUSF5L6m8FEMr
         OzIjEKCneuEMM6RXtPw1JcA8qF/6eUN6Rax4+x3DVn4TB+Lpx5JbC0Tz1QpCl9QGDrlJ
         jreFR6TE2YU7/XEPu0u7ag1n+bpDl5msFmnjdxhllhSaZT2vxM2Xl6QklzlghUipVSZC
         HGZ2Ad3FDOmHkSwgdSdNuh0hpoJSHa5xvXNmLqPaVA+zLmlYR1hEyGuK9VPacYtdSF2M
         K09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031941; x=1758636741;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ihTrH7t7gLzKRumooOOczb4IBjokkGyHJ2+QxNRMxY=;
        b=Fb5MhEMyddw43q8n2O2JYir7LUTG8pTErybUve6ufTj7BwhD3iFAtnlr1YFAnKnDs9
         Vsx9l1e5yARKD2AkOmHGGOW3wdlbMuTvjaywe012OB2A/T3qTE75IF30G+CuLAaAXipM
         1uC92Lr/KMGlfDdYvqcro6WnqYKKz4sTPFJAcTO3Y/SSKjPFiPogjTl6Cv9Hf2Hkue4X
         qrcsZIzw58LwIFNn1oA9Q1L7UXtGbFWMLwqALQjNKpkD7aYYHqQG2yhuhcVfM6l55kAr
         0YPfmkF/Jo4VsNqLl3LToE9WQde9GSo9BunSk9mlzWXaZU2tv2c1SlJ7MAkNFTKify6r
         qK5g==
X-Forwarded-Encrypted: i=1; AJvYcCVbyac2OuoA+f0BRcpOLMC19HpnRZ4b4EE+VhhNktxoA/XfGWJWC++bcn+wXIqBTe7U8wY23uwrBbALdMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/9tjcsfTbNjPhHzEin+QgUSyC10Imr6v0glZ6nHkKgoem9mk
	lHNLfsjGK1XDMNh9+vC8hZhvgJmMUTxDwgsJLdQOps7B2eRKoXG/yh/Qx9Gskc7R1ms=
X-Gm-Gg: ASbGncuJzMuQxS1UsC8PA/7eizsbilxN5kPrUW0KtYdtdRGfl5IXSFzUZ4zSNQv4+md
	xPyMaNJNMdK2INg42pX32iG9twSiqudgvA7Ya9xjmJB7bX34voiso70PYAoR5LfgLi2DKWqv9JG
	GWq8/vlnGpyPaZsJusfYnwugl4eDq3/KSZj9S4vsq+RnGRjl9p+dpYl4i3jbHGts7nWiVaelsOS
	oIVMJyQIIvneQOKKStA9PKiA08cbFi5np06Uum0BghgEb6X8iE9TfaAZifq8CAdvh8rxGB2fk4C
	0BxDBRFkGjc7pMw037pSP09zqYmEThMnppEJwYY27ka7As2yoEjhSMLoxo2Cw041Ssr9u374vfO
	yCW4Zt2XSjik42ZsXUlU0lI5AGBZodCnoNgzhzOop+JnB5XYMX9Lv6seWbf2aLdgXUSqx+jMeoW
	a/C4aPTWhToduOrNZzk7I=
X-Google-Smtp-Source: AGHT+IGmb1kHFNHQ4frPlib14MxI7w4SRTDLbyi2XJON83MQa2TxlNaD5uBHUokreLL+hCdD46cN6Q==
X-Received: by 2002:a05:600c:1546:b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45f211c4c03mr137113085e9.2.1758031941271;
        Tue, 16 Sep 2025 07:12:21 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8c7375fb7sm14091558f8f.14.2025.09.16.07.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:12:20 -0700 (PDT)
Message-ID: <ca511d42-0381-41d1-bea0-0d766e04f9f4@linaro.org>
Date: Tue, 16 Sep 2025 15:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: serial: qcom_geni_serial: Fix error handling for
 RS485 mode
To: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, johan+linaro@kernel.org,
 dianders@chromium.org, quic_ptalari@quicinc.com, quic_zongjian@quicinc.com,
 quic_jseerapu@quicinc.com, quic_vdadhani@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 stable@vger.kernel.org
References: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 10:39, Anup Kulkarni wrote:
> If uart_get_rs485() fails, the driver returns without detaching
> the PM domain list.
> 
> Fix the error handling path in uart_get_rs485_mode() to ensure the
> PM domain list is detached before exiting.
> 
> Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 9c7b1cea7cfe..0fc0f215b85c 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1928,7 +1928,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   
>   	ret = uart_get_rs485_mode(uport);
>   	if (ret)
> -		return ret;
> +		goto error;
>   
>   	devm_pm_runtime_enable(port->se.dev);
>   
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
