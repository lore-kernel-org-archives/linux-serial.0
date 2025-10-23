Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB2331A70
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232428; cv=none; b=J2twoE7l9ozJ7bK6LB3RTL1Ts9GSZyXtInEjLmLvkYqL7kJUbO4a9I9Lv6aB8QxdefIIlE1T2i3RYw1SmIn6AeAfr6F//MhQPm2lizeUxwDfOTuhKyuOb/V8w5vTMETP5KQUGVzCEN+g9+7fJ06PFQz2OfN4lC6Q8okHEsQQjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232428; c=relaxed/simple;
	bh=ZYbxsqcSKe5uOH5UOOlIz1EB84AW+yw68Tm3qSEpoI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpkABLri4ow0AKBdVvrhsLv573c3DmiNzW37+6xU8z0SAvmoFntWhMG4XruCJ6iDPRTG/pZ7tvWQMkt+ozSNJ6BGXvrtpa/Wn8PNSL1PK9DpDt6crV/BqmzvIJn/l0oC28MliBihLKGkknlSOuqhXsJnopjqpZMKui45NFkTueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=kYcbSvlP; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="kYcbSvlP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dr22JhHiTfKnvoaRmt5ka5LgkQDEkPomNJOTU1lLxgU=; b=kYcbSvlP8DkztC/vo4CrWKRaej
	yzSzEmie9/MZrFtfilYIRsRs0FdHh/C+gpiudRTX+9i0zvLXiSk1fGfmbCG8AfR1OfoxBo0vEkxlr
	VdqjVilESmj/llsK2pnz8deZDlzoxMVTUlcowxlVKTgr+MuXsRrqLQRwIucx6HIYEftg=;
Received: from [188.22.5.236] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vBx0Z-000000006GJ-05Ql;
	Thu, 23 Oct 2025 17:13:44 +0200
Message-ID: <7538d8ed-6ab3-4d76-9149-4533ecd66e4e@engleder-embedded.com>
Date: Thu, 23 Oct 2025 17:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] serial: Keep rs485 settings for devices without
 firmware node
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
References: <20251020190658.30655-1-gerhard@engleder-embedded.com>
 <20251020190658.30655-2-gerhard@engleder-embedded.com>
 <aPoAxvRijfsG4hIR@wunner.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aPoAxvRijfsG4hIR@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 23.10.25 12:17, Lukas Wunner wrote:
> On Mon, Oct 20, 2025 at 09:06:57PM +0200, Gerhard Engleder wrote:
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3536,6 +3536,14 @@ int uart_get_rs485_mode(struct uart_port *port)
>>   	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>>   		return 0;
>>   
>> +	/*
>> +	 * Retrieve properties only if a firmware node exist. If no firmware
>> +	 * node exist, then don't touch rs485 config and keep initial rs485
> 
> s/exist/exists/

Will be fixed. Thanks!

Gerhard
