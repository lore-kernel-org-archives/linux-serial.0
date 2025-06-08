Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A18BEC;
	Sun,  8 Jun 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397624; cv=none; b=luhTSF9qhEJFlae+wRFd8z4cJTarOQBlA3L6cybauYQNWK2qr9yKcvrnlT5+sl50Tca3fgmi2PhuhMGnTbRzGb+zEVZFXfh7IiqDKSubmBoTWQUqhsKzFtVOf6sySjPco6UH1Fq/MxD0TYuqSOjYSJsn2KkQ2i0UBMld5c3RF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397624; c=relaxed/simple;
	bh=VtIBuujtVAe9ASiGT9BsyX+qi6TyxqLYyqSi7Zr+ZGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeVGFfxUDK43MATMTHP+M2THwSz76FI/8XGByq4zOcCgp+GzLmZMDcZDn4IKOJfAYOO2hGyzWgUGm7VBf2Gz+EwoYS+yn9Y6v0wwQobvlNfQQU8iAS+i7lNI4n181kw7NpwEnRjpRExBI40aoa1Dz/F0oGdY9y+oBuc451kSa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sZcJT/5L; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sZcJT/5L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=TFKJzYrumdhep1lYtqFRG7p84j1OyXJi+ZaTUY9ohok=; b=sZcJT/5LY9QryJOT
	6oK3PfNhYE+2f9eNgqOW+QXw40/dycc0eVuBfWFQ6LNU5Jp6XWMvesPsezc/3AAxxxhLocSSvh9KZ
	kPB5MLAANJ7A25pb/OI7OWW4hsfTJKs0xty+yCKowUNw3B4f4PpDM52E/LxhiJ+awZuhXu5KtRvbF
	mvqlGAXmZMdlXkYLseUXZTZnqVkhMZQJI4BYP23rjt09DS/PK2xru45BEu13xP3AZnDbUKJW9y45U
	Gl9tjVTvnXJIJtgGDLB/sLIho595b0R0B/Wjvffl+xJoIIERuZZe1p6JmQLkq/K/w9zgknkf3DcUa
	r7didnBtgMixzGPKRQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uOIEY-008GlJ-1u;
	Sun, 08 Jun 2025 15:46:54 +0000
From: linux@treblig.org
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	corbet@lwn.net
Cc: linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] serial: Remove unused uart_get_console
Date: Sun,  8 Jun 2025 16:46:54 +0100
Message-ID: <20250608154654.73994-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

uart_get_console() has been unused since 2019's
commit bd0d9d159988 ("serial: remove ks8695 driver")

Remove it, and it's associated docs.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/driver-api/serial/driver.rst |  7 +++---
 drivers/tty/serial/serial_core.c           | 27 ----------------------
 include/linux/serial_core.h                |  2 --
 3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index fa1ebfcd4472..c1db6a1a67c4 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -24,9 +24,8 @@ console support.
 Console Support
 ---------------
 
-The serial core provides a few helper functions.  This includes identifying
-the correct port structure (via uart_get_console()) and decoding command line
-arguments (uart_parse_options()).
+The serial core provides a few helper functions.  This includes
+decoding command line arguments (uart_parse_options()).
 
 There is also a helper function (uart_console_write()) which performs a
 character by character write, translating newlines to CRLF sequences.
@@ -76,7 +75,7 @@ Other functions
            uart_add_one_port uart_remove_one_port uart_console_write
            uart_parse_earlycon uart_parse_options uart_set_options
            uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
-           uart_try_toggle_sysrq uart_get_console
+           uart_try_toggle_sysrq
 
 .. kernel-doc:: include/linux/serial_core.h
    :identifiers: uart_port_tx_limited uart_port_tx
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1f7708a91fc6..c15e005047bb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2131,33 +2131,6 @@ void uart_console_write(struct uart_port *port, const char *s,
 }
 EXPORT_SYMBOL_GPL(uart_console_write);
 
-/**
- * uart_get_console - get uart port for console
- * @ports: ports to search in
- * @nr: number of @ports
- * @co: console to search for
- * Returns: uart_port for the console @co
- *
- * Check whether an invalid uart number has been specified (as @co->index), and
- * if so, search for the first available port that does have console support.
- */
-struct uart_port * __init
-uart_get_console(struct uart_port *ports, int nr, struct console *co)
-{
-	int idx = co->index;
-
-	if (idx < 0 || idx >= nr || (ports[idx].iobase == 0 &&
-				     ports[idx].membase == NULL))
-		for (idx = 0; idx < nr; idx++)
-			if (ports[idx].iobase != 0 ||
-			    ports[idx].membase != NULL)
-				break;
-
-	co->index = idx;
-
-	return ports + idx;
-}
-
 /**
  * uart_parse_earlycon - Parse earlycon options
  * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 914b5e97e056..cfd891357573 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1101,8 +1101,6 @@ static inline bool uart_console_registered(struct uart_port *port)
 	return uart_console(port) && console_is_registered(port->cons);
 }
 
-struct uart_port *uart_get_console(struct uart_port *ports, int nr,
-				   struct console *c);
 int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
 			resource_size_t *addr, char **options);
 void uart_parse_options(const char *options, int *baud, int *parity, int *bits,
-- 
2.49.0

