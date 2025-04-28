Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEBF13C914
	for <linux-serial@vger.kernel.org>; Mon, 28 Apr 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827987; cv=none; b=WHhhNGXTT9ik69WftXtIU4HArnpeAJ1t3gldiCmT3hRvbIkZ1V2PMQHn/C6t5/hy9ubSvuSpOqsbUL/6UZ9s8ICkDZjPG3V6epWxmJmCFVOY+eAs7IaVIzP3g18v2yVu2dk+H7p9hdxd/fkU7FAkZQ9NoHAvXz5XkJeoBD2JOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827987; c=relaxed/simple;
	bh=bVaq8ds7GrlFWe7h9Sp7Cj+/V1lazxrirLTIbwjo2I8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c5C1vr/Qlo40BaPcFQXfbMGPc1H4KfIVBYFyhFwUdhZGLP7/IexOVVnK+DvVbh6MMlzo1pjsUurmOyzs+tDor9y+cZnIHhQ4oewuYaMe6boOlwQq71iTpC7+Za9JdF7rNr9MLaGejpbRUCh22e+bhnL5QBmdg3rkOcazUNA6HF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CqGfqF2f; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqGfqF2f"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso3500396f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 28 Apr 2025 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745827983; x=1746432783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2BE4IFNraf2nwb+gMN6BrLPdvxjK4GMRcC/zeJ//7Y=;
        b=CqGfqF2fiSwH5xKoGgXv7jHxLbeeubslDlEJgIvEZ0DcPQ+AjMQGWdL58NpuENYaDC
         NfUkLb9Vi6iF6vI1jVJ/pDtPlVGY5bvf8qGmuNwecbsaylmzwz0XNNELAiCCLwLiHq/i
         HklXVGRdRCEHD2CgEB88RIvknbnzr6ODhaUzFmumxNxF7o1DNSup5SzmtHNyrMeXF0G2
         dx/Mnvz52LHRJGEAKR8m3Ko7St2nic3G0LoERy8Q1+LLmAWUMGz+bAkUZKs2wkVa2HeP
         NByOIfLw7xDbPxD1y2zeefs9tHet0MPKysk9gexzWk2O+dvkXucDjSYIGXE99DU54iaI
         KVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745827983; x=1746432783;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A2BE4IFNraf2nwb+gMN6BrLPdvxjK4GMRcC/zeJ//7Y=;
        b=atDVNHRUGtntZTWTglI3vxxr6VaHYS+6C5QZUP8nwc4y+5BpWoIyGoMMrEMWomgE5l
         YkxiEPH1NJn9QQWxn5GHDABU0jhGVWnvORKH8WLfje2bO6Jkw/chVKd0SxwMtLpFFOsa
         KeexFu5VBvuI57jcgNWmjmPWgeE/SXABXx26Sxsv/tPexZMfpUP9miHcvox0VOijAyBB
         wAOOz0Dcye2b7sQLOFu6AUtWCeodRBEspifrjhmPvWQ1Z4mRlqV9dJiC2vEgziO8tToB
         zTH7wC9E5hrVyX5B1yvjBou0YD7MDPX5mcrqe4JWSHQHFSNe28BE+emp7C0gabRBxy03
         R3OA==
X-Forwarded-Encrypted: i=1; AJvYcCVDRyLoG35G2SaPhY7jXH97diWBvqnqIL4KjNE8743kq0zN73MNpB+CnQPz9E0T3G/G+H1/vxlgWWcUjvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkkeaZpYdC34r533QnGdZ1VPNtnA3VUSurLlVJYnXTtMW2A2x
	wA/wHKGE8+nLAuv7w1cBXKHEdE7gTLLk4dKuOsscpYjJH60Kw6AbynqRqdnh+D0=
X-Gm-Gg: ASbGncuo29Dh8PeJSNN+wWD5vpxX9xa39Ixw76m95kgt244LN1VCxH9DDi/Ty71BII8
	TOZ9Br/G52Yri+HpUVvA1J33yry/zrcatap+wh0PZz4nDFerSLC8ojUtelM+/sKY4qW/U18JASG
	2u2IckI3MNTMHGL5LgYWKqmutfYtQPevZMQn2H21HIiGDBjRHAMFREyF4DsX+QWM+cixmzkHYma
	HSukdlY03Q7aSaNfIDRPZuvRGPwLgFSVJNA8T4NFv3Gqd8nSmBDu/HL4m3oUiNyNkq+2Xzjctk6
	0fcsY7nOwINEeB15ortdEy+/vaRKd0UUMSQNGIVFkKV/40EEyhEdkMGuwTxvw4Q2J6tuFeA2S38
	oFD8YH328JNwpsfTXPg==
X-Google-Smtp-Source: AGHT+IFirYO+R6cxa4E/PxDKxv2Eoalg7DNOh3n5z36BXYljdt+Ef5dXthwTwXbfPkkn6KEjfC0prQ==
X-Received: by 2002:a05:6000:1ac5:b0:390:f0ff:2c11 with SMTP id ffacd0b85a97d-3a074e146c6mr6922171f8f.2.1745827983497;
        Mon, 28 Apr 2025 01:13:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:e2bb:d0cc:c4c9:4442? ([2a01:e0a:3d9:2080:e2bb:d0cc:c4c9:4442])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d264sm10609868f8f.95.2025.04.28.01.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 01:13:03 -0700 (PDT)
Message-ID: <449cc46e-fab8-401a-b887-51d621695a1c@linaro.org>
Date: Mon, 28 Apr 2025 10:13:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/7] Baisc devicetree support for Amlogic S6 S7 and S7D
To: Xianwei Zhao <xianwei.zhao@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
 <a175ed1d-9e57-4150-af8f-7ca785203108@amlogic.com>
 <e3229c42-b322-447a-ad1e-86c6f20dd54e@linaro.org>
 <be8b7874-1251-4ba8-9243-a615517861ab@amlogic.com>
 <eb1c3442-6b86-42e9-a672-eaba7de8b375@linaro.org>
 <32473413-b2fb-471b-b2d5-b4fd7914b57f@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <32473413-b2fb-471b-b2d5-b4fd7914b57f@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/04/2025 09:57, Xianwei Zhao wrote:
> Hi Neil,
>     Thanks for your reply.
> 
> On 2025/4/23 15:23, neil.armstrong@linaro.org wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi,
>>
>> On 23/04/2025 08:15, Xianwei Zhao wrote:
>>> Hi Neil,
>>>     Thanks for your reply.
>>>
>>> On 2025/4/22 21:49, Neil Armstrong wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> Hi,
>>>>
>>>> On 22/04/2025 13:45, Xianwei Zhao wrote:
>>>>> Hi Neil,
>>>>>     A gentle ping, thanks.
>>>>
>>>> I'll apply them this week except patch 4,
>>>>
>>>> so can you send patch 4 separately since it goes via the tty tree ?
>>>>
>>>
>>> I will send patch 4 separately.
>>> The following patches(5 6 7) can be not included for now. Without the patch 4, the command "make ARCH=arm64 dtbs_check W=1" will fail to execute.
>>
>> I know, but since it's reviewed, Greg KH will pick it for the next release so it's fine.
>>
> 
> I have already sent patch 4 separately. From Rob's reply, do you think it can be picked up together?
> 
> https://lore.kernel.org/all/CAL_JsqKD=yespd0WM90VBr_XWdppimzDzecmwNfGMV+hNSHuRA@mail.gmail.com/


Greg KH picked it already.

Neil

> 
>> Neil
>>
>>>
>>>> Thanks,
>>>> Neil
>>>>
>>>>>
>>>>> On 2025/3/17 15:16, Xianwei Zhao via B4 Relay wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>> Amlogic S6 S7 and S7D are application processors designed for
>>>>>> hybrid OTT/IP Set Top Box and high-end media box applications.
>>>>>>
>>>>>> Add the new S6 SoC/board device tree bindings.
>>>>>> Add the new S7 SoC/board device tree bindings.
>>>>>> Add the new S7D SoC/board device tree bindings.
>>>>>>
>>>>>> Add basic support for the S6 based Amlogic BL209 board, which describes
>>>>>> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
>>>>>> booting up into the serial console.
>>>>>>
>>>>>> Add basic support for the S7 based Amlogic BP201 board, which describes
>>>>>> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
>>>>>> booting up into the serial console.
>>>>>>
>>>>>> Add basic support for the S7D based Amlogic BM202 board, which describes
>>>>>> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
>>>>>> booting up into the serial console.
>>>>>>
>>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>> ---
>>>>>> Xianwei Zhao (7):
>>>>>>        dt-bindings: arm: amlogic: add S6 support
>>>>>>        dt-bindings: arm: amlogic: add S7 support
>>>>>>        dt-bindings: arm: amlogic: add S7D support
>>>>>>        dt-bindings: serial: amlogic,meson-uart: Add compatible string for S6/S7/S7D
>>>>>>        arm64: dts: add support for S6 based Amlogic BL209
>>>>>>        arm64: dts: add support for S7 based Amlogic BP201
>>>>>>        arm64: dts: add support for S7D based Amlogic BM202
>>>>>>
>>>>>>   Documentation/devicetree/bindings/arm/amlogic.yaml | 18 ++++
>>>>>>   .../bindings/serial/amlogic,meson-uart.yaml        |  3 +
>>>>>>   arch/arm64/boot/dts/amlogic/Makefile               |  3 +
>>>>>>   .../boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts   | 42 +++++++++
>>>>>>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 97 +++++++++++++++++++++
>>>>>>   .../boot/dts/amlogic/amlogic-s7-s805x3-bp201.dts   | 41 +++++++++
>>>>>>   arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 99 ++++++++++++++++++++++
>>>>>>   .../boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts | 41 +++++++++
>>>>>>   arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 99 ++++++++++++++++++++++
>>>>>>   9 files changed, 443 insertions(+)
>>>>>> ---
>>>>>> base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
>>>>>> change-id: 20250221-s6-s7-basic-f300c30877e6
>>>>>>
>>>>>> Best regards,
>>>>>> -- 
>>>>>> Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>>
>>>>>>
>>>>
>>

