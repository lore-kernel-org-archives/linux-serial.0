Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF91B3F27;
	Thu, 20 Jun 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901007; cv=none; b=A6r/HiNt0Gcc/5l9Pp3qpkNr1AgJKRcMMommoPrzL+mjS4lzS7rltrbEQf3nAst/0eflVBpvEcffnTXgKUiJ7rKO55LzAqTESCTViDfNzUqMWoUoGAqIwXU/eCfoC7rDBnOeJ3RoQonbxxsm6U7VhBUUy/tcYTfndGq6o4q1D8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901007; c=relaxed/simple;
	bh=/soEwOsXYvmwlCsfRcQRkZNG24EUSF5AHLtkwpy6oo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=It9ISxlbDaGCkRgJaUAmaFQqPKbZdiIqkBpfBtnpApAMb8tPRUFw2EjOpl5eUN648jzH3xePnN522jECqBbhBjgyMmZ892cu7ZXEzmTbDsf+iC4fMLrmnVAtHKGbFdL5dCT88jPnaO0KCykfr+/LGownoaeivVDc0n64BbTWzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=N3ge/7JN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="N3ge/7JN"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CF8AC0005;
	Thu, 20 Jun 2024 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1718901003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2l9XFMSJOQ1iC3dqfs25C13h1WnTn5dSzlS6Cd2EIro=;
	b=N3ge/7JNfmSYsW6DocjiuMOMTHbHu788Pha83GoMj3gkgwHeiFhoRn23TPlCR90NDnx49r
	thz+PifKkQua3ctkKpqJPAjeblSD8zdXLA+6H5+OsMvQvKKZiyxJ9j8jx7CIjWGuAPWAfC
	+1uTMsSatHjFV+fPF6zo7U+MudA+qLd/+w17FecS2e2ecAx0y2JblaewBEz5Du+NMP0156
	2BH/3yrNDJ4zrmUwF6mKhRNrIUqSi0IL0+ldVpzE6FZ1sb3R2zrGiAnNnXHZVGRPtQYdIb
	dNsGUF/d0p5e7O4utj4AvvuuDvW31TQn5SIR+2jGUudQmwIIY8Jt7mK6lCg7wg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Thu, 20 Jun 2024 18:29:59 +0200
Subject: [PATCH] tty: mcf: MCF54418 has 10 UARTS
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-upstream-uart-v1-1-a9d0d95fb19e@yoseli.org>
X-B4-Tracking: v=1; b=H4sIAAZZdGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMD3dKC4pKi1MRc3dLEohLdZPO0ZMM0c8tUCxMjJaCegqLUtMwKsHn
 RsbW1AGJ1lAFfAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718901003; l=866;
 i=jeanmichel.hautbois@yoseli.org; s=20240608; h=from:subject:message-id;
 bh=/soEwOsXYvmwlCsfRcQRkZNG24EUSF5AHLtkwpy6oo8=;
 b=8E2xpAF+BNXNfVh0F3kifXiRo74IpecD+sBXRHvwn1dp/g0246AwLeVdDP7rGuu/U5EWXuHXe
 TSgsS9Y54aRAOYiwZo+9Oa1NlbqLBLfmQ2Q1i7F8zmut+3WEeY/i9dz
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=oMZuYhJzT0j5MI73RlNUVYaA8VdWpFR/Sao0JKz1D2I=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Most of the colfires have up to 5 UARTs but MCF54418 has up-to 10 !
Change the maximum value authorized.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/tty/serial/mcf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index b0604d6da025..58858dd352c5 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -462,7 +462,7 @@ static const struct uart_ops mcf_uart_ops = {
 	.verify_port	= mcf_verify_port,
 };
 
-static struct mcf_uart mcf_ports[4];
+static struct mcf_uart mcf_ports[10];
 
 #define	MCF_MAXPORTS	ARRAY_SIZE(mcf_ports)
 

---
base-commit: e5b3efbe1ab1793bb49ae07d56d0973267e65112
change-id: 20240620-upstream-uart-c7fc1f79e842

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

