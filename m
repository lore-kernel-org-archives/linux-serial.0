Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE11514F7
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760903560; cv=none; b=Z+eDLYncGLuFkzkCYQ7pILuP3sTmIiYij7RCBBaI/MVWhSrQOmcj3d6EHsu8JhHkmm6fDXwECpUEyKc02s8PsFdc5zF/vsL4PcW+7P35ch9SJdxkduNY5BuP6r0UYw0jJ0ghk3bSBmnIS7JVaL9Ob/qvznOfVY7sf1vIyuQ+4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760903560; c=relaxed/simple;
	bh=iBoiCG2ZeuphCxAMyQU4wwLLUzviP4SR/cBRCibg8ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdpjASfAL2vvzM7UdoaaXfiMXlhAm/JNbxXMN5VedR/zfTAIEiIIr9Ivnke+BGw3zTfI1G/UaTh8xxhQ1l1cMtaG4VrgzufrMLzElMocttJTZisUa7YISjot05/hM2hHlDaI8Xr3LKczlrVKfHIOQ6JkWV8oMCDRDDp7fZ91XiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=BenKnlWU; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="BenKnlWU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aCIqWz0AJ2LVYkwosB/VImcZuSxliRn0JRLCRTOGWJQ=; b=BenKnlWUNUixcAsEvZtA3UcZqd
	px3oL6WJvoU6PeR/NUGC9Mdza8wxrDhTJ+gyAe0xl9iMtNHp7wjvTtfd/Sg5twn4OlReEu1exkKLq
	giZQppDtm4JVSg2SJ1Oecdf3+BmXfbeg3v3RmOPb4VXfYV7MttWWAnsp06ZzP3tN9+yo=;
Received: from [178.191.104.35] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAYw2-000000000Uf-1aHJ;
	Sun, 19 Oct 2025 21:19:19 +0200
Message-ID: <d4dadfa2-38ae-414d-a6a0-4a436678c3b0@engleder-embedded.com>
Date: Sun, 19 Oct 2025 21:19:18 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] serial: Keep rs485 settings for devices without
 firmware node
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <20251017144209.2662-2-gerhard@engleder-embedded.com>
 <aPSmOcbprjf0EoAq@wunner.de>
 <81b924dc-4e95-40af-a52a-48a75e01d7f5@engleder-embedded.com>
 <aPT42ykVKxouqUHK@wunner.de>
 <4e3da3b9-693e-4d21-901e-14ac4663d340@engleder-embedded.com>
 <aPUd5NXmmow77WF7@wunner.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aPUd5NXmmow77WF7@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 19.10.25 19:20, Lukas Wunner wrote:
> On Sun, Oct 19, 2025 at 05:21:30PM +0200, Gerhard Engleder wrote:
>> On 19.10.25 16:42, Lukas Wunner wrote:
>>> BTW is there a good reason that you don't have a fwnode for your UART?
>>> It seems odd to have a UART but not describe it in the devicetree.
>>> Maybe that's the real problem and fixing it obviates the need for this
>>> patch?
>>
>> This auxiliary device is part of a FPGA based PCIe device. It is mostly
>> used on x86 but arm64 is also possible in the future. There is no device
>> tree or ACPI information available for this device. Think about an x86
>> CPU module where you cannot influence the BIOS implementation and device
>> tree is not available. IMO having a self describing PCIe device which
>> works out of the box is best in this case.
> 
> In case you're not aware of it, it's possible to assign a software
> fwnode to devices through device_add_software_node().  There is
> precedent for its usage among 8250 drivers, see 8250_bcm2835aux.c
> and 8250_exar.c.
> 
> So that would be an alternative to this patch.  Conceivably, your
> FPGA might support different UART types and each might default to
> different rs485 settings.  A software node as used by 8250_bcm2835aux.c
> would allow you to define those settings through the driver_data.

I was not aware of device_add_software_node(). Thank you for the hint!

IMO keeping driver defaults if no fwnode exist is more straight forward
than adding a software_node. So I would keep this patch.

Gerhard
