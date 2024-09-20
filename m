Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340117BEBF;
	Fri, 20 Sep 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841061; cv=none; b=j97AGLgKInQJ3k7In2OmVS15Tj3H6fRhN9zKqyvcLnsleb0nptkELCGRowafAhIHnmEmchJ4NQ74SoeKCKVQBlnERU1xV4iOhP8mHVR6kCRtA5BTLdZoT3iRcr40EGHZr4ZrgjNGgpWV0mclSa7HHF7604/9WlWmuwQNSiV3YgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841061; c=relaxed/simple;
	bh=3tMpMExSP8vnlpdIaroyNHu0kVRPvDaPDScagyoRV0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVjBs/sSZREpIq36mKmQ8Mxp8j2J1tnoj9sS4EX3rHwg23THfnjWfAyVoxCwqftjpDGp1bAGB00YxGvT7PXUCwn093I2zWUhUNskVjcU4a2ElKq8rkBtsnzNEfsyj9q7iED6mbc+ulSa1o6RqWoMwD8IhdJigyDmJizGLDvbcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=o0+m8dkP; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="o0+m8dkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726841037; x=1727445837; i=parker@finest.io;
	bh=Do9t6U2j/JcAt3TP89H4VkzWO/23+OkcmaE5mLIMiK8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o0+m8dkPC9StY3YIjiXCqowoWKwYGwdzhhS4olxRrZzxxyduAkzQXkCCNUPSprce
	 epMHi3yzd8BpUdCcU2JU5NyqKIJqai8xrJOtt1YQ4jWt7Ihd08VfW+64tIW5K6wol
	 4Y81V0m66lkXLC4tuJqaK3n18H9DxlgymzARBlwmhV2ntQww39vAroo7dKde1aN10
	 AlcQhZhOT+rCPds+UsXyDhNEFgUM0HxpTgYWXrawFlT+C7rqbjSwIxi8cb7NNTTFY
	 cz4JXUvthLbexmlXyN8/LVDFAAvy+i4CztdrBFpvp0JAHBxd+iFfWvbHHgPDL6/BN
	 UT+PzaksTa+/uIagOA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M55Ka-1s2SpP0QQg-011Hx7; Fri, 20 Sep
 2024 16:03:57 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 1/4] misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
Date: Fri, 20 Sep 2024 10:03:21 -0400
Message-ID: <b92bd58e016a14ae95e259ffbdcfc5e5da6a7aca.1726838531.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726838531.git.pnewman@connecttech.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x6L/U4VIQ7kWp+Zckm1C0zh/q5cAZ6I23V/7NM5cT19u6uNt5su
 O4o/alm37BMVQW78GJHQsw5uKrwiuOAfUWIsgBogfEEnm1LG9AnjG4xAtBMs13LViWPoMrq
 sne+Rs7IwL3TVhUiPSH1tIY7v8tqTKQVYHRkfPnkwtDwWDbkJb4rMZ8mPL4TaYeDCQjOH+n
 Z8CGxcZtrtwo6f6x6IiuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:14KMAnfEqRU=;RXwB3Y0o5hLo+pIY9qBFUBXAxxz
 U9DEee1XR+AFBj/Y9kTvJjzXa17m0lq8UM/KqcciaWUnqvQYzQrzbJAECvvksyUxPUHm83N4o
 5vcKQv9ZG4fajZccb/zmA26UDF41Xnc4mGYQ7i4gGRB0Qxq/9LCiNs0vuHWvrwlvdjAp8fvX3
 TxDpXQSAAwRqEy+sCA0HtKcyPlY/9U0ByrQDCebAukfzcH9JRPlpOhD8Gg1ZkqwRPgvPx6HXO
 qPebO0YzpxwNX2jdHEgktebuJEZMZrDCip9VY4uNNENhwPXlSr1RkRaz3EegUzu0CyNup4LV4
 DbQN7sWEeqynQaOnkiNsxP5rvIUsEnJ8Knd2/kA5DSvUVoCrn/EZuBTSGjccHMT/o3SC4BL/W
 cpyj+Z6B2Uz2Mt0hFp5YU/a80CJ1VFTnXpyKYvCb7VpZLd1pRbHT/A7TuPZkPGJ2i2RCZZlpa
 nn6MCQpIhMYhOrEMQvcXA9hwzWmswBAatv/ryK9VXc1Rs3zcVqoW73fi5Gd8/9DVuf4ZjuxvR
 cIVVethoF3Ey9GweAudzE1K73T8mTirSyiLqDeTw/CbzxmGcvvfqZkvqQ8OWNg4xI6Pd+rLB6
 X71hV2WxJYJTQYvDhg0/qVT92dCKrW7RzLxyh/SSgnRcrL5jRg3ilVMLrXGIoe8yZvUH0wv1U
 L7zXdonGaO2x4RnCFJbc1tVBdtdg4f62RhXdoNr6BsJua9ch8dwi3C/Q/wQA+hOCwdfrXy/KP
 A6uGgrUA3KEQY0ojZ1EWgpdRrTHYvUPsw==

From: Parker Newman <pnewman@connecttech.com>

This patch adds a quirk similar to eeprom_93xx46 to add an extra clock
cycle before reading data from the EEPROM.

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

Link: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-=
AT93C46D-Datasheet.pdf
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v2:
- Moved quirk define into struct eeprom_93cx6.
- Moved has_quirk_extra_read_cycle() from eeprom_93cx6.c into eeprom_93cx6=
.h.
- Fixed commit message formatting.

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

