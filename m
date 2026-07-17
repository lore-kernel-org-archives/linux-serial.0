Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE23C0607;
	Fri, 17 Jul 2026 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275491; cv=none; b=f+/GKQrvO3hb7bSufUyYB/bZIgWcn0zv1GMe5/xsI2FLKLX/SSkLUnw6/xhEgtE902e25Xco+BaXVnoSt8r4yqq82od/LqA3wRW76pMXhmLK+KMVz76ohU3fBYjLP1mZJLU6xisMCYcVSsOxJqGxsLmJVK+R6+EB0LPJNwB/xC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275491; c=relaxed/simple;
	bh=fYbS0sCOrEqLJlHItgakwP3+Y5x15z2KiNU3tTBCrDs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=geyBXzEs5+g0MbLIdXVQZlXhEdUthQhnOgC/UZCVmTEMuS06AuzpvPUsDWWya2jzEN5OFnCdSexPlYwEloko3wHGhsDxd7vXFAeSYQYN+u0TZuZNHwBnRoOSkWCA7t4PNnLjckZuYo8EllRtX/RrlyjDRriSH439aZ23/DnXLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=uWy6+yYD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLDOX/eM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uWy6+yYD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLDOX/eM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E30517A00F7;
	Fri, 17 Jul 2026 04:04:47 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 04:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784275487;
	 x=1784361887; bh=6LUdNMnBaRSqyoN6IPBQzvi+iWUdJzMPuyjYPVqAxN0=; b=
	uWy6+yYDdWv7J6l24u/EQsDSYYHca2XHAqPVt/XIXiJxodVZFHz+jxU9XPPpPRXa
	Abxd9I1kUp4PYMWKOG7R3Sz5pudOelA4omx7I6gWWnwdJ5lTH5/w0rH8YSsoFouo
	lbdyiZ+IHX1U67qvicDrILLqZN4SNHUEe34sYW3e6kB57c1Gn49Nl6tm+HFINqYv
	tcw9umNMWUx3PjxA+qgsSyoqBa0cNQPkCh54+ZOvLMEHMbkHaaFHlPRA0YJlfu7o
	NaYqWBeRs0eNfGY59JyUsOgxacRYiIUZYmn0QUlmUWq1DVueujQdeudU9P7MEPky
	wxX5jRKLKKr4J31BuZqRKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784275487; x=
	1784361887; bh=6LUdNMnBaRSqyoN6IPBQzvi+iWUdJzMPuyjYPVqAxN0=; b=n
	LDOX/eMLFg1VvnDICDjnYWVKusG+SncZ9sg5PiFCLqP0l+Kw3NH1uXuRo/0Pm0rM
	M6Sn/MwWvwBLEcXfmnYTfUJQq6v6Nlxl9DTy6V5nV9e0F1qebYRIyh/W9EgMBp1k
	eeNGMl8VOOKFumPp2OP88fQOWNUg97AQWvJ+Kv7aUP7rH68zIEx0SGRudzWpgpjq
	4eE725hxhidNkHm8W6TyGlYpSKb3ZhaRrjeTqFsUYUFzB0+prpCOULiRUm6zOhWB
	ZdzVWMvKP4k/NSFlcOmoCX4aNjvSeuN8SoDb59kW3Zles1EO32VyRHqkSnoDFBE8
	yGfkv08RfNJ23nC9VL2oA==
X-ME-Sender: <xms:H-JZaleW3pTXxnKrT-yLUJOHtOzoDRG_GJ5cARc49dF8dXkI40YuaQ>
    <xme:H-JZauAAm0MwC2S58dqBrHJaOX6Jyof47qYzhHlAIHCC-jA6aFyESSAOPBB6HIkyu
    0dHa6DRVsZ8wfYAfJhPwqPpeosFrt43SY1y_NdIgyR7gO9uRXVWeEc>
X-ME-Proxy-Cause: dmFkZTFhjKKPRKG7nJvYTjXJiMDFH2rb4YJffNLelfIuXLOK3F0/KRegeCFhzIjbW0bE5w
    qGHY27YYLKz/PBOZmV1e+fBuFlBcD3kNd6mmDZInNaz6j9Sxku+rMCtJWDq92aEWrObX9r
    Lmm8IOG9eOmneit8r/hacP2ae6mXkwPa4RxHNaFvNQ4UkVUHRlLDygdhrdF53yFuCV7hF4
    FRq04bYf0YsRJA1GoFDmVBHeNI9f9XZxF4/3qPpQK3JiGu+wb8/dZX5m9X+0a0p+Mw+fr2
    lIyaJGUGv3l+r+V5sIMuuoxszCwH/b5GA0Zw81gL6djRQbJDqW1spsvKoDg9Sw1HldnLBW
    YCDPSJe0JPdSp6INKkPbpP3Q2w7vv2M7oLlwEg49fm0uPxzKjA/DmMuOJWRNghJHZ8+3sN
    X3/oFZZXCEo2ITnrEpNCOtEwoROHnxnuhHfxC2pb5n6sjkNq0LYUdmijzVJ8IFivp5Sl6e
    7HVsIVYtJcsKKr2Cv5vh/x64cZ1QR3DJMpuosNbaxfhfJ16ftBHRw/uO0zrKBNlxdUzi/+
    5APIYkXume6pupgBggXLqVLoLH7inhMtQ6+EishiRN81LlcGRO+rPfXEEQ4WL84y5QUgVB
    GjRgqL4WndpKmhOUMmglmbLWyVd4TdVskttYK9GYcP0yNEGh5Icb167I6D2A
X-ME-Proxy: <xmx:H-JZam85y39p8_vnSiaLJx3yWhkA8vSNGptWjDjV1ArJY-LusL0lHQ>
    <xmx:H-JZahpNpcIvQVfS9EKkowV5bDPqzJ0eqr2gjpKkyjxr31aG9_T6KQ>
    <xmx:H-JZarCmpxEde3_WhN-BjX1hT3JR8XVPBSj3H0StP-FnBJek_MGrUQ>
    <xmx:H-JZajwdMm3AWE-8WdOvNk-90iJSuXJ4xUvHA-5ycdJ8dtMZzzu0hQ>
    <xmx:H-JZagfHje9Er08ZeNJjJ7gnQ1e3u7iZMrvLFsHSyfbz2EJFTX9f1AJr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7E8EC182007E; Fri, 17 Jul 2026 04:04:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKWf8mvLe8Lc
Date: Fri, 17 Jul 2026 10:04:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Jiri Slaby" <jirislaby@kernel.org>, "Nicolas Pitre" <nico@fluxnic.net>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8a4b1bb8-57ec-4746-8c98-3bcc13e9ffd9@app.fastmail.com>
In-Reply-To: <2026071743-number-headfirst-bcca@gregkh>
References: <20260717071616.91423-1-kmehltretter@gmail.com>
 <2026071743-number-headfirst-bcca@gregkh>
Subject: Re: [PATCH] tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2026, at 09:22, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 09:16:16AM +0200, Karl Mehltretter wrote:
>> hvc_dcc drives the JTAG DCC via the ARMv6/v7 CP14 debug registers
>> (mrc/mcr p14, 0, rX, c0, c1/c5, 0 in asm/dcc.h). That encoding is
>> undefined on older ARM cores, and also on ARMv7-M, but HVC_DCC only
>> depends on ARM, so it can be enabled on e.g. ARM926 (ARCH_MULTI_V5),
>> where hvc_dcc_console_init() runs __dcc_putchar() at boot and takes an
>> undefined-instruction trap before the console is up:
>> 
>>   Internal error: Oops - undefined instruction: 0 [#1] ARM
>>   PC is at hvc_dcc_check+0x50/0x8c
>>    hvc_dcc_check from hvc_dcc_console_init+0x18/0x48
>>    hvc_dcc_console_init from console_init+0x58/0x170
>>   Kernel panic - not syncing: Fatal exception
>> 
>> Restrict HVC_DCC to the CPUs where that encoding is valid: the
>> CPU_V6 || CPU_V6K || CPU_V7 set that arch/arm/include/debug/icedcc.S
>> guards it with, plus ARM64.
>> 
>> Fixes: 16c63f8ea49c ("drivers: char: hvc: add arm JTAG DCC console support")
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I don't like having architecture specific symbols in drivers/*/Kconfig,
but this one is clearly correct, so as a quick fix this is

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

A nicer alternative would be to improve the feature detection
in the driver by probing an appropriate ID register for presence
of DCC. Unfortunately we can't use regular device probing
because the driver is a low-level debug hack that is intended
to just bypass all of that and provide a console.

Maybe checking RCP14_DBGDIDR() to see if the version is greater
or equal to '1' (arm1136) will work? If that also traps,
an __ex_table fixup could catch that to fail the driver probe.

>>  drivers/tty/hvc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>> index c2a4e88b328f..5866195de26a 100644
>> --- a/drivers/tty/hvc/Kconfig
>> +++ b/drivers/tty/hvc/Kconfig
>> @@ -79,7 +79,7 @@ config HVC_UDBG
>>  
>>  config HVC_DCC
>>  	bool "ARM JTAG DCC console"
>> -	depends on ARM || ARM64
>> +	depends on (ARM && (CPU_V6 || CPU_V6K || CPU_V7)) || ARM64
>
> What about testing builds?

The driver only builds on arm32 or arm64, and there is little
value of build-testing it on armv4/v5.

      Arnd
