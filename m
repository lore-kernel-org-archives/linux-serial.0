Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789903;
	b=J2FI+lt34s3Bv/NA5YlSYwB/i3ca5kmEB1zFx7qDIOccn5uNLhWe0OGa86xBiziv2/zJ
	 YwPbFjELUnDQdj7NOM2Utrv8ArGhswtxa7Hv1x7z0SDBmKsXO0rMWFviPUvmBMwEPicaP
	 1GNdBrevmRfynqVIoczWmbRpvnz9MGuMuOhvRAxHrDBSUrDjqoa4b5dK2L76jYsMAkqa3
	 mebWGgpn+n/Ck6M+ZQIe611vvddwmrTNVBucbyugul0CP6+kzwZXTOfh6TUEuswa5YyFV
	 jmeQTGzgj6iNduXEPqDPZK8ReajjtUdER5urr7F0BuS3MBMl5Gx3S3COX8KdS+6rEPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789903;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=Bn7S5HHmVBVlB37CW8Co6RM2gzOIX/i6AlDIxMv5sVM=;
	b=aqZYiTPKQ0gQ/hXFCdLfxUXemkB3Xy4it71iIbXqmqwHCSwzVHLGBJUN/65GCRSR4/r/
	 qq/EqaRvCANgC9TOx498YmqvPi6gHE83E8Zl8563lIsL9OLiLZDRz5EDDBPTXaUKmtZ+f
	 5u8OyoNJlQEHJa57aZJq28WJBntTmLHU4jQFIxeyW/R6e8W4robepskVRjVv3lWty+dx9
	 tOfXSq0UyUdjCYXjqx7j/GVCDJzA2x8fPD4gT/UY/1x7VKn87/dbC689u6zxk7pXCZmYV
	 TQx3TE79WkB38TxF9LfbT+pfW7xrfJycmPlNbXqV6VvDn8FKJPh8EqRSLOr1KgUVaAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=nTqmGzmy;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0C606A31B;
	Wed,  4 Nov 2026 10:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7D0C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=nTqmGzmy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=Bn7S5HHmVBVlB37CW8Co6RM2gzOIX/i6AlDIxMv5sVM=; b=nTqmGzmyYh6xOs1wwqqf1i1/ki
	kpK/KS4Iqb5bw4lPth0bvDW4sU7NlGEBpLyrkI+mL3C1cIwgTq3iEoo9+mxydeRee3UrE9CK31sTW
	oRq5hTD0/6tog4Vq2pOh5cxnGOWrInpyRMBFwaO4xOBxjWugMfvqz7k9JboiKFxhjfNAzWhd9xDv0
	bh2VYQokBsw4+rLWytyXBD5gOqPv1ACOoZBv0JWMpf8HJXIGa+b+OtuiGhkhbC0mnXmCW6Mkvbh+t
	rLs7/++ssZj/tPgBuN6dEtK+CLyM63s9mnYZIUdH0riXEBhmBN/M5qUAqm51L+qvSXOfaPA6Pb6bK
	zFZnFsBQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOYh8-007f9J-1K;
	Wed, 04 Nov 2026 10:58:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 04 Nov 2026 02:35:51 -0800
Subject: [PATCH] serial: amba-pl011: touch the watchdogs in write_atomic()
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
Message-Id: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>
X-B4-Tracking: v=1; b=H4sIAIwK62oC/x3MYQqDMAwG0KuE77eFxOkmvYqMUdo4A0OldSKId
 xd8B3gHimbTAk8Hsm5WbJ7gSSpCHMP0VWcJnlBz/RThxi0/Fvms8z+OLrE8ujZyaNMLFWHJOth
 +b/37PC9uHcCCXQAAAA==
X-Change-ID: 20261104-pl011_touch-d01385c0a5d7
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
 Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=leitao@debian.org;
 h=from:subject:message-id; bh=0KqdgEajat62QysY4IlhZoEcd4BHBchm7bTEv+3LG4s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6w/G6SG92rK0Sow+QYO/angzr0E+DRZRVbc/7
 cwO4mpL1GmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCausPxgAKCRA1o5Of/Hh3
 bXZUD/4lr5ARtRYm3fN2tXLO98iJyaZtds8qlivX8H0PeXh5A7xm4C6bgAttXptKc92/hXUKp8q
 fc9KRfcE+/CmfExTuV/6Y11QAvS/++mChnvYYGs2C/7d8kPx3jw/jSPFXptiVwsegb9rZbYKzzn
 iwUXl9uI1/XuvlGcxRDz6GHP7r1CCzCJ3U1iQ3sUsnGcAohAfC9YAgoeXWs3zIVKy+zuNGQbCs4
 cXeEjLeggzVpH/txu1hkym6sJ9N4VZQOdQULX/1XQZh004fhCrtIreIrAQPO+8cORL+V4smiiEC
 86wpE6flQ7P37OQ2u3ocNxEBG4z/kaf/gSnDNCzja1T/ZtSiUTF6UKWnXMybtbC7RZkn4FR2lz5
 oWm+p3nvFKAh3klJIg+X04UMq+Pip8+iEoUU4sCjYrPlv1uiJNvAzBNSp9EAUk+5gQF1zZdPpgW
 r90sVcX0A4awK4udzhmQSkWybETPDLrHqyKDzlaE04O7SL2ZlhK8ZwBmTdWxazE/RIF5BsV04IN
 IkXay+rX06rYQJQ1Hs/lN5hxsLoqKMPrL7dkiIibFH8wtdw9P7bV9EYKzo17HqwU9L0BTHekY+V
 W36J417FqkOtgJxbVHwybNsOOoIt5PB1KZ9RGdzOVi9n8x+gxHsDLaOWWeLqFaGToVeRxWHpCWN
 Sj65oa+gqmcdw3A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

In emergency context, such as WARN(), nbcon prints the pending records
through write_atomic() with preemption disabled.

On arm64, WARN()  can run with IRQs masked, so the whole backlog is
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
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/tty/serial/amba-pl011.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e6f652905ca6f1..4fac3bca8f8255 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -41,6 +41,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/nmi.h>
 
 #define UART_NR			14
 
@@ -2734,6 +2735,9 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int old_cr = 0;
 
+	/* An atomic flush may print a long backlog with IRQs disabled. */
+	touch_nmi_watchdog();
+
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 

---
base-commit: d6bcfc94eb4da6e089c5473970cd96727292fd97
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261104-pl011_touch-d01385c0a5d7

Best regards,
--  
Breno Leitao <leitao@debian.org>

