Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099266;
	b=R7gdkc3U3V9x8l7r/kh8/4+NKA2SP60dwhGEGb+D6zWCx0CO34QenkENLo76QAAz2l83
	 H3J2c0p92PC2hanUGwoEL05lgXHixf4Ugk9DxPti/FfQFtqY0pORG7R3BEc5HV0IHCrKI
	 YEyh3n+q73bgcWpw0bLICr12NqkOOxje4uemTVKmCUfAGVD0UTRo/01Jd41qQYoKbh1ww
	 ZUH2ZvVeQwtRq/jG8YgAb6hOaRKGW/7yC/sOrFLOcw97pmYuyj755ZwivsZ8sHi72tV5v
	 wihk1zCwwe/pZE6DVca3ef27DRjW8vyfZ2teZftlhEYZSwg/jXMw3uvq+O+9urxxT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099266;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hX1IybcwZHfg8HPSk/LvucEct9x9S7mtJroF/uWcHrU=;
	b=Dgqs4uKCr89IJchMedscac/OeIJu0H3jbaSEXzV7MGHqVhkiSf7Q9HbSstMLIeGUCT1W
	 3l0Xq4ww8v2A7AVkQkxvFY2ipondZojlmADWVQrYjIBvXlhwG55s/Eiz6yJ8VmxxzI9+o
	 6pxfN8FsVarZsMGV/orx130Wfl7TqILE9QBiwwTjIorjHEuySLxNZRCZhjw69aYRDWYww
	 CjlwAwmL89fYgRfa35DbPLJ9OTM66vTiYrdKKw/7xppV4CeH+ven0fqWGjz1r5W/tQ/K0
	 GNauhLzZq9FuO8kZKsvz1yEbStKKkClodOa3YgtE5N4J0KmrFJ1iVFHpLtIn9PBKjoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wsv1AXXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31A60A5BC6;
	Tue, 27 Oct 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wsv1AXXs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964111F031E6;
	Tue, 27 Oct 2026 11:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099265;
	bh=hX1IybcwZHfg8HPSk/LvucEct9x9S7mtJroF/uWcHrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wsv1AXXseyHMZl5E5X/yPCRZltrp8LXJtZ8jZuPl7h3O1ribCFumGvrG8ubLuYl/y
	 dzD3C8ShUjvB7/jBYT+dId4Ht29WGDxrJrNv4zEX1CsVaPi3yjhTJ+zY7eX2wzJAsF
	 4akoasC3Y2ByiGKfN40yjE3cSfxE/YUEET/2r+XA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:49 +0100
Subject: [PATCH 23/24] serial: st-asc: don't report a wakeup to a closed
 tty
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
Message-Id: <20261027-tty-llm-v1-23-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
In-Reply-To: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Peter Hurley <peter@hurleysoftware.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Olof Johansson <olof@lixom.net>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Robert Baldyga <r.baldyga@samsung.com>, 
 Thomas Abraham <thomas.abraham@linaro.org>, 
 Kukjin Kim <kgene.kim@samsung.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=4xNWd1JLA0hRtkumnNAjSS6aWUNc6ojMfMTy5+lpRjQ=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvevnnDhfhP7lkaR/0ul5t3OfFJx93/bxQ+J5oZr9
 j41/XUzpSOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAm8iaWYcEm1c6Gff6hJcJT
 uHesfWFutnuySD7DgmOHkxcsFRA237HwicPhJcvmtPxn4gcA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

If its interrupt is a wakeup source, asc_receive_chars() reports the
characters which arrive as a wakeup event of tport->tty->dev.  That
pointer is only set while the port is open.  The port of a console is
not shut down by the last close, so its interrupt handler goes on
running without a tty.  If the system is then woken up by a character on
the console, the handler dereferences a NULL pointer.

Take a reference to the tty, and leave the event out if there is none.

Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
Cc: stable <stable@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/st-asc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 6ed9a327702b..006874598b6c 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -262,8 +262,15 @@ static void asc_receive_chars(struct uart_port *port)
 	if (mode == ASC_CTL_MODE_8BIT || mode == ASC_CTL_MODE_8BIT_PAR)
 		ignore_pe = true;
 
-	if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
-		pm_wakeup_event(tport->tty->dev, 0);
+	if (irqd_is_wakeup_set(irq_get_irq_data(port->irq))) {
+		struct tty_struct *tty = tty_port_tty_get(tport);
+
+		/* A console goes on receiving after the last close */
+		if (tty) {
+			pm_wakeup_event(tty->dev, 0);
+			tty_kref_put(tty);
+		}
+	}
 
 	while ((status = asc_in(port, ASC_STA)) & ASC_STA_RBF) {
 		c = asc_in(port, ASC_RXBUF) | ASC_RXBUF_DUMMY_RX;

-- 
2.56.0

