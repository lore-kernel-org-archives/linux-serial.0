Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D63A6F18
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339141; cv=none; b=T5Xpudw0JZA3bt57pC1edd6GE30ubfg1+ThyaFvSuQYXLtFvQlyaP6LUn7GST8KXVleOHkTTs9UIoDBBhcPZlW/5KVZ3Dw/pZ94sQsii7xUQxYCL63rFUoq6pm2X0r90OWyIzw2kG3TxBVCMbJKhegAJoWHnxJCrxkh9cUiqXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339141; c=relaxed/simple;
	bh=6KsSLfAF+/mtxLZlpZ3CgURnBm3csVvYhe2jhhXXYz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7aBUZ87XYjAQvLjWfMH0D3MrxPwRPCdhEW7ZIG0ADe98bTIRxvwoiDc3HbL7wsUSc6vGgf3hRwhaNZ47S2S6zPPv+GYqrTfKbymcrwWXa4caOgF2ESQJXOD7oPauV7f5FKNmevKWEBkvG3/5YsRFL4a1v91PZ+yIpHiSacmgmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JiAZhmA5; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JiAZhmA5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776339136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5JpUD1ZX/0TUIEgZlqUk61qFWas8IanC2YUFCf7B3M=;
	b=JiAZhmA57NiG/Za1hAjSk/D4eyv/X9O8YuZdh5UWvuBt/Zfw6Q04O6zG+z8Fkf4BjbkLrM
	to16Gj0zsWkCN4YAg5pMQDokOh1+FsyBPz6Idndpk9g+OGQ5nIClI76O54m37z4PJAi9cJ
	KN3a0/viDQ/MIaqWESeuZ7oZM4Fwh4Q=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: andy.shevchenko@gmail.com
Cc: fushuai.wang@linux.dev,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com,
	wangfushuai@baidu.com
Subject: Re: [PATCH] serial: 8250: Clear CON_PRINTBUFFER on port re-registration 
Date: Thu, 16 Apr 2026 19:32:00 +0800
Message-Id: <20260416113200.38244-1-fushuai.wang@linux.dev>
In-Reply-To: <CAHp75Vc7sdDT+nWZX7u7aSsUhUquYNAiYo9HrxHhjXnGz5g55Q@mail.gmail.com>
References: <CAHp75Vc7sdDT+nWZX7u7aSsUhUquYNAiYo9HrxHhjXnGz5g55Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> >> When two PnP devices map to the same physical port, the serial8250 driver
>> >> removes and re-registers the console structure for the same port.
>> >
>> > Is it a real device out of there? Can you share what that is?
>>
>> Yes, it's a real device.
>> In my Intel(R) Xeon(R) 6971P-C machine, the boot log shows:
>>         [   17.242984] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>>         [   17.251352] printk: console [ttyS0] disabled
>
>>         [   17.257934] serial 00:04: Runtime PM usage count underflow!
>
> This is strange, what kernel version is this?

Please ingore this. I just test the patch in kernel 6.6. And this log
has nothing to do with this problem. It was fixed in patch ed2761958ad7
("tty: serial: 8250: Fix another runtime PM usage counter underflow").

>
>>         [   17.258360] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>>         [   17.258516] printk: console [ttyS0] enabled
>>         [   29.643013] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
>>
>> The issue occurs when BIOS "Serial Device" option is set to BMC:
>>           Setup Question  = Serial Device
>>           Help String     = Sets the Serial Device used to output bios serial log
>>           Token   = 9003   // Do NOT change this line
>>           Offset  = 2F8
>
> Is it an IO port?

No, Offset = 2F8 is the offset in BIOS configuration space, not the I/O port.

>>           Width   = 01
>>           BIOS Default =[01]BMC
>>           Options = *[01]BMC       // Move "*" to desired Option
>>                     [02]S3M
>>
>> So 00:05 may be the BMC serial port device. From ACPI paths:
>>         /sys/bus/pnp/devices/00:04/firmware_node/path: \_SB_.LPC0.UAR1
>>         /sys/bus/pnp/devices/00:05/firmware_node/path: \_SB_.UAR1
>
> Do I understand correctly that both devices refer to the same physical
> device?! How on earth is it supposed to work?

Not exactly the same physical device, but they map to the same I/O port (0x3f8).
They are different PnP devices with different ACPI paths:

  00:04: \_SB_.LPC0.UAR1  (LPC COM1)
  00:05: \_SB_.UAR1       (BMC serial port)

When BIOS "Serial Device" option is set to BMC, both 00:04 and 00:05 are mapped to
the same physical I/O port 0x3f8. And then:

  1.00:04 is probed first and registers the console for port 0x3f8
  2.00:05 is detected and also needs to use port 0x3f8
  3.Since port 0x3f8 is already in use, the driver must remove 00:04 first before
    adding 00:05
  4.This process involves console re-registration, which causes the entire 
    log buffer to be reprinted

Sorry if my explanation is not clear - I don't work with serial subsystem often. :-)

-- 
Regards,
WANG
