Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA748205E17
	for <linux-serial@vger.kernel.org>; Tue, 29 Oct 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206996; cv=none; b=dHTHBviynpbcx6QFo5w2Gz8wrsw4cpkxIlk7WmpAQ7w2vx59VuAt6yH6QBAc/v2fkBGgqCkLikTHzOFYzfpV9KEkYp563nSwoBUbAVtAGW3xOtkJNndKPobSIKnqdhMmjtgHVeMRXL4WlA9IAqTIBYglwtfTHhWp15ksfust4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206996; c=relaxed/simple;
	bh=lkiy3NAX90hFxBY4ufzbfxb/6k0EflHaT7qkgDGFX4A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NHb7qy+qatFuVTFzG6DP+EFHkvMXE8HdP5r+0ENPjU2BiaD3zFs0ZhGDlD3/iiBy9pO7UzFu0XuWpaG+lYIgG/b9qc2VMQ4bBJYwihAG93tU2HJZXqycDh7TJ8hYC8v2Pg7rpq+0rT44XcFaDsO/Xyqb7Dm1ZGqshUOzNz7M5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Xd9RK0mkqz3j1C4; Tue, 29 Oct 2024 14:03:07 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] altera_jtaguart: Use dev_err() to report error attaching IRQ
Date: Tue, 29 Oct 2024 14:03:07 +0100
Message-Id: <20241029130307.5003-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

In case of multiple Altera JTAG UART ports available on the system, the
error message will contain information about the port for which
attaching the IRQ handler failed.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 6162108c758e..4c7bde5dd856 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -175,7 +175,7 @@ static int altera_jtaguart_startup(struct uart_port *port)
 	ret = request_irq(port->irq, altera_jtaguart_interrupt, 0,
 			DRV_NAME, port);
 	if (ret) {
-		pr_err(DRV_NAME ": unable to attach Altera JTAG UART %d "
+		dev_err(port->dev, "unable to attach Altera JTAG UART %d "
 		       "interrupt vector=%d\n", port->line, port->irq);
 		return ret;
 	}
-- 
2.43.0

