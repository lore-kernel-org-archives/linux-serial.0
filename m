Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAEC83F15
	for <linux-serial@archiver.kernel.org>; Mon, 28 Aug 2023 12:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjH1Mb5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Aug 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjH1Mbd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Aug 2023 08:31:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF13132
        for <linux-serial@vger.kernel.org>; Mon, 28 Aug 2023 05:31:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-313e742a787so1947810f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 28 Aug 2023 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693225867; x=1693830667;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfaTj97MUYR8oG5M2y22bu1/J5TfgewQ8yMLK5neTHw=;
        b=ygfvbuvxOt9vhAlpXHsuyMAuOQZZpajrG+eY3DEputQO1QKfx6E5Tu6lxth/W6800R
         aGpe8mdKSNBUFbtqxC2IuIEuA9McDu4V3hyHmKUNzztfS4/VSzW+n8TEk6ceaE6FA0A3
         BDvfX8D+aUlmsRz340G4j9q6dUdCql8/53erPw76Sjr1Bfb+9fSuLI97a3lxwCVnGyit
         beqjlSty4y43m83CS2wecHz0cNC0nAyZGhSN5RxzEa078DphjwQYYFjIwaioIonhWOxZ
         dON38LLywtUG4Zw+a78RPhtIoxGwIoJRsqjTKaPo4phCsrgE0KzqUvqT5M1hdGyOeX+f
         /Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225867; x=1693830667;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfaTj97MUYR8oG5M2y22bu1/J5TfgewQ8yMLK5neTHw=;
        b=TgL2Q18rlOb0Hz287hnONTPTLu16ra4XTPVukPIq1R1+m0P5TV7R+5TCGt+egFSv83
         2Ck2wV71Uk1ACENBdayGBPNQwJj5CBFhwE9drl+aEPsMpzMLr1X9g4KyAaUn2Y/CSt24
         BtSj/r+sMUQsku6WaiBgBWkAnpw3Wy5osfz4iXcG2r5evNqs5yy6NKzkPW8/3MfDK6ke
         aHJeSFJsa6b0h/NOEtadM4O76reI/yIRgIAbocULfqG+hovMMk5Nn7/iOBUvFEwiW8xd
         39/TFkGj2oKyQG+aDhw+/A9dm98Fo+AkehpvBptX4Ic2SLTrDbsY0NXrM6dvPlGg7SbG
         AyLg==
X-Gm-Message-State: AOJu0YwtOI1cx7eVhLKDfRnrBv9xbuCec/VKlcjWpo8XW5LIgLmg8Zqf
        3HaD7dA2FKnYQ2JY5eLORLNdqg==
X-Google-Smtp-Source: AGHT+IHaegYoymwDZu6Vmtxc4Udd/lxAuy01xNIbVrljfxYLKBO+F6fZXcUPA1VTBVHMLeUFPen0TQ==
X-Received: by 2002:a05:6000:147:b0:317:59a6:6f68 with SMTP id r7-20020a056000014700b0031759a66f68mr22064032wrx.0.1693225867417;
        Mon, 28 Aug 2023 05:31:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e59:c27b:747a:3f52? ([2a01:e0a:982:cbb0:5e59:c27b:747a:3f52])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d518c000000b003143cb109d5sm10486910wrv.14.2023.08.28.05.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 05:31:06 -0700 (PDT)
Message-ID: <944f1370-c092-484e-a13d-b7f8211c4835@linaro.org>
Date:   Mon, 28 Aug 2023 14:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Content-Language: en-US, fr
To:     Lucas Tanure <tanure@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230827082944.5100-1-tanure@linux.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20230827082944.5100-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On 27/08/2023 10:29, Lucas Tanure wrote:
> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
> Since V1:
> - add Signed-off-by:
> 
>   drivers/tty/serial/meson_uart.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index c4f61d82fb727..790d910dafa5d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   
>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>   		    meson_serial_early_console_setup);
> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> -		    meson_serial_early_console_setup);
>   
>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>   #else

After some clarifications, it's ok to merge the revert:

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
