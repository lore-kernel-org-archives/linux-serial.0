Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236C29DB8F
	for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013769; cv=none; b=WNU99NNqaVxGm7OFc037dFqVODYGsUYBsJvGKB511RRozZ5de/2EzPfwgbEFRF+h83BxnCOBWxdzfFL/ho8i3JwVHAjQGsppsUW4ctX0Lps352+I+of6vpAgW+nZOekbkuGTcZyBjCLQ8KHln4fj+UkdUGVM+OovdZKWRz+nmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013769; c=relaxed/simple;
	bh=vOIODmvYnxGfLzFs6a25c4Q6CgP93l3ESJqaUth0kgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmkbUwQLazNA3Y2H3N3uAyCM1ZjE236Z0UlgDNC61yE8beTqRG8tym5qb8rLZV4dSnLI0p5zL5iZz+yLEhL6KvvoM591G8w0oPluJ9xcvaNErRTcPONDwlgeJa8l5ZO/QyIs+a2+DpWTm833NrXIC9I85TxysfFLWQvnw2gfXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IYd/W5kQ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IYd/W5kQ"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4042905015cso364536fac.0
        for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774013756; x=1774618556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk5S/NjC4u0xUL6oomLxP9g3uOp7kISttmV1Dk/7kAk=;
        b=IYd/W5kQ8Xq61cZX+4I8cxD3H6IFCCXWOfIsvrbg7FX1JsUB1alYnygqJQ/aO2o6Be
         R86jx6VyCXaueBpDk4ufRuh2P+CuJw/sSjwsrghwLrnGpk7o/lDY0nQVnS7yoFARzze8
         7pkxXb/WkWv9pePx/oNQf+Ghx6J/EFc/Af38UJ3ncUUixocQujT4+rGJCGyAyrcgPqkw
         GUv9P5gDlvGbDyexlOq2u9gdg14aN7/Pu3xK/7zgGwcuTsA2cwd7dQ7TVi0UPy0Ap2tk
         1v4wH7Ktw3saoN+d+iYtHDUDhvQwVPNQV3v+rYKhyZ4y3MITI8jjpFCj/gNU4Mp5qP5/
         zOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774013756; x=1774618556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk5S/NjC4u0xUL6oomLxP9g3uOp7kISttmV1Dk/7kAk=;
        b=gdLdBUZkpRtesomw/VH93mpYzD/GmYbkpqVJRG3Rqo8fr48oKbVWmaSaT2rdilEYLo
         PWJsG41hfObXQmtaSlCeL4c2pjf92rZBPGBisFaMAjiTodgZXObsv3ay0/pqrnsMYzGW
         CqYvKfBrP5BByXcs+CoKvpaiRmov1asvJaMLe8+uTMKdOg6PndKO8th9h+p5OAVo+UNu
         Sdna0JJHAch8DAmtDX9fxr5FRIONv5ogqUd2pc7hwSfKixkzsZjDnKOw9VOH6wsrrXcW
         LF80tt5V4jnB71kqpqYex/sFTgW1U7zH6ByoFDpo7qc87RcvwLOEcnYyUSgzkmH6tdiN
         FA0w==
X-Forwarded-Encrypted: i=1; AJvYcCWayC0f0ksTvZTztUR1lvcHrH92RTUDnPsmC9A7flz0Kv3pLGRuraYD6IgC2mIXtISZXhx99PWBpA/4RwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHphfYPRHnP/IgdGcgHeYuGqkLy6I8Mt3GUyZS90pXKyy0YUCi
	YD4qPW/8iJx1nWdtP53Zpf2z9Qzg2cAJa35/6+wxQZQjOdasTxGvpqs+4CFLP05CyTg=
X-Gm-Gg: ATEYQzx3j224EgKIL/AXDcs8I1Z6Oyl1sTekhGAk9KhSkP8Cvv+I+36UqX785fmZWt8
	dxIbcDC1e9mIJ4aAH6M6MO51gli0/ibAB+5Ud9Z6lWeJs9VBIzKPOWQagQiV+NqbgzVCsSbQFF8
	nsl0EI00J5WeI1H7pbQywJL643DH7Ui4BErx+tG4l6MZiXn5oUj6i37XpKGpcJcoVkSPLc9C3My
	hFIBTri3DTBkaiXTB+jXwPx85H1h3mtOT3u5bwN6gUzDqYdoI2gUhWmV0LKiXUoGuG/9r7v53KL
	2WrhDKrEN8/9ntWtX6+w4fWB7bopQ99Mg4HOVxogODu3TF4qDrOD1/kjM4rqyeN8Qjc5loC4aL8
	zSnNHlPpXJIt4pDPWYOTnU1sNc3XI/zdn3gP7VdTTutVOddKMwdyZAAGy0QxQtdZmG0BoUHNUCt
	jXE7r34jiMw7de72Y9N299u9OlQQ1ZtEpt7omDYH853MFNfiqEa/Lbx/KFAX+i4ajkFW1/Gvs=
X-Received: by 2002:a05:6870:e9aa:b0:417:23f2:6d77 with SMTP id 586e51a60fabf-41c10fd1b74mr1962084fac.16.1774013755741;
        Fri, 20 Mar 2026 06:35:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6a3c:6fc:3be2:208d? ([2600:8803:e7e4:500:6a3c:6fc:3be2:208d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c1497485esm2142629fac.8.2026.03.20.06.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 06:35:55 -0700 (PDT)
Message-ID: <9124e760-6e9e-4621-b684-071dbb271635@baylibre.com>
Date: Fri, 20 Mar 2026 08:35:54 -0500
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
 <c2618423-2466-47bb-a8cf-7c849e7e231e@baylibre.com>
 <7d1e52c0b9c3a6d30e9db617b9bcfa23ed9046b5.camel@collabora.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7d1e52c0b9c3a6d30e9db617b9bcfa23ed9046b5.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 7:37 AM, Louis-Alexis Eyraud wrote:
> Hi David,
> 
> On Thu, 2026-03-12 at 19:26 -0500, David Lechner wrote:
>> On 12/3/25 7:59 AM, Louis-Alexis Eyraud wrote:
>>> Add support for MediaTek MT8189 SoC and its variants, and a device-
>>> tree
>>> for the basic hardware enablement of the Genio 720-EVK board, based
>>> on
>>> MT8391 SoC.
>>>
>>
>> ...
>>
>>> +	mmc0_default_pins: mmc0-default-pins {
>>> +		pins-clk {
>>> +			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
>>> +			drive-strength = <6>;
>>> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>> +		};
>>> +
>>> +		pins-cmd-dat {
>>> +			pinmux =
>>> <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
>>> +				
>>> <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
>>> +				
>>> <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
>>> +				
>>> <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
>>> +				
>>> <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
>>> +				
>>> <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
>>> +				
>>> <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
>>> +				
>>> <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
>>> +				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
>>> +			input-enable;
>>> +			drive-strength = <6>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>> +		};
>>
>> Should we also have pins-ds here to match mmc0-uhs-pins?
>>
> The data strobe pin is only used for the HS modes, that is why it is
> only declared for uhs state.
> No other mediatek board devicetrees have it for default state too, so I
> don't think it is needed here.
> 
>>> +
>>> +		pins-rst {
>>> +			pinmux =
>>> <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
>>> +			drive-strength = <6>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
>>> +		};
>>> +	};
>>> +
>>> +	mmc0_uhs_pins: mmc0-uhs-pins {
>>> +		pins-clk {
>>> +			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
>>> +			drive-strength = <8>;
>>> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>> +		};
>>> +
>>> +		pins-cmd-dat {
>>> +			pinmux =
>>> <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
>>> +				
>>> <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
>>> +				
>>> <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
>>> +				
>>> <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
>>> +				
>>> <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
>>> +				
>>> <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
>>> +				
>>> <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
>>> +				
>>> <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
>>> +				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
>>> +			input-enable;
>>> +			drive-strength = <8>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>> +		};
>>> +
>>> +		pins-ds {
>>> +			pinmux = <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
>>> +			drive-strength = <8>;
>>> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>> +		};
>>> +
>>> +		pins-rst {
>>> +			pinmux =
>>> <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
>>> +		};
>>> +	};
>>> +
>>> +	mmc1_default_pins: mmc1-default-pins {
>>> +		pins-clk {
>>> +			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
>>> +			drive-strength = <6>;
>>> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>> +		};
>>> +
>>> +		pins-cmd-dat {
>>> +			pinmux =
>>> <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
>>> +				
>>> <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
>>> +				
>>> <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
>>> +				
>>> <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
>>> +				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
>>> +			input-enable;
>>> +			drive-strength = <6>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>> +		};
>>> +
>>> +		pins-insert {
>>> +			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
>>> +			bias-pull-up;
>>> +		};
>>> +	};
>>> +
>>> +	mmc1_uhs_pins: mmc1-uhs-pins {
>>> +		pins-clk {
>>> +			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
>>> +			drive-strength = <8>;
>>> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>> +		};
>>> +
>>> +		pins-cmd-dat {
>>> +			pinmux =
>>> <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
>>> +				
>>> <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
>>> +				
>>> <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
>>> +				
>>> <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
>>> +				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
>>> +			input-enable;
>>> +			drive-strength = <8>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>> +		};
>>
>> Don't we also need pins-insert here? (to match mmc1-default-pins)
>>
> From what I've found, it was done this way for other board devicetrees
> to avoid possible reconfiguration happen for the card detection pin
> while switching to UHS and causing a switch failure.
> Also, what you declare in pinmux nodes is how the pin configuration
> should change in a specific mode and you declare only what changes, and
> not what stay the same.
> 
>> I was having trouble with the CD input pin not working in U-Boot
>> until I added it.
> I checked and debugged this on my board and did not get that kind of
> issue, whether this pin config is not present for uhs state or if I add
> it. 
> When inserting my sd card or when I boot with it already inserted, the
> mtk-sd driver first sets the pinctrl state to default before switching
> to ufs. The GPIO02 pin config is also OK in both states.
> The mt8189 pinctrl driver seems to apply a default config for this pin
> that is the same as the one that is set here.
> 
> There might be u-boot particularities that could explain it fixes your
> issue.
> 
> Regards,
> Louis-Alexis
>>
>>> +	};
>>> +

Thanks for having a look at this and taking the time to explain. I will
see what I can do to fix it in U-Boot.

