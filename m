Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA992576F;
	Fri, 13 Sep 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239414; cv=none; b=AGC5cY2qsYjg6k0C6G/Q7wW5VjcRYXjeN8JBE7pI/MQ9P5ClT71mndisVad0wno06EJ4/jYLvwyp+Ai2DgMpqKUf8PkUFc8i3LIT1UBVcEc70Bst0sUOgDx3yaIQi4Yztso6dV1i5wktvEOFmjgxPT2W2gvI8r6wPJ9lvMYvOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239414; c=relaxed/simple;
	bh=9VUjDB38D5gusKXh3tcO7Xgzucfd20lyIcwP8BR9ZnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lvw1rEQ+GXd3vqeisvxiTpyPUrTdkeSVxDW+YiBHixd4LEKFGT+zXaMPrhhU+BItmhMOepJSI5aY221O1uAKzDho0bP16Hd1h3XptZFxRPsOIr32fnuhkj1SaFxv0o5seCy7P4CawSgKI5LXq6n14OHL8HSERUFbiETK8677xC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=fD5X7pf7; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="fD5X7pf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726239389; x=1726844189; i=parker@finest.io;
	bh=LYDFlSewnM1hZa6TohQSG+KKeWsX59McBuPFtyid5I0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fD5X7pf7gxdiPyUc2hMdUSX+UkoqXsV2OEA5u+Y21nEaP5mOEHiQos8weQx44wWW
	 j54Kq+xtVoeJvzporTiMnBatUASNbQTgcfLVofbgm5oJjELyLW3/K8U21+V4Rt1Kb
	 SErKF/NOiXUxqSFFSfGcZyuyEgtwJJqFJ7eNbLWQ6FqMV6M7EJr4Lh6T1croHdqa7
	 w9Er2NXIsx2R9B0bSh+2LHGt0TYzvM+3sxUPlK/EJwacxwGaJHlQsOBc4iZohdU1m
	 U626XuAR0kj2vlLRt1KW9pisEXK3gCMV7KU8laIVXyVGch91pAkNfjhvsvel6DaMh
	 zBTLWn1LnlTbq4ZOqQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MuUKU-1rywXe3W9i-00vOMq; Fri, 13 Sep
 2024 16:56:28 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 1/6] misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
Date: Fri, 13 Sep 2024 10:55:38 -0400
Message-ID: <d0818651c4a58d0162a898c3ba3dd8abf9f95272.1726237379.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726237379.git.pnewman@connecttech.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xoC21p7aRxHGxyZmTc45jiVrbvLLDI0okdT6q2ule3p0kB2AzP5
 G/6i+nDujSRi4K2tWXhPr6axTPdHdzcHCEZZFtmHRT/yDwnZlJXx+ybPaGa7Emdp2xsLXnH
 6sSpDSNiExEas7VAvMIFhiuIELkAvYXOGDEwkmVMQ5pSd18dkGfZo58IYJN6E5Jr0RoVYvR
 BLtxTY64HlH8gRheQzPLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WcYYKb1YQ9c=;vSEqNbY1/6hB7BLz3KZk3axaVyy
 Ks47fDX6XAvr6rIId0w7uev6QoXyki3n3E8ticEQxtpT9VL1IDv8vrSBYd6fLCrtqvRBNE96a
 1X7QhWvu0KLpBCdltCt/ZVHJtqgTunR9qYfi0xeeWCqYWB30BnueIRxQC3yLi1Kvj29W6jrt9
 9QgpdkUddVX9SjrZcFVa78FHybKpo4mo40SnxoeThjoocOFKnnmZH9XUxW+EvIoGQzQO6iUU7
 98pW5WAb07u/vzEWW5CIiq3F9tKa6TWWBvFKETlHsepvbKkLT1eMuUGFn0nAJ9YqhnmZ4Xhw+
 ygelwCtVrqd6+i2EMHxX5rLuFfRXRLICrH0UeInBSlg4lQBrfhLuUehadKFDP3QiqlUUaoywy
 b1XLphULJSkub8F4XtxaY1dSOUam0qPRDKN0kRlumVFc300b5zIAIrAlgkR9sqi01fpd3qNR2
 JnVL70S5lQ5Lj0EVvtrQvYeFIAUx2zDOheVlVXFGe7A6s44eUN1WEOTIl5fIyR8ax0iE+iEgG
 FeZu4+H5r6Mkutl25qjznvxvbWBXGK7GUqeIpvWCThMAYd9IRg4pjOFxSEPDZ5BJPc9/qEdF2
 ptN9OFHXgRwSkbBPMq18HSxAG0tVXGqoDZxkIz4CwiJijFtrEKYF5BAfwJRiuJa7lEIH8NXkZ
 ulzPdbdfewNvqpSwAmm7F6LFqvEJyh+Cn1PoMA4oZT2joRppiVeZagS4aA3/i1hlDCD3QpuOT
 2KesyO0ZSKhlNqU/d54ISfPa1IuuDWiNg==

From: Parker Newman <pnewman@connecttech.com>

This patch adds a quirk similar to eeprom_93xx46 to add an extra clock
cycle before reading data from the EEPROM.

The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
of the op-code/address from the host to the EEPROM and the reading of
the actual data from the EEPROM.

More info can be found on page 6 of the AT93C46 datasheet. Similar notes
are found in other 93xx6 datasheets.
Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-=
AT93C46D-Datasheet.pdf

In summary the read operation for a 93Cx6 EEPROM is:
Write to EEPROM :	110[A5-A0]	(9 bits)
Read from EEPROM: 	0[D15-D0]	(17 bits)

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

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/misc/eeprom/eeprom_93cx6.c | 15 +++++++++++++++
 include/linux/eeprom_93cx6.h       |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eepr=
om_93cx6.c
index 9627294fe3e9..0f52d3c4bc1d 100644
=2D-- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -18,6 +18,11 @@ MODULE_VERSION("1.0");
 MODULE_DESCRIPTION("EEPROM 93cx6 chip driver");
 MODULE_LICENSE("GPL");

+static inline bool has_quirk_extra_read_cycle(struct eeprom_93cx6 *eeprom=
)
+{
+	return eeprom->quirks & PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
+}
+
 static inline void eeprom_93cx6_pulse_high(struct eeprom_93cx6 *eeprom)
 {
 	eeprom->reg_data_clock =3D 1;
@@ -186,6 +191,11 @@ void eeprom_93cx6_read(struct eeprom_93cx6 *eeprom, c=
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
@@ -252,6 +262,11 @@ void eeprom_93cx6_readb(struct eeprom_93cx6 *eeprom, =
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
index c860c72a921d..5274bcc7ca39 100644
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
@@ -25,6 +27,9 @@
 #define PCI_EEPROM_EWDS_OPCODE	0x10
 #define PCI_EEPROM_EWEN_OPCODE	0x13

+/* Some EEPROMs require an extra clock cycle before reading */
+#define PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE	BIT(0)
+
 /**
  * struct eeprom_93cx6 - control structure for setting the commands
  * for reading the eeprom data.
@@ -34,6 +39,7 @@
  * @register_write(struct eeprom_93cx6 *eeprom): handler to
  * write to the eeprom register by using all reg_* fields.
  * @width: eeprom width, should be one of the PCI_EEPROM_WIDTH_* defines
+ * @quirks: eeprom or controller quirk bitfield
  * @drive_data: Set if we're driving the data line.
  * @reg_data_in: register field to indicate data input
  * @reg_data_out: register field to indicate data output
@@ -50,6 +56,7 @@ struct eeprom_93cx6 {
 	void (*register_write)(struct eeprom_93cx6 *eeprom);

 	int width;
+	unsigned int quirks;

 	char drive_data;
 	char reg_data_in;
=2D-
2.46.0

