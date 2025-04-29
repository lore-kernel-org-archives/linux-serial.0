Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41932C1099
	for <linux-serial@vger.kernel.org>; Tue, 29 Apr 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925008; cv=none; b=jquJiF3JxrKqw69txew7a+rCH+VkjCAN097ojvLShSxTlCFoE3yCK2S0/yahs3yj0aKCAu3oUABYOb8A5TAnh4QCF37k3rVGrMkTPc1J0iuKEneQ2fxNXNkvM6FSUXjuckc7ydvg7vFJ7q5dh2vmTB+upbNgmIZAiwze4d8OqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925008; c=relaxed/simple;
	bh=KK9iL7bKNMxHFK/3rKqgEsDWwYrNcf0XwPTkcF6nDZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZAOktnFasWAoqN/07r8JingGvlQjIx/OeNV7wyq+nSPKL0S+9DHYxHkWl/+ZrGhm+HxMUIe8Kx6tvscMgqELgy4io4CBzDLE18KXyO1gbzYQMrr+LC7tbaPzO8i6D9K95ijDX/CG60Kw/X049wzROYRT6Hkg7adlpicG9ZcKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8776ovT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8776ovT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TADp6B007195
	for <linux-serial@vger.kernel.org>; Tue, 29 Apr 2025 11:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3eXgqaX9FPZn2FFLi1FRwep/m3MeEfiEWvlCVO9dQLw=; b=Z8776ovTw4yDXoOO
	66pQ8PmhjL4OiSiqc3Rbz0UvOZiGGgtTsT6cyqA1a8xkzZCvVOpEEyS7+tN9ZDjF
	FJUAfKKWRGXcGqb59iT/q5WpLaVNTA/zpb0Ivc3teONOXsKeaDVYV0vNdRwau9sj
	cM/e+kxwy3zNBfYVu1nMOGV9Lcf9mSeMiHTT6/7hRManJMF1rIemfok5UtArVqBp
	x/9FJzwplbXcZyrYaIygwucEJKJSPgK3SqiRrsdwDEfhSOtvD/UqDXn9xaNOJReF
	ZTPqXzvya0nTOeBg9rRfkCFy3nlZ5ZZeG/Hv67EMQVemjX1eRFPnf3DWhy3J2kxV
	HuRXew==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468ptmm9wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 29 Apr 2025 11:10:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f2c8929757so14430776d6.3
        for <linux-serial@vger.kernel.org>; Tue, 29 Apr 2025 04:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745925005; x=1746529805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eXgqaX9FPZn2FFLi1FRwep/m3MeEfiEWvlCVO9dQLw=;
        b=HiMbwp44juxUNcMAA3fHklnFm3To5MkPR4Wq+BAtb/RPgCZJhVdnSuvYK28vAlTIzL
         QEu785JBYIbCoAGLF49IKQlMIg1BfkH24pse+4MAhtB8Z1oaj8JbzeHdetuhvvm6NZZ9
         v2DSd6EgGfVEpdf0nrV+ZcqC3ZAPeoGGGOUkwmqGk0kV7QNVfVifUNbW9N+Qkpa+3qOY
         gyVc82/ZyYccKez5iiSWV57cXfw5m8LBoBesbJZNVBSMGwzb1GJ8i4rnSkR04QX3PO1Y
         ytmKaCReAY0MHQyzu2XV5Qyakyxe52gXI2DdtxWfocyMDwUg6H5z61xUHfAgC0RRxNAq
         u30w==
X-Forwarded-Encrypted: i=1; AJvYcCXApnrwXaNO8tbjPiuIG6jlRUxNO7I120gbfwDLIjeLbjnwWoskWyEVtyAOrVeN/QPioskAyGuzhQTGPKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxToy+tnj39KGYRENsMaoLSmbZGGKQAvBoi1jlM8bXXId9ZrC1u
	grIR3PanLOJ04W1IOVPjtdkYlzHD18TGT64vTevlHl39kkTZAe8cqYhRt8F8/37JZKYezNUKwBz
	qGAl7++SMQvoYEK+JHmv2qqp0UzOJLQSHriP2z/ZPSKWn4cmExQjy5nbfy71L+hQ=
X-Gm-Gg: ASbGncsV7lSD1qlmlgBfj+JLsH1vhr5Cud1BbYqcan/u1Em27vDprIaqLNgA4tgFY5e
	6QSD5HwFCoPcs7U+wh0kiz+kV9LwgWi1TmPA3UL1r4x4y5nIFLXpUcgqfNIRqQJ8VOeGc8KMDGz
	8SPZsLVd70Cny6VcBzExyoOBWaeOpHIJFCDarZUujOvZnKInbzT+m2RRQerpMvms56Xbj+L7bkC
	yC4g3CbYANVGtWwDsT2ZBzm3iU2HGdMP3zDJETd+1AHyqZD0QltwMSK4+3onu31wxWwwbRU/2as
	oqQPNSg6JxNUKZhZfCw+sfHZ9fvyNxA+9gcPrY3Rjo3SrRV/RvgrJYLF5kDwOdCJxQ==
X-Received: by 2002:a05:6214:27ee:b0:6f2:c10b:db11 with SMTP id 6a1803df08f44-6f4f1c5027emr14490966d6.6.1745925004811;
        Tue, 29 Apr 2025 04:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR34y0DBWhGAIj4iQs/8+yyXVHj4IypCK3z1RIFoMHCsdDytX2p307UVgi6+Slx6SdcufxHg==
X-Received: by 2002:a05:6214:27ee:b0:6f2:c10b:db11 with SMTP id 6a1803df08f44-6f4f1c5027emr14490776d6.6.1745925004408;
        Tue, 29 Apr 2025 04:10:04 -0700 (PDT)
Received: from [192.168.65.43] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f703831b5csm7282451a12.65.2025.04.29.04.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 04:10:03 -0700 (PDT)
Message-ID: <5f4a2b6d-3757-4a4a-ab27-187efde90b46@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 13:10:01 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: Enable support for half-duplex mode
To: Anup Kulkarni <quic_anupkulk@quicinc.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, johan+linaro@kernel.org, dianders@chromium.org,
        konradybcio@kernel.org, u.kleine-koenig@baylibre.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: andersson@kernel.org, quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com
References: <20250429104339.321962-1-quic_anupkulk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250429104339.321962-1-quic_anupkulk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7luQg7u-PVrjOtiKYTvts-1xBqx1U9lE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA4MiBTYWx0ZWRfX7NQYPeSvA2J2 ZjZel5pZjHHatitieZsJpRa/sAQxvaxJ7AK9bWWASm2AXQQUcyv0YQjr5z4g+BhKQLV1w1sqtlY dTYb0MnLbigQDXV9HYpx5AvMgq6B+5VQLLe0NlMtZqIO8vVA2wVgNouHBKS4wFFq2QBC9HVgYLA
 CElVeW1YJ1YDX/beWoBn1FxzZVKk2g81brjIFnsjDRlb3yEQuZGQ2JS5pookuM9a/Be/Tf/znib oCRyL7gMaOQvhncx444uVgwN3U5D5WZuTFFoOqBCfj9E9V7R+u4mXGlCCfw9o4EUl450Wmrk3p8 UU7E+tdbsb+ByC+kFTZ2SX8dfeS2LxXR20eXXTf0wRYewGuIFsPknsOqdZPIXK5zWoC6Mm0lF3q
 WCtMXPGaP2PN7CEbXJvUmyZUSaN/trnoGb9shPF+8ZKgsY94ow70rGOtwofHYo2PE4wddRrr
X-Proofpoint-GUID: 7luQg7u-PVrjOtiKYTvts-1xBqx1U9lE
X-Authority-Analysis: v=2.4 cv=DKWP4zNb c=1 sm=1 tr=0 ts=6810b38d cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=_eVvX3NImPkpd70kKkkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290082

On 4/29/25 12:43 PM, Anup Kulkarni wrote:
> Currently the RTS pin is used as flow control in the UART controller by
> default.For half-duplex modes, use the RTS pin for direction control to
> prevent data collisions by allowing only one direction at a time. Utilize
> the rs485 structure and callbacks in the serial core framework to support
> half-duplex modes. Use the IOCTL value, 'TIOCSRS485', and the 'struct
> serial_rs485' supported by the serial framework to implement support for
> related callbacks. Enable RS485 mode with these callbacks.
> 
> Signed-off-by: Anup Kulkarni <quic_anupkulk@quicinc.com>
> ---

[...]

> +static void qcom_geni_set_rts_pin(struct uart_port *uport, bool pin_state)
> +{
> +	u32 rfr = UART_MANUAL_RFR_EN;
> +
> +	/* Set the logical level of RTS GPIO pin based on the bool variable. */

This comment doesn't add much

> +	rfr |= pin_state ? UART_RFR_NOT_READY : UART_RFR_READY;
> +	writel(rfr, uport->membase + SE_UART_MANUAL_RFR);
> +}
> +
>  static int qcom_geni_serial_request_port(struct uart_port *uport)
>  {
>  	struct platform_device *pdev = to_platform_device(uport->dev);
> @@ -637,6 +650,7 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
>  	struct tty_port *tport = &uport->state->port;
>  	unsigned int xmit_size;
>  	u8 *tail;
> +	bool pin_state;
>  	int ret;
>  
>  	if (port->tx_dma_addr)
> @@ -648,6 +662,12 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
>  	xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
>  			UART_XMIT_SIZE);
>  
> +	if (uport->rs485.flags & SER_RS485_ENABLED) {
> +	/* For RS485 mode, the RTS can be set/cleared before transmission */

This comment is incorrectly indented (need 1 more tab)

[...]

>  	if (dma) {
> -		if (dma_tx_status & TX_DMA_DONE)
> +		if (dma_tx_status & TX_DMA_DONE) {
>  			qcom_geni_serial_handle_tx_dma(uport);
> +			// Check if RS485 mode is enabled
> +			if (uport->rs485.flags & SER_RS485_ENABLED) {
> +				// Determine the RTS pin state based on the
> +				// RS485 RTS_AFTER_SEND flag.
> +				pin_state = !!(uport->rs485.flags & SER_RS485_RTS_AFTER_SEND);
> +				// Set or clear the RTS pin according to the determined state
> +				qcom_geni_set_rts_pin(uport, pin_state);

All of these comments repeat what the code says quite clearly

[...]

> +		}
> +	}
>  
>  		if (dma_rx_status) {
>  			if (dma_rx_status & RX_RESET_DONE)
> @@ -1594,6 +1624,29 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  	}
>  }
>  
> +/**
> + * qcom_geni_rs485_config - Configure RS485 settings for the UART port
> + * @uport: Pointer to the UART port structure
> + * @termios: Pointer to the termios structure
> + * @rs485: Pointer to the RS485 configuration structure
> + *
> + * This function configures the RTS (Request to Send) pin behavior for RS485 mode.
> + * When RS485 mode is enabled, the RTS pin is kept in the ACTIVE state.
> + * When RS485 mode is disabled, the RTS pin is controlled by the QUP hardware for auto flow control.
> + *
> + * Return: Always returns 0.
> + */
> +
> +static int qcom_geni_rs485_config(struct uart_port *uport,
> +				  struct ktermios *termios, struct serial_rs485 *rs485)
> +{
> +	if (rs485->flags & SER_RS485_ENABLED)

Because SER_RS485_ENABLED is always checked before calling
qcom_geni_set_rts_pin(), it may make more sense to combine that
and this function, perhaps calling it from qcom_geni_serial_start_tx_dma()
too

Konrad

> +		qcom_geni_set_rts_pin(uport, true); // Set RTS pin to ACTIVE state
> +	else
> +		writel(0, uport->membase + SE_UART_MANUAL_RFR); // Revert to auto flow control
> +	return 0;
> +}

