Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD241FA4
	for <linux-serial@vger.kernel.org>; Thu,  4 Jul 2024 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054122; cv=none; b=j8ZAq2jPogMnWqXDHYgmd+AhHunih+cYweVK/DgEf6Af6F2ryy+UU2foJGZvgxOrMQg7Few6j6cM89Y98Cd+TNp/NgM1KCi6QhuRvzYqkJTLXzv6hI7OC3qpG51PykZKLQNssWlXwXpNuHOq23LZcq0/ClMUGnIsm5Y7fOghzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054122; c=relaxed/simple;
	bh=2COa0HWJqWitOaZ8dVW69x5naK4O3xfqMmhxjvE1qdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8K+E7hW2FRWc/GgPrEwwLEX/cSrKUHkmhBvzfEdT0BmAmyAiRLdSE8W0LpfO/CYQMNj34YlBETECWU01EodGo0drWwsl8mlcZt2GTOWHMFG2oQ7nfAR9PTzKHeTCTFrRFihO3zrhrcVnICnv0VPDBcoi6pPjB5FNe0PomFGmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rrcR++WZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rrcR++WZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb0d88fd25so898505ad.0
        for <linux-serial@vger.kernel.org>; Wed, 03 Jul 2024 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720054120; x=1720658920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8cn2ejmCXJ6G+eZPnZq9ZYI/4KIpY2mI/Ezi+jalfM=;
        b=rrcR++WZEjPDOoq/Jtccbm1U4aQ8XyCwHRf1xZGYNzRQ6tv5u2rYo3D73xPiFFqQXm
         t6mHXVPjdRRJpHVh3So/rmc1rXbM9uOMN14nD5vZ3/ZHtG8kVFfkpEE9IsHR48Cp5hLC
         93uT4gXEOpHQl4hs+2NtNObx193XxFy4RbG+BB1Edzd00VfYu/UpY7MqVlRSM6dOFOhc
         KR6XKtbCwEhCzwbWCdV7VFTmfL72HO60Yt/FM6AaPeNJCkGPTwlxlt38tU/vE1hs8J6T
         Bm8vHsyjAfteTHKjZN1wby7V46RIOkb/kZ8nvtpiriusZ8dEzNxRYF8dajX5/7sY07y6
         0vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720054120; x=1720658920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8cn2ejmCXJ6G+eZPnZq9ZYI/4KIpY2mI/Ezi+jalfM=;
        b=tSQmo2UNqclvNkLKhbtTqiZ/bVoQj6/G8vQ/gaSy990AWblt99Smvlp+lCrQMZBj3t
         1NrRg5TxaquO/B3gJMvPcY49ZM9d2SagW/Zo4tNpJiGkB5CPkPTAuArPy0VoYTDkmNCq
         7UEj9N+oGpnRon7S04ivnGCwV6Ds++abQWPqfDKfnlY0SIAOyCVGnMWK0MzS7PQ3iby8
         9GiZJbB1CSCWAr5eIUWIPjb19JjGBr6baxysTie3I8199LTWO8Rl6zTxaUv7qzLq6FbK
         JDR6EK3+giTdgwyUpcyjfgZNmnQda4g/7fe4t5mp6XKjdTO/nBzIuCmwKJ4rWGnd5CHx
         rtVg==
X-Forwarded-Encrypted: i=1; AJvYcCUoYa3orYZixJTh3AJKbiReTFYx+adFRKzV88IxwDwUou08FiQ17MjVDk0iF/Ti0qyWtFtBJ3TTynzFao7ftXZFPaCqXQg6WD8HdvCl
X-Gm-Message-State: AOJu0YziSBwEqL+4bUyEAn8GD1OBIaYAkj2hQFuJXiBQL1fgD0004Kgu
	q5nDKXnRu14fSupgDorT+DxB8LHXavo40W1I9KaGNfMzUOkBl4YWt5ifASnQTVY=
X-Google-Smtp-Source: AGHT+IFZ3U86C/lboDH2rxZfJ1yaega9D0tCmZ+SV9C8fIfhnpir2evwRGIG7EXufs9qWN9lYP/GPg==
X-Received: by 2002:a17:902:d583:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1fb345044a2mr2175645ad.6.1720054120423;
        Wed, 03 Jul 2024 17:48:40 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb18b1fde8sm20274345ad.297.2024.07.03.17.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 17:48:40 -0700 (PDT)
Message-ID: <6be424e0-c746-48e8-94fe-8d5d2eb6cc03@rivosinc.com>
Date: Wed, 3 Jul 2024 20:48:25 -0400
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] riscv: defconfig: enable SpacemiT SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangyu Chen <cyy@cyyself.name>, Anup Patel <anup@brainfault.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>,
 Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-serial@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Meng Zhang <zhangmeng.kevin@spacemit.com>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-10-12f73b47461e@gentoo.org>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <20240703-k1-01-basic-dt-v3-10-12f73b47461e@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/24 10:55, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
> 
> Enable SpacemiT SoC config in defconfig to allow the default upstream
> kernel to boot on Banana Pi BPI-F3 board.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
Tested-by: Jesse Taube <jesse@rivosinc.com>

Thanks,
Jesse Taube
> ---
>   arch/riscv/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 12dc8c73a8acf..5287ae81bbb78 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -29,6 +29,7 @@ CONFIG_ARCH_MICROCHIP=y
>   CONFIG_ARCH_RENESAS=y
>   CONFIG_ARCH_SIFIVE=y
>   CONFIG_ARCH_SOPHGO=y
> +CONFIG_ARCH_SPACEMIT=y
>   CONFIG_SOC_STARFIVE=y
>   CONFIG_ARCH_SUNXI=y
>   CONFIG_ARCH_THEAD=y
> 
