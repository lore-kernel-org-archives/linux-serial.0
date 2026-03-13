Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEA1A5B9E
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361601; cv=none; b=A3vyKwczVFenrAWQaBmbRcvP0o9e4F12OWihyfsUoc9bWFj8NoXs/clkQJ+A9TAufe/nLziw0A+EK4xSrNHBfUnGfk5R3AVSS8FAJ38Ao6MTArv92ZaCwQu83RkDoW0YcocgU4tjiZRtXeJTsU+M3r7IBFeSwCHrwjLqNj9Dxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361601; c=relaxed/simple;
	bh=A45ax7NVDO1TwHx9p9l4hYQx4uaTGpxDk/u0odhpyRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCjpVMuCLJZqeogYc+rZLjz1lENuToP+kTdGfigc1sezo+43vYBZRLsGqJoa/I3fFcbB0cJ1pwr+j/LAuVVOSNEITFMTq9sE2DqGYyL2xVHxGp6+agO+j72ohu4zDv+wJFEbUjlHT5PcovUwTHXzzJPSfASJcTbMDG2IGMBVst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3OJNjumP; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3OJNjumP"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d75ed779bfso1754035a34.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773361599; x=1773966399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqFmU7kx4Mq4mgXnbflh7LA6+0GpHxy9Eldmo/AcQLw=;
        b=3OJNjumPftaxOq9AhG5jlKEOGJ2FQttkmUFagLGBTCig+goMgjdEj81674QntxLJUh
         blPz2kOiyp3cfozgOcLDYyBGpJvrQRKyF3VKbkmKXBcjnjtrTHSW+Q71EPL4RKUoY16P
         AroOjSavkghbo7Tlp+G2dZlMvHvZNBqSRqOgRmnGdXn931NbXr/McSWUCTxgktezE36r
         cyaMVwtXXnGqL1hCBdmsULvE7ChF/APEIDAIvQ2JdjEEuqiSUz7B+RR/lbm1AiihwhLs
         Y37/ao1IWbmlwZgfezrXhcEeZpf1LKzcYkpiGG/K26qDqelf67Sd9hFE1U6QiBS1BUwW
         xxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361599; x=1773966399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqFmU7kx4Mq4mgXnbflh7LA6+0GpHxy9Eldmo/AcQLw=;
        b=VKEknvGTfShB9UI3p/ZrEsrMSVG4djonwwrrBY75f3OJqEnRWfoY0aXEV7oDKkErH1
         xvIsHMyE41Xyd67sNSVmxV7JmlXBeqKdpAXa4ivJTsYDi9pYv/kqnXhCE/9hnF7+LGSe
         wQ8PvSK9EQvOd21p2CsJqnw/hlUDhu/eo9AmUN1ERfEId7XPhWzjZxwb4AT+fwAJ7fU0
         B+Kh4H3ubWXLb2CTTRmeyYOMsJCxFYHUPfo8LobFjSNuSJ1XO+lrZ76avrpk9yV3WS1k
         sZ4qJxNZs3HcBejTF0eo72sKMVoTX2p5iQD7hkPe7xwKX8KDhKy+00ep+rzwi+wMJ24w
         Wbqw==
X-Forwarded-Encrypted: i=1; AJvYcCU9H4+nRLCA2g5eU+P7Fs8aLC00hQAm3t988NUZzdgtPQ8skYLXYH+hXkpWOpmL6NRYc1AECIOvLEhbB5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIE28W9SRVCSG+yWl9hg7ynyQycQ6tnxp/k+xxS19dvVy34UA
	Rd/lx2zCwmrHMgh+rhKDizS+i8Y2Uu28s+lu9frhKSQ6aRv0P8DlQfyS7OXYUqbLPnc=
X-Gm-Gg: ATEYQzxpVOcSbpeAUwcjJqZyqz01ctbYKWms20uL51Olt5AF1vKYewWl1K4ACFFUia6
	YinEy06RudXGMiaHeeSLg9E89QpxEs59swoBzJfGyQdD9x+Ow0Qzp6luN+PkAw/ftanyGaBuq9K
	sOImQDPbWXyDZeYkuFvPBxvtvwCcsTFe9riJq66wCQ+QFI/pLTYi0y5PqWYQi6wmim+XdqFvnDJ
	pJGnJJYzCJO7/SK+u3KFDrzfUHUIH/uPvj1nA+tq3QDpibnoIZ6KhqBq+xrwwpjpXbj2fBbjLNe
	6N0HLcfhUa5cC02RY23xSyYs22lfroQ3doJkOImoBhIStDY6NdAfOSLLqh3JEZmHNLMDohM9MMH
	Hj2A3KPgbTbH2uE+pUUtxxsvHrGTIO4E9oqQIi6naGoKvBftB3hREjTr8hFMazkTQX+zHKcLFqH
	olY+PXH+epbuozbUK83BAFKz4cE5a0uOYzqUlfrm0zDf+qTmo1XYtJhIwMzzCwMTWHhg==
X-Received: by 2002:a05:6830:4428:b0:7cf:d168:2107 with SMTP id 46e09a7af769-7d7825cbfe6mr1074685a34.36.1773361599160;
        Thu, 12 Mar 2026 17:26:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:bf:9982:ff59:466? ([2600:8803:e7e4:500:bf:9982:ff59:466])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae39600sm5254761a34.17.2026.03.12.17.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 17:26:38 -0700 (PDT)
Message-ID: <c2618423-2466-47bb-a8cf-7c849e7e231e@baylibre.com>
Date: Thu, 12 Mar 2026 19:26:37 -0500
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

...

> +	mmc0_default_pins: mmc0-default-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
> +			drive-strength = <6>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <6>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};

Should we also have pins-ds here to match mmc0-uhs-pins?

> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
> +			drive-strength = <6>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
> +		};
> +	};
> +
> +	mmc0_uhs_pins: mmc0-uhs-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
> +			drive-strength = <8>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <8>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-ds {
> +			pinmux = <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
> +			drive-strength = <8>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
> +		};
> +	};
> +
> +	mmc1_default_pins: mmc1-default-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
> +			drive-strength = <6>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
> +				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			drive-strength = <6>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-insert {
> +			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc1_uhs_pins: mmc1-uhs-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
> +			drive-strength = <8>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
> +				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			drive-strength = <8>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};

Don't we also need pins-insert here? (to match mmc1-default-pins)

I was having trouble with the CD input pin not working in U-Boot
until I added it.

> +	};
> +
