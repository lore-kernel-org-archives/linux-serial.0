Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727235028E
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894109; cv=none; b=MIMmOqjLFlz0AbSofEHZUktQmRH7IKqd6Ji8TUclGsIpSIbfB4rZo2b/SF7tx7h52sImPeMcawoHgqx/pEpVh1queJizgtazhCnI0KH6TRsXC1vCISR2yVsdhIAokmgKKT5AfR03O9+Qlh2gG77D2g+q0a34OIffaUtXF2NEXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894109; c=relaxed/simple;
	bh=/Wododm6Hj52N73BD32ughfd/z1UEFrBFZydemobFr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO6uC+bLtaAYivPvt6lkTvV3tGU1z7DrgL71SsK63pZ3S+mJ+PzvkzXIqS660aEvaMpurZKLE4nQYiWjZvwVhLdwN2gUdpXmDazFwMZoSwoZH67oljfPzDUTOBI1CRyCdIZx29ADHM7AVOOdLJuk7TWEvdaAC/f6WzTI0vILi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=EB95yM4t; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="EB95yM4t"
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 89DC73FC34
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765894086;
	bh=s6OKug5US6pxBUrhttaNzk4ojcTJP4aLJKCdbICH8xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=EB95yM4t9qIFdZaAOY3YK45qauMionXTEVRD+Un41IdxcnjfMqDRfZi9rmuCT6s3t
	 k00f4uCTFKVwXoHlceGyV0nn75kJhgDDV5DHE88t4aoEVDmS6P/FV2OnFPMTLSzREs
	 5o/b+hGiFAur4tdw7Hf+I5a4nYSWFARU9Tjo7w4Kb6Uv6E6Krao8onSIYXIPazS+1y
	 MaJBI6VtKcRqtcwHJqRmxx0GWko2jqjUfoWcPYEf8LbIb//vJXuozebDMAHbMmMCg1
	 5R43Uz5qGd8BKNczqAoPlpAIE25zi66XKOFzM9x3r9VakWgLDCa0oM9sPc3je+gbjK
	 gSxOojBBu6d1Nj3CUObUC1pK3G25z39ULgvmSYOMYBbe263fiyXS1ts46EHxtGnB0u
	 alhvbhtEW/RVQbZjYQ6ry4iPhS+PdEzHYxk+vjEUkzqGPTzCzXc6iHNdZaShmVEI7T
	 Be6nyEiNRrgnp3g4NSjLXxyvGRuB9sZCLSnvgEPC28owFG4jDowIt0eSln9rtiViWQ
	 AawKuukQxq8es2PR962rgOXOOaXXOMvlHWgbljk3DHscXHrsMXMebZtMdOwv2mA7P6
	 /VIDC9lgQXh7OHdXZbfzMJ+VbLUL7whSn/9JSH55OYIKWN67yAAALCyRs4niG+fGrZ
	 4GzaEAxcaqqk9tZswvH3swDg=
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64981bd02a4so7403838a12.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 06:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894085; x=1766498885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6OKug5US6pxBUrhttaNzk4ojcTJP4aLJKCdbICH8xs=;
        b=l2wzM5zIzSUvKYG3TH2Rus3kEKlkzTRtNThTyKP50YaNtShgGgpqmZ2lpiFVdS7ttk
         coE4WPQz5l0nb//RJ+BZtucN9Q9rpJQGGxL+GrfuIXBwCHRrvWjCXpJzGpMk8xsxsepC
         jLiHlFbV4mtqY95QA2n/wp3fIHj06w0VFw0iWHb53uMewqLgfSatIb8htlBDFYv+hDzU
         Z8pl+Vz23j+vTJJ9BB7dpBvrfk5yFIldjNev7s1h1vg77I5NmUgMJtAByY+38/ahzEMt
         MqHMP+UoNl2rl6IyEtf1GqHMaAbof0rRDQeY4oXxcAKh6TshYBEMRNFM+ZUm9MWgG8T3
         JN3A==
X-Forwarded-Encrypted: i=1; AJvYcCUF5HNLgOHppUF+OoCgcZtXgW9Z4Mj+U/aDsLyI5cp+QGnhHGvu5Woppb0P0sTX4rvbSBghyR/6qbz1PJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywalf9wmo1JuW8Lbaag/9X8xm0g8J9yrrDHPN058eAqNI1XCMdq
	yQ5vC8FAWexcO24m8r8Blmlj97Zl2zvaZ1fGaIcyvaaorX4rFoYsgDSqD0AIjptvhB6Rg48jyaX
	LbvRaemImsuqTMmw2Ocz905YA+uAriRNoGlJMWqtJmUE0rIcEjNxlAGprWM9U62PDPbJRx8j/E0
	XT+IwfPQ==
X-Gm-Gg: AY/fxX5OvFpU/+MjFFyNeRjsyMwphA+Vce3RPgYUTJ+yJZXfMFfH2yEYua0fQiUyZSx
	6vT9XWy3b5PyjyDx2nh7qY2WgHYr6WAXFIzud91xKd/WqifwAM1YEQDDXdOCDFIvMx5+bu6inNZ
	7oYnbiPDtXc7rA1L0gtgCUm+2BVHNZZ3GOZLlqwWWrw08UCTDGPfwOBDrFWOTVsWvzOwAFSNniL
	PR/nfF9dZ01zwnlSIe5v1eMCeg77f5+5c6iXrCf/gfTdecVXs1vbopICk+ES5XvMLPJi3rlcQxa
	JED+6b1keNt3vE75b7fapMB+GM7nC1PL/CD74Hby8EXpW4JCyFtjFSuT8sHrWVkP4nnJ36ibwi7
	ESjM+lvAokMUeY/rXa5tbMw0DLW8fK94c0hQzLnbpIoe/oGDylkvqKYNk7wrzvuHSdxxDLSYNxe
	VvjciPLxh6OWJv9A==
X-Received: by 2002:a17:907:60cf:b0:b7c:f82e:30b with SMTP id a640c23a62f3a-b7d23b1c3ffmr1594364566b.52.1765894084887;
        Tue, 16 Dec 2025 06:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtqWjNEWPbxkffOmFNn2OFkrwSQdkzVjA6Bq6rV9Lw/Z0LSQ+mn+A/wq7Eqay9PrsgCg2JGw==
X-Received: by 2002:a17:907:60cf:b0:b7c:f82e:30b with SMTP id a640c23a62f3a-b7d23b1c3ffmr1594361066b.52.1765894084492;
        Tue, 16 Dec 2025 06:08:04 -0800 (PST)
Received: from [192.168.103.125] (dynamic-046-114-006-010.46.114.pool.telefonica.de. [46.114.6.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa51b859sm1698504466b.43.2025.12.16.06.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:08:03 -0800 (PST)
Message-ID: <e1383a10-84ac-483c-aca4-7f2b39ccac16@canonical.com>
Date: Tue, 16 Dec 2025 15:08:01 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: riscv: add SpacemiT X100 CPU compatible
To: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 linux-serial@vger.kernel.org
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-1-a0d256c9dc92@riscstar.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251216-k3-basic-dt-v1-1-a0d256c9dc92@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 14:32, Guodong Xu wrote:
> Add compatible string for the SpacemiT X100 (RVA23 compliant) core.
> 
> Link: https://www.spacemit.com/en/spacemit-x100-core/
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

LGTM

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index d733c0bd534fb63ed7c0eada97c42832431f1fc1..cce87092dc7749f49066154d9a256af6c7b6c19f 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -62,6 +62,7 @@ properties:
>                 - sifive,u74
>                 - sifive,u74-mc
>                 - spacemit,x60
> +              - spacemit,x100
>                 - thead,c906
>                 - thead,c908
>                 - thead,c910
> 

