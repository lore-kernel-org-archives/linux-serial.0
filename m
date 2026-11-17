Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916949;
	b=o9ZXnUgfyDFvcHfL5UJ2gSSOUBCIHB3mNdA+CQCbO03WHruDoMbIg1pkEJJklMzCm9Ly
	 vr1S0gqYFt48GAP6cAbfJo4vMlUvS7+4oUrytWQ9yM8qyEFGhsKHpFokLMhJqgQgkAHqw
	 uImIkTv7zpGFR8MFAhxupZUKmvkzmkoAZb50/thMRxCjZntkgseNLOweK8OtYud61+XCf
	 LbIGWVW9WawTDpLoHtXfMnmOAY/WzRB4+AKyjio1R3LdkTkv0kDIsSZLxid+5ZuLAWBh9
	 WAqnQ3rfe1XDAmFC36tV1Kdl+Gt30qjxYKrmV2Xpk3gRj3cIih2w4z2w021My8MqN3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916949;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=K1Zvfa99sLuK1DLzK+ZnNXjcPb2OGlPh4oAuZqkwtkw=;
	b=koxXvV03SGR7BMvDpC4Gb6bp1clblZDXVQQSf056UHmODlQmyxn8atTBWJDFyF7c/1VJ
	 oZwW1EB4nTBnZJpJKQnm7VQBcuDOMGntS5LhTkih1BpwMMNjfInK9W8f1qrnC27XurVVo
	 AxRnBHFH03XwUo3cy7FkE4hvjCXPyfjYmucSLLBINEN0W/NImiiAKNCU0TcTPkgFNcY47
	 kc1Xp3s0TpNYGJNouUs4Lx/18ePjgBl4BZ1M3nyasApPHcHd74NVj6uMuk1E3HUvvlB0g
	 7WCISUeYIvBlnjCaP90WWPYsKZu1Js4qvGCaTlmsS5WoHOzOs2N55jqrF78+SnmOfog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ZzqHuuPs;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6573606A89D;
	Tue, 17 Nov 2026 12:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6573606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ZzqHuuPs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794916946;
	bh=Pn/vfILlPgBup/CmDpdpki2EarwYCJXJtgx9MsaRfYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZzqHuuPsdun6H5EzYeowjGgBvsG48E5Bx+DLK1RB6P2I/WTSewjunAKXg2InEfkoJ
	 08F/RwnoWzx8i+NGNHI3dgpg5mDAgAhmCnEZdt8OS0GxC5AXnxXwfy5fX7PPpTfGT5
	 d9g0yQHw3DHBmI4IAKJEAz3Td2PlizoaxiLCDbEGDekOi5C4TYKBEadkvYcVdiO0RK
	 8ozohV/+jpWxUWTKQGlpvuGtbyzQtS+FYYqf2rnSAYSx8nJw/WdE1qLOF3EIrTJh+J
	 ua3XZP6yIiaBRxkMqjPTpSAh2MWlpbiNcoyg7mjKUx5BOudQ+6jO4OjO0gPdpB2qjm
	 Nxc9QIUDR2IaA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B26E17E0406;
	Tue, 17 Nov 2026 13:02:26 +0100 (CET)
Message-ID: <fb428deb-9408-4129-89d1-1c2a3da1b75b@collabora.com>
Date: Tue, 17 Nov 2026 13:02:25 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] arm64: Initial support for MediaTek MT8163 SoC
To: bengris32@protonmail.ch, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 15:28, Ben Grisdale via B4 Relay wrote:
> This series adds basic support for the MediaTek MT8163 SoC.
> 
> The MT8163 is a 64-bit SoC featuring four ARM Cortex-A53 cores,
> typically found in entry-level tablets and smart displays, such as
> the Amazon Echo and Fire HD devices.
> 
> The bindings and SoC dtsi added here, together with the already applied
> watchdog support, are enough to boot the 2016 Amazon Echo Dot (biscuit)
> to a shell over UART0.
> 
> This series requires custom TF-A, U-Boot and OP-TEE ports for MT8163.
> The stock vendor firmware does not provide a usable PSCI implementation
> (the vendor kernel brings up secondary CPUs with a custom "mt-boot"
> enable-method instead), and these ports also define the reserved memory
> layout used by the board dts:
>   - TF-A: https://github.com/iara-linux/arm-trusted-firmware
>   - U-Boot: https://github.com/iara-linux/u-boot
>   - OP-TEE: https://github.com/iara-linux/optee_os
> 
> This is the first of several series. Support for the remaining
> peripherals will follow, starting with the clock controllers, pinctrl
> and power domains.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

