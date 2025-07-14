Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF81DD0C7;
	Mon, 14 Jul 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490369; cv=none; b=glktZQhF4e+9oZ5c8TlIM/WBZASZ7H2ham1xvt+H5HrT/kUBWSV7lRNt/tpFVDUnZvUMA2cgoMXI/5+gvvTHVJMs3ttd2t5jmHtTlCvr+BLtceZ/vVCgtPGKc1mi/ygrg3seijaS/PXZZ7UkhPQWaoe4TEK2sdyaALKJQspMwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490369; c=relaxed/simple;
	bh=8XPSpfcnpA5YhqSdHS4f5gHFRWQZ1wZOSNp8AjlFrcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uId4sFbLAEm6rLK7zXUi9LUa2ZTb0FjyOB5PYgquQtfZXdHRThcmV3xIVj88j0jUOOCygZnFh3TDvEydAt8zH/YhusCpvMM5sEpds0s7RJ2ecth3gk7xfDe+dHs0yM88wVJRh7BYhzg/xYT+DRQkGrK0kIkhUCH8kLtLCk5QbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687071BC0;
	Mon, 14 Jul 2025 03:52:36 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6DE3F694;
	Mon, 14 Jul 2025 03:52:45 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:52:43 +0100
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, ankita@nvidia.com,
	bwicaksono@nvidia.com, rmk+kernel@armlinux.org.uk,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <20250714105243.GD1093654@e132581.arm.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
 <aGawTd8N2i8MDCmL@J2N7QTR9R3>
 <aG0kYjl/sphGqd4r@gmail.com>
 <juiog3337iozva23zpf4apdydegj4z7jibqykfvcgnkabemw4w@z5g5hhwrqr2w>
 <20250710133557.GA1093654@e132581.arm.com>
 <jlhgtwkeezoca34wbqipvsgr4muxov5wmgrswleo2k7zqitzfr@4ngriyb2udra>
 <20250711095023.GB1093654@e132581.arm.com>
 <cno3lsprrz36gqu27omvwrw27d2ubqtshac3cahfgkhcm2rla7@bpnulcmsyx2u>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cno3lsprrz36gqu27omvwrw27d2ubqtshac3cahfgkhcm2rla7@bpnulcmsyx2u>

On Fri, Jul 11, 2025 at 03:45:03AM -0700, Breno Leitao wrote:
> On Fri, Jul 11, 2025 at 10:50:23AM +0100, Leo Yan wrote:
> > > I've reverted commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
> > > console"), and I don't see the CSD locks anymoer. The serial speed is
> > > the same and continue to be slow, but, the CSD lock is not there. Here
> > > is the time spent on the serial flush when reverting the commit above
> > > 
> > > 	[    0.309561] printk: legacy console [ttyAMA0] enabled
> > > 	[    8.657938] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])
> > 
> > From this result, we can know both the atomic path and the thread path
> > take a long time polling.
>
> I am wondering if this slowdown is by design, or, if there is a bug
> somewhere.

Polling for over 5 seconds (5,001,000,000 ns) seems too long; it
should not be by design.

> > Since both paths configure the UART clock, I'm curious about the
> > behaviour if the UART clock is untouched. The relevant code is shown
> > below.
> 
> Is this the clock frequency that is connected to pl011 coming from AMBA?

The programming clock is for programming registers, my understanding is
the clock is not provided by bus.

> > I may seem a bit stubborn in suspecting a clock issue :) But if you
> > have confirmed that a standard pl011 UART IP is being used.
> 
> How do I double check this is a pl011 UART IP or if this is being
> emulated by firmware/ACPI.

The log shows:

  ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA

This should be emulated by firmware by reading Peripheral Identification
Registers (see [1]).

The most reliable way is to confirm with SoC vendor if the IP is
standard or includes any modification.

[1] https://developer.arm.com/documentation/ddi0183/g/programmers-model/register-descriptions/peripheral-identification-registers--uartperiphid0-3

> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 71482d639a6d..b04773ba2602 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> >
> I've tested it, but, it seems it didnt' help much. here is the full log

[...]

> [    0.307809] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
> [    0.307816] printk: console [ttyAMA0] enabled

Based on this log and followed OOPS, the issue happens just after
enabling console. It is a bit tricky that it prints logs during
console registration (and configuration).

Seems to me, it is good to check pl011_console_setup() or
sbsa_uart_set_termios() has any impaction on the long waiting. For
example, the flow below will configure pin control and which might
impact the data transaction:

  pl011_console_setup()
   `> pinctrl_pm_select_default_state()

Based on the information shared earlier, the UART FIFO appears to be
stalled, which is causing the long wait times.

Apologies if my suggestion was unreliable or misled anything, and
welcome others to freely correct me.

Thanks,
Leo

> [    5.414515] smp: csd: Detected non-responsive CSD lock (#1) on CPU#0, waiting 5001000000 ns for CPU#01 do_nothing+0x0/0x10(0x0).
> [    5.414532] smp: 	csd: CSD lock (#1) unresponsive.
> [    5.414535] Sending NMI from CPU 0 to CPUs 1:
> [    5.414541] NMI backtrace for cpu 1
> [    5.414545] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc5-00056-gd7753fd13f9e #86 NONE 
> [    5.414548] Hardware name: Quanta JAVA ISLAND PVT 29F0EMAZ049/Java Island, BIOS F0EJ3A13 06/04/2025
> [    5.414550] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    5.414552] pc : pl011_console_write_atomic+0x94/0x170
> [    5.414559] lr : pl011_console_write_atomic+0x84/0x170
> [    5.414562] sp : ffff80008492f1a0
> [    5.414564] pmr: 000000c0
> [    5.414565] x29: ffff80008492f1a0 x28: 0000000000000000 x27: 00000000000000e0
> [    5.414572] x26: 0000000000000190 x25: 0000000000000000 x24: 0000000000000000
> [    5.414578] x23: 0000000000000001 x22: 0000000000000000 x21: ffff800080c38ea8
> [    5.414584] x20: ffff80008492f288 x19: ffff0000b2060080 x18: 00000000ffffffff
> [    5.414590] x17: 6362323230303030 x16: 3030303078303a30 x15: 206e6f6967657220
> [    5.414595] x14: 3030303064322072 x13: 3030303063623232 x12: 3030303030303030
> [    5.414601] x11: 78303a30206e6f69 x10: 6765722030303030 x9 : ffff800080c390e4
> [    5.414607] x8 : 6964657220646e75 x7 : 205d313533383630 x6 : 302e30202020205b
> [    5.414612] x5 : ffff0000ad10200f x4 : 0000000000000000 x3 : 0000000000000008
> [    5.414618] x2 : ffff8000816336c0 x1 : 0000000000000018 x0 : 0000000000000018
> [    5.414624] Call trace:
> [    5.414626]  pl011_console_write_atomic+0x94/0x170 (P)
> [    5.414630]  nbcon_emit_next_record+0x234/0x388
> [    5.414634]  __nbcon_atomic_flush_pending_con+0x88/0x108
> [    5.414637]  __nbcon_atomic_flush_pending+0x108/0x198
> [    5.414640]  nbcon_atomic_flush_pending+0x24/0x38
> [    5.414643]  vprintk_emit+0x200/0x348
> [    5.414645]  vprintk_default+0x3c/0x50
> [    5.414647]  vprintk+0x2c/0x40
> [    5.414650]  _printk+0x50/0x60
> [    5.414652]  register_console+0x424/0x560
> [    5.414654]  serial_core_register_port+0x878/0x898
> [    5.414659]  serial_ctrl_register_port+0x14/0x28
> [    5.414661]  uart_add_one_port+0x14/0x28
> [    5.414664]  pl011_register_port+0x74/0x130
> [    5.414667]  sbsa_uart_probe+0x164/0x1b8
> [    5.414670]  platform_probe+0x8c/0x100
> [    5.414674]  really_probe+0xc4/0x398
> [    5.414676]  __driver_probe_device+0x80/0x1a8
> [    5.414679]  driver_probe_device+0x44/0x120
> [    5.414681]  __device_attach_driver+0xb8/0x158
> [    5.414683]  bus_for_each_drv+0x74/0xc0
> [    5.414685]  __device_attach+0xac/0x1e0
> [    5.414687]  device_initial_probe+0x18/0x28
> [    5.414690]  bus_probe_device+0xa8/0xb8
> [    5.414692]  device_add+0x648/0x830
> [    5.414697]  platform_device_add+0x114/0x280
> [    5.414700]  platform_device_register_full+0x148/0x1b8
> [    5.414702]  acpi_create_platform_device+0x264/0x388
> [    5.414706]  acpi_bus_attach+0x2c8/0x2e8
> [    5.414709]  acpi_dev_for_one_check+0x38/0x48
> [    5.414711]  device_for_each_child+0x54/0xa0
> [    5.414714]  acpi_dev_for_each_child+0x30/0x40
> [    5.414716]  acpi_bus_attach+0x6c/0x2e8
> [    5.414718]  acpi_dev_for_one_check+0x38/0x48
> [    5.414720]  device_for_each_child+0x54/0xa0
> [    5.414723]  acpi_dev_for_each_child+0x30/0x40
> [    5.414725]  acpi_bus_attach+0x6c/0x2e8
> [    5.414727]  acpi_bus_scan+0x5c/0x1b0
> [    5.414730]  acpi_scan_init+0xa0/0x288
> [    5.414737]  acpi_init+0x1e8/0x4b8
> [    5.414740]  do_one_initcall+0x3c/0x2a0
> [    5.414743]  kernel_init_freeable+0x22c/0x460
> [    5.414746]  kernel_init+0x28/0x1f0
> [    5.414750]  ret_from_fork+0x10/0x20
