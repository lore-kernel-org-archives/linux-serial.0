Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="eaE4JBTn"
Received: from mxe-1-51d.seznam.cz (mxe-1-51d.seznam.cz [IPv6:2a02:598:128:8a00::1000:51d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D7125;
	Tue, 21 Nov 2023 00:28:31 -0800 (PST)
Received: from email.seznam.cz
	by smtpc-mxe-b7dc65f8c-7rcq6
	(smtpc-mxe-b7dc65f8c-7rcq6 [2a02:598:128:8a00::1000:51d])
	id 7226a1698cd213c372a82f71;
	Tue, 21 Nov 2023 09:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1700555292;
	bh=J2I1LgR+R5ZrT9fKUyz3O47ieYqVVfjxD2dhJj8QCJU=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=eaE4JBTnoBKS2rFUhOZKGHIK+dlToqaFK4eYJ7HJpjDkBxTHk0997zS+U+QjJ/PSB
	 Y/gzB7xjGbuIuKlLe+bZJKq/4BFNp7dPeejDFleXZlXEHeSyvQJAIfgmk34kYDAd4U
	 50JWNQ83yKbqmft+4Nprd0kA3khadoW0xir73MrochxH7wmgaPdlmJKOMnykuY5ukE
	 kz8kNqESEOGcLszKdzM5nl9dqKAeRHKeFJHNiGMnmXKncMooTSy6fkQ/0m9hau08Sv
	 L0tbcR+kzFqVTMDy839Ufw2WMon1L5DFIGWSHeCUo3C5hOvAqZQEId9tGTbgatPRIJ
	 2d4hBjJtoCZgg==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Tue, 21 Nov 2023 09:28:10 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Conor Dooley" <conor+dt@kernel.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: =?utf-8?q?=5BPATCH_v4_1/2=5D_serial=3A_core=3A_Add_support_for_en?=
	=?utf-8?q?abling_RS485_mode_via_GPIO_at_boot_time?=
Date: Tue, 21 Nov 2023 09:28:10 +0100 (CET)
Message-Id: <3Za.ZZs}.ndXI8CMee4.1bN6eQ@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an option to enable the RS485 mode at boot time based on
the state of a GPIO pin (DIP switch or configuration jumper).
The GPIO is defined by the device tree property "linux,rs485-mode-gpio".=


Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/tty/serial/serial_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_=
core.c
index f1348a5..f1bf0b9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3603,6 +3603,18 @@ int uart_get_rs485_mode(struct uart_port *port)
 	}
 
 	/*
+	 * Enable the RS485 mode based on the state of a GPIO pin.
+	 */
+	desc =3D devm_gpiod_get_optional(dev, "linux,rs485-mode", GPIOD_IN);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get linux,rs485-mode-g=
pio\n");
+	if (desc) {
+		if (gpiod_get_value(desc))
+			rs485conf->flags |=3D SER_RS485_ENABLED;
+		devm_gpiod_put(dev, desc);
+	}
+
+	/*
 	 * Disabling termination by default is the safe choice:  Else if many
 	 * bus participants enable it, no communication is possible at all.
 	 * Works fine for short cables and users may enable for longer cables.=

-- 
2.7.4
 
