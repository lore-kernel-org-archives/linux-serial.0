Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C1198E8C
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651414; cv=none; b=SW5Vo0f1G5m60RM+8IwG9ZiSb1IQF5/8Y+VIm0PHJofM7MVlGfa3yk7piv8PbGsFP7CjXtEKMExyAP9w7G5Mz/6VpasMs9eU9eZoo22scVC5qQ/Heq1OKPknKpvEK42wF8pf8gHnygaQ3E2TvosyICvogYVC/x9tjg6IzCs3+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651414; c=relaxed/simple;
	bh=wcl7+zOsJr1+gN0g0Rlxn/gVOmWy+fNU6sY89FCPmyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqJ5rbBtcbzRU5u1yfbTeC9f6HHqnFp0DvYcxpxtjJ7NME0eCWeEWOfT7eVMxUYMwRxoY20VncAavmO9bRDCcS9OGKci5oaZvzoTxmW3r4MeR9X6bVV7HKiD+SquDOS7XAG4jOoAJ55oJ2ztnRw+FPL5QPVmk0OTyo8TpaEvsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TVdvByBL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVdvByBL"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c85a7f834so6032966e87.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718651411; x=1719256211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7UUqmYzt5Fad8Nwjz29EcFeQsVZigIrkSENxKW+D/U=;
        b=TVdvByBLvNQRg3Dk/A1GWyTEKv5kOwvsg6xlM7AM35QPMY3vNGhkpSG03Fv2uuC4XF
         HE+3vtjRByisXJ5/urcx98uKyfRKy0ZrezsuSOMyMsBzgCNVXKDpIX1vuVcYeG/hQb6B
         mGVhhbrgixvDFnbLVr5AcqfzT7taOSqMsBefhMy3fbOz/7oMYIUk6xgPrrqo8bdqTkEQ
         7jSORlLPPm/rriUimEkAB5r5oTIAB3G7zu2f9ItQ23Ohb0fkbengNwR5g+GmkFWkHNYw
         m1TBH4ayxmiaHSb9H3jrBvf+TXv71wtuwm9Zhvm+AnqAhNDT1MWE9j+3GOJAyVeillwS
         BTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718651411; x=1719256211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7UUqmYzt5Fad8Nwjz29EcFeQsVZigIrkSENxKW+D/U=;
        b=lReiVrJqjpuRIkDl6uU6DVYXjCr54K6h+LfGiiN6m7MVXnDWJEGrFrIiy2FPa6RlF5
         2UJZ6+6t0JWYQD6axDtWpJ+y+lnmGIV6K4pRep9r9hsaHVLrWQk8f4JUKXr7FGfKzL3f
         06bzcCkOQqcwMMCb31KV7dsuRtc5n4+bbdBRQXU8OB5dV7IsLkBEv8D7M7y5BrIX9NN/
         SeR6jYzrDEokYeqM8zDgs8sQLsDS0XVr+ZeuAwpRCRvUpsgdUL3bzxXKU1od3AG54zkU
         QqKKMMz821GhBG3oNrPIRgxhT3YtIt/fkmHyQbO2Dh0QEM/4Oh0Qm5CTKbXN1KW9WH0H
         rKHg==
X-Forwarded-Encrypted: i=1; AJvYcCXYeHNRiMLtGtzJzRpqi9RDZkLU5WUAKvfB5mFNAVH1OfzViLnL6upJjcFvQ6WCOXWxiJZC+/tjx+keceBFeIkLFHRUHtz8lMuYcxtl
X-Gm-Message-State: AOJu0Yxb5PyPWsca8TKyhHY0oVNKsM6aHFu9HCl7BaqlRvGtMdcZMQti
	0S/Es0FKTQa3/i66joLOPKEYTyWBOzqxQ9e9E9H1vLLSxM/pECyDe9uljsCZew1k6pkZaZ+PATI
	d
X-Google-Smtp-Source: AGHT+IHz0efUjCHMuOtSGmYf5fBexuE5AlUAyxRPBDkh+DJ46L6ZAbXr0lp0Kpx9rY5b9wdeHBiOVQ==
X-Received: by 2002:a05:6512:3112:b0:52c:7f16:d439 with SMTP id 2adb3069b0e04-52ca6e6e286mr6166946e87.39.1718651410939;
        Mon, 17 Jun 2024 12:10:10 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59? ([2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287ae9asm1313968e87.211.2024.06.17.12.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:10:10 -0700 (PDT)
Message-ID: <bc4892b7-7c34-4fcb-b4c0-e383890162f8@linaro.org>
Date: Mon, 17 Jun 2024 21:10:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] serial: qcom-geni: Rework TX in FIFO mode to fix
 hangs/lockups
To: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.8.I1af05e555c42a9c98435bb7aee0ee60e3dcd015e@changeid>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240610152420.v4.8.I1af05e555c42a9c98435bb7aee0ee60e3dcd015e@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 00:24, Douglas Anderson wrote:
> The fact that the Qualcomm GENI hardware interface is based around
> "packets" is really awkward to fit into Linux's UART design.
> Specifically, in order to send bytes you need to start up a new
> "command" saying how many bytes you want to send and then you need to
> send all those bytes. Once you've committed to sending that number of
> bytes it's very awkward to change your mind and send fewer, especially
> if you want to do so without dropping bytes on the ground.

[...]

  
> +static void qcom_geni_serial_enable_cmd_done(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +
> +	/* If we're not in FIFO mode we don't use CMD_DONE. */
> +	if (port->dev_data->mode != GENI_SE_FIFO)
> +		return;
> +
> +	writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_EN_SET);
> +}

IDK if this is worth of a separate function, instead of checking for the
FIFO in port_setup and writing it there, but generally this patch looks
good to me

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
