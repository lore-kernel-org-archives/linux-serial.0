Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5FC1E47A8
	for <linux-serial@vger.kernel.org>; Tue, 11 Feb 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297394; cv=none; b=Dr2ZQfiq9vE8NjIrD5dKAQK/L4CublBsg1+6V5v0dwEXUMMr3u1fsJDe4qYR38mYprvjy0iLsFcU0sKNp5qey5nR+OfBXcZaDlhI0Z84MBijuYl+9KKK61MMR3bRLGejKpKuigdPnlrlBMwZ04iJ+VjOJ4xZSJoJgx69Xwz9gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297394; c=relaxed/simple;
	bh=vTTPbcm3hPWQGAXc8lS7kKozh9I5JK5VxBG03C5YoQc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=GKi7jTFNQSCKcDhqXURSdsP/V+Vagfp5kqkSySaM5kep34fyimepra56JLc+ttMcTMzAolbaQOe7FIkj/oe/4AJZAyWYJWL9sEZ3ztXd94ik2FBLUUx2qH0SDAVVZyw+Gz1Jv8kbAMZ5Dcbxzbm1y++dUR195Essh64CTp4vvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FRsIxHWm; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FRsIxHWm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D206A41C15;
	Tue, 11 Feb 2025 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739297390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9utK34bGiMkrLUFlE/zHrqGypJA3CK/m81WMH15xmSc=;
	b=FRsIxHWmhVB2h4hAVLdxj6ikwyQaUbEGKJwuVJKclFrOJ2lmbTZ/KqDYcy+25zRpj723XA
	25lS6JNU7gSNCtalLNa6GwxqthLIrl+lHS087GPD/LdeUpDOnM2NI/GXi+wN+25e4Zi32N
	xOajh7tWV+ilMzZjroNnhV0Z+Qpkv3Znz/qtbZ60e2iLM9TD22K1aq9ZjLhONGcqSokTiV
	U3/S/i7Y1K/X8wBFi2gZN4Sm9Ex7pez5RlN3moto5FM2hBNjTPTBw1inbATFa5RKm15OKy
	36kotOEVcJPn5fUMAredGm+fezPG9fLaPk0ZuZ18jV2lxVL6HK47/CDCRIjrKA==
Message-ID: <3d227ebe-1ee6-4d57-b1ec-78be59af7244@bootlin.com>
Date: Tue, 11 Feb 2025 19:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: linux-serial@vger.kernel.org
Subject: Splat: sleep in atomic section in atmel_serial
Cc: Richard Genoud <richard.genoud@bootlin.com>,
 Nicolas Ferre <Nicolas.Ferre@microchip.com>,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfhffvufevtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeuledvheejhfdtteevfeevheeuheduffetffdvfefhuddtkeeuueevfedtteelnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopeglkffrggeimedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgurdhgvghnohhuugessghoohhtlhhinhdrtghomhdprhgtphhtthhopefpihgtohhlrghsrdfhvghrr
 hgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

I am currently working on a device driver for a serial device, on a setup
involving one of the standard UART from SAMA5D27 (not the flexcom one), as well
as two additional gpios for flow control (CTS/RTS). I can reliably reproduce a
splat when trying to enable/disable flow control on the target uart (through
serdev_device_set_flow_control). I am basing my work on top of the current
wireless-next tree:

BUG: sleeping function called from invalid context at kernel/irq/manage.c:738
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 27, name: kworker/u5:0
preempt_count: 1, expected: 0
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<00000000>] 0x0
hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
softirqs last disabled at (0): [<00000000>] 0x0
CPU: 0 UID: 0 PID: 27 Comm: kworker/u5:0 Not tainted 6.13.0-rc7+ #74
Hardware name: Atmel SAMA5
Workqueue: hci0 hci_power_on [bluetooth]
Call trace:
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x44/0x70
 dump_stack_lvl from __might_resched+0x38c/0x598
 __might_resched from disable_irq+0x1c/0x48
 disable_irq from mctrl_gpio_disable_ms+0x74/0xc0
 mctrl_gpio_disable_ms from atmel_disable_ms.part.0+0x80/0x1f4
 atmel_disable_ms.part.0 from atmel_set_termios+0x764/0x11e8
 atmel_set_termios from uart_change_line_settings+0x15c/0x994
 uart_change_line_settings from uart_set_termios+0x2b0/0x668
 uart_set_termios from tty_set_termios+0x600/0x8ec
 tty_set_termios from ttyport_set_flow_control+0x188/0x1e0
 ttyport_set_flow_control from wilc_setup+0xd0/0x524 [hci_wilc]
 wilc_setup [hci_wilc] from hci_dev_open_sync+0x330/0x203c [bluetooth]
 hci_dev_open_sync [bluetooth] from hci_dev_do_open+0x40/0xb0 [bluetooth]
 hci_dev_do_open [bluetooth] from hci_power_on+0x12c/0x664 [bluetooth]
 hci_power_on [bluetooth] from process_one_work+0x998/0x1a38
 process_one_work from worker_thread+0x6e0/0xfb4
 worker_thread from kthread+0x3d4/0x484
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xd095bfb0 to 0xd095bff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000

My current understanding is that the issue is around atmel_set_termios which
disables interrupts (through uart_port_lock_irqsave), but then calls
mctrl_gpio_disable_ms, which in turn calls disable_irq, which can not be called
in atomic context. It looks like the issue may have been around for quite some
time, but it may have started to appear because of disable_irq having been
marked with might_sleep: see commit 17549b0f184d ("genirq: Add might_sleep() to
disable_irq()") ?

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

