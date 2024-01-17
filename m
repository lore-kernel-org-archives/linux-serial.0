Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0D2134E
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503570; cv=none; b=IBmikozIyku/AqdZtzwo8KckUlB0MvDTDjEfl9W45MLwJvfE9Nj1zd1lJtAYdUfkRePhckFmuEHzfnP4rbJoKlytBsyOx0AsFYNwuhAtxvIhIxpFfLqoRDauRuabPwYNMfOTkQ+x5XBUra+6BoAiCeWoPrHOQHdaKq5QAfmYx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503570; c=relaxed/simple;
	bh=7j81HGmM3UVZuMW1aajgnh/Tqkfv5ZlF1e2arTN11NI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=anwQSGAkiTA1g1Y6S+hR837DRdwfRu/CaWGs4/YnmHSYwW4ZKHNQziEKaVdBCR8usS+ua24Q4rv4KDpqzGATmbpHXnhWledVlrE0bcjhau5T4w6dlbFwkykXDsx2rHXEaRG5qUudGSFwvy0YPG5vqfOqMmYdVE/HLkf8yCuUfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M126Baao; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M126Baao"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso17073855e9.2
        for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705503567; x=1706108367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmOxe8Kt63reb+K83M/fiIpc7ZoymLxbMzD4gGdoAzs=;
        b=M126Baaoif7bxWr9cLsIatT/8b81mBZd4R7H9bNooD8W27aH0LrMDecGWraXMcRqC8
         Ir2XCV3QW5PYHHEZyxbiTeHHcKTbpDjR0+sj4IAcyoWnPfqhEul5vKC2d6GpAHnQPeik
         RfVme+heJWOj5cgrC3fNaO4kOw5O9+CkeB0Mxj6UzWe53WYVKsbVgIpFK/Lw69MGhDC1
         tNDxkChPwapCvqQWBVrKshvO6rOwmxdBjbl9PrPGqABSStMEmZfwIIxmNT/swZBRRHS+
         TuM7NxiyJInuDpgPPQmdz/SB4/Bjqsa4hE+fDa+fYE3Eew0ORyFTxVBaxLpeZ0Fq1T2d
         7UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705503567; x=1706108367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmOxe8Kt63reb+K83M/fiIpc7ZoymLxbMzD4gGdoAzs=;
        b=MWYS3Mv1+xoowRYgbu4/2Xjp/7YIY1o+jTSa/SpgQtqty5y4kqe0H4z7SXeSqMEfSK
         aYSKCNJ/RZCAyV7Du55EuhYxyfSTNXkm7hqFoXssOwvQnDDgk6wMhW/lnJ27yJPoNord
         AN4Rua+Wx6EKxgKIwWZswFHb7q+KtQ1Gy8TiIW2pqtuJFkTv+1tynZr+K3eVdt4ahpmb
         aR3TJI483iv2ee+SnN6Nt6/apuSPbR90ZGx9zSaDfEVV/iUgnWI6ZGn4PN32nzmnZfer
         X0t6cZ4zOpS6Pb17dukYF/XTfXPQThH7BRw528rr6ZV+iJPuhYvpabcnmv44759RQvHl
         zaqQ==
X-Gm-Message-State: AOJu0YwUwHZghJLd9mSDc5kTUF/uI0HWkev6KyslsbLO4SxrmiAaS4zg
	E538PBfEHilBnvJkqWSSiXLgrS6+KSsZJg==
X-Google-Smtp-Source: AGHT+IGy6qHkEPrF3Ir1FNIzi8E8U7HINl3OXeiajhONjDtBYPNIZN6SHJlqkSjxbgHRxUhaMtMqfg==
X-Received: by 2002:a05:600c:84ca:b0:40e:4e54:3e46 with SMTP id er10-20020a05600c84ca00b0040e4e543e46mr4715735wmb.91.1705503567601;
        Wed, 17 Jan 2024 06:59:27 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id bm19-20020a170906c05300b00a2362c5e3dbsm7856439ejb.151.2024.01.17.06.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:59:27 -0800 (PST)
Message-ID: <59a2e142-e970-4792-9233-7c447ac391b2@linaro.org>
Date: Wed, 17 Jan 2024 14:59:24 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] arm64: dts: exynos: gs101: remove reg-io-width
 from serial
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: peter.griffin@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
 alim.akhtar@samsung.com, jirislaby@kernel.org, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, andre.draszik@linaro.org,
 kernel-team@android.com, willmcvicker@google.com
References: <20240109125814.3691033-1-tudor.ambarus@linaro.org>
 <20240109125814.3691033-9-tudor.ambarus@linaro.org>
 <CAPLW+4mUMx9RvFiS0L2U+_Fd_PzcHhmNbyR4cmUrYF3BVgb=Cw@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mUMx9RvFiS0L2U+_Fd_PzcHhmNbyR4cmUrYF3BVgb=Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/16/24 17:57, Sam Protsenko wrote:
> On Tue, Jan 9, 2024 at 7:00 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>> Remove the reg-io-width property in order to comply with the bindings.
>>
>> The entire bus (PERIC) on which the GS101 serial resides only allows
>> 32-bit register accesses. The reg-io-width dt property is disallowed
>> for the "google,gs101-uart" compatible and instead the iotype is
>> inferred from the compatible.
>>
>> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
> Just out of curiosity (I probably missed the relevant discussion
> earlier): what is the actual reason for moving 'reg-io-width' to the
> driver's code as 'iotype'? I mean, what is the actual problem that's

The majority (if not all?) of the hardware blocks in GS101 SoC require
32 bit register access widths. Instead of specifying reg-io-width = 4
everywhere in the device tree, we infer it from the compatibles.

The relevant discussion is here:
https://lore.kernel.org/linux-arm-kernel/db368449-f446-47e8-81b6-a11c2a872306@linaro.org/

Cheers,
ta

> being solved by this -- is it to make the earlycon functional for
> gs101? I'm asking because the bus width looks like a part of HW
> description, which usually belongs to dts, from the design point of
> view. Anyways, that's not a concern, just trying to understand the
> decision.
