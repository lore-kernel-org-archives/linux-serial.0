Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089460;
	b=d8o1WikdjeLfjGqlOZcm/RIhvNbl9ruy2XIVdw+bmktT/fF4onADfKfP9uhPoKzfHJn3
	 2lWwnci+yckFn3v3nJ8DcqoPxydYEZvO955XoUNdSbD9Dsgc4UlScgCMLhIWR2Mx7O6R6
	 EjNAE0itDGwAaX0F8CkcWrSn7V2Hp+s0voht8WM+O6oOrH/RP72J/PGpYtguUhj0x/K62
	 1oRbYwaFdTfPzd7qoaSwKhrJRrAKe3HHU3+h7N9Jmnv7zYJPdV7pPd910r6UhU4sRek9X
	 1SD+YFOO7bc1JtL8xJ8UQZMrRH7luWj8Q77At8wiaA9mzBP1jaYMFFM3H9n50E3N/kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dCICRK3Q2ogNqVz3yPrXVvctFjOQRKEefpiuJ5bCXJ8=;
	b=IKiiXOc85G2sTkIIz3cXGDk2auBus/ZYHrNMkUH/6rhfpXpzN8IsTX3xkUp8X2+fLPYf
	 JC7cK3VPV/DtleV2VTbpOesqXqcx/WQ3Cl2L7I4Dj8xN/Jn3IeIuIndtzGpFbFJ816l54
	 AqwnReId4a57Ag8EIo4a2Tv3Yv5/KN/DIL+kZv8pHWafe/g+hucRd0jolf24bBTy/6+s9
	 oGFAKhguzoarWF9Va0Oy6eUtCCzfILoPX++AJs2wOOlkw8FY8XfPdUyOzwvgZpM7Fh4Cz
	 aqG/9766qPkKhMgEqtxWwGdSH27Dd2E3tfp45HlS32H1GhL8MWbQjkfV3nS6Op3aRNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rrpFqLRq;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337F606A326
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 08:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E337F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rrpFqLRq
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so2625476eec.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089459; x=1793694259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCICRK3Q2ogNqVz3yPrXVvctFjOQRKEefpiuJ5bCXJ8=;
        b=rrpFqLRqQqvBTd3U1WEcu/ms1CK7EvAZFXuWlOfW30Ym1a68niK+tvLZbSbKQuGWJB
         Mi7XdlfcXb1A0DmQ6lf6SGjyU/ljEeYdaBAV4HNw7MKYhqEES6amn0OInwODKIm/v/dI
         6QEQjHtoikh8Jkg1E3Fo1vHoCAxSCQy4g2Gi3E3NKOGNrb4cuoQJEq0nq+dH0+prWYc6
         djSikYcYT/1C+4LxVblB19Uw88FSehmWorXa0iRPqPSGL4u6wNtL5qbLlvo/wxUTkEgY
         5LuXXdk1fo5o3NISg4PcyX8+Ok4RGYlDHxS2HAXkJG6ssQxlmdQg8QzCO21dADGV+zyA
         4ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089459; x=1793694259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCICRK3Q2ogNqVz3yPrXVvctFjOQRKEefpiuJ5bCXJ8=;
        b=2jdyNu2/1IvV0qASKMAsreAiOPGh+wBTrrMm7wy7XIYUNBbhrqc46dJpI/WyO5rDEe
         P31slphAB8TXEpKvzoP8cOANhU2bjv9NtfmFT31x03He/KKD33FUMSlQTnfuZUZXmqz8
         5CdmQu2z4hr3DpF0G0qmDGgjeQ60ZIFMkMXi0XSJiDBYjo4mpKapOfSvdtZDgDDoNw55
         6Chmc1+KEoFqP9Qtzc11BpQxgpQBBeKoR9vesWS2edVJpulocF670GEUzkOXIeaICTeu
         vc1kDioVxSOcFhMdpKbv3mAxqapKQLF5821Vg25xRxjL9AhXJyPxPr+XBm+0BU5SOlgi
         4eGQ==
X-Gm-Message-State: AFq9FYIR98kWdgao9uDzQ6Bgphioh7o9PQJcZJXjSIzJq4NkZ8CiQvqB
	nZI37vleBhJ/FWXpPO6lskyrVtx0S6kul52iwnGyj4VJtHMoopNtnHh4
X-Gm-Gg: AYBFou3EPzwYDQEmgdv6MLWZoF259JidfRZodM1oHB1mWWmAC10v+ZQZ6dzR5LUxQGm
	WfwSFD7uvMsba0fotSG7gXvdCg7sv2GMaKNDr3crHzFVxHIcEaeM+CI+69+CQXRRJikS1PY+Csu
	0MhGYSuQx7R0zt9HXZyLGFfZwha3hc9l6hChYjWhIFM1wtXuHfm8K+9TFojUq7eQ2RQmQTFrFR7
	i9XpClyB9i9IV8h7cNIHfgdc8XpFCaXsMP2I1+NhujI414XOaFUP8mRScRecwLZLbnUuc/xYmY4
	C1d7CFDBISyJFJoo0az0wMaA2kzDANIuyNgQrrR1ko4T1iP6QsSeDoYfYgnjG+mwH5cE2p9jO5f
	TfKTT91ZMVT2ZsJDB5BVX8rVFH8lJMREC+GvhBJYejx754MX6+3SJYSvfL1UzhY/XFRp2+BYQ0h
	Ypy75cU8D04YAlHDgWw6n0vGo74ml/1XMzF+DU9ojKTya/z52hijbeRdPI8OsYk+nLHWZ4XdX9N
	J5R3qMdVfUC8MznLgDIEtHHhFNfDLBmtDEicmJFUmaYuyFw1iICXOdRF/xCXWbwrxyaP+jeE8NI
	emZV560=
X-Received: by 2002:a05:693c:87d9:20b0:369:987f:d15e with SMTP id 5a478bee46e88-369e8336389mr13936464eec.2.1793089458652;
        Tue, 27 Oct 2026 01:24:18 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a03bea5d4sm12404412eec.6.2026.10.27.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:24:18 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] tty: discard flip-buffer input for TCSAFLUSH
Date: Tue, 27 Oct 2026 08:22:36 +0000
Message-ID: <20261027082236.56724-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

set_termios() handles TERMIOS_FLUSH by clearing only the line discipline's
input buffer. Data already committed to the tty flip buffers can be
delivered after that flush, leaving old input readable after a successful
tcsetattr(TCSAFLUSH).

This can be reproduced with a noncanonical PTY: complete an 8192-byte
master write, wait until the slave reports 4095 unread bytes, and apply
TCSAFLUSH. The remaining 4097 bytes are still readable afterwards. Small
amounts of pending input can also survive if they have not reached the
line discipline yet.

Use tty_buffer_flush() with the referenced line discipline to discard both
receive queues under the existing buffer lock. If the line discipline has
a flush_buffer callback, also unthrottle the tty after releasing that lock,
as TCIFLUSH does. Otherwise a paused input source or sleeping PTY writer
can remain stopped after the queues are emptied.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Unthrottle after flushing when the line discipline has a flush_buffer
  callback, matching TCIFLUSH and addressing Sashiko's review.
- Add local blocked-writer and serial-type N_TTY flow-control validation;
  rerun the original functional and sudo/PAM tests. Test harnesses are
  kept outside this patch.

 drivers/tty/tty_ioctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 90c70d8d14e3..be764f04bf3a 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -496,8 +496,11 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 
 		ld = tty_ldisc_ref(tty);
 		if (ld != NULL) {
-			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
-				ld->ops->flush_buffer(tty);
+			if (opt & TERMIOS_FLUSH) {
+				tty_buffer_flush(tty, ld);
+				if (ld->ops->flush_buffer)
+					tty_unthrottle(tty);
+			}
 			tty_ldisc_deref(ld);
 		}
 
-- 
2.43.0

