Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386488;
	b=t3JM/rf0KJ8J3xUrerzoHFz/unFxuemcc5C1EQcjH2+vmji+Fcje959AsE6Z83H2SJMZ
	 LDnxWivA9HTLqdgdja6X42Po+KP2BL3jefL3cs7cXKN1D8RQ9td9Gg6p58zfzUExsrb1r
	 L6oEYuz59dQERYcDEzn8r9zs58CXsz0OfIu0jBYZym9hpuvEbaPkMuVf4rQjMD9N4VdKz
	 E3DwRfZIZr/hVhRaZo86oscqMIbKdDS/LQRxXuw2XwTZlKaHxHBeHjvLvz/UWPsy+KuyL
	 OhpUfaGj3qBZiwh5A0RS4KupkPidz2mTgSX8WlFdUehm7ZOdvKTaH7SrHCpbXvl9Ldw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386488;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cZcyq30jjTKYEIFBW131vcxGcQvJvhGY/ctk/bOWy4w=;
	b=jFEtDcsUwTD8NGt/ryPwVGTvdo/EAwB5pI8ArlSB7ygIiuYl/vJ77Wu9L/1eyL5bFBF0
	 75MZ1ZDB5jJXq9b+1j/MDdwdt+BRzCpBswg1H7+06qXAs60OeBqh1ozaBFFOG6dpQYJCs
	 pNzuZPv3Ozh1C/eiZu8vol3pLfC4QPK0Dxz8IENZUYP8BYtI7MWCXEqg0esYr8HE/fk/S
	 QL4BBB1l6L/AUeJQqi36kt383+sIaA77koVCX/WhXjLl5iNxbXUP4LSRSF4joHOwzJmef
	 3/LNiPdlT3uk2m7L0lNPOByiTd4uEeA8ag8Hx1QuwAQJamXEBnFpan0avWM2Z4Pbe4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=M9n+b1Qj;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D85606A32A;
	Wed, 11 Nov 2026 08:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55D85606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=M9n+b1Qj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=M9n+b1QjQxdgJsrl8DDX5/YwVOnK/rPuQsL9Qg75nvy4vnoVjE1QQP5ix+oT5UJlJvSmRPgRyhzIY
	 Ft/R/xmJoo0hMTaEKQ6Uz6u0Q4KmcbArkhphhSdvGQl7rb/pH8SInz8IPR8iVz5ZRVk/BphJDsfQ5k
	 8GZTM16MCo6yS47A=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af42a35aa3-76952;
	Wed, 11 Nov 2026 16:41:26 +0800 (CST)
X-RM-TRANSID:2ee46af42a35aa3-76952
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af42a352cf-d54de;
	Wed, 11 Nov 2026 16:41:26 +0800 (CST)
X-RM-TRANSID:2eea6af42a352cf-d54de
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+eebcc2b949c1c7663850@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] serial: 8250: Lock saved status flag resets during startup
Date: Wed, 11 Nov 2026 16:41:25 +0800
Message-ID: <20261111084125.80910-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial8250_do_startup() clears lsr_saved_flags and msr_saved_flags after
installing the IRQ handler and starting the port timer. An interrupt or
console write can access these flags concurrently under the port lock,
as reported by KCSAN.

Hold the port lock while clearing the interrupt registers and resetting
the saved flags, so the reset is serialized with their other users.

Fixes: ad4c2aa6354f ("Serial 8250: handle saving the clear-on-read bits from the LSR and MSR")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..dc5e002332be 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2386,9 +2386,11 @@ int serial8250_do_startup(struct uart_port *port)
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial8250_clear_interrupts(port);
-	up->lsr_saved_flags = 0;
-	up->msr_saved_flags = 0;
+	scoped_guard(uart_port_lock_irqsave, port) {
+		serial8250_clear_interrupts(port);
+		up->lsr_saved_flags = 0;
+		up->msr_saved_flags = 0;
+	}
 
 	/*
 	 * Request DMA channels for both RX and TX.
-- 
2.51.0



