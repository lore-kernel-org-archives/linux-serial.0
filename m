Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48A3FE362;
	Mon, 27 Jul 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153601; cv=none; b=guXSUh2OhEnpgxXshejR3RzRKIcORZqmy25lKHU/eDzs1Z2J4GX7FLczQ3DZf8BkgeMkbMV/NDMxWEUwN3XoVMuKm+d1BPhJyYOo2V3RKkmHC8OT1SiiNieCRA4ioWiV3Rf81c9KhbEeC0ul5W06Vdbjt7QiS3SBlpYD+JIP9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153601; c=relaxed/simple;
	bh=rILz7wtfonvqpyG5c3H5MGKD51F3LkusCc5Lk22A8tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uZYAsA0sItkK50yQ8hWBRD1pIhItxKDTO+CJuQLzD8D9OwvBYgYbSgXllS/BU0VodwPa35J3APh3Ap9x65+aDOglkR6ZEpHlDYBZTGVTc46mC89UfePP9YWGI3ZGzw8mbWFwBX07gnT3Orj0xfKgnMDxvsnTBJOtTKBGgXDf3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+dqrzXU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1rl//il; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+dqrzXU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1rl//il"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785153591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rILz7wtfonvqpyG5c3H5MGKD51F3LkusCc5Lk22A8tw=;
	b=l+dqrzXU0ezzpa4jwucaaZP3mvNR7xBv2+wWm7RNSDpfCceoK0Nbd9ynHpfN+aS1W5MyF8
	h46ebnRT2kVW+Jbzrb+bAtCbIndTVdqov5nd5stFcKHE+EDUc9R35A1w7jaWJXJopaf4HB
	ymrDJ+hF7nDXWZuUYcTXBxBq+QdCEn/t9pL+AjEWiADvtBTfPqQ/3qwp74OBNn4QJwNoVa
	ZD5YWLbjVU0C0Q6viY2zb18tCv5ps+bnq16XZx5ybSjI/TF6mD9Q/E4sqJXnPOn8BBDm0+
	arC6B7NQhfBPNxA3ZtWGCztzLpKDWHrtiF942ReR4wyK1zOnGde3HNzk+gvoCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785153591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rILz7wtfonvqpyG5c3H5MGKD51F3LkusCc5Lk22A8tw=;
	b=t1rl//il0I3uF34i2WLNAaP+jeSDiuWIUpDruy5uOPOxcCcmdYu33tcDFe+LoL1ARkvsWF
	XrnaSPgtfuKXtFCA==
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>, 'Karl Mehltretter'
 <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Clark Williams <clrkwllms@kernel.org>, "Toshiyuki
 Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Subject: RE: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled
 for atomic writes
In-Reply-To: <TYXPR01MB15199DA567AF4541DD79359FBD7CC2@TYXPR01MB15199.jpnprd01.prod.outlook.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
 <20260724213348.77418-3-kmehltretter@gmail.com>
 <TYXPR01MB15199DA567AF4541DD79359FBD7CC2@TYXPR01MB15199.jpnprd01.prod.outlook.com>
Date: Mon, 27 Jul 2026 14:05:50 +0206
Message-ID: <87pl0863t5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Toshiyuki,

On 2026-07-27, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> Regarding Petr's comment [1] as well, I'm concerned about the
> potential impact when the clk remains enabled during periods without
> console output.

Can you elaborate on your concerns? Do you actually need such low-power
_and_ kernel logging directly on serial?

> When creating nbcon patch, I saw a similar patch [2] from the past.
> Have you considered coordinating with the clk subsystem implementation
> for this?

AFAICT there was no real justification for enabling clocks per write
other than because we can. A lot has changed since 2013 and neither
spin_locks nor raw_spin_locks are appropriate because atomic printing
can occur in _any_ context (including NMI's).

If the amba-pl011 insists on enabling clocks per write, I would
recommend not implementing the write_atomic() callback. Since I assume a
significant amount of users _will_ want atomic printing support, perhaps
you can add a Kconfig to toggle building with clock-disabling and no
atomic, or clock-always-on and atomic.

Note that there is also CON_NBCON_ATOMIC_UNSAFE available, if the driver
wants to somehow blindly enable clocks on panic in order to unsafely
dump panic logs.

John Ogness

> [1] https://lore.kernel.org/all/al4KdsU9YLOmwDoV@pathway.suse.cz/
> [2] https://lore.kernel.org/all/1359475526-17523-1-git-send-email-walimisdev@gmail.com/
