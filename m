Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48E2356B4;
	Mon, 17 Mar 2025 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194899; cv=none; b=cf/DNcd3rUsJcjjqnyPIURhvd3qrJwJK2LcIuAkQ6RuDyXGQpOcFP77InMjmq9pHkT4Woo0L/1ISDM/xa4LuWdJ4Io6cRC62IVspWffF1zKrynzUPqau3+Dt6/al4HCrmL+V0cX/TaKo4MilRJLpujNOJGtVx3uKUhC4iiviWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194899; c=relaxed/simple;
	bh=cuQaYOtw2y+3qDg1BeXkGnsveeCxWpGEEUYWxY7aM9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7HtG376cxJ7Da0uzTOmz8r5qLJOYipqwi+Pj04ANMRSdHbEsvXFQN4zpdbGoK21ZndrPRCvyzQiRC1LMLHPCrmg9hL4UpJoBr973H9+LG1nABk59+YnnsG6ca0JC0NlcJ8tAjftykgDrWDIAFHM7BvaSWp8Hqb6IXuZsVtcqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBt8sZDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBt8sZDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71653C4CEEC;
	Mon, 17 Mar 2025 07:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194899;
	bh=cuQaYOtw2y+3qDg1BeXkGnsveeCxWpGEEUYWxY7aM9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBt8sZDiRv4f12v5K52JY/j4W3LNhiMhCv3uNSRYulvoWx1E6WPc5FINYo7oJj2fm
	 hyZre930m5KwXRNKNwqpO/L1A24rXHj+9zmeCgdvs/GfAY0ZHKCZXp9gCyVzyliF0R
	 KUECf/KDgBBhp0roE9Uajcc/NWVgSzQ78/XEm3cPfRz3GnBNIyoVv0eShSoL5pb8Uq
	 MaRwui5mLYpfug6nDFSW/8gghsouHTL260l8PX1GxYforE2A7zLMvGBUeExZTTQYHT
	 134pTwQvRqVbHAZUHpr/924rNRol34jglbEb1ntHlJ46Oe9Loyslv2IukKLMqT0F2e
	 viLZBD3cdmaGA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 30/31] serial: 8250_port: simplify serial8250_request_std_resource()
Date: Mon, 17 Mar 2025 08:00:45 +0100
Message-ID: <20250317070046.24386-31-jirislaby@kernel.org>
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

Return immediately from the error locations or switch-case ends. It is
therefore easier to see the flow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6466f60416a9..8ac452cea36c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2966,7 +2966,6 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 {
 	unsigned int size = serial8250_port_size(up);
 	struct uart_port *port = &up->port;
-	int ret = 0;
 
 	switch (port->iotype) {
 	case UPIO_AU:
@@ -2975,32 +2974,28 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	case UPIO_MEM32BE:
 	case UPIO_MEM16:
 	case UPIO_MEM:
-		if (!port->mapbase) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!port->mapbase)
+			return -EINVAL;
 
-		if (!request_mem_region(port->mapbase, size, "serial")) {
-			ret = -EBUSY;
-			break;
-		}
+		if (!request_mem_region(port->mapbase, size, "serial"))
+			return -EBUSY;
 
 		if (port->flags & UPF_IOREMAP) {
 			port->membase = ioremap(port->mapbase, size);
 			if (!port->membase) {
 				release_mem_region(port->mapbase, size);
-				ret = -ENOMEM;
+				return -ENOMEM;
 			}
 		}
-		break;
-
+		return 0;
 	case UPIO_HUB6:
 	case UPIO_PORT:
 		if (!request_region(port->iobase, size, "serial"))
-			ret = -EBUSY;
-		break;
+			return -EBUSY;
+		return 0;
 	}
-	return ret;
+
+	return 0;
 }
 
 static void serial8250_release_std_resource(struct uart_8250_port *up)
-- 
2.49.0

