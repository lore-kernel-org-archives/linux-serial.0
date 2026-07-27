Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A201F1513;
	Mon, 27 Jul 2026 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151822; cv=none; b=c6+vV+wHKhmAmWpvVl0WRL5dyqWf1Lq1ykiYnsSaY7ABE9uRdVaQ3lB/TBfmFEfVqpYG/VxJ9Dmb3oO3TebF3MLBtJrRbrIK332oUiIQSEiwBPBI/DORsi1JZODMEMGDY6nFOLJJAkFz6QKEe0qk6CZ4qGAgTqmwe8soGBB3YCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151822; c=relaxed/simple;
	bh=ZFIAFTwas2rhk3bEM2JyYbhvmHOR7sbABrYjwUVNLQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjzWnwiMOWxlrh7VDNwCVSdg4tOnitjq1UtEoxJOEB4JE6tpsPmdEoaGHZrOTs0+Z0cH2EM22YOMwHyekyZ3stIwFYX16x6m8wXFdYkodkXRvuYrAuyDRHFIeMHyoGv8Yir9a8pfP2Tsqm+9LSaN0W+ZOKvh1JUCjJ7DJSFBT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eluZNqzo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eluZNqzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785151819;
	bh=ZFIAFTwas2rhk3bEM2JyYbhvmHOR7sbABrYjwUVNLQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eluZNqzoifWatVLkxPgK7atnz3bqNuwlLsmhWgAt8gmaEw3yCwnr9qqvhW72bM3F1
	 dEyCinGMU87TJAOYrWSecCipByGtNnu50ZUum9ecK1LFatVvoNMyICbnzYPWBGPXtL
	 4tGvf/aNUyrSLd3RjFdSuPI7sye3GgjBl0VWX7BG8iiOjrUDveduub/xgLyftAa4Dz
	 ZPTnb6wSz0nWLuknBGtjxbcIlIAZpe2fuHGeYe0QMkXF8jyf8FI7w2AIkLuuRJlg0R
	 sudvXZUvXCgNWYKya2/4uVUATkq/7XrzQyWGxaaAw06YN2+1YIhRQegt6dtUR924IK
	 Gx71BeqleSFiw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1741017E0213;
	Mon, 27 Jul 2026 13:30:19 +0200 (CEST)
Message-ID: <a3298120-f5be-4a8a-bb71-1d6923a28d6c@collabora.com>
Date: Mon, 27 Jul 2026 13:30:18 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: alias all enabled serial
 ports
To: Carlo Caione <ccaione@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com
References: <20260727-ccaione-genio-serial-aliases-v2-0-0f2ae41a8e89@baylibre.com>
 <20260727-ccaione-genio-serial-aliases-v2-1-0f2ae41a8e89@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260727-ccaione-genio-serial-aliases-v2-1-0f2ae41a8e89@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/26 09:38, Carlo Caione wrote:
> On most MediaTek boards only serial0 is aliased, so the remaining
> enabled uarts get first-free ttyS line numbers from the 8250 core in
> probe order. When the console uart defers on its clocks another uart can
> win line 0: console=ttyS0 then ends up on the wrong port and the boot
> looks like a hang on the serial console, depending on probe order.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts    | 1 +
>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts              | 1 +
>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 2 ++
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts              | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi            | 1 +
>   arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts              | 1 +
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts               | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi     | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8390-tungsten-smarc.dtsi   | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi     | 1 +
>   12 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> index 0e086dd487d9..63659e240b1d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -20,6 +20,7 @@ aliases {
>   		mmc2 = &mmc2;
>   		serial0 = &uart0;
>   		serial1 = &uart1;
> +		serial2 = &uart2;
>   	};
>   
>   	backlight_lcd0: backlight {
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index 8c3e2e2578bc..7bccad118d24 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -20,6 +20,7 @@ / {
>   
>   	aliases {
>   		serial0 = &uart0;
> +		serial2 = &uart2;

Why is that serial2 and not serial1 = &uart2?

Cheers,
Angelo

>   	};
>   
>   	chosen {
