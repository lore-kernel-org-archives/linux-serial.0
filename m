Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE31D096F;
	Wed,  2 Oct 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881987; cv=none; b=Hc9oGoffq+zdMdJTY6Ru0L/563DmkbC6euTHHjqs4QhQ79BpDIhv20Q2PR3Hmhsoj/bWWpwrPN1LZoJYNdPHilsQWgv0mmnhYuyQACE5K8IDKF8ZYFKBkIlgqfsk6IVB1isC+0LqYNhJQ7ajMnoDn4m9q+I3pZFjEDSMxxiTw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881987; c=relaxed/simple;
	bh=tY70Ze/CHWwT5bdbgC6inckAJYqueXmmMbOmrFgxhLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQf32XF7YKp69C7yqVqkVCOvOffWUkgkcbFe5WItRb3zp4wElOoXhWomYCeHdGjT05NB0p1DYtBuVblxbqS9MMHe11BCKAClbIVJhfeW3mj5TfAZwn2fvULOXsKxtu8W1Bk9uHaGBU41PUVEWTdLVAZrB67AXlJYqTfdmcGj3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=Js/UIovm; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="Js/UIovm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727881975; x=1728486775; i=parker@finest.io;
	bh=Mt9PJle5Skz6w5r8Bol4+nvFpa1B3jTPEiwNoAdON2E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Js/UIovmefFM1gurV1mmphYdcPZaYeQky9Ufv0SN5qfNySZDMqsZLquE4+GWPWGM
	 VnNPa/I+7ZxDSZvsZ8cPI0nHCajP1HK2puyMLPS7KHUpdtUCPY8W19rD3FHq0nvOv
	 OB/6JShVKkXvYpruwSZyeNEmVBFz0kt0wtyT781UyUd21XZbMGahk7OHQvzWsTy7i
	 pklRXWYdkDnDR+gChxlBHM0S35xEXRAzbcYOepKLWTXGT2iyqnEGZSPRyQtT8baDA
	 A9r/Z9tNQAo16OKc2L8VTWr/mXfqmesEye81eHRvwmzCvn2aK+Dpj+BEH7Sk/vaPb
	 mKRAuVVXCyeJSyu6Ww==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LqBHC-1sIZXj0anY-00krAw; Wed, 02 Oct
 2024 17:12:55 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 1/5] misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
Date: Wed,  2 Oct 2024 11:12:33 -0400
Message-ID: <0f23973efefccd2544705a0480b4ad4c2353e407.1727880931.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727880931.git.pnewman@connecttech.com>
References: <cover.1727880931.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fFVlQdoOksGNgvYqYzX3MV3voUlaHvA47a8twACPN+rbVGsPhH7
 vjxK5DVeFyviuKJz1wkUeqQwCndMBrjWaTBJjcGm3VigFqj41Xp0Ln8pWPbmRhNMTAmyTX9
 wmRBH/lmo+GgXcNCGavT6OHVANrgrXgkRGcZ09BLGpEU7UGr2NtcDPEbF+SjVoPRfwrWozl
 +rGAUiVbkQjsCp3SoQfYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mxd/X1rVyMk=;4GIIT9aT+ckUyyYciL64cClzFN4
 7jWFw6JVxKVJR61U0TuIfh7cl3pARnP6IpbnEE0XbTIXZ0DVbSLIrT93NIaGtLu8hA9Nhp8eK
 I2GZ2wU3prpdC3JQU9K/VWZYz3zqYGoOYe0LjI+hwy1tWx5g+Iq6TZApN3EBFrluCkyn/pJWO
 Nor/DXm4ep2rUiSz8nqavBGN6OZFNTgbX8kwyDL9zUZSXLT+PLoXlyEaTIAYOyus8y/8jLHur
 Y4I9z+5b/NZTFi9yO488N/Ffo61rBe/bFHZqOINpdDh/h8/uKku2PpbSKaiS1M8dhfDr63EVB
 ezwLLM2v0ftIetXXPFCT1toBugXjopi5rMjXYNTD+sdKhT1G6ls0Os1QQ139oqQIgF3waeUfj
 vge0g/qoiZQCDbNV9b95ZsNVb8ApocT10K9ZOOom2eDfHEZb4KPeezN0PTHrlHUO7ya17hFas
 quk50mg5YcgkLnAuPRTxN57vSB0oOoSS41E9Xt5Hz3fJm0Wamehx3ymbwWMYTWijhgLJ4ykDn
 MQnvcdsdyb8McD3r4DcREgXhy9EGVtbcJa5TFhCs7gHJZmnyZ+ez806zagH4NZAwnm8Lo1BVl
 I7M4RpGF3kx9Nr2ET8vdsj+M7+gqk0GrtIAqdXyfb4xczSqHFSWCcuL061EVww244dj8aIYdV
 oR7qkkaWvLZa8TrI9DLGe/GGALu7IlR1+lfmpv13dEOpjRBYjU6REoJ8kBW8xCFAgiCMLIzvG
 obq96ghNTyRRfqx7VEWtvb2rCaBOm+VhA==

From: Parker Newman <pnewman@connecttech.com>

Add a quirk similar to eeprom_93xx46 to add an extra clock cycle before
reading data from the EEPROM.

The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
of the op-code/address from the host to the EEPROM and the reading of
the actual data from the EEPROM.

More info can be found on page 6 of the AT93C46 datasheet (linked below).
Similar notes are found in other 93xx6 datasheets.

In summary the read operation for a 93Cx6 EEPROM is:
Write to EEPROM:	110[A5-A0]	(9 bits)
Read from EEPROM:	0[D15-D0]	(17 bits)

Where:
	110 is the start bit and READ OpCode
	[A5-A0] is the address to read from
	0 is a "dummy bit" preceding the actual data
	[D15-D0] is the actual data.

Looking at the READ timing diagrams in the 93Cx6 datasheets the dummy
bit should be clocked out on the last address bit clock cycle meaning it
should be discarded naturally.

However, depending on the hardware configuration sometimes this dummy
bit is not discarded. This is the case with Exar PCI UARTs which require
an extra clock cycle between sending the address and reading the data.

Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEE=
PROM-AT93C46D-Datasheet.pdf
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v2:
- Moved quirk define into struct eeprom_93cx6.
- Moved has_quirk_extra_read_cycle() from eeprom_93cx6.c into eeprom_93cx6=
.h.
- Fixed commit message formatting.

Changes in v3:
- Commit message wording.
- Rebased to v6.12-rc1.

Changes in v4:
- Remove trailing newline.

 drivers/misc/eeprom/eeprom_93cx6.c | 10 ++++++++++
 include/linux/eeprom_93cx6.h       | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eepr=
om_93cx6.c
index 9627294fe3e9..4c9827fe9217 100644
=2D-- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -186,6 +186,11 @@ void eeprom_93cx6_read(struct eeprom_93cx6 *eeprom, c=
onst u8 word,
 	eeprom_93cx6_write_bits(eeprom, command,
 		PCI_EEPROM_WIDTH_OPCODE + eeprom->width);

+	if (has_quirk_extra_read_cycle(eeprom)) {
+		eeprom_93cx6_pulse_high(eeprom);
+		eeprom_93cx6_pulse_low(eeprom);
+	}
+
 	/*
 	 * Read the requested 16 bits.
 	 */
@@ -252,6 +257,11 @@ void eeprom_93cx6_readb(struct eeprom_93cx6 *eeprom, =
const u8 byte,
 	eeprom_93cx6_write_bits(eeprom, command,
 		PCI_EEPROM_WIDTH_OPCODE + eeprom->width + 1);

+	if (has_quirk_extra_read_cycle(eeprom)) {
+		eeprom_93cx6_pulse_high(eeprom);
+		eeprom_93cx6_pulse_low(eeprom);
+	}
+
 	/*
 	 * Read the requested 8 bits.
 	 */
diff --git a/include/linux/eeprom_93cx6.h b/include/linux/eeprom_93cx6.h
index c860c72a921d..3a485cc0e0fa 100644
=2D-- a/include/linux/eeprom_93cx6.h
+++ b/include/linux/eeprom_93cx6.h
@@ -11,6 +11,8 @@
 	Supported chipsets: 93c46, 93c56 and 93c66.
  */

+#include <linux/bits.h>
+
 /*
  * EEPROM operation defines.
  */
@@ -34,6 +36,7 @@
  * @register_write(struct eeprom_93cx6 *eeprom): handler to
  * write to the eeprom register by using all reg_* fields.
  * @width: eeprom width, should be one of the PCI_EEPROM_WIDTH_* defines
+ * @quirks: eeprom or controller quirks
  * @drive_data: Set if we're driving the data line.
  * @reg_data_in: register field to indicate data input
  * @reg_data_out: register field to indicate data output
@@ -50,6 +53,9 @@ struct eeprom_93cx6 {
 	void (*register_write)(struct eeprom_93cx6 *eeprom);

 	int width;
+	unsigned int quirks;
+/* Some EEPROMs require an extra clock cycle before reading */
+#define PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE	BIT(0)

 	char drive_data;
 	char reg_data_in;
@@ -71,3 +77,8 @@ extern void eeprom_93cx6_wren(struct eeprom_93cx6 *eepro=
m, bool enable);

 extern void eeprom_93cx6_write(struct eeprom_93cx6 *eeprom,
 			       u8 addr, u16 data);
+
+static inline bool has_quirk_extra_read_cycle(struct eeprom_93cx6 *eeprom=
)
+{
+	return eeprom->quirks & PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
+}
=2D-
2.46.0

