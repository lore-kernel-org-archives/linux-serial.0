Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EC498E2E
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173935; cv=none; b=HlprCn0Zexb5FjpOHkuWWEku/q5gFwjLIkfnVRDBCgvNM92jCw+ymcbo7O5zEfoTXEj/TTTHqFSM8dm2JgNCYURQJiuebm65zp3Ems6ZBZ3AnpswlmORdFz5lAh1/Rt1mi9AC2NyydzFjaO0LlzTLnA2JjmggeWHo5X4/9cVovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173935; c=relaxed/simple;
	bh=GF3qJ28po4tzQKhOOmc1ZjYhXtmA/fVN39S6nEBHPRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U9/9JgeftDdEIu+F46E6AKQSy9SGwn/ItqWjbJzgJ3i8UoL4NB9a9441IjKQKT6k/pYdmcm6UCo3gUWxQNA1YfRMNSBfc9Jov2EiHG0HC2LScTY8nqiqH893HHMvWdeTFYVqeSiqY4pr4V7+xchHiygxSEGt+f02gtHRlS7fKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=HrJrEjfj; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HrJrEjfj"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4F259240103
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 20:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792173932;
	bh=4KZfnZZWUgpacNaNvWb37H6nYeezWlIgqRQQEVtr3Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=HrJrEjfjgivQSE0nrTovZkcjBla/eWblOihzDJU5SAUTVFj/izb1WeeXDCTQaBNDm
	 lB8HAPBEiL9rSYaPuQ4gU+CHwpT6xOCuX69XqU46GmgqJAUB9tYdBhmeOciWlwnuWF
	 0N5bmluq0R3ACOiGubE2zgzl8r4+oJP39TsywoYwzjlkodb+j1cHLa26F6Wmvu7Zim
	 Bx93oreW2xC6nQiht7IxAmqGL+zQZhwwUGgoc5tK0YlxZ1nO1oeZ2c8MJabm4Dwj3j
	 LY9rWx8KykeSRQJbCOAhiKHrJxpBnFG5XgExwi3naq0eDogNR+5+NQbpe8Ehr8Efer
	 BmuMqQveNUOLQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j5tCH13b5z9rxM;
	Fri, 16 Oct 2026 20:05:31 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 16 Oct 2026 18:05:31 +0000
Subject: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency field
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-acpi_spcr-v4-1-f9a96fe016af@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6200;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=GF3qJ28po4tzQKhOOmc1ZjYhXtmA/fVN39S6nEBHPRI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq0mdqZhcEpDUIIAPU9+EHdirBiQl1T5vHCIACO
 nFbi9oCjDuJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCatJnahsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LvQRAAugL0uF1vopl6dbDFBgWjc44+XwB3E7P
 l80N9Br+lLg4YO4qNcEEGbVuq/h4UJxLteAGoYKmfUyh62CnUHs/T3dsMRg6uerr/jIptCXIdAd
 TowZtIgsmRjaKj8JYlEgnnwpvQ+u6/JtL2umSHmQmKT/zH40kFnqMsCSu7OiYaD+0I8vSwp9X9X
 wD2teItNAZYxr2n4lTBP87ZaU7WIQuGxfKhtsg0k/RyDci8mklGM5tpjj7ZlKu016JCwbAEVxBj
 JgsPHCyVg0frHSRiLnJ2boAAIk1LBFupvuExA66oOggM719kLQeGBYdP5XHrt+4GFW2bpukxUTB
 ubug+p3agV17OAjvpTLFpDeRNz92tp7W/7AwpFepwGHV0maqLKUA+iduI2WIF/EeXPJg5BYZwYx
 33Y2aswQlOmgXnSPf5l45Ni0ExKjFL8qD/AmLY7GgGVG3Qg3i1UrFdrcS0sMoz/3JjEEhe3hqtV
 8aPJ91nRYMoS9gAfVHqanQiXmKp5LjD4/JuDBZNQuNlAx7jSl1nzDUZAZd4GTP9Ay69jc66Dd3W
 uSb611FU6ojT7vRtEhAf0dCetf3eZy8Eyy3qd8tPGBqzqstVy08hCYWQ7/e3i4Bq+RsN2xkbpCL
 +qW2NbrN4ntoM6g0YhXCks9VMO8ycpMDTZThTWYVmXIlzdBlhI3I=
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

