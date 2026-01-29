Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA737FF6A;
	Thu, 29 Jan 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682752; cv=none; b=izYkVHjJ01o9hSC/5lTi+ZBzir5e3W8BoUx/qYGPiSrHqtI9QTeesRp0uljTxOpcvloJeqxa85eErC6izuuS1Fvw/a9TX8TKC4OMad8+5tJYHi6PlLG2XatFYBUqJVO+4U6no+g0bMnQWEpmsy/TN6X8OCUAjC+qoSO/0rPJVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682752; c=relaxed/simple;
	bh=1bQYK8IacfwSNGVK5GuB1+Gp+uYx3am5EW74qsojXX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhVX0xogvijRKXLMtcYk3hOjhC3FedNosN7ONYQyV4HpOdMWwd/barfvj62hqYxm4II9qmUgep3sDFbEV3Vmy9Xv8JGECBZVijLPXqVBqhRgBQezqdoB/VZPaibnmKqYlNhdBjtJrch9iCWgE5FAag6pvwFkls+I2JZWkS5GMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qvg+lEoY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qvg+lEoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=EL
	dN71COLeZk+g0przg5cAdmCR92SeR+RRNaH9kCEGA=; b=Qvg+lEoYbnnxAED+Wu
	vuOkpUJbT7dq3XW5cnlXiWe5af9R6CAVYqHfsSg7M3ucek/oWPnHufmoT3mrjlck
	jLgtmLHu2r1P2Vs+jDZRGVvXMs3KpUROyieWHnP0xPm2gBPbcLGRJnK9OW4mUlO9
	10ZiAT779SA4dNo86rtFFiQKg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnHn8BN3tp+MxUJw--.23801S2;
	Thu, 29 Jan 2026 18:31:30 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: m.szyprowski@samsung.com
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	tommaso.merciai.xr@bp.renesas.com,
	geert@linux-m68k.org
Subject: Re: [PATCH v8] tty: tty_port: add workqueue to flip TTY buffer
Date: Thu, 29 Jan 2026 18:31:29 +0800
Message-Id: <20260129103129.2928955-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d1942304-ee30-478d-90fb-279519f3ae81@samsung.com>
References: <d1942304-ee30-478d-90fb-279519f3ae81@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnHn8BN3tp+MxUJw--.23801S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF45Cr13Jw1Uur4fJrWxCrg_yoW7JrW8pF
	Z8KrWFkF4kJFsFyw42yF17uFyfZay09ay5Krn7J345Zrs09r9Y9r17KrWY9F1UJr4vva45
	t3W0vrWYk3Z0v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRfb1nUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5wIHEWl7NwItCwAA3y

Hi all,
    Sorry for the problems! I didn't consider all the situation.

On Tue, 27 Jan 2026 11:34:32 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> It looks that driver->name is not unique on some systems, see:
> 
> $ git grep ttyMSM drivers/tty/
> drivers/tty/serial/msm_serial.c:        .name = "ttyMSM",
> drivers/tty/serial/msm_serial.c:        .dev_name = "ttyMSM",
> drivers/tty/serial/qcom_geni_serial.c:  .name = "ttyMSM",
> drivers/tty/serial/qcom_geni_serial.c:  .dev_name = "ttyMSM",
> 
> This fails on Qualcomm RB5 boards, breaking the boot process (booting 
> hangs, because drivers try to use the unregistered wq):

I think I should use the name format "%s-%s-flip-wq", ..., driver->name, driver->driver_name
as you suggested, and remove the 'flip-wq' part to avoid exceeding the WQ_NAME_LEN limit.
I checked the lengths of all dev_name + driver_name in all tty/* files, and none exceeded
WQ_NAME_LEN (32).


> The other issue with this patch I've observed on ARM Juno R1 board. With 
> one of the above fixes for the workqueue name, the boot process is still 
> broken because of the NULL pointer dereference:
> 
> input: gpio-keys as /de ** replaying previous printk message ** input: 
> gpio-keys as /devices/platform/gpio-keys/input/input3 Unable to handle 
> kernel NULL pointer dereference at virtual address 00000000000001c0 Mem 
> abort info: ... [00000000000001c0] user address but active_mm is swapper 
> Internal error: Oops: 0000000096000004 [#1] SMP Modules linked in: CPU: 
> 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-rc7-next-20260126+ 
> #16443 PREEMPT Hardware name: ARM Juno development board (r1) (DT) 
> pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--) pc : 
> __queue_work+0x30/0x7c4 lr : queue_work_on+0xac/0xdc ... Call trace: 
> __queue_work+0x30/0x7c4 (P) queue_work_on+0xac/0xdc 
> tty_flip_buffer_push+0x2c/0x38 k_fn.part.0+0x7c/0xc8 k_fn+0x20/0x2c 
> kbd_event+0x2d8/0x504 input_handle_events_default+0x50/0x74 
> input_pass_values+0x148/0x2b4 input_handle_event+0xcc/0x5e0 
> input_event+0x64/0xa4 gpio_keys_open+0x9c/0xc4 
> input_open_device+0x8c/0x128 kbd_connect+0x84/0xa0 
> input_attach_handler+0x9c/0xf4 input_register_device+0x308/0x48c 
> gpio_keys_probe+0x40c/0xafc platform_probe+0x5c/0xac 
> really_probe+0xbc/0x298 __driver_probe_device+0x78/0x12c 
> driver_probe_device+0xdc/0x164 __driver_attach+0xe4/0x224 
> bus_for_each_dev+0x74/0xd0 driver_attach+0x24/0x30 
> bus_add_driver+0xe4/0x208 driver_register+0x60/0x128 
> __platform_driver_register+0x24/0x30 gpio_keys_init+0x1c/0x28 
> do_one_initcall+0x64/0x308 kernel_init_freeable+0x284/0x508 
> kernel_init+0x24/0x1dc ret_from_fork+0x10/0x20 Code: a9025bf5 a90573fb 
> aa0203fb 35001843 (b941c260) ---[ end trace 0000000000000000 ]--- note: 
> swapper/0[1] exited with irqs disabled note: swapper/0[1] exited with 
> preempt_count 3 Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b SMP: stopping secondary CPUs Kernel Offset: disabled 
> CPU features: 0x1040000,41858004,00020000,0400421b Memory Limit: none 
> ---[ end Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b ]---
> 
> Reverting $subject on top of current linux-next fixes this issue.

Thank you very much for your detailed stack; it has been very helpful to me.
I followed the call stack in detail and found that the line in kbd_keycode(),
(*k_handler[type])(vc, KVAL(keysym), !down);
calls k_fn(), which ultimately calls tty_flip_buffer_push().

In kbd_keycode(), vc is set as follows:
struct vc_data *vc = vc_cons[fg_console].d;
fg_console is set to 0 in con_init().

con_init() calls tty_port_init() to init vc_cons[0].d->port but do not call
tty_port_install() which link flip_wq to the port.

Although tty_port_install() is dedicated for in-memory devices like PTY to
link port allocated on demand, the logic of tty_port_install() is so simple
that people may not call it. vc_cons[0].d->port is one such case.
On the other hand, not all instances during tty_port_init() have easy access
to the corresponding driver pointer, which makes it inconvenient to directly
link flip_wq during all tty_port_init calls. Below are some other code that
I found, which may not link wq, potentially leading to flip_wq being null:

drivers/s390/char/sclp_vt220.c:
    sclp_vt220_con_init
        __sclp_vt220_init
            tty_port_init
drivers/tty/n_gsm.c
    gsm_queue
        gsm_dlci_alloc
            tty_port_init
drivers/tty/vcc.c
    vcc_install
        tty_port_init
drivers/usb/serial/usb-serial.c
    usb_serial_probe
        tty_port_init

Maybe in tty_flip_buffer_push() 'checking whether flip_wq is NULL and use
system_dfl_wq instead if it is NULL' is a better choice. 

--
Xin Zhao

