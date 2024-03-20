Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494B3BB20
	for <linux-serial@vger.kernel.org>; Wed, 20 Mar 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928033; cv=none; b=DB+sFa+VXQl1DTliEunN3vMtTYJnJj80MywxKWLVFK7/jQEksUaZnuHcSXZ5IKDmStmiJPL6dBprIe0B/t02yAwSSOAYZXfNcwI2Vy5M35Je6XMEqBYcB5OECsVinc4Ptyh+UyFiYLnGOflJa11B2d/VrdeizxvpFdFfaX5RdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928033; c=relaxed/simple;
	bh=T71d/DYPe8MJ7oXjPvR+T8CINLCLOZ5H2kEF1kVUtjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoZze4L5DDnFQS5FOiGbl7QoI273qrWk8jrriKm6Zob1rigrpKqNoj4jWuPV0EY7jhyGmEHxklH3kI1TbtbbcMGU2MQOxhMOdZS0Q9XEPtlZk0gN5AW2UNMG4HwrR40DAykq4sHOFMjNRH5kfCAtMYPk7PYptKUD6XYHaI5cLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yajpJXBb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yajpJXBb"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a465ddc2c09so429503566b.2
        for <linux-serial@vger.kernel.org>; Wed, 20 Mar 2024 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710928028; x=1711532828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CbzQqgtR2/oPrDWpsF4gk7sQRR5UpFu6LGDqxOTX624=;
        b=yajpJXBb/+5Or5A1g/c/MOI8bU7PzBta1RrOzWz4AA3uXyIkkDyHWdpjiGV9mIepcA
         LyCRwNDcdCNZnIFUpMUhbSIusbZ12bTKJFFKM1zVEqMSzJBjj262CTSzjJiOI+8WmIkf
         3nfed7ZMxa3v4o35JTgzF6zwVLBbciSyzqybTMCN7J/ePwISZIynmuEElh2gV932rQ7y
         vWltowj7Pf8XzCYRU14KgaEgPIfH+BTFji+nqqrqci2wpSHIpQO0OodLDH4veufjo65N
         EELHKTwfI9RQDWEmPUpDgt9H0xHtKErS8PCMhUyGmXT5vC5r7J++C5QW2pDOLdn0O1v6
         e4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710928028; x=1711532828;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbzQqgtR2/oPrDWpsF4gk7sQRR5UpFu6LGDqxOTX624=;
        b=OQMLmjGE+gh/ciZ7uE/9Hc44DCd1CmNDV4O/Up6gbEGSLyu04L5bfYzkUjzk1AJQ0B
         lDh6DYWTdFDTCUWwBgXytanX/ViqH4bNH8U5RrRcubwuBzritm2Mexzqa3KHL+YrT0j3
         y+eJi1t002h2G0iYaj+2qBElsFVNpzEjD76/M4c4kMohe436SmSy8j8O5TkeaqKWfmo7
         N/tktjsCqdoLnRFg41TEJiHmipQDSf/PHdYhBBEP3R4Yo3t3t0LafzoR6WW04XCJBDHP
         FYCsp5UPw5jIkZ6QdGede19Q/qPZhJjvd22M85iHaGF3CZKHZvk7+u7EPBREbL8tgf1E
         NKAg==
X-Forwarded-Encrypted: i=1; AJvYcCWV7DCVxTMPDFqKIWH0hCShTFnyFi8NaCkMHqjkJdTAZrlL7CDdVwndh2HxxnZtSTtjpx6tzk8Z1svUr2PNFoplSbbA21DYf++ggXop
X-Gm-Message-State: AOJu0YwjmaJAa7hkHIA5OlL35j9Rvn7AGTWNMlbTveEGMNjl9TFEo+0W
	ntQUUFrRcc3tldQ4PXGeD9JlHBkPbcvYHI0gYMgoJwzRhLXrYh7aH2uNuL33qN0=
X-Google-Smtp-Source: AGHT+IGD8nmNsm4WngcbqJY3GrBLg8IasyBQJUjEkcUlH43SsZdIMB3+tnEuxPC+k6Z6ur7lnlUrtw==
X-Received: by 2002:a05:6402:3983:b0:565:7ce5:abdb with SMTP id fk3-20020a056402398300b005657ce5abdbmr12567978edb.10.1710928028297;
        Wed, 20 Mar 2024 02:47:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v24-20020a056402185800b0056a253e66fasm3195614edy.10.2024.03.20.02.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:47:07 -0700 (PDT)
Message-ID: <402e56ec-7fee-40a9-995b-b737d4a53d60@linaro.org>
Date: Wed, 20 Mar 2024 10:47:05 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A4
To: xianwei.zhao@amlogic.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
 <20240320-basic_dt-v2-3-681ecfb23baf@amlogic.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320-basic_dt-v2-3-681ecfb23baf@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 10:44, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Amlogic A4 SoCs uses the same UART controller as S4 SoCs and G12A.
> There is no need for an extra compatible line in the driver, but
> add A4 compatible line for documentation.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 2e189e548327..d05c45815dc2 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -54,7 +54,9 @@ properties:
>            - const: amlogic,meson-gx-uart
>        - description: UART controller on S4 compatible SoCs
>          items:
> -          - const: amlogic,t7-uart
> +          - enum:
> +              - amlogic,t7-uart
> +              - amlogic,a4-uart

Keep alphabetical order. Don't add stuff to the end of lists. This
comment applies in general, for almost all your patches, so also future
submissions.

Best regards,
Krzysztof

