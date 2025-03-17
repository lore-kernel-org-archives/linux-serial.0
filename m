Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE0233127;
	Mon, 17 Mar 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194897; cv=none; b=Jjx1Fgc935ojaWH1LJU0UcRUdONdUcdPg5FOmupVF5T3jV0wJw6v4pHUf3ATmyuqKv51g1MOgWVAoBMzrHNCp9cxTV5xM98Gtk8ZIkj9TRuo8l4ZiXywUrpLqVyxIKz/P/zMTgPVC6Ov/JYMWQpivyLE/QWpYkTuJDr8jGfHzQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194897; c=relaxed/simple;
	bh=UBPE6m0iLxPwUguqTzOfkL4imXr5/+UmuxJBQ9Pu8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNMrMk7DDVpGlhfRcePh+uv65c/soM/zobmP93fNqj47SqiHdYskWT8sRAoiIZuyjw0MqNgisa7YpzJMYhNe68MernEyleRwBu9DRAsgd97M6NytrsvAHndPeSzzimZONnLLAl3pDDYBQYl30dJr+GR5LTUbwIkafE3i7Fy//go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrrfHLpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrrfHLpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B996C4CEEC;
	Mon, 17 Mar 2025 07:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194896;
	bh=UBPE6m0iLxPwUguqTzOfkL4imXr5/+UmuxJBQ9Pu8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrrfHLpI4HpFsYtkQhkXW8KlMEdxfUK5tfnJUO5ZRzfECyb/DR6S1kAqpYq4YXKwQ
	 Is44XMXzem823SVvfDA4CLZJrhqkGIhpNVe5TGGDYn78naNyVIGgDDRkHFpVNw4sze
	 KC3m+cfZsycmKzCIJV+qKkj228GalEg59vzqRxNIqyiDJUugU6YLHOvYYzW7wcLCqZ
	 /EDFqdngGA3ri5/1yrIFtapHBe1HWh+miTT5qjIKjjNQaJ5WG+X/lU3QYJM+czhGYG
	 baadcimip0KSXJdcb7gFwN2xLvwvfTRzYpuIJ9swOojd8sRUWShnXGzT8B7v0PeRWT
	 Mtmw3vO6GyQbA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 28/31] serial: 8250_rsa: simplify rsa8250_{request/release}_resource()
Date: Mon, 17 Mar 2025 08:00:43 +0100
Message-ID: <20250317070046.24386-29-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Use already defined 'port' for fetching start/offset, and size.
* Return from the switch immediately -- so it is clear what is returned
  and when.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_rsa.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index dfaa613e452d..82f2593b4c59 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -16,30 +16,27 @@ static unsigned int probe_rsa_count;
 
 static int rsa8250_request_resource(struct uart_8250_port *up)
 {
-	unsigned long start = UART_RSA_BASE << up->port.regshift;
-	unsigned int size = 8 << up->port.regshift;
 	struct uart_port *port = &up->port;
-	int ret = -EINVAL;
+	unsigned long start = UART_RSA_BASE << port->regshift;
+	unsigned int size = 8 << port->regshift;
 
 	switch (port->iotype) {
 	case UPIO_HUB6:
 	case UPIO_PORT:
 		start += port->iobase;
-		if (request_region(start, size, "serial-rsa"))
-			ret = 0;
-		else
-			ret = -EBUSY;
-		break;
+		if (!request_region(start, size, "serial-rsa"))
+			return -EBUSY;
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static void rsa8250_release_resource(struct uart_8250_port *up)
 {
-	unsigned long offset = UART_RSA_BASE << up->port.regshift;
-	unsigned int size = 8 << up->port.regshift;
 	struct uart_port *port = &up->port;
+	unsigned long offset = UART_RSA_BASE << port->regshift;
+	unsigned int size = 8 << port->regshift;
 
 	switch (port->iotype) {
 	case UPIO_HUB6:
-- 
2.49.0

