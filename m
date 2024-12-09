Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939131A2399
	for <linux-serial@vger.kernel.org>; Mon,  9 Dec 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755550; cv=none; b=jR1MDfjIVQX8HAerCShf9ObxpOg7Pjn1ghf++kNW7J5mv5u//2zYam43Nxx+H0QmFx0ztLZX/CQgJjSofZjS7HJxP6N+gcWmM5kjZrq7DR4gsiPO3J/BACfL0SGE+YXaCoKqF+Tutoq8JuyP6sSntGH4O3uv7Uyd85yMfw/8Zqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755550; c=relaxed/simple;
	bh=3DccwU8bsNIKxXVNI/DtlsyxRxxXOVT1W4bhGoVeU9o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mi7qGlXJfL/MiNLq0PmQMzwaZEXtajss4yjWdjKnlSVGe0B6mjEQnKm87Nl9rDLQ5U5WomYaV2pxOlXmTEXq8m6Sdn4HWrJr02yRf/sFzHH4IIcNHsyGqiVqBzr1dvU/Y/pkAZzs6xNqZ5vRK42J2lnD23iRZmBET9AYvq1WsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j55ps9Bf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j55ps9Bf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e9716feaso11555745e9.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Dec 2024 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733755547; x=1734360347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTfHlEBruYE/MHyxL3mgFOiuYOmpe0Q5tZ0GAzbgVOc=;
        b=j55ps9Bfn0M3Sh5sCEQvQIDhCvG6j8t7sQjL74uhOiXfMae5zdG/TqLitcEoMqaAIE
         /iFW2tCtSKQ7ueL11YzhLXDNnlFOwmsP7wNbcVm8cdH0gq4x4EXAmdAM+YYZQLza/MBr
         S/lWTRJeQ4QzPgtWps26uFwBKkKC86z7j7L2ASHWrDvbpzEdV/C3XIf+qfU1O/fCh4ma
         vaUAzdbxXv+gt5Jvr6BbVfBs51mgQkyZ/P26ElglyZcMQZfm4DLO62eQJ+fvBlJhnys/
         ooSTYoZib3BPSNf2ge8OjzC4zFqpuLEcAmARy3hG5KFOokF6HPXzBGCYW+l3Zum/hpPn
         3Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755547; x=1734360347;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KTfHlEBruYE/MHyxL3mgFOiuYOmpe0Q5tZ0GAzbgVOc=;
        b=PsvRyCdY3dV9bdKdq7X2OpsBIrMbc/WVs/X4y1rB1qV8w6Q76qGV5LT9F9Enr0ghxe
         k9BEx6eRQkTkhMuz4rtZun2fQRI3og8JDPYIODUcfBT6cu1sCny9DJQPng1x5tx7nvO0
         2Vqz8/w8WhmqdSI1f1VFvd0kom/hPiQrZ8JGyzOkGG0vQ7qy8zyHW8/m0fLZXxPo8QSc
         rHwSjn5t8DnmZP1MtE4oHjddC0vgAnn0VqXBIGLx32AH/U8DQgaPneQfEtU42l85LgLJ
         JkcEdmAui2BAq7QUlduoUCiY1mT/FJ7/SE++jYv/HIuRXzz2Tcp5JoyjqGJd2CCWBhjd
         Xa5w==
X-Forwarded-Encrypted: i=1; AJvYcCULcNrTOWSlh8zV/BMhGI+SOE2YffkBdvD62DSMHX1Rrdidnmd4DQMkfIGtQ0pmTjRFV2r6fwHsLR7FZlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9KYw9cGEMDQLfoqyXw5iKiX4XVVeiKlldAb/knJGGQpefDNM
	yxLuXymD+aLe0zzBv/Ye5tsiyPv/Zj8+ShVyXImhx0wSKZBXSKEI3b5l0NhbO3I=
X-Gm-Gg: ASbGncvF0d52YPFS0+PgEMxfZVymqLGFe+dpZH74gE9mjF7TKcnRDJywM4a6tMN5oQx
	UJ2l2CKg+qNOcrHcU3hHT6wWKCK5eBPbXfmrw3UYsLUN0t4qojQYD64pd9LBrKNFbm/SQghWXwA
	DjyjFHHyIGaRMyazD7My5k1GGFc7K5j5zTAA9KVtX0Lk4Y28Cz55nH03RVxedw6JZbAmdaaiZN6
	1sWrR1nPiTG4mWli7Ddt+cg2JIxyT1zfT9AB/Lp4LCdSR3INMi2QiQP1MUIOJYv+JaaS/pDjFee
	f2I9Qbqpq2Hmprrz4gGQWaoEQik=
X-Google-Smtp-Source: AGHT+IGXczvk8/drcPnzB/3x9sBYxzCR+lhz793QJAVXvYPFhUrR93Cq3xgZf/gTd72hwYjCIfErXw==
X-Received: by 2002:a05:600c:1f8c:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-434ddeb5379mr93055895e9.11.1733755546975;
        Mon, 09 Dec 2024 06:45:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7546:6147:f006:709b? ([2a01:e0a:982:cbb0:7546:6147:f006:709b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f7676d45sm45750525e9.33.2024.12.09.06.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:45:46 -0800 (PST)
Message-ID: <42b1c187-e924-4690-8338-4c694f3e16d9@linaro.org>
Date: Mon, 9 Dec 2024 15:45:45 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/7] Add support to load QUP SE firmware from
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
 andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
 dianders@chromium.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: =quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <9d5e5b8b-aeaf-4ec8-b34a-8edeaec20037@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <9d5e5b8b-aeaf-4ec8-b34a-8edeaec20037@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 16:59, Konrad Dybcio wrote:
> On 4.12.2024 4:03 PM, Viken Dadhaniya wrote:
>> In Qualcomm SoCs, firmware loading for Serial Engines (SE) in the QUP
>> hardware has traditionally been managed by TrustZone (TZ). This setup
>> handled Serial Engines(SE) assignments and access control permissions,
>> ensuring a high level of security but limiting flexibility and
>> accessibility.
>>   
>> This limitation poses a significant challenge for developers who need more
>> flexibility to enable any protocol on any of the SEs within the QUP
>> hardware.
>>   
>> To address this, we are introducing a change that opens the firmware
>> loading mechanism to the Linux environment. This enhancement increases
>> flexibility and allows for more streamlined and efficient management. We
>> can now handle SE assignments and access control permissions directly
>> within Linux, eliminating the dependency on TZ.
>>   
>> We propose an alternative method for firmware loading and SE
>> ownership/transfer mode configuration based on device tree configuration.
>> This method does not rely on other execution environments, making it
>> accessible to all developers.
>>   
>> For SEs used prior to the kernel, their firmware will be loaded by the
>> respective image drivers (e.g., Debug UART, Secure or trusted SE).
>> Additionally, the GSI firmware, which is common to all SEs per QUPV3 core,
>> will not be loaded by Linux driver but TZ only. At the kernel level, only
>> the SE protocol driver should load the respective protocol firmware.
> 
> I think this is a great opportunity to rethink the SE node in general.
> 
> Currently, for each supported protocol, we create a new node that
> differs in (possibly) interconnects and pinctrl states. These are really
> defined per-SE however and we can programmatically determine which ones
> are relevant.
> 
> With the growing number of protocols supported, we would have to add
> 20+ nodes in some cases for each one of them. I think a good one would
> look like:
> 
> geni_se10: serial-engine@abcdef {
> 	compatible = "qcom,geni-se";
> 
> 	reg
> 	clocks
> 	power-domains
> 	interconnects
> 	...
> 
> 	status
> 
> 	geni_se10_i2c: i2c {
> 		// i2c-controller.yaml
> 	};
> 
> 	geni_se10_spi: spi {
> 		// spi-controller.yaml
> 	};
> 
> 	...
> }
> 
> Or maybe even get rid of the subnodes and restrict that to a single
> se-protocol = <SE_PROTOCOL_xyz> property, if the bindings folks agree.
> 
> We could extend the DMA APIs to dynamically determine the protocol
> ID and get rid of hardcoding it.
> 
> And then we could spawn an instance of the spi, i2c, etc. driver from
> the GENI SE driver.

How/where would you add the peripheral subnodes ? A Serial Engine can only be a
single type on a board, but I agree we could have a "generic" serial engine node
that would be differenciated in the board DT with the protocol, and use the bindings
yaml checked to properly check the subnodes/properties depending on the protocol
property.

But we would still need all the serial nodes in the SoC DT.

This may make the software support harder, meaning we would either need to
have the same compatible probed in sequence from the i2c/spi/uart driver until
one matches the protocol, or have the qup driver spawn an auxiliary device.

Honestly, not sure it would be much simpler...

Neil

> 
> Konrad
> 

