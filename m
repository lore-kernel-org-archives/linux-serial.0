Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385C37C11C
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333800; cv=none; b=aC/Pi/UNXp5Htf7STdVByOGHL6/LeNo6sqDUqM1kFrp8oMW5Z4jMEyhody/fPPcUv/Y3S725h+9amMbe7XrnF43+rVh1EIUGv1WVc5s3fj3p6XcsO0LBkyz40wICBEFhiQUa1EtBwDRr9MKUzUz1R6OlJby9wVegAAEGwwdxXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333800; c=relaxed/simple;
	bh=Esp682fhQROLW7Tl5GvuP0h1OWdaGoVocDFrMm4l+gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDWS5NBDol4Be0pJHIr2OH91tVZtbqfNoSnU4pxp2mSlRvsvwI9T5Lb9JxIMO+ssdCX0CFNZhl8Pl/TrOxlTdncLM7OiHlXm5JVhEWUOFxvllEdrSy4e24X5YoTglOTktZAjDgKZ8OM2DS4jyGpFdMDsbzCp1f8e9eAkzDIP+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kmPHWVQd; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kmPHWVQd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776333796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ES7FomgV3m+vLUS23YNm+x7cA2lc7YU+mz8wh6yoknw=;
	b=kmPHWVQdFM8YV9i2B8aaTFjdHUa1UOcrRnystsf+n+afbarA3tIe2j1EoA+07cBPpzx3/7
	H7tiVgNXHHpASqwvqSEESUkOHj6rtfzS4utfn7JQohkHGydh54z140YjkgD0zY+r6IW9nb
	ch/k9eMGJDrD1fETIY5gkyan7sFPft0=
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
Date: Thu, 16 Apr 2026 18:02:54 +0800
Message-Id: <20260416100254.30581-1-fushuai.wang@linux.dev>
In-Reply-To: <CAHp75Vfrw6jLWOm6gC3gjMnUrvyd5nxvS16sJj5TP_JxaDSDNQ@mail.gmail.com>
References: <CAHp75Vfrw6jLWOm6gC3gjMnUrvyd5nxvS16sJj5TP_JxaDSDNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>>
>> From: Fushuai Wang <wangfushuai@baidu.com>
>>
>> When two PnP devices map to the same physical port, the serial8250 driver
>> removes and re-registers the console structure for the same port.
>
> Is it a real device out of there? Can you share what that is?

Yes, it's a real device.
In my Intel(R) Xeon(R) 6971P-C machine, the boot log shows:
	[   17.242984] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
	[   17.251352] printk: console [ttyS0] disabled
	[   17.257934] serial 00:04: Runtime PM usage count underflow!
	[   17.258360] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
	[   17.258516] printk: console [ttyS0] enabled
	[   29.643013] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A

The issue occurs when BIOS "Serial Device" option is set to BMC:
	  Setup Question  = Serial Device
  	  Help String     = Sets the Serial Device used to output bios serial log
  	  Token   = 9003   // Do NOT change this line
  	  Offset  = 2F8
  	  Width   = 01
  	  BIOS Default =[01]BMC
  	  Options = *[01]BMC       // Move "*" to desired Option
            	    [02]S3M

So 00:05 may be the BMC serial port device. From ACPI paths:
	/sys/bus/pnp/devices/00:04/firmware_node/path: \_SB_.LPC0.UAR1
	/sys/bus/pnp/devices/00:05/firmware_node/path: \_SB_.UAR1

>> During re-registration, the console structure still has CON_PRINTBUFFER set
>> from the initial registration, which causes console_init_seq() to set
>> console->seq to syslog_seq. This results in re-printing the entire
>> system log buffer, which may lead to RCU stall on slow serial consoles.
>>
>> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
>> log printing.
>
>Seems like the Fixes tag is missing.

Yes, I will add Fixes tag lately.

-- 
Regards,
WANG
