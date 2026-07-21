Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49A21FF2E
	for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672837; cv=none; b=ALg+AY3zRK3WNGEc1mVzn/yW9T+B/siubQjesDcll3Yqbc3P08JE37pj5G6berBN+wB7HI/tN89/Zt0OJpTHEF3H0MfmgeUf7NLfULUcpCI71WQmSEX9zc74xcMFlUMbxlMShcf/8OEr3lbe2zftiQ7gAXswE3waX+Uc4lsIB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672837; c=relaxed/simple;
	bh=7zmPz26VekVv8pGTJ1pX5ab73d1VWSa/+KFYsz0RL9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxatyygU3tWHPzqfHXyEL5xGEpbXlzU35v/O+1G2h2ECgoht8HtSwhF10zi812w9/VDYTPXz0/Xo+gsaRKEIJnXjkqw1HfLdjEMIiwcDpa2ymj0jkNO0rrS8g4/LO/GBIErd3TvEZ46LmGfwNXjiIDaiQYNiKvcrdTQQaacCsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bithiatec.com; spf=pass smtp.mailfrom=bithiatec.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=cIGxxMep; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bithiatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bithiatec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="cIGxxMep"
Received: from bithiatec.com ([85.18.246.178])
	by Aruba SMTP with ESMTPSA
	id mIsewWxXk9tEmmIsewdqDH; Wed, 22 Jul 2026 00:24:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1784672644; bh=7zmPz26VekVv8pGTJ1pX5ab73d1VWSa/+KFYsz0RL9g=;
	h=From:To:Subject:Date:MIME-Version;
	b=cIGxxMepPcT2hLdDwW1cSgBY9MilJlrUJkE4dzv0ERpuRhzSd1myAT/ZrwSc6YspQ
	 KahW1jUGgQMO/xRC13JniuhywJbNk9neXo7rw29LWFhTD83Y7XwpNH+xeXP9yVZvKj
	 YrMxhRaBpfPw0YOYnhv0y2vBd/ftQBHgf4gQM0Kv8TeftZoDxoHJo8cYMiOK7ftGHB
	 rji9euVyO3a5yCubhENu5+QQl2/jp6Q2lpTcMKmnz903RTUC1R1hYm6vHWzVHUxrw9
	 LimAcj2X3nfgf3nzYulKdVzKAuFkZtjv0a+Zmz/4nSXj4aVZOi1C1mIXAh/YvP0wLE
	 J2eXtZmAF1OoA==
From: Luca Fresi <luca.fresi@bithiatec.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luca Fresi <luca.fresi@bithiatec.com>
Subject: [PATCH] serial: sc16is7xx: enable THRI before filling TX FIFO
Date: Wed, 22 Jul 2026 00:24:04 +0200
Message-Id: <20260721222404.204746-1-luca.fresi@bithiatec.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKqqLMK7wqqG0ewBMTAmxtYH1jVyodMYfe1Vgpl6yJK+Ra7YiZLYB7rbMb5OqYCAsAZM8dqwdni9HJTjW6SBLzPaMyRJbqs5TnKnJky7lTGtYS4COnVv
 lH/B1h9AEPUXX71Yj9+AQjZjYY8XXmkkhmOM/fV44Kau0ELCDoZBvTiH/FwOwUuA3HBOVMahGoZmiyRIio81HHF+cjpobmPH3Uw3lTL9cSgWCBbEp6UvnV73
 wl53QhyqrK6fKiU3m7BJPeVolj4h3vtDOZy2WbgqxRfFptO7+fLHEo8xfRRqTLdV0Va22qHl9Jxg/HcMALKn0yDauqfNLCzvLgWcP+K/V1tsIsk4GKHrMJE6
 DSj/PeyvGZYYwv9v7sDehqylxneU3bR/tH2lE0S4OhBMpGzvH+3YR1VWqQ+7+BMjB23vRxXS5vdWuGhLDM5Zua/PU74uhg==

sc16is7xx_handle_tx() currently requests the THRI enable only after it has
filled the TX FIFO. The request is asynchronous because the IER update is
performed later by reg_work.

The SC16IS7xx generates a THRI interrupt when the TX FIFO crosses its
trigger level. If the FIFO drains past that level before reg_work enables
THRI, the chip does not generate a new interrupt. Characters remain queued
indefinitely even though the hardware FIFO is empty.

This was observed on an SC16IS752 while both UART channels were active.
During the stall the software TX buffer remained non-empty while TXLVL
reported 64 bytes free, LSR reported THR and transmitter empty, IER had
THRI enabled, and IIR reported no interrupt pending.

Enable THRI synchronously before filling the FIFO so the threshold crossing
cannot be missed.

Fixes: cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Fresi <luca.fresi@bithiatec.com>
---
 drivers/tty/serial/sc16is7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index daebd92f32c7..a1bd175e2feb 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -827,6 +827,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 		msleep(port->rs485.delay_rts_before_send);
 
 	guard(mutex)(&one->lock);
+	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
+			      SC16IS7XX_IER_THRI_BIT,
+			      SC16IS7XX_IER_THRI_BIT);
 	sc16is7xx_handle_tx(port);
 }
 
-- 
2.34.1

