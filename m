Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAC20E334
	for <linux-serial@vger.kernel.org>; Fri, 16 Jan 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548144; cv=none; b=brb8UxCSbU8NOwSmWOwbvteHBhoFOGmQ9ibW/k/vIoavA5wQVvQZZ0Zg1auxN0SQPqztYV2MzCpLb/b+0ODJLMIjOWQQB22QIVrReC63lIyX9VTFLbfx2G5I3zQHhxO1a6jU0jfIMxfwcyz2qkFjXZp+Ocrtvyt4YtfqyzOIGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548144; c=relaxed/simple;
	bh=ZoZCxIZIxuNG7iiq7ouEpN8AOaGaswIYZVOM5BEKY0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwDk8AkHLOOuykulfFO5fr3wJc6mjZxZjx7ygecI9XvNVFpulSLNndPkHSlauElE3fjEaEd4jP/PLm3h2OnW1+6ZhDF9PtZA+PGP/BQ/N3cT0WhbCzLENaIEAZgR6H7alzlM6M5uFNCoMOS0wGbflu5LdqgzQgFyGpcSbXVlMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DOz03dJJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DOz03dJJ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432755545fcso1010963f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 23:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768548141; x=1769152941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W95GN1V+oZI3tCyhJrWoqvfYp2X9bfUg8CvoDb5FSAs=;
        b=DOz03dJJJrHhANTzRWfRIwG4CLx0lVlmsIjqaVXIAMhwfUkQMzxluDIvnt6G5tZvZr
         4c0dlJQT35H7vKeQ2kACS7kFyjHOCBRMDhEqHMGjvAHO3J/KXmEMGQKVzcuA8Tkh5u4v
         iSdLnjY0HoFbhIx7+jU9y4jcsGD5y9+L4A9Rbbfwe9Oajkr9Uy/QAO6wftMa4FTKMWiv
         Xr2onvXDgcKQNOVRRMi3T/uSAL+HyazSQJuk5cqWgDP+C85At8mPoVxlZUnJY2INJNn6
         NZOLFZwP31nUoRTSEM/hLvbT2rEi9re57qBnGAEmHczkC9DApHPsTcrZS0p+KjQiDy4r
         ffNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548141; x=1769152941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W95GN1V+oZI3tCyhJrWoqvfYp2X9bfUg8CvoDb5FSAs=;
        b=TrIwOvpsnvFNNURgSVrlGWZSfchX00EJTdAsGwg4EmDPjJB36x1hWgw7O73lazu7jj
         jE4ehh3JDvsunXEsS6287oqgoSkUNBxG1eqeDSmF6015dQ0qD/H/RVsgiZXEUCVhmhqK
         WaiJOiyfTCuG6Icl24RyS5EMFyCDN6/YPz0FmpJd4sKMm0Zmla+VUhmt8+x1o1HFWpOm
         Fvfv60VOmA5cCOr2LLEBLXeucNiAM3GcxhS01bRY6hy9KLjFc7uqr2ogG6ShHog20j03
         FYSvW3ZV/3mdkyh4wDWpdFkPEToI5m12bpdKSXu67IkSzY6vQtbxBulAPF7pHEm07arB
         W3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEImxkc2mAgf2DOy3/usIY5h2tokk5O/KWgv+8S+RC6EdTkFNx7N/mE5cm4eTys4rD4HZLCAsqxP1+1Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCaD4gF2kRqJAvW+EdRCaPkAjpoI0BzJrlJBxLJsYxPQKSA9+M
	jVeAG9+Qd1k8KG975CTkduw+QisIGaPQ2fi6X7285w1G1JI58whiFc3vvlPN2+MXEgw=
X-Gm-Gg: AY/fxX7KJt44r3KN2eK4ejex7IeA7RpgsAQV1nwuE9tl5iG3SMofnGVOMGYcUQKIEjl
	jPaX9T9HOD3rykvyVSpCJi7/mvAniky6WTLjygnjzFSdq5+0ATMa5ld0767ddlyv+ALVi3UkCTb
	cReHIBZXIsoaOy2QT3OSZeSP0MjgZVHmMyiKuxCuUHjCXFnc3RpMS8wamgRTvxYMVJK6Bd6vdLY
	7O2sgP9VACHivWQyybBK3E2ABCVK0yAfk2Kis7w9cFwk8T4dIm3vQY7LVcTDdbSt8F15qiiAPj4
	sStljvU0Xu5JsGqwuU3syf6xGC076+Qm13em2QO2t5VGpJ63+F7+7TWxGYuVCcYmvZftJKwPvfY
	EjhVVa+65PV8K8eoK6GRnSo7WmJP37aSLGkkjVVPkmKUb7Jmir4sFlqH7OxcD1mFUZQ1rIb5LWr
	dZBYR7Dx+xoFGjV6r1oQ==
X-Received: by 2002:a5d:5d81:0:b0:431:752:672b with SMTP id ffacd0b85a97d-4356998a823mr1864994f8f.14.1768548140696;
        Thu, 15 Jan 2026 23:22:20 -0800 (PST)
Received: from [10.31.13.216] ([82.77.28.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm3496749f8f.42.2026.01.15.23.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 23:22:20 -0800 (PST)
Message-ID: <40b636b3-b1d3-4c67-bbfd-6f41a5b0b290@tuxon.dev>
Date: Fri, 16 Jan 2026 09:22:16 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] arm64: dts: microchip: add LAN969x clock header
 file
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, lee@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, linusw@kernel.org, olivia@selenic.com,
 richard.genoud@bootlin.com, radu_nicolae.pirea@upb.ro,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, Ryan.Wanner@microchip.com,
 tudor.ambarus@linaro.org, kavyasree.kotagiri@microchip.com,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-8-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260115114021.111324-8-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/26 13:37, Robert Marko wrote:
> LAN969x uses hardware clock indexes, so document theses in a header to make
> them humanly readable.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

