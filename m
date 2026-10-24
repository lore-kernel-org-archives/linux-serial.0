Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872360;
	b=ZzF24L+giTLq0Q+ghvtQcSYffJU8lIP3vRdMBU1aBUyuJeOfwxdyXUe4Q4R0TdUM5fvM
	 2uJUVDB2v2l17QDwZMlLZp6XJ4KsfMw8CN0rUutF7IIKdnyVM8rupTDwZ/KP5MBm1FJI1
	 5M3qUnU/vmExt1mb9JYb9KZnNU/IVqBS6E6yDwAjRX90W9AcsOn5VoTt+hTPRq3GypRvt
	 51/cDKdosexWu+G7IpgNo9em1k8ZiF/1ZY5UhXxXjoEdMvIyFYS0i27tkpH5EektpKk3s
	 eecomWm1ZC0PpTJ8QQV3jplGqUWJ68cfnlSuB38jS66zNVfMJIJjHf6mz6DoYAEk8Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=cgdV2l8OQBJLScaiLLZmyJ8udq04GHVSVzdhmyemrjQ=;
	b=3Go8muq5ka+DKH6s+qwc12ifBzz47l4NPIZZOeJeNJzcGH7AIg/ISyPo+IGO9/3gb0qq
	 Uzb8H+CSHl6wV/t854YX98zjJJikIT0NUdh9RiUVgfBr70enw8eplSNIYvYMutPPku1v1
	 /r6THIfvODRdIxGsyfzFM/5x7vhSPouG7M7ub3Fjxsk8V+KkQRCzZu79OnGbPBH5xOkzE
	 +wucPkkEwRO2ptZ5w3hyuS1QpWa4nqJ9eizLoBR4ZT8fliCUvA+SZ9N1Uz2kcHFrjF5lO
	 Ku+b45CkV3ktbj21nrUyrIz4mjxZtiQGq9vqXQ4hQlaBuagUrEtOS0OlxcYZT6s8/pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EKnj1Z+N;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA387606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA387606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EKnj1Z+N
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d68de53053so998062eaf.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792872359; x=1793477159; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cgdV2l8OQBJLScaiLLZmyJ8udq04GHVSVzdhmyemrjQ=;
        b=EKnj1Z+N2wxcJs99oyz38lqNAF6LDQsvgbmvLwf7S/dPne7EeP6sJvZZS1yl9JLaPt
         F6Ksz0jcflKDiqF98BMlmc0gqIXe9zphn0bXO4K9Nckfbb8zFRIoTD+ZMH8IUo9P9lYL
         Mh7sIxoRH1XI8I//HERZ7cTGjtX2IVtYw7pQcSZr2Lv/T/rcvFoj2TrXYXND7fgDv4UN
         Dh0DANke7dax2GC2kYD4fcq3gT1nfHCTpl3LP4WodyHNAn4HYzJDZvy/3894tedg3yZm
         MwJE9ZCMMsu29xi3Xj53dOa6XRX0FJ3gF7bMu7qc7qPgR/tIkl0U4w1R66vHmhesf3tz
         SdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792872359; x=1793477159;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cgdV2l8OQBJLScaiLLZmyJ8udq04GHVSVzdhmyemrjQ=;
        b=Ag8JM4+YYESTviFXrU/fjxyKQSDn6RxpuqW8CUntXEyLojXySVoKCkomjYQFbSqJ4D
         UypNdEh6Vw9rbErJ8VIo1bk6ung6Id5aDM9PMDp0um2GaTz2pCi6EDb9V65nlg+mD/MA
         DerX99QF1cz/51aE11BEdkSXPQagWdyl8vkTIHVnkLXPvCwVWBOc811akIVZ/lQxHojP
         E3wxfw1BktccvfuVSilsk+2hVkuiDlGB31sC5MBR5CyJ3ucnyqO7t7SXsl8bPWuCusP7
         YobRWb1hmiJq3EC9B4CLlhwxxzD5Gv5DrcqWHuBkSY8F3GVxcMqipVWEQkdPiVitXd6o
         NekA==
X-Forwarded-Encrypted: i=1; AKwUvBzd/L6e2YHqVwgmLbhisLMH8yunY4Q9ros6H3FajwBpusJpASsPmXxV5xHH9kcteml14daWHqsUrHKdpyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFGBUvpT681EZMcoqRlWe/MZAMdjFhsXZ6cVMmeNBooEPVsyXz
	x5wbeK4dx8Ek4bXUnvPMAUoFT9oa14uL2b6PufFVcuRQ1w54QeWntsGYtVz41GEj
X-Gm-Gg: AYBFou34PjtQr+Ypi4HEgCt6yAb9NxLuRt8tW2uw7Jq0e4zKmQ2QxqPolKhhxiRpG0W
	6Cg3DJlDizsiMI6UYDO0QGNeCARqhV9lKaTQuyzkxOeFEXjH28LyALgYYA8VV/IdSxjIXfvl16y
	pCIrYvapqufKY/LqYPFVlvRvJ+2v/vTqSYe8sjBRHxNDjRj2rbrYxowSPQBDxSTyp5FJs/psK5B
	rjizLWvWScjuB5beW0n4NIgV0YrTGM28AxDxpBpRVwISkyQLehf4C7j99eVblSecbA0CnAqDOTi
	9su428p43nMytj7TLLKvLm5FWq+XbPOWz+rs8STRhl1HGgKFi4ca/n5K07+yWbgAq9Y0gPQSMqq
	V/yo4IhIwvUk+1WkoTehlrVZ7gQ+9M57ZuxCd4HOLKmJES2yY7seUF2mGycZ6RySOD57C4vN4t0
	3hj1Z7MJ/mn6QCOIvyT3/JCZD+9ozYRDBBlbjsbxLoFEZY8VTtDka7NrqVzT3iTDQg+AhddD2yR
	e0EqgHhRdDK4qfTIFjPAUkr8sX+xrC75FjvFtyXfeOHWKRBgDMUVTsjlhEYA8IN36JVSeTjCYML
	9/ylcVNKlpJe5DIdYqe3lHpx8SEvAdVMF7zItUEFPRTM35Uh4wUmlSzVfoUlyphWojXYfxZLvTI
	2uGVjsJFkJ2rIn3cWIvhoJEXcF4OnTyu47D87a1F5vUocY6oTKs2WJQEcPHxF0jBoxpbUTGaOKH
	d/hA==
X-Received: by 2002:a05:6820:c2cc:20b0:6e0:8fc2:84a3 with SMTP id 006d021491bc7-70ba0e26b06mr838530eaf.39.1792872358767;
        Sat, 24 Oct 2026 13:05:58 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fbb25f59sm3017611a34.20.2026.10.24.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:05:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:05:57 -0600
Subject: [PATCH] serial: 8250: clear RX trigger callbacks when removing a
 port
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
Message-Id: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7CMAxEr1J5jUUStfyuglikwWmN2oASUwVVv
 TsJLLx4o5nnFRJFpgSXZoVICyd+hgJ614AbbRgI+V4YjDIHrUyL6d3PLFhndsKT6RTGLJEHnNi
 T8Ey4aGy9PbfKqKOlDorrFclz/v253v5cRA9yUuW10dtE2Ecb3Fgjkc++HAbKAtv2BdlBIe2oA
 AAA
X-Change-ID: 20261024-submit-serial-8250-rxtrig-lifetime-v1-4fa940207ae5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

serial8250_unregister_port() removes the device supplied by a driver and
normally re-registers the persistent slot as an unknown legacy port. The
slot retains its RX trigger callbacks and sysfs attribute group, so the
replacement rx_trig_bytes attribute can still call the removed driver's
code. Unloading that driver leaves the callbacks pointing into freed
module text.

Clear both callbacks after uart_remove_one_port() has drained the old
sysfs users and before registering the fallback port. Its RX trigger
attribute then uses the generic handlers, which reject a port without
FIFO capabilities.

Also copy the callbacks unconditionally during registration. A replacement
port without custom handlers must use the generic implementation instead
of inheriting callbacks from the previous owner of the slot.

Fixes: 8a6c543cf8b3 ("serial: 8250: allow UART drivers to override rx_trig_bytes handling")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 42319843cb5b..c638e10c43e2 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -830,10 +830,8 @@ static int __serial8250_register_8250_port(struct uart_8250_port *uart,
 		uart->port.get_divisor = up->port.get_divisor;
 	if (up->port.set_divisor)
 		uart->port.set_divisor = up->port.set_divisor;
-	if (up->port.get_rxtrig)
-		uart->port.get_rxtrig = up->port.get_rxtrig;
-	if (up->port.set_rxtrig)
-		uart->port.set_rxtrig = up->port.set_rxtrig;
+	uart->port.get_rxtrig = up->port.get_rxtrig;
+	uart->port.set_rxtrig = up->port.set_rxtrig;
 	if (up->port.startup)
 		uart->port.startup = up->port.startup;
 	if (up->port.shutdown)
@@ -953,6 +951,9 @@ void serial8250_unregister_port(struct uart_8250_port *uart)
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
+	/* The fallback port must use the generic RX trigger handlers. */
+	uart->port.get_rxtrig = NULL;
+	uart->port.set_rxtrig = NULL;
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261024-submit-serial-8250-rxtrig-lifetime-v1-4fa940207ae5

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

