Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F8E95A8E
	for <linux-serial@archiver.kernel.org>; Mon,  9 Oct 2023 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376567AbjJIM5O (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Oct 2023 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376530AbjJIM5O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Oct 2023 08:57:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654518E
        for <linux-serial@vger.kernel.org>; Mon,  9 Oct 2023 05:57:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso42272705e9.2
        for <linux-serial@vger.kernel.org>; Mon, 09 Oct 2023 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696856231; x=1697461031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZXoHEUdlaSpzaGNvl0KYK8jIguk5p4r9xc4kKWkyNI=;
        b=cQ8n5i8gBa6K5tN65CTo0SfyYm3lqrHYuM7Hjhg0fboo73ZIf1Vw5bs97nrGOcQ7R9
         NoxKEl+qPh+d6w+REN0VGQhYHWfMqwP/kVP/bocTd2hUsEsIRZ7TW23ZB6w1kG+zwE48
         hNAaMMYzNhqEQowpEIUuXXU1XbZDYfzh57B9kI5jUkbKbqWskkzp1SYICz5pU7G6B81e
         TgkKFhx3IqfJcIsbHg4hewVu8OaGps7maOVqowKiRIYQ7564GgokGVWaj498Z2OeAYXk
         voGrz9GBedmE/cJ2qQHtXCd0NvqY5KNTlZ959c288nh2hqIm/lb87VTepx3djB3I7RDx
         WGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856231; x=1697461031;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZXoHEUdlaSpzaGNvl0KYK8jIguk5p4r9xc4kKWkyNI=;
        b=xTN6SK9UY8hsMLzuXFFg2LvD+wdGP5LH3wRCV4/5cGG6k/3NM68tf4I0hUWVYtXoqE
         wgTIXVumkBq44N6z1OCajnj+y/esNZNVO3Virsev5dauDAKGnIbsQl2bQyHJAeEdTTkH
         P+A9d5OnjJkmSHb6DiXtE2IKOBpVXCo2IP7bKXHsPocIvO/7v7wzvn67jj4cwogPh7/5
         sVBqwF9bpOrwWRtIi4qejO/Y15EjZHMgA1oFgyD9bdsE6DAujhnFiPr7jynFEp87gpRT
         j/DdHqYR/YwxAxbX2KJU7GX1oVKsQPPGN01w8vXhfE0QBg9QQTi1lHbXDdZtyOvo9rVn
         XMhQ==
X-Gm-Message-State: AOJu0YxLhLV6Q7a41o7ByJRKfWbmkDZoU8CJrZtDO3lHjdKuqXqYxyBe
        /0NTbx96ztP471tDdux32oJNHEpJLJLx+bjV69K0CBpn
X-Google-Smtp-Source: AGHT+IFCcZ9U4VKbmvYJqVAUH/X0Z49KpYeQVkB7vsetwEcUfdpmXdEvFY1+nTDw39WcIZKChcMilw==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id x1-20020adff641000000b0031fb6eaaf48mr13186215wrp.49.1696856230815;
        Mon, 09 Oct 2023 05:57:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4406:fc3c:1c62:7b3e? ([2a01:e0a:982:cbb0:4406:fc3c:1c62:7b3e])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000180800b00321773bb933sm9575321wrh.77.2023.10.09.05.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 05:57:10 -0700 (PDT)
Message-ID: <d25ce389-b18b-4c45-9c61-5a909b514699@linaro.org>
Date:   Mon, 9 Oct 2023 14:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] tty: serial: meson: Add a earlycon for the S4 SoC
Content-Language: en-US, fr
To:     Lucas Tanure <tanure@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20231009121151.4509-1-tanure@linux.com>
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
In-Reply-To: <20231009121151.4509-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 09/10/2023 14:11, Lucas Tanure wrote:
> The new Amlogic S4 SoC does not have a always-on uart, so add
> OF_EARLYCON_DECLARE for it.
> Amlogic T7 will use this as fallback.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   drivers/tty/serial/meson_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 45cc23e9e399..de298bf75d9b 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -646,8 +646,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   	return 0;
>   }
>   
> -OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> -		    meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart", meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-s4-uart", meson_serial_early_console_setup);
>   
>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>   #else

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
