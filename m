Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7E298987
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191946; cv=none; b=GdB55dpwlCxT4QZxa973bK+PKhC0fv5UNlPV4xWClGNP5i+dqrO0ZSx6+rerCXKBgZ5MFvLl3FtorjqLf90KfnXdI482u7ebB/NorKbW4/Ggn/rcb/xDvokWbo+jNAnfdEElhZC9tmzpxMEIhQ7ujdneoYNIe5eWxwz0Z6noAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191946; c=relaxed/simple;
	bh=O53v66/n2tm86Ej6cJd8JA+4L61tiJrsXjstEIU7vJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHlqQlPpBC0s6dZqrd//cmZYE/m2EMweSkIKY+/Nq3+9V0axwmfAPJ4ws8CXw+FxRfvQpFpgx9M6k8a5LgPZUy3JrW4t7vCxQ4PHI8xoKzd9QRRuEGIEWXSkvs7GCAmUfORZFKD+a0w/gBFvdTtRqrwaurt1kQf7+/sr8UwEpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=EEJtmSQZ; arc=none smtp.client-ip=81.19.149.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="EEJtmSQZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=odMzHSLU50BreEMTUMtbuxO2jPQfkKMW23gxZ/9ghRA=; b=EEJtmSQZ+N9cGBuMI0zjz82u9f
	IwW1clLECqbjU4r5wxuu+XMhl2PQPd2iKKRYfCh4jkwXFvG7jMFl0jCnm9Tn8GGoTmcBiRsYnVNlr
	UpXNzNKareak837JjhonliPR4lGeeM26Ex/0RnEY8zcL2wUBTNrcUU7eEP3DzuN2lJmA=;
Received: from [188.23.34.236] (helo=[10.0.0.160])
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vOMLH-000000000sJ-3iwh;
	Wed, 26 Nov 2025 21:42:24 +0100
Message-ID: <6759314e-d595-4319-976b-cfc9edad0239@engleder-embedded.com>
Date: Wed, 26 Nov 2025 21:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] serial: Keep rs485 settings for devices without
 firmware node
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, lukas@wunner.de, Gerhard Engleder <eg@keba.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-2-gerhard@engleder-embedded.com>
 <aSb8OTRLUsgcXUjO@black.igk.intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aSb8OTRLUsgcXUjO@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 26.11.25 14:10, Andy Shevchenko wrote:
> On Thu, Oct 23, 2025 at 05:12:28PM +0200, Gerhard Engleder wrote:
>>
>> Commit fe7f0fa43cef ("serial: 8250: Support rs485 devicetree properties")
>> retrieves rs485 properties for 8250 drivers. These properties are read
>> from the firmware node of the device within uart_get_rs485_mode(). If the
>> firmware node does not exist, then the rs485 flags are still reset. Thus,
>> 8250 driver cannot set rs485 flags to enable a defined rs485 mode during
>> driver loading. This is no problem so far, as no 8250 driver sets the
>> rs485 flags.
>>
>> The default rs485 mode can also be set by firmware nodes. But for some
>> devices a firmware node does not exist. E.g., for a PCIe based serial
>> interface on x86 no device tree is available and the ACPI information of
>> the BIOS often cannot by modified.
> 
> While the code is okay per se, the above statement is not fully true.
> We specifically have device properties and software nodes to provide
> the missing bits.

Yes, Lukas Wunner teached me that possibility. I did not mention this
alternative solution in the commit, because I did not use it.

Gerhard
