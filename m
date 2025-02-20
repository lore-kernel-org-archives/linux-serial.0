Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C63214202;
	Thu, 20 Feb 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050221; cv=none; b=AEdynTniCwSEz99zYD5e9tL3BVKMhAo4+22xs1NvIYnRB0ExUSM1Gz60W0RYR//teRJCP5O8wYbH9mYHYO0RQWlm6vFioaiofuP6AP3ki27C8p3Of3bJQk/q2IpQxqQTMGeKbn8xdYd2E7sYZ9p1fvSUWuVST1SV651hEMRm8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050221; c=relaxed/simple;
	bh=+OYhCfT+9b/1AYLBMmVjAFt2OwPjTFnmUdRU9VwqAXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eP3nJKRlROhKcjVqa1PGknvpN+WakCwfNk2YyiGG4VcsI6ij385yDLj+Pfs79jf9Dt1TEabc07QHK9qLkvWT0bcjN2T+VkYRhuMYG+ip2d3pm1KAx4gz3HfkScKZnO0YGU1o5xIAFf/e1ClhpNTmW78NWwpRwjPy2rfET/aMWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+hiskTP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+hiskTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F1EC4CEE3;
	Thu, 20 Feb 2025 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050221;
	bh=+OYhCfT+9b/1AYLBMmVjAFt2OwPjTFnmUdRU9VwqAXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+hiskTPjYfYeeAOzQOZRXmrokWo8ZeMM0WQJO2LQSwzPz7Hkwjn3YBZkr3FZ/NuM
	 5T0+nXBk5eOFcZCPq3Set7+HDM4kjsNVFQgjgnNpbOpSjfTAfMLTNZFynJ9ujubYc2
	 sKXNONRKGwSKCZiC4wIctLW/DENknqvuRiFIROYg3r3vR/gw3uE/RCfblhdMGSNjfj
	 MM/aADyihIGnQNqmhJp1YYKQODw2zZjvg8jeHqAJJciR5XBvUU4R0eCx/EO4sDNTV8
	 FzzX5sLBxoXY/inNRR+F/oPRcJVdLaPoMopOPOWt+5SUJkNjiiwGgwWKlWV7+KpYT/
	 oV9e6Q1F21ShA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 29/29] serial: 8250_port: simplify serial8250_request_std_resource()
Date: Thu, 20 Feb 2025 12:16:06 +0100
Message-ID: <20250220111606.138045-30-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
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
index 4ac5f16fc6ba..caf4e2ec74bd 100644
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
2.48.1

