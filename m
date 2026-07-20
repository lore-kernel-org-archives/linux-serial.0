Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D934DCCD;
	Mon, 20 Jul 2026 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577114; cv=none; b=Sd1XbXfCqZsTbecWHZjlfQdefzZJQLMIgl0qFUn30DgH0JH/4+b+sT8WJSnYxXIFGnF/jWK7lkC2j/7YVxwzMIOKhikJ2ahwcWrQl7nkphSOvw6IXkUdgjYK7cB977QRC/uLallNjKdDlHZj9zcvvQsqKjXyQpbJR1iVzOPm7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577114; c=relaxed/simple;
	bh=+3tRQOkKXYTfm8//XPY7dOZ2s2DB0vL8Ensxxjwe5CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExD5VjJoAG9o3N6n3Imgwt3Y/YMIEO3YySFv0IGncBLi0wzKjB6RusH0XPlgCtXfP1gjzWYoCRxqbeoBtFM/tSYg6g4uz0LR26mQYGLgm01Q7W9c+Ru3UFHT1pPd/G33ybForapcCFxYooCR9kMwkx9Yv+VqjU5g1dHlr1g40O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=s6+jR2vL; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="s6+jR2vL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=pgebSYBfvUp63+eMYv0AErJqT8i7Kjg3m4XtWaqjsyU=; b=s6+jR2vLyZ1igGeaZeVadE+SD6
	Ql+izDBxzMZ8O+mbBDAxMFqcUqP0cocvkMHio8qxR20U84Xw4hi5Z3CIqPsfQ50ngDDfFu/ZbJkSL
	0hbap8sU1MDJmW1Sx40XrgRuVnIA4f14bHdLz/3RxpKApRJIVRPYI6SrKvLIa4PyHwSE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wlu1l-0000000065N-2thT;
	Mon, 20 Jul 2026 15:51:50 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: rsci: remove check for zero baud rate from uart_get_baud_rate()
Date: Mon, 20 Jul 2026 15:51:44 -0400
Message-ID: <20260720195147.3630241-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The minimum baud rate supported by this driver is 0, so even for the B0
case, uart_get_baud_rate() will return 9600, not zero. This check is no
longer necessary since commit 16ae2a877bf4 ("serial: Fix crash if the
minimum rate of the device is > 9600 baud") so remove it.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Cc: biju.das.au <biju.das.au@gmail.com>
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b00c9e385169d..40db9daa4272d 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -265,8 +265,6 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
-	if (!baud)
-		goto done;
 
 	/* Divided Functional Clock using standard Bit Rate Register */
 	err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
@@ -278,7 +276,6 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 		cks = cks1;
 	}
 
-done:
 	if (best_clk >= 0)
 		dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n",
 			s->clks[best_clk], baud, min_err);

base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

