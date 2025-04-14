Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706D2989AE;
	Mon, 14 Apr 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630923; cv=none; b=R860lVV9Yso8HontstztW7zwSnBjrfTjDb3LdZhgsT1VeHDL+E/bM1xgSxyOXGsamw+5VXB6Bn3OqGA8gQ+eCvFSUoqPUuySXa85azfhmPEa08B8Fuz6AViHyhTKCS5KronwrUsiLLvwl4P6jLczBPNtMrXjP7BMf5gS+5hoG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630923; c=relaxed/simple;
	bh=9DhbCem6qHUdFZLjbIL3JSEZGBo3RveYvhFclEzv8Pc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E2SzUbS8U3u32WwILZCeOVO2bLdkk58YTGa0c7xZ7Skday8w069SthRKQsYZ1jSGsWJJfUNvCjgbB1whAgNQsS4SfuZZP9brbiFHzLfOlun5bBctKH5N2IeiN2jAIToyR8sabtEElI/yiXdY6YW/F88hXGIaAGZ3ial7MmccQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTTNh+C1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTTNh+C1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744630921; x=1776166921;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9DhbCem6qHUdFZLjbIL3JSEZGBo3RveYvhFclEzv8Pc=;
  b=gTTNh+C1la16KxuWvrJdbJRWgmyF7yClN9wDncoa54dWJwWmA0oBV+tc
   aSJJzwLYc0/1SQ8CxGCg7YWxOh/PF2yi1sTDlT3uCTuc2iBbk5M4yi3D/
   Dlw0SKI11BFq1mxF/Uvgo2mExh8UvF21d1a9N2Q6NspDw+GXXkCn/HufF
   zGI7Khvd+Qx5jvg95R09FcPOgNVpeHzgLDiO+J5ONCnGhtk8+e+ohafNS
   oK2Zpgz5WQ4cBJbsy33qcsxqHhbbFZH/6Ag/xBNCQmm3gaStz2MiEG2Wc
   uXlOhJe+ZClTiBqBhnUV5+WcOBs6hBBlan/aJLnsGy8Sh+LhUFLIDN0G8
   Q==;
X-CSE-ConnectionGUID: UkZ6OB1yQJSHA3i8vY9toA==
X-CSE-MsgGUID: kAUzHh4LRQi5xKzLMvchrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46184582"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208,223";a="46184582"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 04:41:59 -0700
X-CSE-ConnectionGUID: MK1sxc1NRuScLDD7KS7oxA==
X-CSE-MsgGUID: xqbiNfyvS1SFW3CSpxue8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208,223";a="134635533"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 04:41:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Apr 2025 14:41:51 +0300 (EEST)
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, john.ogness@linutronix.de, 
    pmladek@suse.com, arnd@arndb.de, namcao@linutronix.de, 
    benjamin.larsson@genexis.eu, schnelle@linux.ibm.com, 
    heikki.krogerus@linux.intel.com, markus.mayer@linaro.org, 
    tim.kryger@linaro.org, matt.porter@linaro.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3] serial: 8250: fix panic due to PSLVERR
In-Reply-To: <20250414031450.42237-1-cuiyunhui@bytedance.com>
Message-ID: <079c8fe6-9ce4-fa59-4b44-93e27dd376d6@linux.intel.com>
References: <20250414031450.42237-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1672980820-1744630364=:10563"
Content-ID: <d4af13d4-6b75-913c-e1b1-d910337ddb45@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1672980820-1744630364=:10563
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <08433a8d-047b-5658-9e9d-8037baa7338e@linux.intel.com>

On Mon, 14 Apr 2025, Yunhui Cui wrote:

> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
> 
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the dont_test_tx_en label:
> ...
> serial_port_in(port, UART_RX);
> This satisfies the PSLVERR trigger condition.
> 
> Because another CPU(e.g., using printk()) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> 
> To fix this, all calls to serial_out(UART_LCR) and serial_in(UART_RX)
> should be executed under port->lock. Additionally, checking the readiness
> via UART_LSR should also be done under port->lock.
> 
> Panic backtrace:
> [    0.442336] Oops - unknown exception [#1]
> [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> ...
> [    0.442416] console_on_rootfs+0x26/0x70
> 
> Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
> Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

As Andy mentioned, this change looks it would benefit from splitting to 
multiple parts.

However, this change brings back some memories from a few years back.
Back then, there was a reporter who had issues issues related to 
dw8250_force_idle() or writing some of the registers (IIRC). I ended up 
looking into finding a better solution to the write-while-BUSY problem 
which entirely replaced dw8250_force_idle() that is quite hacky and seems 
unreliable on fundamendal level.

Sadly, once I had posted a patch for testing, the reporter went dead 
silent so the patch was left rotting as I had no time to try to reproduce.

Perhaps the patch I created back then would be useful for addressing this 
problem you're facing (the patch is attached). I've rebased the patch on 
top of the tty-next now (but I did no testing beyond compiling). There are 
a few further thoughts / missing bits mentioned in the comments within the 
patch itself (I did not try to updated them now, so the comments may have 
rotten too).

> ---
>  drivers/tty/serial/8250/8250_dw.c   |  8 +++++
>  drivers/tty/serial/8250/8250_port.c | 46 ++++++++++++++++++-----------
>  2 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index af24ec25d976..e97200ff30e3 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/lockdep.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> @@ -112,6 +113,13 @@ static void dw8250_force_idle(struct uart_port *p)
>  	struct uart_8250_port *up = up_to_u8250p(p);
>  	unsigned int lsr;
>  
> +	/*
> +	 * Serial_in(p, UART_RX) should be under port->lock, but we can't add
> +	 * it to avoid AA deadlock as we're unsure if serial_out*(...UART_LCR)
> +	 * is under port->lock.
> +	 */
> +	lockdep_assert_held_once(&p->lock);
> +
>  	serial8250_clear_and_reinit_fifos(up);
>  
>  	/*
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3f256e96c722..21bbd18195f5 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1328,6 +1328,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  	unsigned int ICP = 0;
>  	unsigned long irqs;
>  	int irq;
> +	u16 lsr;
>  
>  	if (port->flags & UPF_FOURPORT) {
>  		ICP = (port->iobase & 0xfe0) | 0x1f;
> @@ -1357,9 +1358,10 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  	/* Synchronize UART_IER access against the console. */
>  	uart_port_lock_irq(port);
>  	serial_out(up, UART_IER, UART_IER_ALL_INTR);
> +	lsr = serial_in(up, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
>  	uart_port_unlock_irq(port);
> -	serial_in(up, UART_LSR);
> -	serial_in(up, UART_RX);
>  	serial_in(up, UART_IIR);
>  	serial_in(up, UART_MSR);
>  	serial_out(up, UART_TX, 0xFF);
> @@ -2137,19 +2139,16 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>  static int serial8250_get_poll_char(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> -	int status;
> +	int status = NO_POLL_CHAR;
>  	u16 lsr;
>  
>  	serial8250_rpm_get(up);
>  
> +	uart_port_lock_irqsave(port, &flags);
>  	lsr = serial_port_in(port, UART_LSR);
> -
> -	if (!(lsr & UART_LSR_DR)) {
> -		status = NO_POLL_CHAR;
> -		goto out;
> -	}
> -
> -	status = serial_port_in(port, UART_RX);
> +	if ((lsr & UART_LSR_DR))
> +		status = serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
>  out:
>  	serial8250_rpm_put(up);
>  	return status;
> @@ -2264,13 +2263,16 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
>  	 */
> +	uart_port_lock_irqsave(port, &flags);
>  	serial8250_clear_fifos(up);
>  
>  	/*
>  	 * Clear the interrupt registers.
>  	 */
> -	serial_port_in(port, UART_LSR);
> -	serial_port_in(port, UART_RX);
> +	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
>  
> @@ -2380,9 +2382,10 @@ int serial8250_do_startup(struct uart_port *port)
>  	/*
>  	 * Now, initialize the UART
>  	 */
> -	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
>  
>  	uart_port_lock_irqsave(port, &flags);
> +	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +
>  	if (up->port.flags & UPF_FOURPORT) {
>  		if (!up->port.irq)
>  			up->port.mctrl |= TIOCM_OUT1;
> @@ -2428,15 +2431,16 @@ int serial8250_do_startup(struct uart_port *port)
>  	}
>  
>  dont_test_tx_en:

I don't see this in the tty-next branch?

~/linux/tty-next$ git grep dont_test_tx_en | cat -
~/linux/tty-next$ 

-- 
 i.

> -	uart_port_unlock_irqrestore(port, flags);
>  
>  	/*
>  	 * Clear the interrupt registers again for luck, and clear the
>  	 * saved flags to avoid getting false values from polling
>  	 * routines or the previous session.
>  	 */
> -	serial_port_in(port, UART_LSR);
> -	serial_port_in(port, UART_RX);
> +	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
>  	up->lsr_saved_flags = 0;
> @@ -2492,6 +2496,7 @@ void serial8250_do_shutdown(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned long flags;
> +	u16 lsr;
>  
>  	serial8250_rpm_get(up);
>  	/*
> @@ -2518,7 +2523,6 @@ void serial8250_do_shutdown(struct uart_port *port)
>  		port->mctrl &= ~TIOCM_OUT2;
>  
>  	serial8250_set_mctrl(port, port->mctrl);
> -	uart_port_unlock_irqrestore(port, flags);
>  
>  	/*
>  	 * Disable break condition and FIFOs
> @@ -2526,6 +2530,7 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	serial_port_out(port, UART_LCR,
>  			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
>  	serial8250_clear_fifos(up);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  #ifdef CONFIG_SERIAL_8250_RSA
>  	/*
> @@ -2538,7 +2543,12 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	 * Read data port to reset things, and then unlink from
>  	 * the IRQ chain.
>  	 */
> -	serial_port_in(port, UART_RX);
> +	uart_port_lock_irqsave(port, &flags);
> +	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
> +
>  	serial8250_rpm_put(up);
>  
>  	up->ops->release_irq(up);
> 
--8323328-1672980820-1744630364=:10563
Content-Type: text/x-diff; NAME=0001-serial-8250_dw-Ensure-BUSY-is-deasserted.patch
Content-Transfer-Encoding: BASE64
Content-ID: <62bdd06c-209d-2f82-a4cb-118b67f585c1@linux.intel.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=0001-serial-8250_dw-Ensure-BUSY-is-deasserted.patch

RnJvbSAxMDIzNzY0MGIxNWFkYTMxM2MzYWMzMDIxZDdjYzlhZWI3NzRkNWM2
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogPT9VVEYtOD9xP0ls
cG89MjBKPUMzPUE0cnZpbmVuPz0gPGlscG8uamFydmluZW5AbGludXguaW50
ZWwuY29tPg0KRGF0ZTogTW9uLCAxNCBBcHIgMjAyNSAxNDoyMzozNiArMDMw
MA0KU3ViamVjdDogW1BBVENIIDEvMV0gc2VyaWFsOiA4MjUwX2R3OiBFbnN1
cmUgQlVTWSBpcyBkZWFzc2VydGVkDQpNSU1FLVZlcnNpb246IDEuMA0KQ29u
dGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04DQpDb250ZW50
LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0DQoNCkRXIFVBUlQgY2Fubm90IHdy
aXRlIHRvIExDUiwgRExMLCBhbmQgRExIIHdoaWxlIEJVU1kgaXMgYXNzZXJ0
ZWQuDQpFeGlzdGFuY2Ugb2YgQlVTWSBkZXBlbmRzIG9uIHVhcnRfMTY1NTBf
Y29tcGF0aWJsZSwgaWYgVUFSVCBIVyBpcw0KY29uZmlndXJlZCB3aXRoIDE2
NTUwIGNvbXBhdGlibGUgdGhvc2UgcmVnaXN0ZXJzIGNhbiBhbHdheXMgYmUN
CndyaXR0ZW4uDQoNClRoZXJlIGN1cnJlbnRseSBpcyBkdzgyNTBfZm9yY2Vf
aWRsZSgpIHdoaWNoIGF0dGVtcHRzIHRvIGFyY2hpdmUNCm5vbi1CVVNZIHN0
YXRlIGJ5IGRpc2FibGluZyBGSUZPLCBob3dldmVyLCB0aGUgc29sdXRpb24g
aXMgdW5yZWxpYWJsZQ0Kd2hlbiBSeCBrZWVwcyBnZXR0aW5nIG1vcmUgYW5k
IG1vcmUgY2hhcmFjdGVycy4NCg0KQ3JlYXRlIGEgc2VxdWVuY2Ugb2Ygb3Bl
cmF0aW9ucyB0aGF0IGVuc3VyZXMgVUFSVCBjYW5ub3Qga2VlcCBCVVNZDQph
c3NlcnRlZCBpbmRlZmluaXRlbHkuIFRoZSBuZXcgc2VxdWVuY2UgcmVsaWVz
IG9uIGVuYWJsaW5nIGxvb3BiYWNrDQptb2RlIHRlbXBvcmFyaWx5IHRvIHBy
ZXZlbnQgaW5jb21pbmcgUnggY2hhcmFjdGVycyBrZWVwaW5nIFVBUlQgQlVT
WS4NCg0KVXNlIHRoZSBuZXcgZHc4MjUwX2lkbGVfZW50ZXIvZXhpdCgpIHRv
IGRvIGRpdmlzb3Igd3JpdGVzIGFuZCBMQ1INCndyaXRlcy4NCg0KVGhpcyBp
c3N1ZSB3YXMgcmVwb3J0ZWQgYnkgcWlhbmZhbiBaaGFvIHdobyBwdXQgbG90
cyBvZiBkZWJ1Z2dpbmcNCmVmZm9ydCBpbnRvIHVuZGVyc3RhbmRpbmcgdGhl
IHNvbHV0aW9uIHNwYWNlLg0KDQpSZXBvcnRlZC1ieTogcWlhbmZhbiBaaGFv
IDxxaWFuZmFuZ3VpamluQDE2My5jb20+DQpTaWduZWQtb2ZmLWJ5OiBJbHBv
IErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQot
LS0NCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2R3LmMgfCAxNDkg
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDEwMyBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHcuYyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHcuYw0KaW5kZXggMTkw
MmYyOTQ0NGExLi44YTlkZmZjODVmZTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX2R3LmMNCisrKyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC84MjUwLzgyNTBfZHcuYw0KQEAgLTQyLDYgKzQyLDggQEANCiAv
KiBEZXNpZ25XYXJlIHNwZWNpZmljIHJlZ2lzdGVyIGZpZWxkcyAqLw0KICNk
ZWZpbmUgRFdfVUFSVF9NQ1JfU0lSRQkJQklUKDYpDQogDQorI2RlZmluZSBE
V19VQVJUX1VTUl9CVVNZCQlCSVQoMCkNCisNCiAvKiBSZW5lc2FzIHNwZWNp
ZmljIHJlZ2lzdGVyIGZpZWxkcyAqLw0KICNkZWZpbmUgUlpOMV9VQVJUX3hE
TUFDUl9ETUFfRU4JCUJJVCgwKQ0KICNkZWZpbmUgUlpOMV9VQVJUX3hETUFD
Ul8xX1dPUkRfQlVSU1QJKDAgPDwgMSkNCkBAIC03Nyw2ICs3OSw3IEBAIHN0
cnVjdCBkdzgyNTBfZGF0YSB7DQogDQogCXVuc2lnbmVkIGludAkJc2tpcF9h
dXRvY2ZnOjE7DQogCXVuc2lnbmVkIGludAkJdWFydF8xNjU1MF9jb21wYXRp
YmxlOjE7DQorCXVuc2lnbmVkIGludAkJaW5faWRsZToxOw0KIH07DQogDQog
c3RhdGljIGlubGluZSBzdHJ1Y3QgZHc4MjUwX2RhdGEgKnRvX2R3ODI1MF9k
YXRhKHN0cnVjdCBkdzgyNTBfcG9ydF9kYXRhICpkYXRhKQ0KQEAgLTEwOCwz
NiArMTExLDg5IEBAIHN0YXRpYyBpbmxpbmUgaW50IGR3ODI1MF9tb2RpZnlf
bXNyKHN0cnVjdCB1YXJ0X3BvcnQgKnAsIGludCBvZmZzZXQsIGludCB2YWx1
ZSkNCiB9DQogDQogLyoNCi0gKiBUaGlzIGZ1bmN0aW9uIGlzIGJlaW5nIGNh
bGxlZCBhcyBwYXJ0IG9mIHRoZSB1YXJ0X3BvcnQ6OnNlcmlhbF9vdXQoKQ0K
LSAqIHJvdXRpbmUuIEhlbmNlLCBpdCBtdXN0IG5vdCBjYWxsIHNlcmlhbF9w
b3J0X291dCgpIG9yIHNlcmlhbF9vdXQoKQ0KLSAqIGFnYWluc3QgdGhlIG1v
ZGlmaWVkIHJlZ2lzdGVycyBoZXJlLCBpLmUuIExDUi4NCisgKiBFbnN1cmUg
QlVTWSBpcyBub3QgYXNzZXJ0ZWQuIElmIERXIFVBUlQgaXMgY29uZmlndXJl
ZCB3aXRoDQorICogIXVhcnRfMTY1NTBfY29tcGF0aWJsZSwgdGhlIHdyaXRl
cyB0byBMQ1IsIERMTCwgYW5kIERMSCBmYWlsIHdoaWxlDQorICogQlVTWSBp
cyBhc3NlcnRlZC4NCisgKg0KKyAqIENvbnRleHQ6IHBvcnQncyBsb2NrIG11
c3QgYmUgaGVsZA0KICAqLw0KLXN0YXRpYyB2b2lkIGR3ODI1MF9mb3JjZV9p
ZGxlKHN0cnVjdCB1YXJ0X3BvcnQgKnApDQorc3RhdGljIGludCBkdzgyNTBf
aWRsZV9lbnRlcihzdHJ1Y3QgdWFydF9wb3J0ICpwKQ0KIHsNCisJc3RydWN0
IGR3ODI1MF9kYXRhICpkID0gdG9fZHc4MjUwX2RhdGEocC0+cHJpdmF0ZV9k
YXRhKTsNCiAJc3RydWN0IHVhcnRfODI1MF9wb3J0ICp1cCA9IHVwX3RvX3U4
MjUwcChwKTsNCi0JdW5zaWduZWQgaW50IGxzcjsNCisJdTMyIGxzcjsNCiAN
Ci0JLyoNCi0JICogVGhlIGZvbGxvd2luZyBjYWxsIGN1cnJlbnRseSBwZXJm
b3JtcyBzZXJpYWxfb3V0KCkNCi0JICogYWdhaW5zdCB0aGUgRkNSIHJlZ2lz
dGVyLiBCZWNhdXNlIGl0IGRpZmZlcnMgdG8gTENSDQotCSAqIHRoZXJlIHdp
bGwgYmUgbm8gaW5maW5pdGUgbG9vcCwgYnV0IGlmIGl0IGV2ZXIgZ2V0cw0K
LQkgKiBtb2RpZmllZCwgd2UgbWlnaHQgbmVlZCBhIG5ldyBjdXN0b20gdmVy
c2lvbiBvZiBpdA0KLQkgKiB0aGF0IGF2b2lkcyBpbmZpbml0ZSByZWN1cnNp
b24uDQotCSAqLw0KLQlzZXJpYWw4MjUwX2NsZWFyX2FuZF9yZWluaXRfZmlm
b3ModXApOw0KKwlpZiAoZC0+dWFydF8xNjU1MF9jb21wYXRpYmxlKQ0KKwkJ
cmV0dXJuIDA7DQogDQotCS8qDQotCSAqIFdpdGggUFNMVkVSUl9SRVNQX0VO
IHBhcmFtZXRlciBzZXQgdG8gMSwgdGhlIGRldmljZSBnZW5lcmF0ZXMgYW4N
Ci0JICogZXJyb3IgcmVzcG9uc2Ugd2hlbiBhbiBhdHRlbXB0IHRvIHJlYWQg
YW4gZW1wdHkgUkJSIHdpdGggRklGTw0KLQkgKiBlbmFibGVkLg0KLQkgKi8N
Ci0JaWYgKHVwLT5mY3IgJiBVQVJUX0ZDUl9FTkFCTEVfRklGTykgew0KLQkJ
bHNyID0gc2VyaWFsX3BvcnRfaW4ocCwgVUFSVF9MU1IpOw0KLQkJaWYgKCEo
bHNyICYgVUFSVF9MU1JfRFIpKQ0KLQkJCXJldHVybjsNCisJZC0+aW5faWRs
ZSA9IDE7DQorDQorCS8qIFByZXZlbnQgdHJpZ2dlcmluZyBpbnRlcnJ1cHQg
ZnJvbSBSQlIgZmlsbGluZyAqLw0KKwlwLT5zZXJpYWxfb3V0KHAsIFVBUlRf
SUVSLCAwKTsNCisNCisJc2VyaWFsODI1MF9yeF9kbWFfZmx1c2godXApOw0K
KwkvLyBXaGF0IGFib3V0IFR4IERNQT8gU2hvdWxkIHByb2JhYmx5IHBhdXNl
IHRoYXQgdG9vIGFuZCByZXN1bWUNCisJLy8gYWZ0ZXJ3YXJkcy4NCisNCisJ
cC0+c2VyaWFsX291dChwLCBVQVJUX01DUiwgdXAtPm1jciB8IFVBUlRfTUNS
X0xPT1ApOw0KKwlpZiAodXAtPmNhcGFiaWxpdGllcyAmIFVBUlRfQ0FQX0ZJ
Rk8pDQorCQlwLT5zZXJpYWxfb3V0KHAsIFVBUlRfRkNSLCAwKTsNCisNCisJ
aWYgKHAtPnNlcmlhbF9pbihwLCBkLT5wZGF0YS0+dXNyX3JlZykgJiBEV19V
QVJUX1VTUl9CVVNZKQ0KKwkJbmRlbGF5KHAtPmZyYW1lX3RpbWUpOw0KKw0K
Kwlsc3IgPSBzZXJpYWxfbHNyX2luKHVwKTsNCisJaWYgKGxzciAmIFVBUlRf
TFNSX0RSKSB7DQorCQlwLT5zZXJpYWxfaW4ocCwgVUFSVF9SWCk7DQorCQl1
cC0+bHNyX3NhdmVkX2ZsYWdzID0gMDsNCiAJfQ0KIA0KLQlzZXJpYWxfcG9y
dF9pbihwLCBVQVJUX1JYKTsNCisJLyogTm93IGd1YXJhbnRlZWQgdG8gaGF2
ZSBCVVNZIGRlYXNzZXJ0ZWQ/IEp1c3Qgc2FuaXR5IGNoZWNrICovDQorCWlm
IChwLT5zZXJpYWxfaW4ocCwgZC0+cGRhdGEtPnVzcl9yZWcpICYgRFdfVUFS
VF9VU1JfQlVTWSkNCisJCXJldHVybiAtRUJVU1k7DQorDQorCXJldHVybiAw
Ow0KK30NCisNCitzdGF0aWMgdm9pZCBkdzgyNTBfaWRsZV9leGl0KHN0cnVj
dCB1YXJ0X3BvcnQgKnApDQorew0KKwlzdHJ1Y3QgZHc4MjUwX2RhdGEgKmQg
PSB0b19kdzgyNTBfZGF0YShwLT5wcml2YXRlX2RhdGEpOw0KKwlzdHJ1Y3Qg
dWFydF84MjUwX3BvcnQgKnVwID0gdXBfdG9fdTgyNTBwKHApOw0KKw0KKwlp
ZiAoZC0+dWFydF8xNjU1MF9jb21wYXRpYmxlKQ0KKwkJcmV0dXJuOw0KKw0K
KwlpZiAodXAtPmNhcGFiaWxpdGllcyAmIFVBUlRfQ0FQX0ZJRk8pDQorCQlw
LT5zZXJpYWxfb3V0KHAsIFVBUlRfRkNSLCB1cC0+ZmNyKTsNCisJcC0+c2Vy
aWFsX291dChwLCBVQVJUX01DUiwgdXAtPm1jcik7DQorCXAtPnNlcmlhbF9v
dXQocCwgVUFSVF9JRVIsIHVwLT5pZXIpOw0KKw0KKwkvLyBNYXliZSBtb3Zl
IHRoZSBETUEgUnggcmVzdGFydCBjaGVjayBpbiBkbWFfcnhfY29tcGxldGUo
KSB0byBvd24NCisJLy8gZnVuY3Rpb24gKHNlcmlhbDgyNTBfcnhfZG1hX3Jl
c3RhcnQoKSkgYW5kIGNhbGwgaXQgZnJvbSBoZXJlLg0KKwkvLyBETUEgVHgg
cmVzdW1lDQorDQorCWQtPmluX2lkbGUgPSAwOw0KK30NCisNCitzdGF0aWMg
dm9pZCBkdzgyNTBfc2V0X2Rpdmlzb3Ioc3RydWN0IHVhcnRfcG9ydCAqcCwg
dW5zaWduZWQgaW50IGJhdWQsDQorCQkJICAgICAgIHVuc2lnbmVkIGludCBx
dW90LCB1bnNpZ25lZCBpbnQgcXVvdF9mcmFjKQ0KK3sNCisJc3RydWN0IHVh
cnRfODI1MF9wb3J0ICp1cCA9IHVwX3RvX3U4MjUwcChwKTsNCisJaW50IHJl
dDsNCisNCisJcmV0ID0gZHc4MjUwX2lkbGVfZW50ZXIocCk7DQorCWlmIChy
ZXQgPCAwKQ0KKwkJZ290byBpZGxlX2ZhaWxlZDsNCisNCisJcC0+c2VyaWFs
X291dChwLCBVQVJUX0xDUiwgdXAtPmxjciB8IFVBUlRfTENSX0RMQUIpOw0K
KwlpZiAoIShwLT5zZXJpYWxfaW4ocCwgVUFSVF9MQ1IpICYgVUFSVF9MQ1Jf
RExBQikpDQorCQlnb3RvIGlkbGVfZmFpbGVkOw0KKw0KKwlzZXJpYWxfZGxf
d3JpdGUodXAsIHF1b3QpOw0KKwlwLT5zZXJpYWxfb3V0KHAsIFVBUlRfTENS
LCB1cC0+bGNyKTsNCisNCitpZGxlX2ZhaWxlZDoNCisJZHc4MjUwX2lkbGVf
ZXhpdChwKTsNCiB9DQogDQogLyoNCkBAIC0xNDgsMzcgKzIwNCwzNyBAQCBz
dGF0aWMgdm9pZCBkdzgyNTBfZm9yY2VfaWRsZShzdHJ1Y3QgdWFydF9wb3J0
ICpwKQ0KIHN0YXRpYyB2b2lkIGR3ODI1MF9jaGVja19sY3Ioc3RydWN0IHVh
cnRfcG9ydCAqcCwgaW50IG9mZnNldCwgaW50IHZhbHVlKQ0KIHsNCiAJc3Ry
dWN0IGR3ODI1MF9kYXRhICpkID0gdG9fZHc4MjUwX2RhdGEocC0+cHJpdmF0
ZV9kYXRhKTsNCi0Jdm9pZCBfX2lvbWVtICphZGRyID0gcC0+bWVtYmFzZSAr
IChvZmZzZXQgPDwgcC0+cmVnc2hpZnQpOw0KLQlpbnQgdHJpZXMgPSAxMDAw
Ow0KKwl1bnNpZ25lZCBpbnQgbGNyID0gcC0+c2VyaWFsX2luKHAsIFVBUlRf
TENSKTsNCisJaW50IHJldDsNCiANCiAJaWYgKG9mZnNldCAhPSBVQVJUX0xD
UiB8fCBkLT51YXJ0XzE2NTUwX2NvbXBhdGlibGUpDQogCQlyZXR1cm47DQog
DQogCS8qIE1ha2Ugc3VyZSBMQ1Igd3JpdGUgd2Fzbid0IGlnbm9yZWQgKi8N
Ci0Jd2hpbGUgKHRyaWVzLS0pIHsNCi0JCXVuc2lnbmVkIGludCBsY3IgPSBz
ZXJpYWxfcG9ydF9pbihwLCBvZmZzZXQpOw0KLQ0KLQkJaWYgKCh2YWx1ZSAm
IH5VQVJUX0xDUl9TUEFSKSA9PSAobGNyICYgflVBUlRfTENSX1NQQVIpKQ0K
LQkJCXJldHVybjsNCisJaWYgKCh2YWx1ZSAmIH5VQVJUX0xDUl9TUEFSKSA9
PSAobGNyICYgflVBUlRfTENSX1NQQVIpKQ0KKwkJcmV0dXJuOw0KIA0KLQkJ
ZHc4MjUwX2ZvcmNlX2lkbGUocCk7DQorCWlmIChkLT5pbl9pZGxlKSB7DQor
CQkvKg0KKwkJICogRklYTUU6IHRoaXMgZGVhZGxvY2tzIGlmIHBvcnQtPmxv
Y2sgaXMgYWxyZWFkeSBoZWxkDQorCQkgKiBkZXZfZXJyKHAtPmRldiwgIkNv
dWxkbid0IHNldCBMQ1IgdG8gJWRcbiIsIHZhbHVlKTsNCisJCSAqLw0KKwkJ
cmV0dXJuOw0KKwl9DQogDQotI2lmZGVmIENPTkZJR182NEJJVA0KLQkJaWYg
KHAtPnR5cGUgPT0gUE9SVF9PQ1RFT04pDQotCQkJX19yYXdfd3JpdGVxKHZh
bHVlICYgMHhmZiwgYWRkcik7DQotCQllbHNlDQotI2VuZGlmDQotCQlpZiAo
cC0+aW90eXBlID09IFVQSU9fTUVNMzIpDQotCQkJd3JpdGVsKHZhbHVlLCBh
ZGRyKTsNCi0JCWVsc2UgaWYgKHAtPmlvdHlwZSA9PSBVUElPX01FTTMyQkUp
DQotCQkJaW93cml0ZTMyYmUodmFsdWUsIGFkZHIpOw0KLQkJZWxzZQ0KLQkJ
CXdyaXRlYih2YWx1ZSwgYWRkcik7DQorCXJldCA9IGR3ODI1MF9pZGxlX2Vu
dGVyKHApOw0KKwlpZiAocmV0IDwgMCkgew0KKwkJLyoNCisJCSAqIEZJWE1F
OiB0aGlzIGRlYWRsb2NrcyBpZiBwb3J0LT5sb2NrIGlzIGFscmVhZHkgaGVs
ZA0KKwkJICogZGV2X2VycihwLT5kZXYsICJDb3VsZG4ndCBzZXQgTENSIHRv
ICVkXG4iLCB2YWx1ZSk7DQorCQkgKi8NCisJCWdvdG8gaWRsZV9mYWlsZWQ7
DQogCX0NCi0JLyoNCi0JICogRklYTUU6IHRoaXMgZGVhZGxvY2tzIGlmIHBv
cnQtPmxvY2sgaXMgYWxyZWFkeSBoZWxkDQotCSAqIGRldl9lcnIocC0+ZGV2
LCAiQ291bGRuJ3Qgc2V0IExDUiB0byAlZFxuIiwgdmFsdWUpOw0KLQkgKi8N
CisNCisJcC0+c2VyaWFsX291dChwLCBVQVJUX0xDUiwgdmFsdWUpOw0KKw0K
K2lkbGVfZmFpbGVkOg0KKwlkdzgyNTBfaWRsZV9leGl0KHApOw0KIH0NCiAN
CiAvKiBSZXR1cm5zIG9uY2UgdGhlIHRyYW5zbWl0dGVyIGlzIGVtcHR5IG9y
IHdlIHJ1biBvdXQgb2YgcmV0cmllcyAqLw0KQEAgLTU0Nyw2ICs2MDMsNyBA
QCBzdGF0aWMgaW50IGR3ODI1MF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAlwLT5kZXYJCT0gZGV2Ow0KIAlwLT5zZXRfbGRpc2MJ
PSBkdzgyNTBfc2V0X2xkaXNjOw0KIAlwLT5zZXRfdGVybWlvcwk9IGR3ODI1
MF9zZXRfdGVybWlvczsNCisJcC0+c2V0X2Rpdmlzb3IJPSBkdzgyNTBfc2V0
X2Rpdmlzb3I7DQogDQogCWRhdGEgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXpl
b2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsNCiAJaWYgKCFkYXRhKQ0KDQpiYXNl
LWNvbW1pdDogMDQzODA2YmM5ZGJjNjU5N2RkMTVlNmNhOTIyMGFlMjc0NjQy
NWYyZg0KLS0gDQoyLjM5LjUNCg0K

--8323328-1672980820-1744630364=:10563--
