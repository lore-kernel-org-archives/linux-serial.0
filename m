Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E133CEB0
	for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2026 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937567; cv=none; b=j29mxjEVnqjB21qnaQxBu89zcl0B7X9dX1lRKoTdboVj8e3LW2PS5qtyM5E3/uzQOv+qJFFh1DL1SFm+3xsL0ynoXAviQj10LPsd4xcFHqTbvFd9vu1M1Fgpr38KCvyPVEU3PYamUovEgncIAv0EHkEw/id8wRjeofGe6uG+MEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937567; c=relaxed/simple;
	bh=gp1bLWk0W4SSinC4th4QfuO65u5aGtMyIzGqq8LfSDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXtKWLfT0LCkFpsLa/ABm0HPW6iet3DRs/pFjGqo8UZ47OZbcCr78uJIpmCj/xIKnJES7vzSECMNl5H8SIXyaE3eqsOoK1xRvjZy7i7G5Y/Ss2VPqugQNoP6f1akGwqrrl3YR5k1UbKXzc9lfEWSEmWsyidIPFLwZ6v0rVpa7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9Wvy2aD; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9Wvy2aD"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304cf518c9dso5545150eec.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937564; x=1781542364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omAGU0C3MD/oOe7cVIVwpjk2GpA2qrqblld/4zNfBb4=;
        b=q9Wvy2aDa1qVVg3OFHEBQMkHcTXCgkrO8IwG9Vt2An39ftjBXb5lvdNg5IS6WOqcSO
         ISURR4YUCDPmpp8/WbPxq+G/EpTfJDv7EsDAujt5bDABdj6DPV7RrjNkkKWV6kYVj2di
         rPfbeCi9LGVQjtx81R9LGP62UrtxRRd/s7XCJu1DMnFQ0cDPdiMFbrSx2AGU045bjqOQ
         hs6AG6fP70eoLsA1VfjRcL5YwTi1Q8JPYeOjLc6j8/sb9GLuy6btg+vWO6IhAHAkpBIS
         uQbkJ3aJ1JK8FuyjA2nNeAXo9lzoU8TvSuxeErNk2NotTeVtgOf8wi/yYV2oieysD/i8
         tMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937564; x=1781542364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omAGU0C3MD/oOe7cVIVwpjk2GpA2qrqblld/4zNfBb4=;
        b=hBH+rCnkZdiBeYcDVKuAG+wYdoywUvPzU3xAIB0faonjz7U0/oaVawsps/qwlLSuqc
         W3PFFk6fmWM1OWg1D/3/rCOqtGHMnLbdsWWjbwhVLZU3gq2uyuFl9Uf4YNfypS+nJ8Jq
         i8kq/AsiugnifEHRHDtNXr+4R2q65z9nRC0olAl9mvnaDUho3Fd90pdKvlRp149ekSk/
         vYsiRGIJx9p6FhK/bUk7jqWy6dAVrkJPqzOfqE8zqaA+3UbJ83iDOc5RoHqejyP0a8U+
         61moC9t0k2KEmP3XbbfGjPwGAmeNf/HzGIfCK0pUbL+WeJd6W5dxUDJt4nA9/uGI4AO1
         LPzg==
X-Forwarded-Encrypted: i=1; AFNElJ99QXahAA+UlggESDBQsBycH9+xY/BQKznp5w12omipuc9suxSeCdzUlp7WoQB4DXfSVTtaUcOHw58vUd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxt5J3RJSYow6bSlB+deX9w9D2MzALSI3g5lQGBcrH+YZhlNGu
	wwFemq4hbmS6TeSZPv8Bltlf7DKq0drNNG/yf4rBhrpGVTKEMSyU2zpn
X-Gm-Gg: Acq92OEDnS8nlJbbPfnTxEMjmEsJkFnun5otntJ2UFlZ574RVHMyvT1dvyHiprFDQdS
	LtdxJmjgfWzHYlo+CX3x30Z3SIKakrbdQEcY3oX8+kjftCCzdVl8bLkiN0FgDm7RkeKsCIctT6Q
	D57CJApF9ELKLjbrlvgysuoIfsS+TB5Vvg2WKrAXCToXhQR65St21E0Vr58BmmXe7Y5HyFG1cYQ
	4sJHq8LmdVxM9Yq86T6PwCKEIPvoi66YtraC9418ajznTaYZnfde2tfmQwZ1T2KHWG4BG1MoMOZ
	T6hoOoKgiXe0j0TvK9baqLsZTjtjN2B0PK6xkTjlLZLM2wbGePkLU7GekYkgpMx9shEDSKDXOuf
	gK2jxD2V7Rt0M/0eibl2ilD0qre9QX8XuDR3fD6uG3eA4X650EBnXVB230Nhx1yXFbenox/Pnz2
	Ck5ApjkhxWyJsY9K4uYonkUAEMYx6ohXWQOGwmsAppOMP/0hLIGym7fAAW54ioKiADBn5Bi5uvf
	lIFSVk=
X-Received: by 2002:a05:7300:7313:b0:307:26a3:75d2 with SMTP id 5a478bee46e88-3077ae86b6emr8240147eec.7.1780937564310;
        Mon, 08 Jun 2026 09:52:44 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba046esm15973532eec.9.2026.06.08.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:52:43 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] tty: serial: core: fix NULL pointer deref in uart_resume_port()
Date: Mon,  8 Jun 2026 09:52:17 -0700
Message-ID: <20260608165223.70148-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_resume_port() looks up the tty device child with device_find_child()
and passes the result straight to device_may_wakeup(). device_find_child()
returns NULL when the port has no matching tty device child, and
device_may_wakeup() dereferences dev->power.can_wakeup, so a NULL tty_dev
faults. uart_suspend_port() already guards the same call with
"tty_dev && device_may_wakeup(tty_dev)"; the resume path does not.

 Oops: general protection fault, probably for non-canonical address
 KASAN: null-ptr-deref in range [0x148-0x14f]
 RIP: 0010:uart_resume_port (pm_wakeup.h:84 serial_core.c:2477)
  serial_pnp_resume (8250/8250_pnp.c:522)
  pnp_bus_resume (drivers/pnp/driver.c:234)

Mirror the NULL guard from uart_suspend_port(). put_device(tty_dev)
already tolerates a NULL argument, so only the device_may_wakeup() call
needs the check; the non-NULL path is unchanged.

Fixes: b3b708fa2780 ("wake up from a serial port")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 89cebdd278410..7dd3ec3dea438 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2373,7 +2373,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	guard(mutex)(&port->mutex);
 
 	tty_dev = device_find_child(&uport->port_dev->dev, &match, serial_match_port);
-	if (!uport->suspended && device_may_wakeup(tty_dev)) {
+	if (!uport->suspended && tty_dev && device_may_wakeup(tty_dev)) {
 		if (irqd_is_wakeup_set(irq_get_irq_data((uport->irq))))
 			disable_irq_wake(uport->irq);
 		put_device(tty_dev);
-- 
2.43.0

