Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C31C2AA
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484030; cv=none; b=Ls0AQw4oslLXf+HpgE8zY15fLnFJNQ1jnOb0M5+hnkWb0sSt9XdhkwoI17hmdwLEx58edau/a4AMNnGiRDNYdlibUc6KywOKjK88bcFvoUfd5n17cyEsBTYD+hWcyKuQ3ewkLhlD9XWdQxeIbZ29+HFS7+AOh7KEkxbJHmvJUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484030; c=relaxed/simple;
	bh=+224hee0vF2PrlP9+wUN8C16JI0W0b+GsrBZoxiDo0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a73A6aYrdCZkMy3BlA3siDWEYNDzNxZ8FWayDniDAEBdTGmDw1gzZgSyuMLybD44CduGidvIAQmBwyv4qqpQ/XrgW8OJXbMp5i7YonfX4Q+sFqgqOWjCqZBY5Dweit8CyM9FqchyxkgmSqKIekjYe05DTO3VXGe4Xg8S/K5a4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=nVYiKuCf; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="nVYiKuCf"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B1F52240104
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 02:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1781484021; bh=Hi1n85INy8qrkSi90aNIhgIANDa5ehEQj1yLY+PriN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=nVYiKuCfa4v64LZc3Epdq9sNuv0tNM+2/Em4pPKWRwvQzEL8sirHtVRRmuSw9vHW6
	 rUua4qdS5+G/ho7KN+LfJ6CmI6NU3DtrhETFxmzsQJ2mcSPhS7GEYNw/6tQnhH8EOQ
	 szjCZLUr2p9NdUqynwhu5GjOZg9eDwPlMJNUllKIxvg4kPxxjQ/+nrR/SaPLVt5/W7
	 Cgs5kAiNLTG4BnTQtfZE+sOzYZLmfTz7IXBNH6ecwa5v7KbZm3arp0nXB9T8vSUF+f
	 XHCCfy+OR1ikMDDOLfBUSLpRLLQDB3JgerTRpMqfFKNMcLkTRVNjSGzSiUIi/UJDoz
	 dwkAJddozRW9Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gdrr45bbCz6tsf;
	Mon, 15 Jun 2026 02:40:20 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Mon, 15 Jun 2026 00:40:21 +0000
Subject: [PATCH v3 1/2] serial: earlycon: add uart_clk_freq parameter
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-acpi_spcr-v3-1-9a59ebad74ea@posteo.de>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
In-Reply-To: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=+224hee0vF2PrlP9+wUN8C16JI0W0b+GsrBZoxiDo0Q=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqL0nzap2753bM94HdoYuIjI2CCX162oEw0jwpM
 bDyupitqWOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCai9J8xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KKJg/+LV5+1HTx34LQN2OG7wzkYO/XMhgNmFG
 Gcp5r/IjfBqjznMKgNhCvfKBE1vZtIP+J6hDy9nxFW76GDSIW2KvTYC3P9sX6lzBvCaw4xE7Inz
 c8gcjfZpcxSxZ4GDX+uz7ur2zgAYaNRk8p6D7XWqBPx+E4t920NByS1q3YN2Iha00mqNiSVCiH6
 vUA4gul3cOTdIG8v73h3rjo6vD91w4Wl/rq/DVw0HXQ8YxFV3UHboAUpihL9nllEx8IfBEftgrg
 Gv35O1+vldklVYd42oT9d2PeQrjq+tVTeehq7Yhvj9f5UT0QkFPJ3aOc9rMPhv9lL0/GloDa1eB
 RTC5CgJRhEU1de2GgzL+ji6QdXJ62BB8dhdV0z/R4WJ17s0kDQhWsxHQ2u2rnMjFwxhZqm4D3go
 0NhmIiF785Ycswrh8pAMceUhugyBtBLDVo2yaRZJxP19w9flMQjuIt/z+XzgWDhvOURq8+0CnBF
 GsBnw8WZvDXpwCaXSpd7LsDNX/j0+nrk5f9lwH/gBeP1y7iGFfF70C+1Xp/0HeJxz1LC7iv4Lj6
 82kTnqWHB6h8jgsXpJ6E4npc4rTLu1/Pf3+uVATAGsb3e3oWgtSh8bfp4IBeUJ/MswBIaIoKNlS
 5Rn+kR5YrLBRJqvECczLeLPPnKaodsZMfCi3neqBBifslddheOms=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Add function `setup_earlycon_with_uartclk`. This allows the
options string to be reused with `add_preferred_console`, while still
allowing to set the uart clock frequency. This will be used in the
following commit ("ACPI: SPCR: Support UART clock frequency field").

No logical change intended.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/tty/serial/earlycon.c | 17 ++++++++++++-----
 include/linux/serial_core.h   | 11 +++++++++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index ab9af37f6cda..5a20fe9e3fb6 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -135,11 +135,14 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	return 0;
 }
 
-static int __init register_earlycon(char *buf, const struct earlycon_id *match)
+static int __init register_earlycon(char *buf, unsigned int uart_clk_freq,
+				    const struct earlycon_id *match)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
 
+	port->uartclk = uart_clk_freq;
+
 	/* On parsing error, pass the options buf to the setup function */
 	if (buf && !parse_options(&early_console_dev, buf))
 		buf = NULL;
@@ -163,8 +166,9 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 }
 
 /**
- *	setup_earlycon - match and register earlycon console
- *	@buf:	earlycon param string
+ *	setup_earlycon_with_uartclk - match and register earlycon console
+ *	@buf:			      earlycon param string
+ *	@uart_clk_freq:		      uart clock frequency in Hz or 0 for BASE_BAUD*16
  *
  *	Registers the earlycon console matching the earlycon specified
  *	in the param string @buf. Acceptable param strings are of the form
@@ -177,10 +181,13 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
  *	<options> string in the 'options' parameter; all other forms set
  *	the parameter to NULL.
  *
+ *	If the uart clock frequency is specified in the 'options' parameter,
+ *	the value of the param @uart_clk_freq will be ignored.
+ *
  *	Returns 0 if an attempt to register the earlycon was made,
  *	otherwise negative error code
  */
-int __init setup_earlycon(char *buf)
+int __init setup_earlycon_with_uartclk(char *buf, unsigned int uart_clk_freq)
 {
 	const struct earlycon_id *match;
 	bool empty_compatible = true;
@@ -209,7 +216,7 @@ int __init setup_earlycon(char *buf)
 		} else
 			buf = NULL;
 
-		return register_earlycon(buf, match);
+		return register_earlycon(buf, uart_clk_freq, match);
 	}
 
 	if (empty_compatible) {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 110ad4e2aef9..19d8181c9005 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1097,11 +1097,18 @@ int of_setup_earlycon(const struct earlycon_id *match, unsigned long node,
 
 #ifdef CONFIG_SERIAL_EARLYCON
 extern bool earlycon_acpi_spcr_enable __initdata;
-int setup_earlycon(char *buf);
+int setup_earlycon_with_uartclk(char *buf, unsigned int uart_clk_freq);
 #else
 static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
-static inline int setup_earlycon(char *buf) { return 0; }
+static inline int setup_earlycon_with_uartclk(char *buf, unsigned int uart_clk_freq)
+{
+	return 0;
+}
 #endif
+static inline int setup_earlycon(char *buf)
+{
+	return setup_earlycon_with_uartclk(buf, 0);
+}
 
 /* Variant of uart_console_registered() when the console_list_lock is held. */
 static inline bool uart_console_registered_locked(struct uart_port *port)

-- 
2.53.0

