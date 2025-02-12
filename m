Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E21FBEA6
	for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342044; cv=none; b=ALyPYv3IytpTzzuMtrEeYMwWHrRzB17z06vvbXw6KgOMgPyMGM0RdETcCKzgsahDhuzDEMjn08uZbGUV/BPGlqfwbxk5lCps6dOTVMbPNRFOmpBpOSOuvQWfO4nMRaIx1veI2VGjXYdIRyfGziuKWbqqhqVK9iAvstntWGkGjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342044; c=relaxed/simple;
	bh=eMwgHmb81n4uXICCj+ClqeeqBFQiecNpoFPZi1wlS0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLgrG5ZDgvIGIs9UwTzzWl7YPC49IYKTzVsOgJDvPMXbjsMIjynt0CTT5OQ1n7Q8j6p9lL42gH2SJHMVZjBeD+7vuScOmCFZy4huLrfSkdQTXvmKbErDL89GUkMhPXBCD3r8lxPdPVjjNtizAftbNACefyMzYFfJVz4hFxNGoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgqyNJKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgqyNJKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A401BC4CEDF;
	Wed, 12 Feb 2025 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739342043;
	bh=eMwgHmb81n4uXICCj+ClqeeqBFQiecNpoFPZi1wlS0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HgqyNJKD7WBTFwFMxeUkU9kuE7VZ7pNwyaEIo4rTVg8847Wdae5bHJLHoq+u44g03
	 WuQ7bO1KRkzwqaYeZShoG4ADnZUXipeTSTDi+MuWyQt6e7ghoqWRZieevSJ9TOLaK1
	 GQyYDuiTs5WvWXHgEPkBxzZiTrG+Aw3OsYq3tdlDRommFfyloUrROowW69XRYlME4T
	 8qmqp+bxJKHO5ayvTzgcI6YfC2PuOmJFHPHzN06tnPljMnUohzfwKQGqiipAh4hBAk
	 tEtE2JIeeueuxCmtZRPxk3zrsuZ87B/iXGfg+LiIqWoqshU8z13DSdzqsx+hxHVbMU
	 4EY25hGIRuNYA==
Message-ID: <1eb0cd31-4d29-4b87-b19f-7e245787bfbd@kernel.org>
Date: Wed, 12 Feb 2025 07:34:00 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Splat: sleep in atomic section in atmel_serial
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-serial@vger.kernel.org
Cc: Richard Genoud <richard.genoud@bootlin.com>,
 Nicolas Ferre <Nicolas.Ferre@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <kernel@pengutronix.de>
References: <3d227ebe-1ee6-4d57-b1ec-78be59af7244@bootlin.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <3d227ebe-1ee6-4d57-b1ec-78be59af7244@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11. 02. 25, 19:09, Alexis Lothoré wrote:
> Hello,
> 
> I am currently working on a device driver for a serial device, on a setup
> involving one of the standard UART from SAMA5D27 (not the flexcom one), as well
> as two additional gpios for flow control (CTS/RTS). I can reliably reproduce a
> splat when trying to enable/disable flow control on the target uart (through
> serdev_device_set_flow_control). I am basing my work on top of the current
> wireless-next tree:
> 
> BUG: sleeping function called from invalid context at kernel/irq/manage.c:738
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 27, name: kworker/u5:0
> preempt_count: 1, expected: 0
> INFO: lockdep is turned off.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<00000000>] 0x0
> hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
> softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
> softirqs last disabled at (0): [<00000000>] 0x0
> CPU: 0 UID: 0 PID: 27 Comm: kworker/u5:0 Not tainted 6.13.0-rc7+ #74
> Hardware name: Atmel SAMA5
> Workqueue: hci0 hci_power_on [bluetooth]
> Call trace:
>   unwind_backtrace from show_stack+0x18/0x1c
>   show_stack from dump_stack_lvl+0x44/0x70
>   dump_stack_lvl from __might_resched+0x38c/0x598
>   __might_resched from disable_irq+0x1c/0x48
>   disable_irq from mctrl_gpio_disable_ms+0x74/0xc0
>   mctrl_gpio_disable_ms from atmel_disable_ms.part.0+0x80/0x1f4
>   atmel_disable_ms.part.0 from atmel_set_termios+0x764/0x11e8
>   atmel_set_termios from uart_change_line_settings+0x15c/0x994
>   uart_change_line_settings from uart_set_termios+0x2b0/0x668
>   uart_set_termios from tty_set_termios+0x600/0x8ec
>   tty_set_termios from ttyport_set_flow_control+0x188/0x1e0
>   ttyport_set_flow_control from wilc_setup+0xd0/0x524 [hci_wilc]
>   wilc_setup [hci_wilc] from hci_dev_open_sync+0x330/0x203c [bluetooth]
>   hci_dev_open_sync [bluetooth] from hci_dev_do_open+0x40/0xb0 [bluetooth]
>   hci_dev_do_open [bluetooth] from hci_power_on+0x12c/0x664 [bluetooth]
>   hci_power_on [bluetooth] from process_one_work+0x998/0x1a38
>   process_one_work from worker_thread+0x6e0/0xfb4
>   worker_thread from kthread+0x3d4/0x484
>   kthread from ret_from_fork+0x14/0x28
> Exception stack(0xd095bfb0 to 0xd095bff8)
> bfa0:                                     00000000 00000000 00000000 00000000
> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> My current understanding is that the issue is around atmel_set_termios which
> disables interrupts (through uart_port_lock_irqsave), but then calls
> mctrl_gpio_disable_ms, which in turn calls disable_irq, which can not be called
> in atomic context. It looks like the issue may have been around for quite some
> time, but it may have started to appear because of disable_irq having been
> marked with might_sleep: see commit 17549b0f184d ("genirq: Add might_sleep() to
> disable_irq()") ?

We likely want to introduce 'bool sync' param to 
mctrl_gpio_disable_ms(). It would call disable_irq() or 
disable_irq_nosync() appropriately. As for example, imx_uart_shutdown() 
wants to sync, but serial8250_disable_ms() and atmel_disable_ms() do not.

But I am no expert in this mctrl land.

thanks,
-- 
js
suse labs
