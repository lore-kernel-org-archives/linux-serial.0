Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B1239E9F
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960923; cv=none; b=FoFmU0UZmyZeQp+Is1YqqdXRRpySCwuIAl5F2j8s3XMaLBGtm4FBc8Dk5JgxYx8aF/9wwfFze5HgXrGOLcVUuFqX0QJUf7Je1jpNiudRI5VZPStNKezI4odeEJ1XGlg5lwdc3rf540wCM42Waf/MkureA7gjc9K3RH3YTBlRwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960923; c=relaxed/simple;
	bh=BHoROxq4Yg70EhGIUKjQurV0ymRZkbKIPnWlHTUtRds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMkM55+wzR/4x3lRoaCfynLFeA9DTkqWq/8lYfaEA37zzOQUqCQcGpHdozdcroRAcrXWSl14DKdxj9W4ZeYb35mlMSldsaJpYYyAb+f4Y6gH/ME89M7AK0vu+lKt2B29JRHkDSLDPTGUFekQQsivvNDL4MNYcNUvPrHFHGOiX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JuWtqqmc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuWtqqmc"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a36748920cso6330541f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Jun 2025 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748960918; x=1749565718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVoevd4lyUI3zPOEpq/RIzyFhX2NtvaxczLaES3uue8=;
        b=JuWtqqmcW7cs/mhXv5O115HtovW8asw97hwTSQw9d9XqBDzUrRVEWGisSLkHnVVYmI
         CUzsDzFZj0FfNU2CBWftGl3eQhSbCBp6slJia9l+RcRM82Ta04EAGMOJANfBcdUN6s3p
         5yNiVDC+zEsNSXi7Iax54ef+CplDKEttjYunsjVE9kJsz9jLQ4zz1tR944hvjcEif/Dz
         7yiaauwTIrjmDUZhNYYHxeswAmra3sn8GnCsKFIS+q6pMcCmnBT9NGFzjN4ryG2fIkYB
         /VY5oyOl4JENgGVqXEEMEYK1LedohwkxjJD1f7LbAAnx/vQV7iyWCVX1vT9Q+xQEi9Fv
         RvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960918; x=1749565718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVoevd4lyUI3zPOEpq/RIzyFhX2NtvaxczLaES3uue8=;
        b=cPM5lpOloHe+pC3ZPXLg8XdbKEp7KOJU0G9jyu2dIyKUXcIokr1HdZfOqOU2UT9XDk
         E54XuLSNxnfMcMQZIEGwfuaZLjGgqmZV7M+g0PFH8CBNcMAPLydp0cdfLJ0ocw3Lvmv4
         2hm4baPHCuGFU22vTwx+jb810rtv69Mv+OX0cEJVFo8J7dzDzXODcagQSXeSf2SniDNF
         VjUnuxPYwfjyop/TZNDFvw2Eb3GSDmKF0oEep9K21ajKHC1inFgnbY6HiNLmDppkPgBg
         m6y1lXIbOtb4qAIAfCqSHohAVMARbac8NCc7QqPdmc3X2nGg/6VTvHyhy6MS4XXdVhQ3
         W4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMgSr7DHP6WAaruk8s8lnwOh+JDJOw6qwZi3PnQg36N3Xuj6PH+opX/v7CIjjph25OEOU7eDV1z9+y98g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrB43IS/CIwbpqHa+wuiRfBxJ/nbb3bAtG9OTm9IwcohpSZO9
	Sdr7GJgH33cSDGoxCtywjg1DkQqALD7N5wpp2xRTubGJChwgHqYFeRAKaQBCzD7cb9w=
X-Gm-Gg: ASbGnctPa8IQBQ0nUIf9YHaEIlmIrhnFScquf6mLkx1I7P4rd6lUBDxB/bXJJHIHM7t
	8OWb4+c6LTetF9BCHOtH37XGRD/iXa90tWuir7kJkTjbEc3OqtF+g3JK9bE6mI40o3aZvaFLA/i
	jE2whqOdJ9Cu3nqySRrI+IXbm+PZGhFHcSQNnNdGbGE7YCu0N3brjfTNV4iyD+2iLFpPjaPN9ha
	l4hKErBNXDZT6cFAVAJfvSspmLB0HTogviYnvmLVt7wmB98vKDTMcMifpENM/4DkMTNoQVeF/nH
	L7oiI4sBM80RxspJcQSxgr5w2opq3JmbtMxyUVTB3xJIUye/mBTcaRwY7EmNqlDU8Cw+4q5Z435
	d1v2D+Y7wpkVgce0HNxGr6lq9RMQ=
X-Google-Smtp-Source: AGHT+IHZurIKIq1+E6HJ23X1xCR/CPwysvL7IX6Z+9+U73oLFe1k7nAiy+c7nnudAfdU7L/qlrvwEA==
X-Received: by 2002:a05:6000:2306:b0:3a4:de02:208 with SMTP id ffacd0b85a97d-3a4f89ac91cmr13017254f8f.25.1748960918481;
        Tue, 03 Jun 2025 07:28:38 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c4f2sm18232873f8f.22.2025.06.03.07.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:28:38 -0700 (PDT)
Message-ID: <f912588b-fb54-4257-a4d8-db58e93b8378@linaro.org>
Date: Tue, 3 Jun 2025 15:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] serial: qcom-geni: move resource control logic to
 separate functions
To: Praveen Talari <quic_ptalari@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
 quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
 quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com
References: <20250506180232.1299-1-quic_ptalari@quicinc.com>
 <vTOsjvsB7oSpu2Oe8i1ufoz5C2Hy3EtfDnfBsLag2p-s63J0BLdqbLn44Hds17WR12JGfo7sd52k7uHaXlTTeQ==@protonmail.internalid>
 <20250506180232.1299-6-quic_ptalari@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250506180232.1299-6-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2025 19:02, Praveen Talari wrote:
> Supports use in PM system/runtime frameworks, helping to
> distinguish new resource control mechanisms and facilitate
> future modifications within the new API.
> 
> The code that handles the actual enable or disable of resources
> like clock and ICC paths to a separate function
> (geni_serial_resources_on() and geni_serial_resources_off()) which
> enhances code readability.
> 
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
> v3 -> v4
> - added version log after ---
> 
> v1 -> v2
> - returned 0 instead of ret variable
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 54 +++++++++++++++++++++------
>   1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 6ad759146f71..2cd2085473f3 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1588,6 +1588,42 @@ static struct uart_driver qcom_geni_uart_driver = {
>   	.nr =  GENI_UART_PORTS,
>   };
> 
> +static int geni_serial_resources_off(struct uart_port *uport)

It seems like an extremely nit-picky thing to say BUT

geni_serial_resources_on();
geni_serial_resources_off();

since that is the order you use in the code below.

> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	int ret;
> +
> +	dev_pm_opp_set_rate(uport->dev, 0);
> +	ret = geni_se_resources_off(&port->se);
> +	if (ret)
> +		return ret;
> +
> +	geni_icc_disable(&port->se);
> +
> +	return 0;
> +}
> +
> +static int geni_serial_resources_on(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	int ret;
> +
> +	ret = geni_icc_enable(&port->se);
> +	if (ret)
> +		return ret;
You're adding additional logical checks here, which seem reasonable but 
are not stated in your commit log.

Please make clear in the commit log that additional, minor function 
return checks are added as you do your functional decomposition.

> +
> +	ret = geni_se_resources_on(&port->se);
> +	if (ret) {
> +		geni_icc_disable(&port->se);
> +		return ret;
> +	}
> +
> +	if (port->clk_rate)
> +		dev_pm_opp_set_rate(uport->dev, port->clk_rate);
> +
> +	return 0;
> +}
> +
>   static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
>   {
>   	int ret;
> @@ -1628,23 +1664,17 @@ static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
>   static void qcom_geni_serial_pm(struct uart_port *uport,
>   		unsigned int new_state, unsigned int old_state)
>   {
> -	struct qcom_geni_serial_port *port = to_dev_port(uport);
> 
>   	/* If we've never been called, treat it as off */
>   	if (old_state == UART_PM_STATE_UNDEFINED)
>   		old_state = UART_PM_STATE_OFF;
> 
> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
> -		geni_icc_enable(&port->se);
> -		if (port->clk_rate)
> -			dev_pm_opp_set_rate(uport->dev, port->clk_rate);
> -		geni_se_resources_on(&port->se);
> -	} else if (new_state == UART_PM_STATE_OFF &&
> -			old_state == UART_PM_STATE_ON) {
> -		geni_se_resources_off(&port->se);
> -		dev_pm_opp_set_rate(uport->dev, 0);
> -		geni_icc_disable(&port->se);
> -	}
> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> +		geni_serial_resources_on(uport);
> +	else if (new_state == UART_PM_STATE_OFF &&
> +			old_state == UART_PM_STATE_ON)
> +		geni_serial_resources_off(uport);
> +
>   }
> 
>   static const struct uart_ops qcom_geni_console_pops = {
> --
> 2.17.1
> 
> 
Assuming you address my points.



