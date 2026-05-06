Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAF480336;
	Wed,  6 May 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076115; cv=none; b=nbpL1xu+m8u9iPf31eMdhsdFQkd65jAf50EJBjzcYbAEh7AzcavEOXYkhdyj/uVWN11Q8vRaqwxogGO4JJnBJx5VaHWWGt9Yzt/l14to2F5WegtJUY1fqYvUavMwQ5bLdYSqze1n5jUUb7+iM4i0R87w3HJA2s/oeL31baToWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076115; c=relaxed/simple;
	bh=vCDOuHN0VbpeqeqivYaNmH3+BwICfwmwRLFOopvKXgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsuAxUywyCe+De2gSSaq4seR9yj2+FPgaCRwfKb0KubUP0sIthSyE8/g5E6HG7txz9ZvwrKy/k5Qsdc25Sw0f+4/MDsO1S507rsBzCRjP4qP0r0kpBMQKqtWWVjrIj9o2HS0zOHcwoUcBzXCRPD5MqBReiYqes/vAPP5dQn1+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jbv3dDuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8IDY158; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jbv3dDuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8IDY158"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778076111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vCDOuHN0VbpeqeqivYaNmH3+BwICfwmwRLFOopvKXgU=;
	b=Jbv3dDujweydGixa27kIjzqk96eBm9i/H8DzjzQCGI8vQKe35Fh2K50j33k/Y9DsZYCu3v
	GzI6Xw6yL7TM8XROt9nL/0I4ZPdeh22dQzFUvv0e7b+eHkgvTI/kecu7Sp4UGNGCv1gSgT
	MY/IXsEhZPiWezO7Z2kacg2XEuf7CGw3d71DnaxjdISBWntNpkmR0ELvQ0gJZJhI5qEZF7
	Fu3YvL36sWnSgnSYW+9+22p9i3J5YWA4epDgQ7FTMIxdz351H3+rwiq0VMQjtFZq5U5mLY
	He5kB5zPL/fZyrwRuPzN6GXIyBeEvE0iDWffeqYMAILMN/B2H+igjmpWXW0LIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778076111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vCDOuHN0VbpeqeqivYaNmH3+BwICfwmwRLFOopvKXgU=;
	b=r8IDY1580Ia7PoItLV6xucM4HLAKleb+E4XVrPqYvOQfsOID9O5dxujM1gd0Hy+E9Pa/zw
	lWDKd0qzhKKkZJDQ==
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] serial: sh-sci: Remove plat_sci_port.flags
In-Reply-To: <20260506124643.128021-1-geert+renesas@glider.be>
References: <20260506124643.128021-1-geert+renesas@glider.be>
Date: Wed, 06 May 2026 16:07:51 +0206
Message-ID: <87pl388wmo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-05-06, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> The last setter of p->flags was removed in commit 37744feebc086908
> ("sh: remove sh5 support") in v5.8.
>
> Link: https://lore.kernel.org/CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Aside from manually inspecting possible users, I also checked using a
coccinelle script.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

===== BEGIN flags.cocci =====
// SPDX-License-Identifier: GPL-2.0-only
// Options: --all-includes

virtual patch

@r1@
struct plat_sci_port *U;
@@

- U->flags
+ FLAGS_USER

@r2@
struct plat_sci_port U;
@@

- U.flags
+ FLAGS_USER

@r3@
identifier U;
expression E;
@@

static struct plat_sci_port U = {
- .flags = E
+ FLAGS_USER
};
===== END flags.cocci =====
