Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781943;
	b=Ed2DegjuWE3bfhgRE1s79TFA4AuSoWBlzOhlP6KoZ7CKPSvJ5pLxvulUNsMqlqAKnbDE
	 sFXSrb2p/obx0bjctZw7Whd3X+VNVPxasuKluylIazpWwL1qoIaoFTJ4EbK9XXT/msghu
	 kn5HL9clZ+37VdsdXfPjJuYMb+WwbgIUFLJLYuPn0Xn4LQeZZk6Jm3tehIB89PEXnWM1t
	 TjyAGip0zWx68l8Jgm54TF/zUYL5BNdtwhRh+ruviYlG5VIBpJf/JCZ2fYIliIKw6Nae0
	 LUzxt09YZt863k21uh6WbZdhRUVn8fKJsQqXMN07HM4ZmUFrfwkw2SPvp4KwgQh/6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PY/ho+NWplWZr5hzq7a2dKL6DiDdkQ/o2tiv08eUeXw=;
	b=Y4g+gjAb/lcAicFiG+GdnFgSmrwgZEDtk6Hrp18MLZVlg3y0taDHHYEzFUNMjhp2rOhn
	 ylgsEi6So5CQ8/JkFfSlN2R0ZBJWLProrWqStV6b5SrZD9iz0t+t8bbAZqNH8xZZXuTjB
	 mWmhKeAWymr5mtT1U+F7Nl1gOcts2i3sFcMKe/vXihsqCXOTpEh8lrovhIbNr2HaiBXDp
	 EV5Il2SdsFvfW4mVaLGo90e7JB0uRSfV/PT+lhfcZuckByQPlI4HW1JJkEz3NL4H2u2i5
	 0XWiG2q6LUY4Tk1iiieWRorYVRknpx82qVxwlE/39ZJuqs2jBsZ1F/9v0k9Gik+lClg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=st7DRj8H;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF2606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 08:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32CF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=st7DRj8H
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so3762105e9.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793781941; x=1794386741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PY/ho+NWplWZr5hzq7a2dKL6DiDdkQ/o2tiv08eUeXw=;
        b=st7DRj8HHdbazUd+w9GvTOBoyvYd18iehIvNzfpxmPJSWN6twDLVtQHTI0/F9D91s7
         OahsINt7ssVJmbDBTp3phe1N6inkgjM9VI6B366YcfSSTQ8hVtpdyfrC4nZo6riJ3FRl
         BaK0MfRQ2QvH85cRpyVZrN4aDMW2jbu1zjb8E2k9TTU3WS19q6p7hnllJKD/16FeeUz0
         Xh8U61syd9cucicBormvGoj1JPBuRGksK5HwqX9xK0koIll1NKiqDi2kXObRs2RC5Kae
         OySYOvE544VfLtlH/V4I3HE2UgxUePaFsej1Sddn2AVqJBuOmmC/f80SlxebXfjp3++o
         OAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781941; x=1794386741;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PY/ho+NWplWZr5hzq7a2dKL6DiDdkQ/o2tiv08eUeXw=;
        b=av24fr1smrMdugy9x58faEtZesKtNmdZBBwMTM5SJrg/g53xU5CXemK5S8aQ9pmcxD
         7hAf4AS7EiheilQbBHczggZ5R+X4D5F+Mfbqqnl+Jw+/8Y3GBKbXaBI/xRNxTf3HrS2A
         xtDQCe2aMLczETrToOLx2fpKZhiUSkZSIh//QtEzeO7KYeKlQjvrR1SiNi/fK3NFL4Fh
         hgXgnm8hRpaMZhRZLgCa98Y1cMvv8G5xgO8lRg+lfDzw1SLm+vt63WiojXO52/gzApzg
         fF7pSyXTY3msrNxFcyFmxEoWWD2iO+GXq+8IR4tcwPoFIdyYa9wKxW4d52swPeofZu1K
         G+6A==
X-Gm-Message-State: APuU4Z/QkiZcTC15aSb1EC/GhwDDLgmzjzduqxlWRAvGkufqo7pr9T2d
	iJTcNd2E78A9JO4NL9GqjvBINtWzatklsojraFyX+RCsoFc4U2JN5vsWZNm0vaO+fb8=
X-Gm-Gg: AYBFou0s1glMcfxFq9D+sfYgIrkt/gW3T+Wj4Uz7jZLBTxarcI+ErSiF/UFEUL0hq7+
	0dkS8mvMXjPmnVNgvLYtlEQVoUUgn6OwpCmMiyOsLPUia8W5RuELJAJFAn67eXDOFrcw2W4ohRE
	6uLnR03pAQd+4Gl0XLLWlmnTkeJkUGxu12Bft0bi6u1mUDC4Qybb0dyd6zYMnxrklLqE3THOGk+
	mOlDCoMC6uMzjSapFjaoYCxNAvMZ0c6kPoFoCi3iRPmCwCYdXebS7MHWyepiIGgoL+KhQBV4stB
	iBqtjNTj2p15g5xRjOfIlAIU16NIIvX/6h+LYFZAvQTtSk/dBT65x6Ubimq3OlnJvQLnB42vpYf
	lhIFpfwFkE601fdKra2eBZV3UfuSnDLybfWpm3SdSC0AGdIs+hJGF7djFeHgQDBVMikxRwNabau
	kM54OV3zAFCOh9U7Vl1h7WABNgPN91c0qa7H73qqsnk81I7ofEw2OI5O+lwS51WfeAkYjlqH6xo
	04v3NGqVAVfIn8KoIOMfyMwMWL6SCMjvAEVFsmh9mGodHsZm9sshkLsxzBA95rwV1wc08KRBYcj
	Yfvnwjdr1ap5Pzce5Tx6v+Hb/JoYJe/PTXMofy5v+/yv9LxlRK5bmZ581PQT6AOnUjFpJoxLUIu
	92bJmGP1P
X-Received: by 2002:a05:600c:1f93:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4ac17ffa050mr366958235e9.22.1793781941394;
        Wed, 04 Nov 2026 00:45:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70? ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43d7b0727sm34521615e9.14.2026.11.04.00.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:45:40 -0800 (PST)
Message-ID: <1022a8b5-3f2e-4499-a432-f3be713110e0@linaro.org>
Date: Wed, 4 Nov 2026 09:45:40 +0100
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
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] serial: meson: unregister the UART driver if port
 registration fails
To: Wentao Liang <vulab@iscas.ac.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20261104021501.1468500-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104021501.1468500-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 03:15, Wentao Liang wrote:
> meson_uart_probe() registers the shared uart_driver on the first port and
> relies on meson_uart_remove() to unregister it once the last port is
> removed.  If uart_add_one_port() fails, probe returns an error, so remove
> is never called and the driver stays registered, leaking its tty driver
> and per-port state.
> 
> Remember whether this probe registered the driver and unregister it again
> when adding the port fails.
> 
> Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/tty/serial/meson_uart.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index a6cb2a535f9d..a51362f73dee 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -702,6 +702,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	int ret = 0;
>   	int irq;
>   	bool has_rtscts;
> +	bool registered = false;
>   
>   	if (pdev->dev.of_node)
>   		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> @@ -753,6 +754,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   		if (ret)
>   			return dev_err_probe(&pdev->dev, ret,
>   					     "can't register uart driver\n");
> +		registered = true;
>   	}
>   
>   	port->iotype = UPIO_MEM;
> @@ -781,8 +783,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	}
>   
>   	ret = uart_add_one_port(uart_driver, port);
> -	if (ret)
> +	if (ret) {
>   		meson_ports[pdev->id] = NULL;
> +		if (registered)
> +			uart_unregister_driver(uart_driver);
> +	}
>   
>   	return ret;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
