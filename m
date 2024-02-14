Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E315F48C
	for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925718; cv=none; b=KCRq8UtKTi2tFwBN3OXhjK1xq/FgpyuQdW2TU9itEEx7DksjyEmd03RolFjafLlPN3YJkfYnfyv0px0mBiFxYnldLa49/pYDHwewys7EYxV7oR53kcPfqZQnQvYJililTPxQSRi56FY4zEpwlSrHQChzDHDmSxH/Vq5OxLzDXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925718; c=relaxed/simple;
	bh=sLC97ITSZbUe27XY4ztbHzTuCJ4TH2le3J+EBFpwv5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sthUAyErDDaVW2alFDOTQVBHhFIxN3m6dxPhPp/4Twde8BuGBU7bdaOM3xHAslK3h1s7MApZrLmlv3aZk3BRHSJbVcFqmryaFjnS67zT4Qahm0Mupdsb3QfdfHQTUXv84s4+8ieLdk4b8yXRhFatpbN0Aa3aqcXmJ5oLDuVT/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PB9hx6+5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PB9hx6+5"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso66865251fa.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707925714; x=1708530514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtZmAj5Obyu85PHbwkEdB5mj3pB91mqkkCJS/j9Thic=;
        b=PB9hx6+5o0lhedhEbbiL6N8fLcUj8i8q9Iwio0yO8InuJ/y+j+MJEMpscktUuKdpr9
         kBmX64xPX1MFoBNsn12HLbbw8fch8h10ZWYW011103Sf+P+p120HILolNRIFDydMfSBR
         +0JvPUpWIay3jw7/ih6ZJeMdp3opK1t7WzIVkLtCyJBB5ylncKnvOLYTZqZksLP1gQ0s
         tTJBKkEUmw0E7rPZTEvWWvXiuz5A+meZ38v96QQWZyvzPn3sDiWDndNfB7jaByi222+g
         3QgHXgibfZcWBE4pvL7/1piidB6HpWdHo7VJgGQsuW9O/G7gjzyhf3GLXRLbg2w8bG6I
         VrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925714; x=1708530514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtZmAj5Obyu85PHbwkEdB5mj3pB91mqkkCJS/j9Thic=;
        b=AGnCkQKBNV5x73gbE2wL017AL7yqlV+w0w40zZtaO6KLbSAxvSUqEl2JIagxiEc1QM
         cFsLQE4RRg92psyWPXYg2biYSOflDKSjIImHbLKsSR3wGMM9qyvvc3wb4cGzXfJPZQUo
         OK9oSoECAPmMqBiRrf6d2wOr8oaI6DcaX8lUMy44H1U0AmdBLccCGoIKYmWjmyoZcTqK
         R6coveDsEedM6LuHzPl7R0OVgQZIVbKdBPDBeJtXRHnm3PA2xJt6oOfe7G++YyuLPfnV
         dxn1+4+iD82134QtpXlCPZLw2NooYqNBTyp4pUJny5NHUjmZB1u4gtAigsQ3K3vipcy6
         j80A==
X-Forwarded-Encrypted: i=1; AJvYcCVb481tueDEEy8N/RdJyhvYt1od/av3RL30XoQwwGnvQXjFtTdMvOEjkyQ0kvmfb3t9H/najeqctO8Nty5EgQT/6vqCBc6hfj5YpHf4
X-Gm-Message-State: AOJu0YwMswr/BdAOvxgAIpGCrj2tDd0ZmtE8kxYp+AMXRYss7ge15n4N
	hGCPbijrkh7GmvhNtInDFrEFs2wpoa9B/T75xYZpoLSqqmbKKESqYtYF517MJCw=
X-Google-Smtp-Source: AGHT+IH+S52htKOc/Q6HjqncnjpNXj8n98yE3pS05Dq+kJt/WxpNTGJ9Y82Vcv/+jR55IflcwYdyTg==
X-Received: by 2002:a2e:bb85:0:b0:2d0:b663:f052 with SMTP id y5-20020a2ebb85000000b002d0b663f052mr2069792lje.6.1707925714632;
        Wed, 14 Feb 2024 07:48:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+9MdGh+jmUEFZNDJhaCGuOVGmdGhcfTLI58x/WJFMAD+cU5L+9ci+pf6bg1QRr6qmzkWjRVs07xVuecTZGR4cIBSE2EuC1xP6p+Ggc9YZ1ggt1C+8o5/KkFfTpYh5cloNQEfknp2gQcsRYxMpO5Xj3/RZ+RhNGunYUKGD9ruJyCyKmnZpGrJkm4vdsKm6O2qcGE72FaQqLRVOxcNYKNGUVvhSTelXixg90HZZMSetjzzCx8IA2Rm7+I4jqFNPIvKe3hdiv2JxLxUFaTOUDJk129Ut1iklgeMFsru7kVlJnATMxcAUtCbw0vCycucUUB0ahC5k1g0LZBKVxC4zHpBd96QLh+hb2GGHdY+qdnU2I5cLzydj0QuvVQ4R9bi5XIpTQxAZ
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id de21-20020a056402309500b00562af79fe8esm727085edb.19.2024.02.14.07.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:48:34 -0800 (PST)
Message-ID: <3a8f759d-63e4-4580-96b8-03e3b5d8deae@linaro.org>
Date: Wed, 14 Feb 2024 16:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] dt-bindings: w1: UART 1-Wire bus
Content-Language: en-US
To: cj.winklhofer@gmail.com, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
 <20240214-w1-uart-v7-2-6e21fa24e066@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240214-w1-uart-v7-2-6e21fa24e066@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 07:36, Christoph Winklhofer via B4 Relay wrote:
> From: Christoph Winklhofer <cj.winklhofer@gmail.com>
> 
> Add device tree binding for UART 1-Wire bus.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> ---

No need to send applied patches.

Best regards,
Krzysztof

