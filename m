Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DE1D1E7A;
	Mon, 21 Oct 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515099; cv=none; b=V9AYfKMD8+1qhdR+JdXmHGii57tIbX1sduPFs+BnvjUjZFp1TKXGyLvTP5i/668X9z9O3uHRsAwfhXqvThjo+TGLZuFBgWThiCvHBCEjQd1OT4RbQ0mwRTncXWrxP55xtAK/24Hhn0mp/pfHPA3UkcvcN9W4Xs5fCpgu9u94VLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515099; c=relaxed/simple;
	bh=Lv9VrjmXHa8PT28MwNQ7rdLj1ClF1IBCgpDEoygVeNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoYWHIgqCj+PXp9CQo7MgCo7iqL65nFIycF5+UPTrb8ELbunK002IzJ9mXc5jIA60PbApB9XLrICuxJ+6ctAa1bt4D8sliIxsZkze6YqIp1i0Pd8+n7Fnllw8oFchoawPE9qAfAq5sMAzE19AOMVfLA8Ovb9piVbTYLF7/QFMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htfcfLWN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htfcfLWN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so49682355e9.1;
        Mon, 21 Oct 2024 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515096; x=1730119896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWgOmOfi/coO/g3WzFFtfVpzbPBXbofxJwFTWwltwcA=;
        b=htfcfLWNW2vi1yLHg9r1ptPrxgdaMZ1sLPg45suI6tRx8WwLCzFlQoALnohkIg6NJz
         qIyYfNkpXmmM90rVbyEnOFrQnYpoe/AnKVCfAyqp9sh6OZYIIgTS1kWLj1OHLyiW8U38
         tAG4VNG81PECZ+Ah/6l6RA6ncfXPafGW2V6Nz158QVETT/HUg2I0EXH3wEXEzZHHxXgM
         awFf8eT1aNZiNYw0D/dYR41HXmHn76/LSvTacH4tw+qbdhabIZyu3JsCHMEKxgFqD635
         D09bO6H9u5z4pWAzVTCHHNrlJXmbJT7Ei7OQyetdHOfw0uKoomQ0hT6XXTWgHEzIcvxm
         4UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515096; x=1730119896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWgOmOfi/coO/g3WzFFtfVpzbPBXbofxJwFTWwltwcA=;
        b=cEfojQQxethiFNSzf5Gw0jue3sam3Ly2NQKC93mMq8Z/zMlEkaeO/asSQcba0+bsl2
         cBNyeeJ8tsH8EayylcITdje2tWCkfogw94k/SnI/bglS4PFnwMwKqfGD3YzyTLZ+Dl6t
         oc7KOJeq/Te5tT5YrAzNwnvq302m2nSaiJGkaEYo1LaKzd3HKVLx9ze6ll9ccN5hq70K
         MPDLEHpPVHTsxdJ5K/p0CEaQl21hpmm+nVS0Bp5BaLCghzYGPo9u02ybyWjZHDMq1euC
         QOZ6doXIbMW/MIkpG6l7YNDrdpclgPeNTuVBKXrX5flh5TeTgAv/8+s6IR6ZbXMtL7jF
         n8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqwCPP/eeEhthFy4z1PrK+OuKYPlQnYaXIV+jVHCeshi5C7cqiTG85HAC/1ZTZCT6kJfCDbmtaizLhER1s@vger.kernel.org, AJvYcCV90IrgksoS9BGE7An/OHJ+xR6uhH9UCcHBfEtkVfWNsh2nIuplJfRFQ7l4Vlm40I523IS97yrAR79IElWL@vger.kernel.org, AJvYcCVnf7XnWMefAJYDBzkEhtGEs9js+flAKAbXQvsNpm0LBdaZ/TqCEbf4g2UcBgPbUNqWURj8Pxdpptqt@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVlFbx08Ki1++IZ+7zWrBP+ovAN0eFlFmUsd1gH/v2IC8a4PK
	zsqgT0lO6Z35c/AaTZqgYr8NW+LTID/8OqlJe36bLc966GfS7zEu
X-Google-Smtp-Source: AGHT+IE5W1CAoDs1sVbKlEaGdGprifJoywoWBYxAmpwzSv+xmCNh9vaXDVP3VMWtWv+l2NUfwnQTlg==
X-Received: by 2002:a05:600c:474e:b0:431:47d4:19bd with SMTP id 5b1f17b1804b1-431616287aamr99170455e9.9.1729515095885;
        Mon, 21 Oct 2024 05:51:35 -0700 (PDT)
Received: from [192.168.1.105] (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58f2c3sm56826175e9.27.2024.10.21.05.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 05:51:35 -0700 (PDT)
Message-ID: <d20c05a7-5411-4a2a-950a-8a48b0c2e127@gmail.com>
Date: Mon, 21 Oct 2024 15:51:33 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: serial: samsung: Add
 samsung,exynos8895-uart compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241020180201.376151-1-ivo.ivanov.ivanov1@gmail.com>
 <20241020180201.376151-2-ivo.ivanov.ivanov1@gmail.com>
 <09c1e8a0-f669-42ef-bbd2-44649fad35d8@kernel.org>
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <09c1e8a0-f669-42ef-bbd2-44649fad35d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/21/24 12:29, Krzysztof Kozlowski wrote:
> On 20/10/2024 20:02, Ivaylo Ivanov wrote:
>> Add dedicated samsung,exynos8895-uart compatible to the dt-schema for
>> representing uart of the Exynos8895 SoC.
>>
>> Like GS101, it has a required DT property samsung,uart-fifosize, but
>> it does not exhibit the 32 bit register access limit.
>>
>> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
>> ---
>>  .../bindings/serial/samsung_uart.yaml           | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> index 788c80e47..2491b6048 100644
>> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> @@ -27,6 +27,7 @@ properties:
>>            - samsung,exynos4210-uart
>>            - samsung,exynos5433-uart
>>            - samsung,exynos850-uart
>> +          - samsung,exynos8895-uart
>>        - items:
>>            - enum:
>>                - samsung,exynos7-uart
>> @@ -172,6 +173,22 @@ allOf:
>>          clock-names:
>>            maxItems: 2
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - samsung,exynos8895-uart
> This looks exactly like gs101, so please grow the enum there.

It's missing the reg-io-width property. My initial idea was to add a

completely new entry, so new exynos platforms that don't exhibit

the same issue could grow the enum there.

Although now that I think about it, I could grow the gs101 enum and set

the  reg-io-width property for gs101 after that list.

Best regards, Ivo.

> Best regards,
> Krzysztof
>
