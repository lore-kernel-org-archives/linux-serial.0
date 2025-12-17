Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11E35BDA9
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993742; cv=none; b=SGkpU51hp1iR5EV5oMEnygf0eJQ23xVPUcHXu4chXx1tdNsUgC4yEj/zQAWihncBIJmKUQeE6v3IRmYWXwTmk/jnFI0zW/4ivqm1Rq3/Cu3Hdx1/Iz5b6JoEQ5MREuisnzucP2iurXNF5TrA/WkKTUjW7t6R/WRnG2azHMZx0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993742; c=relaxed/simple;
	bh=vbxz75owOvLM9rZCEeLSaOhl4QgfcHd2NtWImu+z7XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lt6wFc0NMNhlV2FI6NgEtcM/8jeUqx6V6MOERmtINqk49XUIicO89bBneD/H7S0UiK83FUcIxOTmJDo7vg0GTF5O1juGZ9WBx+VrypUafMorJ9hnrPn08Uh7PXFkTfoH8pB/I/Z3mM08bbw96F85E9YD1DTpMuy6gltnlq9kfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWi2R1nR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWi2R1nR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a110548cdeso41114955ad.0
        for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765993738; x=1766598538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oZdzeQQCC1XbTPRuHGyzqpiZ4UJ3xJafirE7ufyk79k=;
        b=eWi2R1nRwLSOydSBf/v2AF8kHjCcb3JkXqshWgrFLN3yH6jrA2eiNLbTQbwbE9Y89u
         5lOG8/yV81AiUUgPQmxqLW3WNiX/IQzD01vWPVcIj8846/uaPncJi/We0s8LU48zdc8k
         B/7457O8FMJImqIib6192WiC75Ktudoe/Lue08QelyOk1r4H42ZnJh+jH7N2GtmGt0o3
         QgUgDb9339Hci6MtR///42MIytM31mKWrfQ3mPB0d6uwf5jw1szSfKHD6u29zbK+8uVE
         w5xW92iXTt8h/t2yBgfNu+Odlqc4kR3cJTysBqLzIiWrqnrPGKJe2sHrcNvF44igfLjv
         AeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765993738; x=1766598538;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZdzeQQCC1XbTPRuHGyzqpiZ4UJ3xJafirE7ufyk79k=;
        b=ZEBPwrxEkfYE4CL7D9m3VsAM9G5gAaH33LTH0DoDAAYmA+JycfHPyJgwhxChh/rn/b
         GjTOcz7Dn8bSWKH1ctkXEbQnlgfz+lYst4iZjKhJCD+BefPk+AfIiZo6PFtLLQj0tr72
         2NBkcXCCAhcCOXOsW7cVbOSmX9MzLNipAEDuiosQXwo8MxKhQKVlDJ9N0rbLJfuMOTW4
         /qVTSyTBGugx3qR0IsFaJMLC398rny6O4hA16n6XoOmq1vjRqsMOYGkOym84EaWneuX3
         UJRFgqvjpjh2y8BOng+YfTrV/V5FiQLXNwsibAEml2VfzkuEIhvwsWqn2Cw1GBHCz0oO
         m3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXNyGu4vI0d8k6zrg0OiUdWRaR7VuTX1DynKejbjGZpqllrYbeMyUxX+sr6aMvdwhS2CK7quZtwU4VOMnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2HCG39uv2xLJrAyyVe0jre1L66SefNzTQ4Oj8cR9SiufoBn+
	8PuWIWwpaDueXhRZeF/RNKy7+d0o8Jp8T+1hoJFaTC+ruX7rBjF/tTYOE7LfFg==
X-Gm-Gg: AY/fxX5bxvg7hi77RUWqzK+WDWDfGR+S/h4nwvEgaw47QgADSf79Be1MzI865reQmT8
	3eadcXESrHdMJub+VUJnAI0Q6/fuTnaoFvDafPGt/X3C/pRuSRGjX0L5cMQ7m/9TO2kWn4e9T9O
	iGsPa43L2p2o5BQ6DdcMcJXVUq/wYb+ytL+p+Ei2f9eY42F9bNAMaqCM2h9VcIuJhpOZt2cXdH3
	dNGepgJ9QIgZgAPKWSRIWVUFA6uiSMZE3CfsPYL3dGNrY08/zI0vtLStvz8Th+XU6nqBOYsIB+U
	r/ZMqRDClimKqrR2xIPiYynrpy3+VzJFpSS8XJci9inrhnIj0SmOS1QxlFX/3DCvr/73PN0Ny3s
	K0JAkZSj4sHB1mACKesoR2URgpEbO1iYSsPEmgaH6BGuUIrVHEMwIBd2hJE1faoqOlmlUP6D15x
	0BjPUU2aZeVE0lwVwBElgyUmQQs+B4OyVi2eEMRa3T7G1MZesO8tpo/78Y1O72
X-Google-Smtp-Source: AGHT+IEkk0YxblMicvbYPab648P94Dz5mjqKNSWhPQWLEOfr/WSH1wBFS/O5EeO1Cg1yBCCQ1Tu9mw==
X-Received: by 2002:a17:903:244a:b0:295:fc0:5a32 with SMTP id d9443c01a7336-29f26ceb95bmr176680925ad.3.1765987880276;
        Wed, 17 Dec 2025 08:11:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a08cae24d4sm145600625ad.15.2025.12.17.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 08:11:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9bf73b42-9669-4457-9b58-1420a29b61bf@roeck-us.net>
Date: Wed, 17 Dec 2025 08:11:18 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: Replace deprecated PCI API
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, phasta@kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20251126091032.130787-2-phasta@kernel.org>
 <3f5370b7-c67c-409d-8422-83b5096d1233@roeck-us.net>
 <de540d7789d0e9f77efde05fab4705b8d97245d8.camel@mailbox.org>
 <2025121710-audacious-slot-fa2f@gregkh>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <2025121710-audacious-slot-fa2f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 06:06, Greg Kroah-Hartman wrote:
> On Thu, Dec 11, 2025 at 02:57:46PM +0100, Philipp Stanner wrote:
>> On Wed, 2025-11-26 at 09:02 -0800, Guenter Roeck wrote:
>>> On 11/26/25 01:10, Philipp Stanner wrote:
>>>> pcim_iomap_table() is deprecated. Moreover, its special usage in 8250,
>>>> causes a WARN_ON to fire (in pcim_add_mapping_to_legacy_table()).
>>>>
>>>> 8250's function serial8250_pci_setup_port() effectively maps the same
>>>> BAR multiple times and adds an offset to the start address. While
>>>> mapping and adding offsets is not a bug, it can be achieved in a far
>>>> more straightforward way by using the specialized function
>>>> pcim_iomap_range().
>>>>
>>>> pcim_iomap_range() does not add the mapping addresses to the deprecated
>>>> iomap table - that's not a problem, however, because non of the users of
>>>> serial8250_pci_setup_port() uses pcim_iomap_table().
>>>>
>>>> Replace the deprecated PCI functions with pcim_iomap_range().
>>>>
>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>> Link: https://lore.kernel.org/dri-devel/16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net/
>>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>>> ---
>>>> @Guenther: Can you please test this? I hope it fixes your issue.
>>>
>>> Yes, it does. Thanks a lot for fixing this!
>>>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> @Greg:
>> Can you apply this?
> 
> Does not apply at all to 6.19-rc1 :(
> 

It conflicts with commit b7cefdb663382 ("serial: 8250_pcilib: Replace deprecated
PCI functions"). Unfortunately that commit does not fix the problem; I still
see it with v6.19-rc1.

Guenter

