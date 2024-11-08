Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662A1EBFE1;
	Fri,  8 Nov 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073987; cv=none; b=HQKWy3PzM3knSJCGbcW27SAifdKDxGUfS0O2aoiXhUvJfbnwfN2KwCbJJyxDgfEYhQ/qPQElgQnoX08qmNl9eWC56Oqa9biWIWnndndrqdAUffLeafqQBbecVLQqqvSDxbxWk8kyFjUVjCYYBTmQh/ndtlxnElYYXweCwUuXlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073987; c=relaxed/simple;
	bh=IAq5ttC3vbAsycsYo3nu25UcjBasXzDzBPtVRRcBV2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lFK1Bb8j4Q4cg1Dvk+1Dq7bG+EJ3mV6sGntFK1tQU9SkpOSsR8yHr4z3jOOt4qaRNUpQQD+oFS3HYzkHERYRmMjt8DUiZWzvispp8Gw0hVfpvZi5M36kz3+iF1u64e4GT1UiapMlZNV20yTNQxhg+PczJe5GlzTHDoNkhyTF4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K3PtOpHP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K3PtOpHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731073986; x=1762609986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IAq5ttC3vbAsycsYo3nu25UcjBasXzDzBPtVRRcBV2E=;
  b=K3PtOpHPMBVyTdQCcsABxwmPLBgsUJP2r/NNkBWnzYjTjqiCB5YOtV0e
   /tzSl7WshZsI6iQ849YZLXRVboh11OSVGOwJ4bh+Vjc/cjuOLXashJXmz
   yw3ls+0J0F9K2mQvGIz6wUukxlVSesTTjHfoFKrLiD15n5Bq2IKg4MFbC
   4xO2nNLSgXYz+yChiLuAOsIFjPgfI/aEubm6IuOa3WZZIu905+UWrsyXM
   5BJ783n/+w3duyGFpOCZHr+V4XjdFGQPXST87nYosXbOM8sSf+HYl09SQ
   gnbMLKpgHK/z+sQ5PCB7xgiyu/K7wec/Ym0m/PPToEuNoAzJt/VB8h0x3
   g==;
X-CSE-ConnectionGUID: n9Mhh33+SoCqjpbzpzIr+Q==
X-CSE-MsgGUID: oHmViC4PRB2IqZex68sauQ==
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="265192530"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 06:53:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 06:52:33 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 06:52:31 -0700
Message-ID: <2bf3bf7d-0360-4673-a7c7-4b74a9300f63@microchip.com>
Date: Fri, 8 Nov 2024 14:52:42 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tty: serial: atmel: make it selectable for
 ARCH_LAN969X
Content-Language: en-US, fr-FR
To: Robert Marko <robert.marko@sartura.hr>
CC: <mturquette@baylibre.com>, <sboyd@kernel.org>, <lee@kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<luka.perkov@sartura.hr>
References: <20241108112355.20251-1-robert.marko@sartura.hr>
 <20241108112355.20251-3-robert.marko@sartura.hr>
 <609ef9c4-18cd-4a80-9821-5df27727772e@microchip.com>
 <CA+HBbNFomosu+5_C0+6cqKcc3B9DFiXXPxexFYjY4ud2LmWqmg@mail.gmail.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CA+HBbNFomosu+5_C0+6cqKcc3B9DFiXXPxexFYjY4ud2LmWqmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 08/11/2024 at 14:40, Robert Marko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Nov 8, 2024 at 2:25 PM Nicolas Ferre
> <nicolas.ferre@microchip.com> wrote:
>>
>> On 08/11/2024 at 12:22, Robert Marko wrote:
>>
>> A little commit message would be better.
> 
> Hi Nicolas, I basically reused the same commit description as for MFD
> and else as all of the changes are
> basically the same.

Ok, I have certainly deleted it while replying. That's fine then.

>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> ---
>>>    drivers/tty/serial/Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>> index 45f0f779fbf9..e6cf20b845f1 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
>>>    config SERIAL_ATMEL
>>>           bool "AT91 on-chip serial port support"
>>>           depends on COMMON_CLK
>>> -       depends on ARCH_AT91 || COMPILE_TEST
>>> +       depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
>>
>> Checkpatch.pl reports some "DOS line endings", you might need to fix this.
> 
> Hm, I ran checkpatch before sending in verbose mode and I dont see
> such a warning,
> my Sublime text is also set to Unix endings, I also just checked with
> cat -e and I dont see
> any DOS endings.

Ok, indeed. Probably my email client then. Sorry for the noise.

Regards,
   Nicolas

>>
>>>           select SERIAL_CORE
>>>           select SERIAL_MCTRL_GPIO if GPIOLIB
>>>           select MFD_AT91_USART
>>> --
>>> 2.47.0
>>
>>
>> Once fixed, you can add my:
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> Thanks, best regards,
>>     Nicolas
> 
> 
> 
> --
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura d.d.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr

