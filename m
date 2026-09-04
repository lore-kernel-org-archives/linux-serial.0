Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF948820C
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524473; cv=none; b=nuZSydLBW2+Ch7fJlrY3XXFwqdMFfTVXN+OnCirtNaZiKYfhysMbs5Ror2T1XNQwHYG7nx/zHwd85SNoaQV49jpR5LVjVFUy7CzlBB3NYyIQiLGOCXPGXK+gVLXyPXMAesOGZ0EZWiQ9vg1MS66k/CG8ACDQ5PtuNNxblamXtAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524473; c=relaxed/simple;
	bh=APPkNKtEDmrFso4y3E1cHTFO7HZn9y4fTKl0GLQvGOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E0+QD6srPEYavZu1h6/wLbeGzTCbfxaDng5sH0vfoYYA+0eVdTEgknjhH7Co5QBcgNrQFqtH7eZU+chXKD2TLrMj19IfqwmzHtVMoBceP7f10ARzh358FK2ZEBzf0sTmgBOSasklufmCDEzTTeDtXTWyTnl6X2OtD0dtEOxb9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mucWSogE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mucWSogE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso14925305e9.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788524469; x=1789129269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfq2sAT5mAfGVAt5p5kcQFP6u3ifv9uCqnC5mm+uv+Q=;
        b=mucWSogE5+2knv0fI8LclQ4UpzC7iNFh8m1ka8d8fhmnqPfj4GuYFyOAP+rupXMRCB
         tXP94LoqcafrZ4rfMhOb+NsPHchtfQtvfLYl+XfLeqdnXMD0cqsHy1ha0Mzx2keSTSRf
         NU3Kv36cc1lCaQXZ83OWyg9S0AXZkinCuDmL0lvUd30NfBTJLasubqwylSJEEp13geAK
         sZp+u/gvyebsHc52umGb9ST3VXV7NQ+RLyDa9ipbxJ5wYTBSgJE1yJYI7lVWvAm1j9md
         3X4y6At8wOnuKUUt0LmREQsL8bpR8YQPpVKFtUIlEqtqbIWK7b5Gw4DXf67/zdPpBI0O
         1wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524469; x=1789129269;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pfq2sAT5mAfGVAt5p5kcQFP6u3ifv9uCqnC5mm+uv+Q=;
        b=B6xolx4WnPiifSvrGL1igNBlHDZK07im8fFmJu2cDzAURqsS4X7PrV/WBjfXYK25p8
         NNKl2ffL8thEUmuoqrP8joNYScFNxuIjrq/9bGoRpI3xlZtmEYtACzAblvGrCDF2PJ/c
         xiiDSiA8r1kznLLF7E0PKzMNO3Msg/WftG5YQuqtf/G6FiJ76Vp2u71009XsEEfTwfvi
         36p5qp4Yz8w+8tuUypqEIvfxxgOzuyeyUacneYlwtqtynPLi0/7KrE/A32o51/qjmFDF
         0DwSwfpy23qJqvNv2SNjnPXXMDYQWDqSnww2iQ0GbL/9BMWac+Si+krwQl2Y9h0Nabbb
         SQ5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzP9MgkkrMtrrWtOBl67pdUrwvd4TWpAtINWlRjCoD+Aiu38TaA8NEWra/tfdSe5+VgSL+t3i0xKrbo6uc=@vger.kernel.org
X-Gm-Message-State: AFuF++lGo3+oXqzyJqq0H1i++Lkv3aRB2shNDVVOwX33q4v2rQ9Qwq0K
	eYSqA5IiObPp7vPDP1vubBtBJNxHsjgJ32fRnzlHQn2jEd7nG4GGaHA2RnLtl288Rcc=
X-Gm-Gg: AYBFou1nGxO98Wz6ceDB5HUqCpHQOfxL+bq1nPEezzrFa+rH9u10bkOvRbeao92GHKL
	gvytfnbm5x/zU0zXVdq6p5PEguScMsVofXn7sHoI6kzLm2ypP08c+YsjNSaJbpxddDyadl3uRWV
	CU9ThnIg5sxvfSQv+MAlLcInGi/SeE55gjSgsmKpRqEcs1TyU5cy420PS9DUwL9HpNY+CIyNFal
	ozTV6EBbf1Rz692dcJ34P6DQ6uBqYXYMsxpqZLj3aUPKbOggjzo6bm1IHA0gJ4J3BPsgWm8Y1Zo
	HquwU8OPVSZCw6btWNsxoOz+lJPlb9rH8xeYjjNgSJgC6dnM7YDYrw+SuF/Vae5TfphcQ+tC/Bx
	YEaZLPlDExTJvkGrYDwPfv8JpFz6GNz7Nifq30Bldfhvqxc+6pU4jQIwF4i20apARHOeu9qdFW/
	T2IoVz6TXoaAfrYQIoxa5KkVa8Y0lNCqJ0i70DWfFeVmvcu2DpV8rDrr+btEgwwJALgz8ogmym1
	+kQkmEvcqLLaIwojnzxUqswvYNogIstNhF1x2iJj/r8
X-Received: by 2002:a05:600c:3105:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cf82bea15mr43305995e9.1.1788524464146;
        Fri, 04 Sep 2026 05:21:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b9c6:f35c:534d:8463? ([2a01:e0a:106d:1080:b9c6:f35c:534d:8463])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm5120855e9.14.2026.09.04.05.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 05:21:03 -0700 (PDT)
Message-ID: <b1c95b66-4ef7-489f-90ab-1f606b7f9761@linaro.org>
Date: Fri, 4 Sep 2026 14:21:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] tty: serial: qcom_geni: don't ida_free() the console
 port line
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org>
 <29755612-0ddd-4447-9859-ae781e8b3c5e@oss.qualcomm.com>
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
In-Reply-To: <29755612-0ddd-4447-9859-ae781e8b3c5e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 11:24, Konrad Dybcio wrote:
> On 9/4/26 10:50 AM, Neil Armstrong wrote:
>> The console port (qcom_geni_console_port) is a static instance whose
>> uport.line is hardcoded to 0 and is never allocated from port_ida.
>> Only the non-console path in get_port_from_line() calls ida_alloc_range().
>>
>> Fix the qcom_geni_serial_remove() and the matching probe() error path
>> so unbinding the console device doesn't hit:
>>
>>    WARNING: ida_free called for id=0 which is not allocated
>>    <snip>
>>    qcom_geni_serial_remove+0x58/0x80
>>
>> Fixes: a53be6945f51 ("serial: qcom-geni: Remove alias dependency from qcom serial driver")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> The robot continues not to find all the issues during the first round..
> 
> tldr: uart_console() is only a valid check if a port is an ACTIVE
> console whereas we skip ida_alloc for ANY console ports, so in .remove()
> the check should also be for device_data->console

Right, good catch, would be nice if the robot did find issues directly related to the patch instead of random unrelated issues.

Thanks,
Neil>
> 
>   Medium: The remove-path condition remains incorrect for an inactive GENI console port.
> Patch line 326 changes the free guard to !uart_console(uport). uart_console() is true only when uport->cons->index == uport->line (include/linux/serial_core.h:24-25), rather than when the port is the statically allocated console device. If qcom,geni-debug-uart probes but is not selected as the active ttyMSM system console, cons_ops.index remains -1 (drivers/tty/serial/qcom_geni_serial.c:1746-1757), so uart_console(uport) is false. Removal then still calls ida_free(&port_ida, 0) even though get_port_from_line(..., true, ...) never allocated an IDA entry (drivers/tty/serial/qcom_geni_serial.c:279-310).
> Use the same ownership predicate as the probe error path:
> if (!port->dev_data->console)
>      ida_free(&port_ida, uport->line);
> This makes freeing depend on whether the line was allocated, not on current console activation.
> 
> Konrad

