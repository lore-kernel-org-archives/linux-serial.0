Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A36F3911C4;
	Tue, 12 May 2026 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590113; cv=none; b=Z7BdMi0Rz2TNP5zGjuKj8Wwz6dPTx18CNEniPaHxYg2zaglc0AjVmAfsKxnXBP/0/5XFFhRKQhhnJ3wGWh0A5tb51w4jW4801iNAp7K6IZdGel7tD1Rw91Eqrzyn5LCD62d0dr1+C9nvV5+yUWC6U7rGD76/IuL0DRaHB9OHMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590113; c=relaxed/simple;
	bh=OGZopb/UzQad9GkgZFw0DFo2GpuLeud99o6wUX/DRxc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nUsjhAqNzkazSqqLxkpJSe2RtxzmiVLeRTr59u20CKsx2PcCFTDSn7a/lCR6NlBRHjeq2g1nx/UW3w7dlahk5hQUqWQo5IKvW4jQIhX6hbvhKbTi0IHSQ7+virD/RshtrUS/YuQ7pd2S+dtbEsec5ddKk0ApIKYwcjib+wODdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fHZ1KnPe; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fHZ1KnPe"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 9FACCDF87A7;
	Tue, 12 May 2026 14:38:38 +0200 (CEST)
Received: from [IPV6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec] (unknown [IPv6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 209C4780333;
	Tue, 12 May 2026 14:38:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778589511;
	bh=OGZopb/UzQad9GkgZFw0DFo2GpuLeud99o6wUX/DRxc=;
	h=Date:To:Cc:From:Subject:From;
	b=fHZ1KnPehuVHxKu3TFpsMFhNs2VsaKQ+SB6Z3cA8xvOIvl8BwCKACqPbJurVYADl7
	 WZcxMYzgVqPt0bQYJdYR8/Imr4HsDKIaxTy7p0jwLt8awhlJOG5Q1ujdXpcSMk7Hvh
	 /DszLrY+bw4HQABL+S1XOAlWhwIRvp5MhQNkXgmjsRsD1hQCOI+TdY9HQHnSPfRuLH
	 05UoVfCMFg6IMiGwKMtB5Gj6sCN//L+DO6MnwYRlAi+n+WzpYt0OrpZh7wSlcL7YRl
	 ERgwz3iok3pHi/DRoL3D5yPyMyUqCoKHOcclqAJ9BKkKqyNxVwSXmOITqqYb3p4kgk
	 GtX3OTgLvCMiw==
Message-ID: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr>
Date: Tue, 12 May 2026 14:38:24 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Johan Hovold <johan@kernel.org>
From: Jacques Nilo <jnilo@free.fr>
Subject: [REPORT] serial: 8250: BREAK + SysRq dispatch silently broken since
 8324a54f604d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

We hit what looks like a silent SysRq-over-serial regression on a 6.18
build of the 8250 driver. Posting as a report rather than a patch because
there are at least two reasonable fixes and I'd like a maintainer call
before sending one.

Symptom
=======

CONFIG_MAGIC_SYSRQ=y, CONFIG_MAGIC_SYSRQ_SERIAL=y,
CONFIG_SERIAL_8250_CONSOLE=y.

A BREAK followed by a SysRq key on the console UART is consumed by the
kernel (BREAK counter in /proc/tty/driver/serial increments correctly)
but is never dispatched to handle_sysrq(). dmesg shows no "sysrq: ..."
line.

`echo h > /proc/sysrq-trigger` still works, isolating the regression to
the serial input path. Verified end-to-end on an RTL8196E MIPS board
running 6.18.24; the affected code is in the generic 8250 core, so the
issue is not platform-specific.

Path
====

   serial8250_default_handle_irq()
     -> serial8250_handle_irq() [8250_port.c:1835]
          guard(uart_port_lock_irqsave)(port);  [8250_port.c:1840]
          serial8250_handle_irq_locked()
            -> serial8250_rx_chars()
               -> serial8250_read_char()
                  -> uart_handle_break()                 -- arms port->sysrq
                  -> uart_prepare_sysrq_char(port, ch)   -- captures 
sysrq_ch
          /* guard scope ends -> port unlock */

The captured port->sysrq_ch is dispatched to handle_sysrq() at unlock
time -- but only by uart_unlock_and_check_sysrq[_irqrestore]() (see
include/linux/serial_core.h:1239). The scope guard's destructor at
serial_core.h:797 is plain uart_port_unlock_irqrestore(), which skips
the dispatch:

   DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
                       uart_port_lock_irqsave(_T->lock, &_T->flags),
                       uart_port_unlock_irqrestore(_T->lock, _T->flags),
                       unsigned long flags);

So sysrq_ch stays in the struct until the next BREAK clears it.

Bisection
=========

   commit 8324a54f604d ("serial: 8250: Add serial8250_handle_irq_locked()")

Pre-split serial8250_handle_irq() used explicit uart_port_lock_irqsave()
+ uart_unlock_and_check_sysrq_irqrestore(). The split moved the body into
_locked() and replaced the explicit lock pair with
guard(uart_port_lock_irqsave), losing the sysrq-aware unlock.

This was the very condition Johan Hovold's 853a9ae29e978 ("serial: 8250:
fix handle_irq locking", 2021) introduced
uart_unlock_and_check_sysrq_irqrestore() to address -- the new helper was
deliberately the sysrq-aware variant. The guard() conversion undoes that
intent.

Reproducer
==========

On any 8250-driven console with CONFIG_MAGIC_SYSRQ_SERIAL=y:

   # On the host side:
   python3 -c 'import os,fcntl,termios,time
   fd=os.open("/dev/ttyUSB0",os.O_RDWR|os.O_NOCTTY)
   fcntl.ioctl(fd,0x5427); time.sleep(0.3); fcntl.ioctl(fd,0x5428)
   time.sleep(0.05); os.write(fd,b"h"); time.sleep(0.3)'

   # On the gateway:
   grep brk /proc/tty/driver/serial      # counter increments
   dmesg | grep sysrq:                   # empty -- no dispatch

Two ways to fix
===============

Option A -- surgical, only fix serial8250_handle_irq():

   int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
   {
           unsigned long flags;

           if (iir & UART_IIR_NO_INT)
                   return 0;

           uart_port_lock_irqsave(port, &flags);
           serial8250_handle_irq_locked(port, iir);
           uart_unlock_and_check_sysrq_irqrestore(port, flags);

           return 1;
   }

Restores the pre-split behaviour. Doesn't touch the guard infrastructure.
Drawback: leaves uart_port_lock_irqsave() as a generic primitive that
silently swallows pending sysrq_ch in any other call site that processes
RX under the guard. There are no such sites today in 8250_port.c
(uart_prepare_sysrq_char is only reachable through serial8250_handle_irq),
but the trap remains.

Option B -- fix the guard destructor in serial_core.h:

   DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
                       uart_port_lock_irqsave(_T->lock, &_T->flags),
uart_unlock_and_check_sysrq_irqrestore(_T->lock,
  _T->flags),
                       unsigned long flags);

uart_unlock_and_check_sysrq_irqrestore() short-circuits to plain unlock
when !port->has_sysrq, so no overhead on non-sysrq ports. Fixes all
current and future guard(uart_port_lock_irqsave) users in one place.
Drawback: changes the semantics of a shared serial primitive. Some
callers in 8250_port.c run under that guard from non-RX contexts
(serial8250_set_mctrl, wait_for_xmitr, etc.); the only observable effect
there would be a one-time handle_sysrq() call if a previous BREAK left
sysrq_ch set -- functionally desirable, but a behaviour change worth
documenting.

I have a tested Option A patch against 6.18.24 (verified the dispatch
fires and produces the SysRq help dump). Happy to send it formally, or
to retarget to Option B if that's the preferred direction.

Thanks,

Jacques

