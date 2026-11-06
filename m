Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976630;
	b=oAFB88BvMbszTRK524/SIv4IoQxRzkjiHxxfsClRv++G1Mz5iyAmfsfo6I3Pv2V5gyZh
	 1rr49x4/UoYE+KrWf/gRT/5MGITuAP1dnu6QQisjh0ZgKClEyFctibTOT73qBdCSFCUMP
	 c1iS2wItt2O0Mb2QdCHD3cIiGSOy/P/kGXJwtm6/UKzRheFkhU24Zm3Q78rrS2biWWYrQ
	 4YFxdWIHQsWMhUtXOIgJBBADvU6RkAcGy7+rVVtPOSl2vHIHNHN4Qb1KM1J9xgorE65q9
	 3gkedsdwLvuJd1vNrtPFaj5TvuUsxooJRjM8gef70SgPQ7TsbqTXDRbP+TKFv3zbvIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976630;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=XPCLenyEzwZwVfVxLxrs1LBAzeWtprOnp8XgwoTPKyM=;
	b=hUDzivssEh4LG97qcrzEQGqwNTuD64NA3/F0j4Q/TlXynTj7rLyl8yvtLBbwAa0CkF/u
	 sym7ZhsF4G7TL5i37asQyTW1pNse6+lRCG0q6Z5lIBllmBpuyILHWleIXWnclb//aRp+9
	 G9AHa16jDUletGiuSuEAgeJhiy+0bcsB0VGkOr1b0fn9WZGx2snJA80fp+lUvycKJLT0p
	 LgViAI71GCdxEhf9YPfD3T8ixMmPEDKTgMIQ9184U0+qMuSdiO3KwN/WF518m5+k/FaY3
	 0iXAPxC256xio4qov2tax4p1NkYnAsB7fsVAYLo0GYcD6hmBnLWFinInUc43AegUpfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=sXd1Kfqp;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972D606A326;
	Fri,  6 Nov 2026 14:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B972D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=sXd1Kfqp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=XPCLenyEzwZwVfVxLxrs1LBAzeWtprOnp8XgwoTPKyM=; b=sXd1Kfqplx3V7J4hbKR+fL7hCm
	HNI4wjSKnnwmrN9eiQ+UBqVjnAcZ2nKQH6++RyON11iGXISeBOkl+B2TKcK9nXyGn4/oqj7ow/I0c
	BestaFq8+0NwUo8Cm5hnQz2XZZroBrCx+PKDG8m6Gwg+/9F9McV1OfFoGQNoKnRHoKTPo8whqNzRC
	zvmTjsc+uVac6WI5Rf/eTQmro4rk8ZMv9BlFklI1dQxJGqpBasZCjTILQ5uvDt3k9o8H2UGD1e4FZ
	8tVR8a1W9iUj4cQq+Vqr17V5nOTOi1HOBekCPnJ7epcZezohrNUVX16BrKBm1qsIo2+HDwub5x65S
	2Y0Rbo3Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPLGm-009MMU-37;
	Fri, 06 Nov 2026 14:50:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Nov 2026 06:48:34 -0800
Subject: [PATCH v2] serial: amba-pl011: touch the watchdogs in
 write_atomic()
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-pl011_touch-v2-1-8f4996113320@debian.org>
X-B4-Tracking: v=1; b=H4sIAMbo7WoC/23MQQ6CMBAAwK80e25Nt4BiT/zDEAPtSjcxLWmRa
 Ah/N3L2OofZoFBmKmDFBplWLpwiWGGkABeGOJFiD1aA0eaMqGs1PzXifUkvF5TXWLWN00PjLyA
 FzJke/D62Wy8FBC5Lyp8jX/Gn/58VFSoyVzP6tqoJ687TyEM8pTxBv+/7F80wxtGnAAAA
X-Change-ID: 20261104-pl011_touch-d01385c0a5d7
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
 Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=leitao@debian.org;
 h=from:subject:message-id; bh=RnyT6NLxiOeRi96HY2jVtetftkGPlZf5EO3+8nAlwjw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq7ekoZwvxfykwxyvlwBaZPsQ1P0dkYq6KkRPt+
 z1ZJjrEQkyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCau3pKAAKCRA1o5Of/Hh3
 bTNmD/41wX8qj3tYkfhbWoQ/fRr/6aMUn0CaTipht0UtePENy2xgj8l1fd5DnXBlyZgjZni3VSC
 iLLFn1V+ZreIt3x4d+iHE5+ihkZSWLUBSUokemng7bEnqBQPG+B9KNvUQ49p0L+ojjZvdHR7jcC
 sQUkb82c37wliLZhyvih6FXjUxYDA6xdft/I5RJt4kJKXHIRepex/06/LY0ntASIDALGDE7sf4N
 5ngQQ1F0JIkXnmxI/rWf+oSXsU6nxlLfQ5YOgsfXRKmGupShwxInLvHXMnO+j1eneJ40cevNxOS
 WPv6BmWk8dOBP1Vj/GNvmS5dycTWL5qV39zcmhrTwdUDlea9oQU7NgcTcDM72tz6/My+ZXiRdry
 JBcxTKbfeGW6ShKvJ3bkUeHVtQgaDHbS5mpbgKDrpJdr5oQLB9mLpOBkzYqa8TbWPPE1QtXfM7f
 iIl/BYT1Iuw2JBqViS2zz9/iAD8hZer+99oA+aZhhnJPA2GlvFKS1YWzPuBpcfCA0azpQsrUyAD
 XeS8/v4vti7iUcjmO5fOy7d6JIEEs6AODQm3S/CykKEGSk/92907zU8f98Yv/UrZSml2lSWqQF8
 c0XwwKLKHDUC9k3fKWhCF48OaTzzt1Eq7ce4/4oke4a8rohp/juUlOpesaSds3cc2zD6vWV3Ys6
 nrpDqIIfx7ztzJQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

In emergency context, such as WARN(), nbcon prints the pending records
through write_atomic() with preemption disabled.

On arm64, WARN() can run with IRQs masked, so the whole backlog is
printed with IRQs off as well.

Commit 9bd18e1262c0 ("printk/nbcon: Restore IRQ in atomic flush after
each emitted record") does not help here, as it only restores the
caller's IRQ state between records.

pl011_console_write_atomic() busy-waits on the UART for every
character, and at 115200 baud it prints about 11.5KB per second.
Flushing a few hundred kilobytes outlasts the hard lockup threshold
(10 seconds by default), so the printing CPU is reported, or the
machine panics with hardlockup_panic set. See [1].

The 8250 driver avoids this by calling touch_nmi_watchdog() while it
polls the transmitter. Do the same in pl011_console_write_atomic(),
once per record.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/all/87wlqtxb14.fsf@jogness.linutronix.de/ [1]
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Move touch_nmi_watchdog() to the end of pl011_console_write_atomic(),
  per Petr Mladek.
- Link to v1: https://patch.msgid.link/20261104-pl011_touch-v1-1-e292bd834e14@debian.org
---
 drivers/tty/serial/amba-pl011.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e6f652905ca6f1..b6bb7effb08740 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -41,6 +41,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/nmi.h>
 
 #define UART_NR			14
 
@@ -2754,6 +2755,9 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 		pl011_write(old_cr, uap, REG_CR);
 
 	nbcon_exit_unsafe(wctxt);
+
+	/* An atomic flush may print a long backlog with IRQs disabled. */
+	touch_nmi_watchdog();
 }
 
 static void

---
base-commit: d6bcfc94eb4da6e089c5473970cd96727292fd97
change-id: 20261104-pl011_touch-d01385c0a5d7

Best regards,
--  
Breno Leitao <leitao@debian.org>

