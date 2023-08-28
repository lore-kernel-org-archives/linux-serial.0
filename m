Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B17C83F11
	for <linux-serial@archiver.kernel.org>; Mon, 28 Aug 2023 12:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjH1Maw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Aug 2023 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjH1Mad (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Aug 2023 08:30:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59579CC3
        for <linux-serial@vger.kernel.org>; Mon, 28 Aug 2023 05:30:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so29363335e9.2
        for <linux-serial@vger.kernel.org>; Mon, 28 Aug 2023 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693225821; x=1693830621;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kikC2GMZA3lKqRBwEa37aJsf6/FOFnk58xosIM1uppU=;
        b=LOVmckN79tJf+dsYfdpFMqlyjgUFlbVTthUqp4Jlr4IWMUTLUOiHGu5CKu2yCs8G/7
         9cm+58/7BUHNVnOlBboAuhwboP7D2nabsp+ZWsk2kCnm7tLBkSmA272roTrRDeOHgKK3
         kut96HeZbJ+2e1kJsAv4+UJv9qUHBoOdZGCOAVvbl1tUDfvYvT0bJtqrOdEfMP0kU9od
         AOdeMNwvo96VAIjFz+HpSxLfsakfRwc14H5xiMFu/2PJ5bZNhtiyTVmg23//C8kS5GhG
         hErbs3Q4Zbm99CkTt1CXznhuWmdqjBdKfPfd2NmglW2C0hJXqw4HjdwUEJQ/RimdEopk
         3Qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225821; x=1693830621;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kikC2GMZA3lKqRBwEa37aJsf6/FOFnk58xosIM1uppU=;
        b=LUAUWK4GRptrrSu/9q76X8lYZ2ds960iqd5kRPsUSi3o8v7YlIucGWHjfAKfsoOmdK
         kQyN8anQrXzaeWDKWexXMZOJcUfRGVKQC0SuvI3JotWS3Bx5J4YZYVRs0tS/qiYYs8op
         pGFauF+XiGJAMGeQm4mpldZg066ZNwHUwxsA9G8+TSiSHLG+ykjxwb2aqUMsKh2KggxK
         cVKa2E6fHBwh0NfY3NQoURjTsbsQyOGhyM00Q14RPAb5ew1RI+6VPbBHWSw8OOnKTpyQ
         2/WIyySGnYEvg4T1KTvPjN3GsBax0Vk/Ltau9KmRNTtAqVqiNTtuFQlOe2qAxaTazodE
         b1bQ==
X-Gm-Message-State: AOJu0Yx+17ao5bt5VONJ+ugWcgkMjxXaXsxDgcnupz+AMYC5f20Ps72W
        0PNZniEqX9TYUmdghHukyD4ivg==
X-Google-Smtp-Source: AGHT+IHHFmAz5oQdVaLNKoDebNOA4cP6Xfs7jD1J8pUPSk3dEDjD/HL1YdFzkfPYDfeMPrIptx4XPA==
X-Received: by 2002:a5d:4a12:0:b0:317:49a2:1f89 with SMTP id m18-20020a5d4a12000000b0031749a21f89mr18915512wrq.1.1693225820676;
        Mon, 28 Aug 2023 05:30:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e59:c27b:747a:3f52? ([2a01:e0a:982:cbb0:5e59:c27b:747a:3f52])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d518c000000b003143cb109d5sm10486910wrv.14.2023.08.28.05.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 05:30:20 -0700 (PDT)
Message-ID: <413d4c70-fcd4-479d-967b-59130c1a68eb@linaro.org>
Date:   Mon, 28 Aug 2023 14:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] tty: serial: meson: Add a earlycon for the S4 SoC
Content-Language: en-US, fr
To:     tanure@linux.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230828121053.60838-1-tanure@linux.com>
 <7720b990-c9cf-4c3d-8bb2-928b3b17f089@linaro.org>
 <CAJX_Q+0AWcY7SySsdtVn=7xE8H0YtLBfN2XrKSOZMGB-60NRhg@mail.gmail.com>
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
In-Reply-To: <CAJX_Q+0AWcY7SySsdtVn=7xE8H0YtLBfN2XrKSOZMGB-60NRhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 28/08/2023 14:26, Lucas Tanure wrote:
> On Mon, Aug 28, 2023 at 1:16 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 28/08/2023 14:10, Lucas Tanure wrote:
>>> The new Amlogic S4 SoC does not have a always-on uart, so add
>>> OF_EARLYCON_DECLARE for it.
>>>
>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>> ---
>>>    drivers/tty/serial/meson_uart.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>> index 790d910dafa5..8dfaa260e545 100644
>>> --- a/drivers/tty/serial/meson_uart.c
>>> +++ b/drivers/tty/serial/meson_uart.c
>>> @@ -646,8 +646,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>>>        return 0;
>>>    }
>>>
>>> -OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>>> -                 meson_serial_early_console_setup);
>>> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart", meson_serial_early_console_setup);
>>> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-s4-uart", meson_serial_early_console_setup);
>>
>> Not sure why you would change both lines, and where's the t7 entry ?
> ok, but we don't need t7, right? T7 will use S4 compatible line.

Indeed, I forget you finally used amlogic,meson-s4-uart as fallback.

Please indicate this in the commit message.

I'll ack the revert then,

Thanks,
Neil

>>
>> Neil
>>
>>>
>>>    #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>>>    #else
>>

