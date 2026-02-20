Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9E199D8
	for <linux-serial@vger.kernel.org>; Fri, 20 Feb 2026 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771546159; cv=none; b=aO/XWmtlmCpEB5QJsNsa3z2NnjMbqhkHZun9ODI97MFRLZ74WZqsfTrBJoZUr4bxTbFHhct/98jjYP6ilSNrYU3rZtxg4vwKhaUmdSjzqvwVDnWlv7nJ9hqzARA+Fz/o0vsVsbUiLjVW0QICT1xqtwJJcZcdcxjBE9AdwY79eVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771546159; c=relaxed/simple;
	bh=muqBDDQTZm8WW7TEPJ3B4WrvP0tqyQqdJwOdcR66Lgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0ZAfI9az5qn7nGWG886gZ54TU3uT93Yn0zJ2Mj7ACCKQRttQZaY9X2VES2qnJZ2afcVi8acWoub2ppt7Lx+9cBbqgbcNynQQ3D4t+T5ZITl4aNEc0XIqQGuy/Ctw+irj+aWYkUQ9zSQCLgU6FWrFQsdoFWznIlvdM/c0Xozbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=231dObeF; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="231dObeF"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40970f97638so980735fac.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Feb 2026 16:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771546156; x=1772150956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4mPm+ZoP8DxO5yOKQMVe/JsfKSmfmW2/A8ErJD8Mio=;
        b=231dObeFA30pDlly4NfK8dSnOKkZbSHUzm5rLuhoSXuCK+Z/aataC7+lQC4AP1gEj7
         0rtRqzar5JYhCciPcb93QMJpCSZvyfSf9ecvVLu+9U+9iLHeFykB2IaPQ1q4jHERhuSP
         O5HXEPsKuq8gVr7txMJOMaKMJde9/6fhZV0cnAQ6LCleHzeiygNGzu3GEwzmngTnCaTv
         aOe6yjm3L3WXnUSOvXy5yyc3MfTRVhDcl2HnKk7mZryEZKRZVJFVOFoGrgpvuyzshNEd
         VJPo2dmKP+7nOIoL8EboeZWAG4TiloweDJL1wblQgySvhO0GjTrF/liXaMz68II2LgLi
         hPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771546156; x=1772150956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4mPm+ZoP8DxO5yOKQMVe/JsfKSmfmW2/A8ErJD8Mio=;
        b=H/JaYAyJoHVwIff9zVuZXbcCZJ2Z3t7v8bu+xk79/5pDYCwlPlGtxistmw7j8+pwjG
         f6pfr1MgkGWIgzzLtf4Bl35RL4qADdsuDknBwpH7+KokpoImNUVyXAKVBECLAAMKfGNT
         +0S7ol4sVp6eO0mmC2MUdCQXP+cCISurWBH5+cC/RzsZv9TLoDH4drN4pESdJLhGCA59
         e8plC6BXinAsbJIZq6gf5TSzkhiuSBdhBuN7T5HAaA2J6aCjTE23QzeVz4MivWLEbbR4
         Q7wTTKt142SdRA2TnX22LmB2DCs2BSb/7+OrP4ePdEGC7FfRXyiqSsuoQzqiqfr+gSqn
         5PTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMk5Lx2nQUgj5Au5EC8TMprAERZ6y/aQju632qPnDRw6ZhMHDZeOwBoqY1gU9pUWATCuKQXyJV8oHMa0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/koX9wnF81xAd5ba3loaVmGsVUFoRsIDKNJ6bX66G0qePyDiM
	kq9n8IPVWLiuY09C+y3FGe/ObICdphBKUx79J1V2iqWVk7vTH9Rp0mfsOsnApX9ds2k=
X-Gm-Gg: AZuq6aJUflXnxxFjwso0Ou6IXGv3zM/QMmPYiak4SMfsIxiu4Pw03B+774r1y9HKp6A
	3clK5pH2xRRa2/isGHPax31hMDVFrrxCseXISeJym/ZbXtOjSauynssMoc5ipKeTF4H+24RpOZ8
	xZDJ4jy0TMFddgQG0fKmZA+5smVHHGc5EySTdU22Bc9RQpNs040HV53D4junhXYzKbMtyIgkx0M
	AgT4RuRqmcChzUGQ4ioP7Znc05yeiAJzlb4mJftKxCDvS37cvirIZasfViFlP2Xqov+z1GW7Ygu
	kzhwIvH0ZaGcvr0o/V+iIUihIX/f6AUe8z+R0u8Kp6uPUBg0YdcGZlR/7gz5r4C74fCYC/YcsgJ
	bRHjjI6N6mBrwlqZ+JVm5WPxEtGqYgdxFUWTV+FR40pwh1KTYnUkB/qL+VNQOrT5zKjQ90nETe6
	n9SeTq0p9G8sP19xxCrJw//Hcr1wpEqiRe1qyrFmsvgkOqdIzZw1Xz7TkNsSPJFH046tdzjrHpk
	HQ6CHMP
X-Received: by 2002:a05:6871:eb01:b0:409:7c0b:6aff with SMTP id 586e51a60fabf-4152917bfc6mr3628005fac.43.1771546156112;
        Thu, 19 Feb 2026 16:09:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d4c1:bce:26a1:c903? ([2600:8803:e7e4:500:d4c1:bce:26a1:c903])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaeeab492sm25902271fac.5.2026.02.19.16.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 16:09:15 -0800 (PST)
Message-ID: <23778b52-9aa2-49fc-946b-e858b99fc3c9@baylibre.com>
Date: Thu, 19 Feb 2026 18:09:14 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: add device-tree for Genio
 720-EVK board
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
 <20251203-add-mediatek-genio-520-720-evk-v1-3-df794b2a30ae@collabora.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-add-mediatek-genio-520-720-evk-v1-3-df794b2a30ae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 7:59 AM, Louis-Alexis Eyraud wrote:
> Add support for MediaTek MT8189 SoC and its variants, and a device-tree
> for the basic hardware enablement of the Genio 720-EVK board, based on
> MT8391 SoC.
> 
> MT8391 SoC is a variant of MT8189 SoC with a difference for the Arm
> Cortex-A78 CPU core maximum frequency (2.6 Ghz for MT8391, 3 Ghz for
> MT8189). MT8391 hardware register maps are identical to MT8189.
> 
> The Genio 720-EVK board has following features:
>   - MT8391 SoC
>   - MT6365 PMIC

Is MT6365 PMIC ...

> diff --git a/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..744641916952111a4b389cf6adbd27c429b6eff2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + */
> +
> +#include "mt6359.dtsi"

... really 100% identical to MT6359 PMIC?

Asking because I'm working on this in U-Boot and would be helpful
to know that this is correct. Would probably be a good idea to mention
it in the commit message too to show this is intentional.


And I wonder if it would be a good idea to add a compatible with fallback
just to be sure.

&pmic {
	compatible = "mediatek,mt6365", "mediatek,mt6359";
};

