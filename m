Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE658AA3
	for <linux-serial@vger.kernel.org>; Tue, 30 Jan 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602534; cv=none; b=fUBVLya1oTHjISkTekS/oUhHXoKtehKsufegQnw/SZIaREQsXLhJjSUkGWC/6VfdAoqOHY2G4qLa8PatVWlVeOK/akAedKy8o2QypRDTSq724KT/YnRk6pv84yFlb1Qly63Hdmry9skpOSUiyJs+3MAV3omfXXGxytClcpdcNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602534; c=relaxed/simple;
	bh=mL33EfexsGy81qLYkGxPiFCZamrOqVY9zJmZcZSmZmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnx6Ar2dGDJhPVs80mjnQRZBHQJj2Vk5gXUJj7wEvTNlyVIts0s9RjRzzJrkmQslke7renRU4nrru8gQlEmHlgKmicOk2CsPzOdgqH8611DXpYqZb5hnkoubMMb44OwF26Aka9JJ595TSkQOm67VtIMb0oyA1/lW35OhWNLVzGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eso3REuN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eso3REuN"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a271a28aeb4so439269266b.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Jan 2024 00:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706602531; x=1707207331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhMp7KKsjo07nqB7KZNtEWJ6AL1gedASvjEszHUkpSM=;
        b=Eso3REuNjvmymgk5PVCF9iRJsqF0IuL5WNOthgPctLsOywJWsORFxV5pT1LVUGxdI/
         Zn8bvbVaKtbxl/jpKr8+2h8Fgpt7V1XITdG1j2xtUImGVAO3aEah4W/iNcyGcXQkngZl
         AjnR3creEomeLY+AJX7awc89Y6DHTpeecnRVj9wJ/1t4Moweq+yPu2NYL3HAldTx2XAA
         F/P6vbsXNlSDZmLddDRymkAmOctN/tJ35QeIKtY0i+ndtIPD9m6BU3RXSUTnNaW85vFm
         fpC5qnX3ozWICJYnP+Opg7Y9DRxYNjmTLVKN1/BTHUAWrM+NQNT01vsBc4p4nm2TCBUj
         KaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602531; x=1707207331;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhMp7KKsjo07nqB7KZNtEWJ6AL1gedASvjEszHUkpSM=;
        b=Jiu44mAF/kwNLgtfAl50asXA47yvVzTY4g6SgCv0N53REUXbd5UWN32dHzAK+7dTZF
         Cs3FegkHPbLoOyPm9h1T4Jj6c+kWe8Mn6Wxs6q8cDqaGX6SWOXw4GzYVeEhyNedppLX2
         NWJ6eq9Z45BhDcZy0WomZMocDAebQSllxWmO1gZO/I4O8Drh5VhHLNmNJMvQIKHDrmT4
         XJ3Q7zz7OMMgWgAiGQrhbPwGCKwAxsF+5QMA3XHExrBJMlulQhiAyfHmK7mTK4yHvbCk
         iKaaCE7IGBx/iv7IVcCcu0uPAiYybXEoonX57WPAecRay4bDAIY6ql4FFW6Qk+bC4O+a
         wbaQ==
X-Gm-Message-State: AOJu0YzxjKH50FFn+brGrlsPE7WTLKGi5COZpDBORwQ5VOkgtE2m3zTA
	bEq7Z6Bs7ZzxUCVykl2PWitTSB8hFiEfd9AsRQzNhzWUvB+Lpxpi7Fovrq8ZUlU=
X-Google-Smtp-Source: AGHT+IEbD7LG12p286tpDqgpNwalI+adkVXaHQkutVJ57xIRpsIJJyVzZMK0ChiLS9ACxa9kw8wWkw==
X-Received: by 2002:a17:906:af0c:b0:a35:f647:ccac with SMTP id lx12-20020a170906af0c00b00a35f647ccacmr2198534ejb.44.1706602531368;
        Tue, 30 Jan 2024 00:15:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vw7-20020a170907a70700b00a35e26d86dfsm1410740ejc.201.2024.01.30.00.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:15:30 -0800 (PST)
Message-ID: <881d08a4-8bd7-4028-82f2-27bd70aff1e8@linaro.org>
Date: Tue, 30 Jan 2024 09:15:29 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] dt-bindings: i3c: svc: add proptery mode
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, ilpo.jarvinen@linux.intel.com
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 jirislaby@kernel.org, joe@perches.com, krzysztof.kozlowski+dt@linaro.org,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, miquel.raynal@bootlin.com, robh@kernel.org,
 zbigniew.lukwinski@linux.intel.com
References: <20240129195321.229867-1-Frank.Li@nxp.com>
 <20240129195321.229867-3-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129195321.229867-3-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 20:53, Frank Li wrote:
> Add 'mode' property to distinguish between 'controller' and 'target' modes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v3 to v4
>     -fix dtb check error
>     
>     Change from v2 to v3
>         - using 'mode' distringuish master and target mode

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

