Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495422FE0E
	for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495207; cv=none; b=RMZIW0JBx0q7rqJbuRBS8WRVCSVS9cTfJkiMajpfWgkw7LC90/hY6rHS+RNd9L8/LKUDRKqpmGM62vOUvGzoaR56bsaHmaksQXzb+oRKrAvxrsN+uTbSs+Je0+ikzYUKexrS3IjLQFVkm5eixLrUM53meLLPVwt1giDV4WQUjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495207; c=relaxed/simple;
	bh=OBnAlN/NxN9lEc6fVfrZJBeXfQ/pOgs3aOwwwG0g2Zk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EEST12Q0rFsJROLBa6d2GUo3oyPRxLD2VhNaqrDTLZhDKxOXzmwKvz9mGioQULdMWZzA2f4JzRRAoPHaJhTqcFLBFGfizRwdAlIP4aw2u7u9blYMJ41afMkNZnIRhqIaqaWu/tUXKDNBfMieMaGyZa3gZAIZTngPgUJEEHyPnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiK7NBH3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiK7NBH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778495205; x=1810031205;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OBnAlN/NxN9lEc6fVfrZJBeXfQ/pOgs3aOwwwG0g2Zk=;
  b=fiK7NBH3Q6JLhiXVxK5mXtkWk8EatSe1+gXusxzvn8jsPQQvYHfuSXMe
   yI6bGEG1nwecxXftKRyy4LHSKbGlGfhnXmJgJQUPvBWfezM+S8OKOhd38
   5S0NtdgTmDGV+oLZ8+tVy1MfEcBvCpfECyVttqYVfDnB5R1q8wifFnZXm
   7kYQ/qFCI9pkblWDVO4ocElC9bV0W+48IKyoBp8xK/I7/D+PHY6R3p7vr
   AW4fiNrW6u0QmMt4HoWkDUUGCsqJS9yShCUF/gsMyQzJxhKv9APmqhTxu
   XY0eWUNd/qGCCnB+7pZrL4OInTFMqPlZ2N3/eMo+uIPxjJ7oqO3PcfHEC
   A==;
X-CSE-ConnectionGUID: GdcLIut5QuOZ+eC56lo5Ng==
X-CSE-MsgGUID: 5OQ1zxJJTiq7Zf9uE3AbKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96801981"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="96801981"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:26:45 -0700
X-CSE-ConnectionGUID: bY6LIm89RtqCGuPUfYjnXA==
X-CSE-MsgGUID: IMRiYtADRZWkq/nmUM5xfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="260887984"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:26:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 May 2026 13:26:19 +0300 (EEST)
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 6.12.y 0/8] serial: 8250_dw: backport BUSY deassert
 series
In-Reply-To: <20260510134011.618215-1-ionut.nechita@windriver.com>
Message-ID: <d4b4e4db-505f-4400-c1b9-fe589786456e@linux.intel.com>
References: <20260510134011.618215-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-694509530-1778495179=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-694509530-1778495179=:981
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 10 May 2026, Ionut Nechita (Wind River) wrote:

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> Hi Greg, Ilpo,
>=20
> This series backports the 8250_dw BUSY deassert fix to 6.12.y, per
> Ilpo's guidance from the request thread:
>=20
>   https://lore.kernel.org/linux-serial/deb9499d-3245-7e38-9034-e533d4b5f5=
12@linux.intel.com/
>=20
> Background: we ship 6.12 LTS as part of a certified production
> platform (StarlingX/Yocto) and are hitting the BUSY assertion issue
> on Intel DesignWare 8250 UARTs - LCR writes get silently ignored
> under Rx load, causing baud-rate / framing mismatches after
> set_termios. A major LTS bump is a multi-month re-qualification we
> can't justify for a single subsystem fix.
>=20
> The original mainline series is 7 patches by Ilpo (plus its
> dependencies). For 6.12.y, the resulting series here is 8 patches:
>=20
>   Prerequisites (per Ilpo):
>    1/8 serial: 8250: use serial_port_in/out() helpers       [dbd26a886e94=
]
>    2/8 serial: 8250_dw: Comment possible corner cases ...   [bd8cad85561b=
]
>=20
>   BUSY deassert series:
>    3/8 serial: 8250: Protect LCR write in shutdown          [59a33d83bbe6=
]
>    4/8 serial: 8250_dw: Avoid unnecessary LCR writes        [8002d6d6d0d8=
]
>    5/8 serial: 8250: Add serial8250_handle_irq_locked()     [8324a54f604d=
]
>    6/8 serial: 8250_dw: Rework dw8250_handle_irq() ...      [883c5a2bc934=
]
>    7/8 serial: 8250_dw: Rework IIR_NO_INT handling ...      [73a4ed8f9efa=
]
>    8/8 serial: 8250_dw: Ensure BUSY is deasserted           [a7b9ce39fbe4=
]
>=20
> Notes:
>=20
>  - Patch 6/7 of the original mainline series,
>    commit e0a368ae7953 ("serial: 8250: Add late synchronize_irq() to shut=
down to handle DW UART BUSY"),
>    is *already* in 6.12.y as
>    commit 0bae1c670aa8 ("serial: 8250: Add late synchronize_irq() to shut=
down to handle DW UART BUSY")
>    (Ilpo, 2026-02-03), so it is not re-sent here. Functionally this
>    means patches 3-8 above land on top of the existing
>    late-synchronize_irq() fix; the conflict in patch 3 (LCR write
>    placement around the late synchronize_irq) was resolved
>    accordingly.
>=20
>  - Ilpo's other suggested prerequisites are *not* included as prereqs:
>      * commit b339809edda1 ("serial: 8250: use guard()s")
>      * commit fc9ceb501e38 ("serial: 8250: sanitize uart_port::serial_{in=
,out}() types")
>      * commit c213375e3283 ("serial: 8250_dw: Call dw8250_quirks() condit=
ionally")
>=20
>    Reasoning:
>=20
>      * commit b339809edda1 ("serial: 8250: use guard()s") is a
>        large refactor and only the shutdown hunk was needed;
>        instead, patches 3, 5, 6, 7 here are adapted to use the
>        existing explicit uart_port_lock_irqsave/unlock_irqrestore
>        form rather than the cleanup-based guard() introduced by
>        that commit;

Hi,

By doing this you had to add some gotos which makes code control flow=20
more complicated than it was in the original changes. From reviewer's=20
point of view, the code is more complicated without guard() than with=20
them.

guard() seems to be already used in 6.12 in general so I don't know why=20
you had to go replacing guard()s introduced in the original changes with=20
lock/unlock pairs.

FWIW, I scanned through the patches and didn't find anything that=20
interesting (other than that the approach chosen ignored my advice that=20
would have resulted in less changes/conflicts compared with the original=20
changes).

>      * commit fc9ceb501e38 ("serial: 8250: sanitize
>        uart_port::serial_{in,out}() types") only causes a trivial
>        conflict in patch 8 in code that the BUSY change removes
>        anyway (per Ilpo's note);
>      * commit c213375e3283 ("serial: 8250_dw: Call dw8250_quirks()
>        conditionally") only causes a conflict in patch 7 around
>        the dw8250_setup_dma_filter() helper and the conditional
>        p->handle_irq assignment, neither of which exist in 6.12.y
>        and neither of which is needed for the BUSY fix.
>=20
>  - Namespace export syntax: in 6.12.y both EXPORT_SYMBOL_NS_GPL()
>    and MODULE_IMPORT_NS() apply __stringify(ns) to the namespace
>    argument, so it must be a bare identifier. Mainline (where the
>    upstream patches were written) accepts a string literal. Patches
>    5 and 8 here use the bare-identifier form (SERIAL_8250) instead
>    of the upstream string form ("SERIAL_8250"); without this fix
>    the .vmlinux.export.c link step fails with "expected ':' or ')'
>    before 'SERIAL_8250'". This is noted in the [Ionut: ...] block
>    of the affected patches.
>=20
>    Each of patches 3, 5, 6, 7 and 8 carries an explicit
>    "[Ionut: adapt to 6.12.y - ...]" note describing exactly what
>    was changed relative to the upstream commit.
>=20
> Build:
>  - Each patch builds individually on 6.12.87 to a complete vmlinux
>    (bisect-safe), with CONFIG_SERIAL_8250=3Dy, CONFIG_SERIAL_8250_DW=3Dm
>    on x86_64 defconfig.
>=20
> Testing plan:
>  - We will test on Intel platforms with DW APB UART
>    (snps,dw-apb-uart) running 6.12.57-rt / 6.12.87-rt (PREEMPT_RT)
>    to confirm the original symptom (LCR writes silently ignored
>    under Rx load -> baud / framing mismatch after set_termios) is
>    gone. Will report Tested-by once cycles complete.

Testing with a reproduces is highly appreciated.

> Based on: linux-6.12.y at v6.12.87 (8bf2f55ef536).
>=20
> Andy Shevchenko (1):
>   serial: 8250_dw: Comment possible corner cases in serial_out()
>     implementation
>=20
> Ilpo J=C3=A4rvinen (6):
>   serial: 8250: Protect LCR write in shutdown
>   serial: 8250_dw: Avoid unnecessary LCR writes
>   serial: 8250: Add serial8250_handle_irq_locked()
>   serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
>   serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
>   serial: 8250_dw: Ensure BUSY is deasserted
>=20
> Jiri Slaby (SUSE) (1):
>   serial: 8250: use serial_port_in/out() helpers
>=20
>  drivers/tty/serial/8250/8250.h      |  25 +++
>  drivers/tty/serial/8250/8250_dw.c   | 298 +++++++++++++++++++++++-----
>  drivers/tty/serial/8250/8250_fsl.c  |   8 +-
>  drivers/tty/serial/8250/8250_omap.c |   2 +-
>  drivers/tty/serial/8250/8250_port.c |  66 +++---
>  include/linux/serial_8250.h         |   1 +
>  6 files changed, 319 insertions(+), 81 deletions(-)
>=20
>=20

--=20
 i.

--8323328-694509530-1778495179=:981--
