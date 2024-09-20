Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14D2AE69;
	Fri, 20 Sep 2024 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841058; cv=none; b=phBOKjSnlIw3Ry8fPyOLFUBNQeSEuokTmUphTz+Gph8zcL+lL72eu+MuhkVynNdU5e4ZU1rW5DMjmA8OVAxnP9I5yD+F/iZTw29ZP9OGyJOgBuTV0m2iTCaTzCHIeYjFTmUsqrKjdtUamMhUofH3m6U1rni/KIpuJTykiklY/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841058; c=relaxed/simple;
	bh=PUPG6M15p+uvnOpnoGrSj/aP7/FefHXOvVcbz2G0/zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLcLvyoEOeYDuzi/vIqOrZofiENgrpUiefa1nyIE0EabqoYKvxOEysEgbId0iThwmsAHkD0w7LZ7b/bVyRmxwGYkzKc0HLbo+a//OEooeYxAGNko2ibQ5EqBd92p0DBoedZ9W58GgGybmTI1eJS+8s7o4wU46j/SOYzNU3gIXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=n+DpnBEO; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="n+DpnBEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726841037; x=1727445837; i=parker@finest.io;
	bh=Oh8wCdTiw7MRiL8RwHCp3icYa+qrj95ZJRnetzTNmZg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n+DpnBEOe012DfzRWrHa+vFuIMrJT3Nf4dsa2qKBSrFmYUXrdBu/zuQGnAySjdrc
	 PxJ9GBp2nOwspRQ7F221ELLYW9nhb12/bFCYhrDxw0ENlzAJjthnrbZKr0ANn9cYH
	 SFdMDeDzybGF9/CFBqc4p9pzQUUtWIyWhLACVdqV0c0JYW6ObBDx1OjJKaprmzOX2
	 zKFgJ3qgcoa9usUDJHRId9KKrOEKXjyoVuzh7gPnjeDtt7P07IXHN5e6mMQKW7S/V
	 QhgRNaerPl2oC3TzJ/WUPv2XQg3bdD3Yz4Z0RXriZnJkygNJ5e70qkV8d2YrfZJUZ
	 BGgpODaIYQEvZ9sOew==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M3ys8-1s1Klb2GN0-016nir; Fri, 20 Sep
 2024 16:03:57 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 2/4] misc: eeprom: eeprom_93cx6: Switch to BIT() macro
Date: Fri, 20 Sep 2024 10:03:22 -0400
Message-ID: <1c2406fc139015988b996b26b240963b9a35d754.1726838531.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:9Wv3aUwIDsx4x9cSI6mWBJflqxEt3IXmfu9IXjVGpZOGytEGYbu
 pTX9jo+nSck6/2mrUAVpkLzBbm3llv9Sg5VtGQYacFAHu5xSfCvbSIVtU7PPlAwF2w3162f
 EdBEzEgH6+/VmBq25LmcOwsKSj8fX7B1OTcgpI1CtdGLpyDo01KDfH66hz+hHyuOVjcIczg
 Cj9WZDB7a7p7d0OBh38mA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:guI1ujW0iqk=;rb8o7sSIkOwm5JcEqVpEeXHTAYV
 mg9uQhNIoTiCm83tJqd+1LnltAVGVESwHWTG7B6oh2/encLVQ8EbVDNc+PywOm5cdlPY3/xf4
 YZtNPgS4aGJraaBhsaGJaLXiMmGJveFmNpQTh45PBHrZKgUxnBDVcnS8mNMBFtVBn4dvsxmtd
 /795+nB+fZ8ZpaYVjfwiLxkS7MjKjPT4QowtkPjl31HzgcREaaOZzANVn4xCTz6uwyuWGY9DA
 HIscOgzSD+LRpOkTeLxXbDOZNuWhp9AB1hrhdpi8s2x6UYIun4Y9C2p+Glu6rR4rmj1aWUaJc
 kMnbVsUNvht+odgR/FiTrSy2FyRZe1tF1x8MQkvGKBoYXZ//iBH9z/zwu1o3E1/whxx65U9To
 3xcqulytF+NZiLbMUy+KbRru/E7LiGw1HV7Ki3z0fYMxhSV6I4C04gCBLbtDr5inzMCVpAhDy
 6F4HerQuptYmvURChKQ2QAWUw26mmbkiam7P5B3LnfQFuF53ynvVD4YPMXiy+F4BZ8HDSFR+6
 uiD4GGpYUaah8R9qsizCrVBGoxS1kNGObJrswshL0Od1U+9ja1ceGdNdjMU/+jZykgNYezj3w
 Uved/TQs+6OdfRv84EobDA3/FN7E2Y2/aw2OsJ5BG/Njx2yBxBNDYp07Rp7XDu/KxpizAAuFk
 EJ3KcHETydo/LcVYIJ6G3/aPEU7DLPv9ZbgUxNUw0gD2iCi9/QsE5uKopQgR1O4fF9ytedbIq
 wodpVn8eeCrTQy83JuV6OqDnVtHqZD4VA==

From: Parker Newman <pnewman@connecttech.com>

Use the BIT() macro rather than (1 << (i - 1)).

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/misc/eeprom/eeprom_93cx6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eepr=
om_93cx6.c
index 4c9827fe9217..e6f0e0fc1ca2 100644
=2D-- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -8,6 +8,7 @@
  * Supported chipsets: 93c46 & 93c66.
  */

+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -102,7 +103,7 @@ static void eeprom_93cx6_write_bits(struct eeprom_93cx=
6 *eeprom,
 		/*
 		 * Check if this bit needs to be set.
 		 */
-		eeprom->reg_data_in =3D !!(data & (1 << (i - 1)));
+		eeprom->reg_data_in =3D !!(data & BIT(i - 1));

 		/*
 		 * Write the bit to the eeprom register.
@@ -152,7 +153,7 @@ static void eeprom_93cx6_read_bits(struct eeprom_93cx6=
 *eeprom,
 		 * Read if the bit has been set.
 		 */
 		if (eeprom->reg_data_out)
-			buf |=3D (1 << (i - 1));
+			buf |=3D BIT(i - 1);

 		eeprom_93cx6_pulse_low(eeprom);
 	}
=2D-
2.46.0

