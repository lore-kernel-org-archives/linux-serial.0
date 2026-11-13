Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580127;
	b=sLdPfMViUw4TmxfDwiHkJKIN4ATHIzp2siIN62lNamG8bsTfEcjqKBybGqYhHIjzeA4U
	 gj/b3M5H8rFuxU54fCIfn7C4fzx2LU9VzhmGpV8qL+GEoj6E14i+3ntxTM3nt1by35pPs
	 ApX2zCWz9SUYe+ULdwohIArPy9AU8sO4/UuVZyZDZgHwHJRQenZj5ihj0DZ48uDfvjzfl
	 T9XU99N2eoQc68HypD5X6i2/+YCeMNNZRiYuwtunkuQYu5VIlLpJcpiEoTXI5t63FeRiB
	 +sp080IuOG8rqxJ3wzgUZG4eqab257TmbhkqYhx0ZCsv6rLk27dzykF/TP2gEYg15/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580127;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:
	 X-Developer-Signature:X-Developer-Key:Autocrypt:OpenPGP;
	bh=4KZfnZZWUgpacNaNvWb37H6nYeezWlIgqRQQEVtr3Zc=;
	b=jKPtMRoWav9p5iZAEdodq1lBZV+oAtyw/VGHw7hQdgTWAQDvB7RPwVDY+nXGKQ5zfRqu
	 8kIAYp3f4PmsMajQUmwsptuXmm9Qa5dM4SCuhGUUd9JYEE2Bsq4Nlud4JIVxMRWNl6I6g
	 wJ+67bk3Eg+V6/xT9iGuZtrVPjCh9t7gy6cmAMlmkTAnnm4vuExDOd5bj5z+yJCboXBNH
	 sbOKkyrgz+1wSskFd+wG+BrcoMYyF9Fa3VKZyYTfvZlbJJJsV7WrpfgyoMMtIlaH0mEoK
	 2+hlBZpzOkstKK9EKNPvYglPTCwvNh/V8A22iunfxpjeS77OaTmIoSnBZqr0zeuGe+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=LaUrFXD7;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5A606A32D
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 14:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF5A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=LaUrFXD7
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7B097240105
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 15:28:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794580123;
	bh=4KZfnZZWUgpacNaNvWb37H6nYeezWlIgqRQQEVtr3Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=LaUrFXD7OKSEfAR3UOLjQBV9+BejCQ5bX5siOX3odu4Cz8HR5XE0xNLQ8Uen/34fN
	 6Fqb/xkVEsUrbq1/9oHTQkXlgH32iJIcDS1OyDL5sQ1KKIBHVaCHZ6ynPEcRV1NK8i
	 8ShR6qaC7rqfXqm625/39epgZxO/MqJyA4TmbEGQq+FCRIKedS2NqDV45QtGwfDhK5
	 qIfc5qS+OXNpe9a0hlWxopEB03fyAOiy92zxR+ID5wryqjQpMSzEl/svT/re8cCZAE
	 Jn+zxSuxVjxZzTn7iCkpmrHDZiSs0kOJQWkgrJ9eREvtRCcSk2YGQRD/MBvVsovzcs
	 bcDzwDcsDeAiQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jR04B2YBcz9rxD;
	Fri, 13 Nov 2026 15:28:42 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 13 Nov 2026 14:28:43 +0000
Subject: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency field
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
Message-Id: <20261113-acpi_spcr-v4-1-443c88f964d7@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6200;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=GF3qJ28po4tzQKhOOmc1ZjYhXtmA/fVN39S6nEBHPRI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9x6ZKmoSMfo4cnDAS9SrXc9WY3HgrzFOQAvKn
 2or1awB+3aJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavcemRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LTORAAlRUI9trL5r+/BqWIi7fS5df2v8t9wqG
 7X3Yklco4rZrEQYn5icuVPgN/eYb65f8OixkjqbupW7MnS3HApAq2RWYg2zi5bI5pPs1gExB/V7
 Yuu7mVeCE3lg8zmszAvTQUOsvr84hLgFwaFoFqjxYQrtgAME1joOVmCdKKDqKoCrTNzZhKiMt4t
 qPgY1i/pC7Pu6WiPhV11cYhjlxbwc1z975PpkyYeKfVxADl7/cOda0ek6xDbQvSgZ4rrSg/PTwL
 dzunG5F7B+weJsh8leKJKzSgLHR4urSzmrWDIMLwKY95jT5z3WJHs0oKxFZrGVCXPMHbToHyMUT
 JVnUTUds6ITX6v/0yWcpCWRqtHXMXCKHeVdLz1N43sX9wxAmPpiAclvS0Avx5ImPMuBWiUoVr0r
 8hhQkzyBW91aZPzDzwvS6BQiTpGdncYNOV0kPOVjv7qhJZiVtp10lWRO5hQvirrNWDyK+wfrWIO
 3fvk7XxAQgtIJvCAoUXmWuifUue41YG/5SAqxD9zkASmRyoE0pTxBf9W30GlbiMse8JJJ01MDhk
 VoGN+yzlMgVZjGpMEHVxnqaVhunkln9056lEl4ShUWblt7SA2qliVY8CZ/wZAkOknbaZcEz+f1Y
 hBGBZRHCbNFHZGsRq54hP5XCbVAru5TZguBtSq//Dggurkn1PvjE=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Prior to this patch, we assume the uart clock frequency is 1843200 Hz in
the early console. This behaviour results in garbage console output if the
actual uart clock frequency differs.

The UART Clock Frequency field was added in the Microsoft Serial Port
Console Redirection (SPCR) specification revision 1.08. If present, use it
to configure the serial port with the correct uart clock frequency.
Fallback to old behaviour if missing.

Add function `setup_earlycon_with_uartclk` to set uart clock frequency
while still allowing to reuse the same console string with
`add_preferred_console`.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v4:
- merge patches together
- rewrite commit message
- Link to v3: https://patch.msgid.link/20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de

Changes in v3:
- add separate function for earlycon with uartclk
- Link to v2: https://patch.msgid.link/20260525-acpi_spcr-v2-0-c042089d73ca@posteo.de

Changes in v2:
- fix uart_clk_freq possibly being interpreted as parity/bits/flow
- Link to v1: https://patch.msgid.link/20260505-acpi_spcr-v1-1-fd4bc6f4eb53@posteo.de
---
 drivers/acpi/spcr.c           |  3 ++-
 drivers/tty/serial/earlycon.c | 17 ++++++++++++-----
 include/linux/serial_core.h   | 11 +++++++++--
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 73cb933fdc89..c79c809f49d4 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -228,7 +228,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	pr_info("console: %s\n", opts);
 
 	if (enable_earlycon)
-		setup_earlycon(opts);
+		setup_earlycon_with_uartclk(opts,
+					    table->header.revision >= 3 ? table->uart_clk_freq : 0);
 
 	if (enable_console)
 		err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
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
index bdc214386e4a..9b2bcd4295a9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1099,11 +1099,18 @@ int of_setup_earlycon(const struct earlycon_id *match, unsigned long node,
 
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

---
base-commit: 237a1c39e8dfd3e1c6f1f023eea37a48ec04cc63
change-id: 20260430-acpi_spcr-61902fd923f2
-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqOIQQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSt08QALWMim65nIIS428BheYg
aq6BqxDGGqORhlf7aCFGTtNaeNDsu1Tny7sNTe+TEXpKl+AwoFTJ+4+bxl50AYyp
8Niod0JGjEoxkQKsU/aScvCvEvMuPXOABfUGFtzieNpfswU2n6LHjywy+RP1mTEn
aPP1arQGGGhe5b5lvolREN0VbGvymtiLr6P+qOhs76ib/dkOegq2/njBX7UlQ7Fy
dIQo1A/NayUn5F7VWQKUz6ZHLX9bVZYSe2gstKpl5C8Ybwfaj/HgeT1TAdMoQ2K/
KG0HgcWwIyoIaIms+yED6WSQKJwexx4zn/t2w/Qi2eSVF6WSqNdY3rrHf3sY3luj
g5wYs2AvNnGjQU6iNGs7DLwwasHgqwZcOwRIdTvY8z3UP5Wpj5y01a+dJJG378zR
cZhEQUmDn21jBlJvpqSKUoNRZc1L/8uNfQLbnOMVBNOUBXIQ9Z29j2IkqGsYeTG8
uUndjyA/2SlEU29w2G6/MnJykNiW4oMxryXabXvh8dXc+SPQkUIM71ivo4y2/HgM
3XGz9l+cgJk61F0oAHtzie7MorsEGVLMA2n4TpibkUCLRIjK3e5QvEBDHZILWHPA
k2b8dkF2cdu8Q4nbI3PzXUFzuq/rsBpncSvYd/zDQrEMxzhNUVmuX7B9Ws7I0P36
VKkGQqUFJNNx7LLynD7XaJ7l
=nupY
-----END PGP SIGNATURE-----
-- 
Markus Probst <markus.probst@posteo.de>

