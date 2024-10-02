Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98D1D0E0F;
	Wed,  2 Oct 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878492; cv=none; b=h7C5lrf+mIYf/Eax/ZeFP3/I7bmw+da2J6LlfiD34eJxL6EIJuYkDkPrfK/nJuzgw7t7XiepFWI/uSwwnt8dFg/FTCTF8dBOdDf4g2V0IcJfDMchhnz7lA5Xn/awhjhHonIFaVGu1tQy2q0gih5YDSqU7igotzKElq8jOBnYM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878492; c=relaxed/simple;
	bh=7aqkOngVxygtLPGqFsKk6bcTWHSzYy6NtyfV+U0JNQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeHEj7ygogL6vRZdw7FYNkLdD4mxquanrafp6eIgiu5MqY8N+WGxbekgBzBszl4wrRpbhD41blmM9eFeC6DrkNGYro5Mvp4eHaNveIEDji2bKUV0Yt3kofl7YNCugvB1dj2Gm9uxSJc5Ls/ITnkG7XKGpVlNqXY7h63fgH4j6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=IC6kOMeR; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="IC6kOMeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727878478; x=1728483278; i=parker@finest.io;
	bh=GnYdg01IZ/X2ESoP4ioG/q3q4BjmdQgQIgLEKpnw3wI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IC6kOMeRPm3FkLSmWIG8N7ULS8+etVA1tfOkhmalpbecUvY3NZhNMdrN6Fx2Lw3k
	 SiOHhpQ3SEwAmNt0rwt8PQWDYbUUWkoRaR6Euy4EfPJcsJ/f4zhQEIjHaKjbnjtOH
	 4qmYr2hwO17wTCfq5jABXWxD2VOIeoukROJmSvVUwjzDyNTCkXX6jwUE1bzS5O8XJ
	 hVJnd1VxmAUupd5TP9FufLwQrSVqu8jnhCtnmmLUKLh646HZ1aUzjpf26eKi04Ojz
	 Sigv0hH5nfLo/T8O4uvyVUUilbw1m+4LyrgMV0cG5yVVGK2DbGx8ReukHMdGoIBaV
	 vzPTuR0J0xPCIpyXqw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MDQFe-1smgSu0DKQ-0043Jw; Wed, 02 Oct
 2024 16:14:38 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 1/5] misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
Date: Wed,  2 Oct 2024 10:14:07 -0400
Message-ID: <62eca5d814da3734cfa984a78e0978efefbbc827.1727873292.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727873292.git.pnewman@connecttech.com>
References: <cover.1727873292.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+uja/jXQ+/VxW8cdMow0/x3evKiMWjJMbxpa4SFA1GTUNVfXGeW
 CsCqCTEBqDe7n9azc0GVZ1CWdzzdmYXjebuLkg3kDLf5+MTcOLnZ/jeGFssrWv4P8a9Ewvy
 AvHi5T5N96hqT5ctOVeOOa7YjH/EBlttLWabZlqyPm9uIyxjDH5a6qb4a0Zr1b4fIhEU3GO
 uDQh+xh+SntSHYAYfzdxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1pe8yxVaGKw=;dkRJEcmn23xxHJNHzPwjoZ7LAlg
 iaZoHFJw+hZzareu68nEJqnqu8f+IpiPM2ZgIflrMrIocGwWcZlySH5nPPdEieiUdIjf0kL3t
 53jIvIep20h+zjY8IBoAaEfThqjPsvKYzX0pTwS/iZyLVipY9hlJlwnz2ze6nQqj7jnZjtKEH
 u91/Cv3BTm1tIyKngEgqRya6dwz9oGIDoXhEg78J/Snfi4f3hLKfYynacK2Q6vZcY6gT3sbqR
 fT/b02Y8CFcrL7OIImsLdt7pLmo+S/X8bP6Hr5NUExCX+0OpkX0lgSXbzCCS3/BHRDladuGzB
 UpmQskpaPDOod6SCxt94UPEdtKgdLLYFrCLTpqozrNHMhEXOv2wh32abbBClWZE8Hv9aFrkRL
 TZmnm0e6fXhYMl/fmpRUSkoJqwTppYKwpmVhOoiQPV0leJ6t9NgyuKtlOobG2uDn0iPsmvTMr
 0YwU5amt6Mp3xit08bov02jF5vos4aIh5mPk0nlPbzAfEFf92Wyoo+hKWoZFszBE2KVK07Uqz
 QdHDLQJkO2+rnScQ+xPR81gAoTgw6NS1mb/QzHP5/TvORfPlNRPePTDrQfAxFU44kEq6ZbMcg
 Xj5j3w+NNwtVilIsLOuMitZZ9SPBD6PYIwI+TEgODRUBX98vG/7y3d0qNAcaiw9AbpCt532mE
 50CuOWpnYZwh79tcebOP8KhjGUgrnEFCKJipY2vj0kDiTqyyMBDtq21kcfuW8LM75u+AO5sIw
 1J+rXqFPlUGHMfzXNPb8gUZF0gmUhFH0g==

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

 drivers/misc/eeprom/eeprom_93cx6.c | 10 ++++++++++
 include/linux/eeprom_93cx6.h       | 12 ++++++++++++
 2 files changed, 22 insertions(+)

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
index c860c72a921d..4d141345f4d4 100644
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
@@ -71,3 +77,9 @@ extern void eeprom_93cx6_wren(struct eeprom_93cx6 *eepro=
m, bool enable);

 extern void eeprom_93cx6_write(struct eeprom_93cx6 *eeprom,
 			       u8 addr, u16 data);
+
+static inline bool has_quirk_extra_read_cycle(struct eeprom_93cx6 *eeprom=
)
+{
+	return eeprom->quirks & PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
+}
+
=2D-
2.46.0

