Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA52DEA61;
	Tue, 12 May 2026 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592126; cv=none; b=HsUjUvD2rRylmtJ66zt2nNX2KZKC54Tw18HBBJNeVtR8d/GBFsmg5S5Trx7MSz68sc+wce9Em4H+t8CBrpiUdl9WSY+Nhdy5sfdblJEAsyinSEVzKqEXTrRB0gchDF2GSXW0xNF0+mxRfAKUUrYCOss/ZIMZ2++sCWPH0OheV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592126; c=relaxed/simple;
	bh=8pfMuktM6igAp0Dtdc56j/or9Ff5xZTJLQJGUZ9pOPI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k9ZMDiz7pnzBT/1q93X+VixF30VeHVXY8+aKUz+vMclqXid52X3ag67Ro+ZJftaXgSBVi8PM4bXbI41XF/1svU61BSM9kBXh1tiuTmKC6pekozS51Vrw2U33t5q5J6GKyg6jArtsvQ4M6B8LIvyjyG4pjT5gD1wetDdGvsrDZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8ivhipG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8ivhipG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778592125; x=1810128125;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8pfMuktM6igAp0Dtdc56j/or9Ff5xZTJLQJGUZ9pOPI=;
  b=H8ivhipG0WkrFYDcsWN7u8Seon5yaIF4PB5/LyzXnr7YXscBYLaUseFv
   xSN50vccVeTK7uQHWt2lN+STTfqjGO8wt8wCse5dloHrG4PftCozBSg2m
   YBqVWB3M75Lh/VwaXyfh3eGhccNyk40Xa8fjoJ4w2wJ1+Y4muVl099k5w
   E2wUFSw1FGHN4OCEqMq1vNEDHYwVO2DTFmWtfwSZhT6snxEkV1/XYH239
   dFnaFA/V/XsANlBMFD5tZ5/SIKn00plneSwc65/dlJnJ/3RSruRnkSM+k
   xR20aRxlgTS8182TpUm0RRi6asDDQBgQeoT+EAVGotcwVwTGswg/Ujcvs
   g==;
X-CSE-ConnectionGUID: 1TAbNr0ATPqQvtiFZaYUuw==
X-CSE-MsgGUID: Xnm7s0TXSqae818My+Wcnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="67028286"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="67028286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:22:04 -0700
X-CSE-ConnectionGUID: KQpthfC6TQSVma7i6DixUQ==
X-CSE-MsgGUID: Asm/Qn45ScuM1znnNCTEhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="235101162"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:22:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 May 2026 16:21:59 +0300 (EEST)
To: Jacques Nilo <jnilo@free.fr>
cc: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>
Subject: Re: [REPORT] serial: 8250: BREAK + SysRq dispatch silently broken
 since 8324a54f604d
In-Reply-To: <122f6431-2241-4367-be28-bfd3b31f5333@free.fr>
Message-ID: <efc4fd93-9b0f-dee6-9725-ef7a09c4214f@linux.intel.com>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr> <4bab4248-1c49-3f68-d327-fc00a4d7114b@linux.intel.com> <122f6431-2241-4367-be28-bfd3b31f5333@free.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1601201666-1778592119=:11125"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1601201666-1778592119=:11125
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 May 2026, Jacques Nilo wrote:

> On Tue, 12 May 2026, Ilpo J=C3=A4rvinen wrote:
>=20
> > I seem to have come blind to the (unlock function) names. I'm sorry
> > about breaking this.
>=20
> No problem at all -- the asymmetry between the lock and unlock helper
> names is exactly the kind of thing that's easy to miss in a refactor.
>=20
> > 8250_dw's handle_irq also uses guard() which was the reason for this
> > change in the first place so it should be fixed as well.
>=20
> Confirmed -- dw8250_handle_irq() at drivers/tty/serial/8250/8250_dw.c:421
> does the same guard(uart_port_lock_irqsave)(p) before
> serial8250_handle_irq_locked(). Same bug.
>=20
> > > Option B -- fix the guard destructor in serial_core.h:
> >
> > There will be many such sites so this doesn't sound a great idea.
> >
> > I wonder why we couldn't instead do another DEFINE_GUARD() for the
> > sysrq case?
>=20
> Agreed, that's cleaner. The lock side is identical -- only the unlock
> needs the sysrq-aware variant -- so a second lock-guard macro keyed off
> the unlock destructor fits well:
>=20
> =C2=A0 DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave_sysrq, struct uart_port=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uart_port_lock_irqsave(_T->lock, &_T->flags),
> uart_unlock_and_check_sysrq_irqrestore(_T->lock,
> =C2=A0_T->flags),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unsigned long flags);
>=20
> Callers that may capture sysrq_ch (currently serial8250_handle_irq and
> dw8250_handle_irq) opt in by using guard(uart_port_lock_irqsave_sysrq);
> the existing guard(uart_port_lock_irqsave) keeps its current plain-unlock
> semantics for everyone else.
>=20
> Naming-wise I'm not attached to "_sysrq" -- if you'd prefer something
> shorter (e.g. uart_port_rx_lock_irqsave) or aligned with another
> convention in the tree, happy to take direction.

I don't have strong preferences (I'm usually not good with names
anyway :-)). Somebody might object not placing _irqsave as last in the=20
name (and reversing the word order would be a bit inconsistent compared=20
with the unlock name).

> > I suppose thought the lockdep assert in serial8250_handle_irq_locked()
> > cannot discern that the correct one of them is being used by the
> > caller. But at least it's context comment should mention that the
> > correct guard/unlock variant should be used.
>=20
> Right -- both guards take port->lock so lockdep can't distinguish them.
> I'll update the Context: line on serial8250_handle_irq_locked() to spell
> out the requirement, e.g.:
>=20
> =C2=A0 /*
> =C2=A0 =C2=A0* Context: port's lock must be held by the caller, and must =
be released
> =C2=A0 =C2=A0* via guard(uart_port_lock_irqsave_sysrq) or
> =C2=A0 =C2=A0* uart_unlock_and_check_sysrq_irqrestore()

> so a SysRq character
> =C2=A0 =C2=A0* captured by serial8250_read_char() is dispatched on unlock=
=2E

This would be less words to the same effect:

which captures SysRq character on unlock.

?

> =C2=A0 =C2=A0*/
>=20
> Plan, then, for a v1 patch series against tty-next:
>=20
> =C2=A0 1. include/linux/serial_core.h: add the new lock-guard macro.
> =C2=A0 2. drivers/tty/serial/8250/8250_port.c: switch serial8250_handle_i=
rq()
> =C2=A0 =C2=A0 =C2=A0to guard(uart_port_lock_irqsave_sysrq); update the Co=
ntext comment
> =C2=A0 =C2=A0 =C2=A0on serial8250_handle_irq_locked().
> =C2=A0 3. drivers/tty/serial/8250/8250_dw.c: switch dw8250_handle_irq() t=
o
> =C2=A0 =C2=A0 =C2=A0the same guard.
>=20
> I'll mark it with Fixes: 8324a54f604d and Cc: stable for the kernels
> that carry the regression. Let me know if the naming or the Context
> wording wants adjusting before I send.

+

Fixes: 883c5a2bc934 ("serial: 8250_dw: Rework dw8250_handle_irq() locking a=
nd IIR handling")


--=20
 i.

--8323328-1601201666-1778592119=:11125--
