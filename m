Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238666;
	b=2de22Nfu6Zs1iI83W6MX7aaJTgstcZWq28BJ5+eqMHvhDjW9Q7vPbQViJrmS/DOLF/Rm
	 ojHlBFvqwZy4CHn3uztFfIcSwb8ZZveEXxeqjBYw9AuW9EQnI6qREsfijHmOWd2qgSKtD
	 DTeusDeEUwdoGFl8rHoudw/yoOBE1JqipfSg9FYCAGFQZq9kYCjXV9Jp2B+dFnhCzvXEq
	 IxbFEAeWLQSm6f+/pUgJma8C5lzizg2GWmimCSRuhk1SqjdiQA2CevMRb3ozabfqa/OHm
	 QuCWXlYAhRFqwGSN0zm3C32tOdWV791WNRVIZpGYgA6NV3b+7ixY0G0UApMruVoJLyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ydw1s0x1RNP+qqUMo8W/mYY50hHq5MXJ/cd70aJJung=;
	b=t+0oRAOV0OIOPBfzKXF7qAEJAwNO98RQ+lYDxfOXa/AX9OuSAwm4xbm82bnNWJOCNh+/
	 YnKVZVZQOhsqL7/5Z4Fv8OkMbS5Rxlis2boAXIrONw3kSvG61fLnafXBpnglw/xsGLf2O
	 NhO/KvST3Hae2veP5e0SUamtJgP31glOYWnAfgMmd8q5kWBew7+Gyw3Yubvuui+5G6B9e
	 q5AVESnV+dR8HhAmSEv1QqzR2RtFqiQJQZMBFDS5acxdgXGD99IF3ijZczDPrIb2om//g
	 kNibK1NG5nGwlG+cfWy24QJwauYyzAXLYpxYNBcfY1LZTt+M74sPVLPTtxtAbjkINxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHPQDxth;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E36606A32A
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 15:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E36606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHPQDxth
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so10427725e9.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 07:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238665; x=1794843465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ydw1s0x1RNP+qqUMo8W/mYY50hHq5MXJ/cd70aJJung=;
        b=YHPQDxthLio9qZlx+pNRhCp+dyzli9PQSWNVxlSCobZwRcJs2KDBi2hZOZbOS7+uKr
         IBKS67wExr9rulZ+CSFJhK0U9+LlBdvyMgV37JyqRyhlYb4mCDkI3lZY79aI3UTai4W0
         +ulLYRw0kL0ztF5ZBQQiQY3A2/3jx5JbzXXFy8OHR/SqQDGP6bBjreUS/YpehI29x9/O
         MDwUIAZGlm4OLHtxXRtUythH6nVQLiocdzeHZJxpMkThGf4/BNuhsEtW+C4VJ3iJozxl
         qOZREYqGSTjJ2O12wXvUp/u8ETZYXLjuM7xGEszXZPcWAyPggG1QgL9LEgsTXy80fxkL
         OUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238665; x=1794843465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ydw1s0x1RNP+qqUMo8W/mYY50hHq5MXJ/cd70aJJung=;
        b=bN7YErX8o5CeXyWb9c+THfHq689Gn2IVvH779rwsmSA6KdgbxCdckjPZ6zwOOYF4KB
         mf6YhEUv7+gvmh2ueSOFHTZqWZyuMOHVDsyi42aSB00Q50Fg3KjCk6FSpoAMAB4d0UGN
         Aj1IwtBlL//vzvMhPTkf3ppZxbVMjTSeEoxmQvsKZbuDKzt3XnyMhBSxvwxrPzCSuVht
         0su75A59HnrV+aj58hO49T4xPlRWDo/qo5DDuNsVNxZVI8EefdI1lefWQi9ewss59UPS
         bcNFSaEOwjnb/GXBfKUgGmIl/Ns0p8Rs+gR918TRZ3lcclncZ9y2JEdzSx6eRAUUEvGE
         VhfA==
X-Forwarded-Encrypted: i=1; AL+hErGNmamYIYc0FYUwUB1K0OSYOGEqHf+kaNfSM0oKB9TlATz5gSBJbf6c+FeHGrMexsCpj3tRaaMJsxSdpLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oL9LlmYFfNlK2h7I1O6WeC90ZQk1rFrub8QSspSAJybHbuyuw
	n1/xglcJo0KcwXramlURnjX2ajp+84I91b9i/YxKziLXi4xazxAwSIhiy4ysdZN4
X-Gm-Gg: AYBFou0a4ZhWWZehNIwo83iVgk61hs0ehWDDbXcvypSnaZFGkiwcNsRDjey7A56E40s
	O/g59l7u2zH2YAm9G3YrRruMMxffMgU0ZIOO7Qy38m2BMs+FweLX8/a5vtEVW9aPAza4D8a/CO8
	durXQK4SF0CsqyBopWcguGBAFAebkyM9G6iTUayCcYfYrjOfVj3LiCTQoDv0xzxHqEaZ5w+0ZhG
	AtBpGdR1xlTSjjrppatUDaYAfchz2ua/DlZhl0uzLxlnk89B+hz6h9rfQfi8Fo0rqLWotdpJEpf
	gve8dQeoHZtBoFNoCay7ikvj4lHvDrR12PSGO75JE89BRrV1FiMz8pS1OrRdBTD4lLnHM/JGbpd
	4xa/MYEqFgayrcBbuGB90kNHecVeQ7tUGYBm10xg4cAUjRrNfABYLlBsOwztGUdCFPnxaDkvZ1z
	GzJhpKi6hy7T0iTJNWkE3q+JKLx1gBCBkUmcDmLVtU4W0Pco4Qfqt3aCWNqJIAGmNXSQY1S5hNP
	jnRdtMCLsHUjRvdhRzol2DwvYKr5622BXsFB2DnRKIc/NaMgq1UglaQRAeBQTcx9Q4U1sfFSzKe
	vuvhymzlyoYVnq5OjqTiTrJbR8lC7CuGjnBusaA5HTF1cVuq3jIdR9L/Eke8kXCcUqGiH0cRa3S
	PfQ==
X-Received: by 2002:a05:600c:37c3:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4b963c89ef2mr78509805e9.17.1794238664475;
        Mon, 09 Nov 2026 07:37:44 -0800 (PST)
Received: from ?IPV6:2a02:e98:40:8091:f0f7:91a3:e60:541a? ([2a02:e98:40:8091:f0f7:91a3:e60:541a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90619bbd2sm149230065e9.1.2026.11.09.07.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:37:44 -0800 (PST)
Message-ID: <800f8d42-e35d-47ec-bbe6-e437a86d6e70@gmail.com>
Date: Mon, 9 Nov 2026 16:37:43 +0100
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
Subject: Re: [PATCH 1/2] serial: 8250: Add RX trigger levels for U6_16550A
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Miroslav Ondra <ondra@faster.cz>
References: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
 <20261109-8250-select-u6-64bit-v1-1-04bc8332fa34@gmail.com>
 <469362ef-f0c5-45f2-746a-b4a3c51876a4@linux.intel.com>
Content-Language: cs
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <469362ef-f0c5-45f2-746a-b4a3c51876a4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> On Mon, 9 Nov 2026, Kryštof Černý via B4 Relay wrote:
> 
>> From: Kryštof Černý <cleverline1mc@gmail.com>
>>
>> PORT_U6_16550A has a 64-byte FIFO but no rxtrig_bytes table, so the
>> rx_trig_bytes sysfs attribute is not registered for ports of this type
>> and the RX trigger level cannot be read or changed from userspace.
>>
>> Add a table with 1, 16, 32 and 62 bytes, i.e. 1 character, FIFO 1/4
>> full, FIFO 1/2 full and FIFO 2 less than full. These are the levels the
>> Synopsys DesignWare UART uses for a 64-byte FIFO, and they match the
>> existing PORT_ALTR_16550_F64 table.
>>
>> The default FCR value of the type is unchanged, so the trigger level a
>> port starts with stays at 1/2 full. The only visible change for ports
>> already detected as U6_16550A by autoconfig is the new sysfs attribute.
>>
>> This prepares for 8250_dw selecting PORT_U6_16550A for DesignWare UARTs
>> with a 64-byte FIFO.
>>
>> Co-developed-by: Miroslav Ondra <ondra@faster.cz>
>> Signed-off-by: Miroslav Ondra <ondra@faster.cz>
>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
>> ---
>>   drivers/tty/serial/8250/8250_port.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 36b2b0a2c05c..a7acede62f40 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -163,6 +163,7 @@ static const struct serial8250_config uart_config[] = {
>>   		.fifo_size	= 64,
>>   		.tx_loadsz	= 64,
>>   		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>> +		.rxtrig_bytes	= {1, 16, 32, 62},
> 
> Reusing U6 entry for DW UARTs seems misleading.
> 
> We've better mechanism coming up for defining rxtrig in a one pending
> series so this constant friction with the uart config types can be put
> into rest.
> 
> Please build on top of that other series and help in testing and reviewing
> it.

Thanks for the information, I started the work about a month ago
and not sure if the patch existed before. I will test the other series 
on my hardware. I like that approach more.

