Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EA360EEA;
	Tue, 12 May 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590752; cv=none; b=SsJN8epprp1DaU8RGQIfQGNZStsXx7rki1j/scaYuknRrDz4IWwUQ4W7ddn7PZ7gQvKVtliGyxxB+SxXVnpCWAqDCT4wWMMX0XGB7r7iOwINDwgdoyBjGk4Hc1z5iGlU+8fNJRsIH0JVbp/ADcFcvLe9iTjS3vmt+KxG8zwHZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590752; c=relaxed/simple;
	bh=UF3PNjqMKc8JVfx0Z/6O28dvnt11XxoQQ70PKRAOM/E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iXtk+C0b6AeEroTcrZ9jLPlS9PqlsCcqZje5Ydmm6zBgs3ZZ48X+oNSiSmHEOjvJdvw3yQIXwVFguduRfG/Xyn/meQfKyHFpbCYcx3Xh6vhrzLF0n7J0R0TNK4a5H5npipXWtjpqrvHj3dXopIJ3ViHf1MGGrm8FiT/xDJdO13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU/vOb9A; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fU/vOb9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778590751; x=1810126751;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UF3PNjqMKc8JVfx0Z/6O28dvnt11XxoQQ70PKRAOM/E=;
  b=fU/vOb9AbGQZDPyOo1HH+DN+V+pSbJtumEudh5Ktwp7ZlET2cCT/gBMd
   b/WXqRRVxfMHXAklDLFAPtuyfONH85HNiiQGWpwW0R/lelHjWFte3R9VT
   fePUC9Dz1aH1D9470hWIPy4Syf+fvVMib1ZPkAdFhbdsG84n/GxAmbABF
   RRNlocOjlQ01mbw5S//r6sPqYhufekS0qyn8rRvC5osBqcVtZPZ4aE5H5
   iqmeIHbqycPv18V+9bck6SGCorzXOuPTuze3MmnnAMFm9XJ/GeNDlSm4g
   p1OUbMfNxm7HiFleCjaDl2MaTc0AgSWwpTZEre6QLCJlNURujkRTXJJjy
   g==;
X-CSE-ConnectionGUID: xuDxkKGiRtG0vl1jzsuedw==
X-CSE-MsgGUID: tplJZNGxTMaKDzEJAYankw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90195542"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90195542"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:58:58 -0700
X-CSE-ConnectionGUID: Fb/8dZ+HR2GheIAb2HO2Ng==
X-CSE-MsgGUID: pkHIDp/cRkmrfRn/aolMyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="275878457"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:58:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 May 2026 15:58:52 +0300 (EEST)
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>
Subject: Re: [REPORT] serial: 8250: BREAK + SysRq dispatch silently broken
 since 8324a54f604d
In-Reply-To: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr>
Message-ID: <4bab4248-1c49-3f68-d327-fc00a4d7114b@linux.intel.com>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1746770759-1778590732=:11125"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1746770759-1778590732=:11125
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 May 2026, Jacques Nilo wrote:

> Hi,
>=20
> We hit what looks like a silent SysRq-over-serial regression on a 6.18
> build of the 8250 driver. Posting as a report rather than a patch because
> there are at least two reasonable fixes and I'd like a maintainer call
> before sending one.
>=20
> Symptom
> =3D=3D=3D=3D=3D=3D=3D
>=20
> CONFIG_MAGIC_SYSRQ=3Dy, CONFIG_MAGIC_SYSRQ_SERIAL=3Dy,
> CONFIG_SERIAL_8250_CONSOLE=3Dy.
>=20
> A BREAK followed by a SysRq key on the console UART is consumed by the
> kernel (BREAK counter in /proc/tty/driver/serial increments correctly)
> but is never dispatched to handle_sysrq(). dmesg shows no "sysrq: ..."
> line.
>=20
> `echo h > /proc/sysrq-trigger` still works, isolating the regression to
> the serial input path. Verified end-to-end on an RTL8196E MIPS board
> running 6.18.24; the affected code is in the generic 8250 core, so the
> issue is not platform-specific.
>=20
> Path
> =3D=3D=3D=3D
>=20
> =C2=A0 serial8250_default_handle_irq()
> =C2=A0 =C2=A0 -> serial8250_handle_irq() [8250_port.c:1835]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guard(uart_port_lock_irqsave)(port); =
=C2=A0[8250_port.c:1840]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial8250_handle_irq_locked()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> serial8250_rx_chars()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> serial8250_read_char(=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> uart_han=
dle_break()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--=
 arms port->sysrq
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> uart_pre=
pare_sysrq_char(port, ch)=C2=A0 =C2=A0-- captures sysrq_ch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* guard scope ends -> port unlock */
>=20
> The captured port->sysrq_ch is dispatched to handle_sysrq() at unlock
> time -- but only by uart_unlock_and_check_sysrq[_irqrestore]() (see
> include/linux/serial_core.h:1239). The scope guard's destructor at
> serial_core.h:797 is plain uart_port_unlock_irqrestore(), which skips
> the dispatch:
>=20
> =C2=A0 DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uart_port_lock_irqsave(_T->lock, &_T->flags),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uart_port_unlock_irqrestore(_T->lock, _T->flags),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unsigned long flags);
>=20
> So sysrq_ch stays in the struct until the next BREAK clears it.
>=20
> Bisection
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> =C2=A0 commit 8324a54f604d ("serial: 8250: Add serial8250_handle_irq_lock=
ed()")
>=20
> Pre-split serial8250_handle_irq() used explicit uart_port_lock_irqsave()
> + uart_unlock_and_check_sysrq_irqrestore(). The split moved the body into
> _locked() and replaced the explicit lock pair with
> guard(uart_port_lock_irqsave), losing the sysrq-aware unlock.
>
> This was the very condition Johan Hovold's 853a9ae29e978 ("serial: 8250:
> fix handle_irq locking", 2021) introduced
> uart_unlock_and_check_sysrq_irqrestore() to address -- the new helper was
> deliberately the sysrq-aware variant. The guard() conversion undoes that
> intent.

I seem to have come blind to the (unlock function) names. I'm sorry about=
=20
breaking this.
=20
> Reproducer
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> On any 8250-driven console with CONFIG_MAGIC_SYSRQ_SERIAL=3Dy:
>=20
> =C2=A0 # On the host side:
> =C2=A0 python3 -c 'import os,fcntl,termios,time
> =C2=A0 fd=3Dos.open("/dev/ttyUSB0",os.O_RDWR|os.O_NOCTTY)
> =C2=A0 fcntl.ioctl(fd,0x5427); time.sleep(0.3); fcntl.ioctl(fd,0x5428)
> =C2=A0 time.sleep(0.05); os.write(fd,b"h"); time.sleep(0.3)'
>=20
> =C2=A0 # On the gateway:
> =C2=A0 grep brk /proc/tty/driver/serial=C2=A0 =C2=A0 =C2=A0 # counter inc=
rements
> =C2=A0 dmesg | grep sysrq:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0# empty -- no dispatch
>=20
> Two ways to fix
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Option A -- surgical, only fix serial8250_handle_irq():
>=20
> =C2=A0 int serial8250_handle_irq(struct uart_port *port, unsigned int iir=
)
> =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iir & UART_IIR_NO_INT)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uart_port_lock_irqsave(port, &flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial8250_handle_irq_locked(port, iir=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uart_unlock_and_check_sysrq_irqrestore=
(port, flags);
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> =C2=A0 }
>=20
> Restores the pre-split behaviour. Doesn't touch the guard infrastructure.
> Drawback: leaves uart_port_lock_irqsave() as a generic primitive that
> silently swallows pending sysrq_ch in any other call site that processes
> RX under the guard. There are no such sites today in 8250_port.c
> (uart_prepare_sysrq_char is only reachable through serial8250_handle_irq)=
,
> but the trap remains.

8250_dw's handle_irq also uses guard() which was the reason for this=20
change in the first place so it should be fixed as well.

> Option B -- fix the guard destructor in serial_core.h:
>=20
> =C2=A0 DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uart_port_lock_irqsave(_T->lock, &_T->flags),
> uart_unlock_and_check_sysrq_irqrestore(_T->lock,
> =C2=A0_T->flags),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unsigned long flags);
>=20
> uart_unlock_and_check_sysrq_irqrestore() short-circuits to plain unlock
> when !port->has_sysrq, so no overhead on non-sysrq ports. Fixes all
> current and future guard(uart_port_lock_irqsave) users in one place.
> Drawback: changes the semantics of a shared serial primitive. Some
> callers in 8250_port.c run under that guard from non-RX contexts
> (serial8250_set_mctrl, wait_for_xmitr, etc.); the only observable effect
> there would be a one-time handle_sysrq() call if a previous BREAK left
> sysrq_ch set -- functionally desirable, but a behaviour change worth
> documenting.

There will be many such sites so this doesn't sound a great idea.

I wonder why we couldn't instead do another DEFINE_GUARD() for the sysrq=20
case?

I suppose thought the lockdep assert in serial8250_handle_irq_locked()=20
cannot discern that the correct one of them is being used by the caller.=20
But at least it's context comment should mention that the correct=20
guard/unlock variant should be used.

> I have a tested Option A patch against 6.18.24 (verified the dispatch
> fires and produces the SysRq help dump). Happy to send it formally, or
> to retarget to Option B if that's the preferred direction.
>=20
> Thanks,
>=20
> Jacques
>=20

--=20
 i.

--8323328-1746770759-1778590732=:11125--
