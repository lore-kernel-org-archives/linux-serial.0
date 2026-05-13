Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9F30FF05
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667403; cv=none; b=HVaF1pSgE0pR0XnuxMZEWNfeseDaFJYWPdPHuVEGhk0+ozEFfB8rclbnNBWjnnTcVM5uIu34x3gYFxo9oGnhxfScZ/W+sBv7w0/z/s5siAEFBb7OD3CDQnThFvJ6axx/iM+grX1lTqQZC3NeUAg7qbO4xRQ5mUfHcr2qrgFJWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667403; c=relaxed/simple;
	bh=owbj000owA67UkgWR9avdrdnzroY68NPJ+aKbkpafcc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gB4kxUOhuNB1pLHKlQjrLbuyLDukrU7B6p4WsTkmTfNXSkxfB3vI7BWheNfpg1Y4sNretqJn0hSvCB9XSqtNvtVeL6u//91BSnxlQfj43ZymIKC7knWlIEexvcL9JLVt4waV9gzmdX8VHadPtrA8JbS6y1TyJDfF5uDxmx54Tr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLmG/Oiv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLmG/Oiv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778667402; x=1810203402;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=owbj000owA67UkgWR9avdrdnzroY68NPJ+aKbkpafcc=;
  b=bLmG/Oiv0Bne2/QmJYFptploLdLDQ0qA91VK8BZRi+/6pBQbZ0aucvlR
   hAs5NgYASNIWbzt9UyJi7/F+02OpTFqj59yAy5PSBwaz20vqV5Aw7cTir
   tWGoZ155SnI1FmpnwIcdAJeX5g6uezp9obWXPQ+kgzJz7Hs4so+DOFr5L
   f5zNgwsCDg2nHy9790uEk2bdVZAyQY0KHO871OP/rT7fG/5mTzN8RCuUl
   SS+RrMXdQul50Luh9G5PxM1d3rPspLYxhzJFbWQNL5dzEMN4pm+sahI6B
   F+Ybb4Qqj9AnkUWUZQjdzFrH+ERQU3OF3UHiF5jYnhR5cH7s0Uyj+IolR
   Q==;
X-CSE-ConnectionGUID: /YL9srhpREqRynMP967Qig==
X-CSE-MsgGUID: FkXUexaoQIGdFm9zytqwaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79612091"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79612091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:16:37 -0700
X-CSE-ConnectionGUID: HfpNC37YQfKWKC99yXGV4g==
X-CSE-MsgGUID: uwL+KE5uSMSDStukO0+pDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="243035081"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:16:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 May 2026 13:16:31 +0300 (EEST)
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, wander@redhat.com, 
    chris.friesen@windriver.com, linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 6.12.y 00/10] serial: 8250_dw: backport BUSY deassert
 series
In-Reply-To: <20260513065028.112468-1-ionut.nechita@windriver.com>
Message-ID: <c9f3545f-4522-4b78-7398-b364a4033a77@linux.intel.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-517342167-1778667391=:12534"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-517342167-1778667391=:12534
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 May 2026, Ionut Nechita (Wind River) wrote:

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> Hi Greg, Ilpo,
>=20
> This is v2 of the 8250_dw BUSY deassert backport to 6.12.y,
> addressing Ilpo's review feedback on v1.

FYI, this came up yesterday related to guard()s vs unlock variants:

https://lore.kernel.org/linux-serial/cover.1778592805.git.jnilo@free.fr/

> v1 thread:
>   https://lore.kernel.org/linux-serial/20260510134011.618215-1-ionut.nech=
ita@windriver.com/
>=20
> v1 review (Ilpo, 2026-05-11):
>   https://lore.kernel.org/linux-serial/d4b4e4db-505f-4400-c1b9-fe58978645=
6e@linux.intel.com/
>=20
> Changes in v2:
>=20
>   - Keep guard()/scoped_guard() from upstream verbatim in patches
>     5, 7, 8 and 9 (no more explicit uart_port_lock_irqsave/
>     unlock_irqrestore + goto-out adaptations), per Ilpo's review:
>=20
>       "By doing this you had to add some gotos which makes code
>        control flow more complicated than it was in the original
>        changes. From reviewer's point of view, the code is more
>        complicated without guard() than with them."
>=20
>     To make that work on 6.12.y, two small additional prerequisites
>     are now part of the series (see new patches 3/10 and 4/10
>     below).
>=20
>   - Stop replacing guard()s with explicit lock/unlock pairs; v2
>     diff against upstream is now significantly smaller.
>=20
> Series structure (10 patches):
>=20
>   Prerequisites (per Ilpo's original guidance, plus one implicit
>   guard-defs prereq):
>     1/10 serial: 8250: use serial_port_in/out() helpers         [dbd26a88=
6e94]
>     2/10 serial: 8250_dw: Comment possible corner cases ...     [bd8cad85=
561b]
>     3/10 serial: introduce uart_port_lock() guard()s            [0fd60b68=
9b0d]      (NEW in v2)
>     4/10 serial: 8250: convert serial8250_do_shutdown()
>          to scoped_guard()                                      [partial =
b339809edda1] (NEW in v2)
>=20
>   BUSY deassert series:
>     5/10 serial: 8250: Protect LCR write in shutdown            [59a33d83=
bbe6]
>     6/10 serial: 8250_dw: Avoid unnecessary LCR writes          [8002d6d6=
d0d8]
>     7/10 serial: 8250: Add serial8250_handle_irq_locked()       [8324a54f=
604d]
>     8/10 serial: 8250_dw: Rework dw8250_handle_irq() ...        [883c5a2b=
c934]
>     9/10 serial: 8250_dw: Rework IIR_NO_INT handling ...        [73a4ed8f=
9efa]
>    10/10 serial: 8250_dw: Ensure BUSY is deasserted             [a7b9ce39=
fbe4]
>=20
> Notes on the new prerequisites (3/10 and 4/10):
>=20
>  - Patch 3/10 cherry-picks commit 0fd60b689b0d ("serial: introduce
>    uart_port_lock() guard()s") unmodified (13 additive lines in
>    include/linux/serial_core.h). It introduces DEFINE_GUARD() /
>    DEFINE_LOCK_GUARD_1() invocations for uart_port_lock,
>    uart_port_lock_irq and uart_port_lock_irqsave, which are
>    required so that scoped_guard(uart_port_lock_irqsave, port) and
>    guard(uart_port_lock_irqsave)(port) compile in 6.12.y. The
>    underlying cleanup.h infrastructure (DEFINE_GUARD,
>    DEFINE_LOCK_GUARD_1) already exists in 6.12.y; only this small
>    serial-specific wiring is missing.
>=20
>  - Patch 4/10 is a *partial* backport of commit b339809edda1
>    ("serial: 8250: use guard()s"), per Ilpo's original request:
>=20
>      "b339809edda1 ('serial: 8250: use guard()s')
>       (8250_port.c shutdown hunks)"
>=20
>    The commit is authored by Jiri Slaby (SUSE) and carries the
>    upstream Link/SoB chain, plus an explicit [Ionut: partial
>    backport - only the serial8250_do_shutdown() hunks from
>    b339809edda1] note. The remaining (much larger) refactor of
>    8250_port.c and 8250_core.c is not needed for the BUSY deassert
>    series and is intentionally not backported.
>=20
> Notes on the BUSY series itself:
>=20
>  - Patch 6/7 of the original mainline BUSY series,
>    commit e0a368ae7953 ("serial: 8250: Add late synchronize_irq()
>    to shutdown to handle DW UART BUSY"), is *already* in 6.12.y as
>    commit 0bae1c670aa8 (Ilpo, 2026-02-03), so it is not re-sent
>    here. Functionally this means patches 5-10 above land on top of
>    the existing late-synchronize_irq() fix.
>=20
>  - Ilpo's other suggested-but-not-required prerequisites remain
>    *not* included:
>      * commit fc9ceb501e38 ("serial: 8250: sanitize
>        uart_port::serial_{in,out}() types") only causes a trivial
>        conflict in patch 10 in code that the BUSY change removes
>        anyway (per Ilpo's note);
>      * commit c213375e3283 ("serial: 8250_dw: Call dw8250_quirks()
>        conditionally") only causes a conflict in patch 9 around
>        the dw8250_setup_dma_filter() helper and the conditional
>        p->handle_irq assignment, neither of which exist in 6.12.y
>        and neither of which is needed for the BUSY fix.
>=20
>    Both of those conflicts are resolved trivially in patches 9 and
>    10 with explicit [Ionut: adapt to 6.12.y - ...] notes.
>=20
>  - Namespace export syntax: in 6.12.y both EXPORT_SYMBOL_NS_GPL()
>    and MODULE_IMPORT_NS() apply __stringify(ns) to the namespace
>    argument, so it must be a bare identifier. Mainline (where the
>    upstream patches were written) accepts a string literal. Patches
>    7 and 10 here use the bare-identifier form (SERIAL_8250) instead
>    of the upstream string form ("SERIAL_8250"); without this fix
>    the .vmlinux.export.c link step fails with "expected ':' or ')'
>    before 'SERIAL_8250'". This is noted in the [Ionut: ...] block
>    of the affected patches.
>=20
>    Only patches 4, 7, 9 and 10 carry "[Ionut: adapt to 6.12.y - ...]"
>    notes; the rest are clean cherry-picks of the upstream commits
>    using the standard "commit <hash> upstream." stable convention.
>=20
> Build:
>  - HEAD of the series builds to a complete vmlinux on 6.12.87 with
>    CONFIG_SERIAL_8250=3Dy, CONFIG_SERIAL_8250_DW=3Dm on x86_64. The
>    .vmlinux.export.c link step (which v1 originally tripped on
>    during development) passes cleanly.
>=20
> Testing plan:
>  - Same as v1: test on Intel platforms with DW APB UART
>    (snps,dw-apb-uart) running 6.12.x-rt (PREEMPT_RT) to confirm
>    the original symptom (LCR writes silently ignored under Rx
>    load -> baud / framing mismatch after set_termios) is gone.
>    Will report Tested-by once cycles complete.
>=20
> Based on: linux-6.12.y at v6.12.87 (8bf2f55ef536).
>=20
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
> Jiri Slaby (SUSE) (3):
>   serial: 8250: use serial_port_in/out() helpers
>   serial: introduce uart_port_lock() guard()s
>   serial: 8250: convert serial8250_do_shutdown() to scoped_guard()
>=20
>  drivers/tty/serial/8250/8250.h      |  25 +++
>  drivers/tty/serial/8250/8250_dw.c   | 296 +++++++++++++++++++++++-----
>  drivers/tty/serial/8250/8250_fsl.c  |   8 +-
>  drivers/tty/serial/8250/8250_omap.c |   2 +-
>  drivers/tty/serial/8250/8250_port.c |  90 +++++----
>  include/linux/serial_8250.h         |   1 +
>  include/linux/serial_core.h         |  13 ++
>  7 files changed, 338 insertions(+), 97 deletions(-)
>=20
>=20

--=20
 i.

--8323328-517342167-1778667391=:12534--
