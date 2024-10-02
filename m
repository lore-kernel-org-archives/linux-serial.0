Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075781D0E17;
	Wed,  2 Oct 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878492; cv=none; b=BuQ/WWCwM+QpEEI5TE+RguJZTe9CgrrMfhxVzklj8ZzxBuAfeYCtm9cRzPyMUxlJYuyVUIHnivJTF1EavJt+bxwmcwqpYb3eF9fC0bwrpJo1ILLU+vMgcH9weoFJexhCVrzdNjQdNYc7HlCGpbon+KU+w4pa+7klV0Qzrn9mIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878492; c=relaxed/simple;
	bh=KndFyGM1uAUMUOnpOlWVUKPyDe0gPzTWSQrE7Ofea8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3zP6FiyVzaLVU2tuW5SSap0coO5ZUY7uRbpHVgyHmgQEknfWsZ78fQtKUT3pck0IOq01Y9h3JeNgzKKgxAKMFYgPnvFUZP/unL49MP72/roo2OdnC1GpynAOT7ULX/X4+24Qkc7mK710X58m9XnLPKMVUhBbfF1wXn/lRVnt6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=2bkZYRht; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="2bkZYRht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727878478; x=1728483278; i=parker@finest.io;
	bh=z4NFjvndw+1Z7Ias/lvqJM5lh4X+wHBD6u0I1U1F6AE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=2bkZYRhtp7GyZ80SxT8ciswV2jiuPEYD/6HF2mYLndn7vtaJsKSXlgSfR17ugHD0
	 VnlI9+/l4AmpoNpDHJPB/+Qw/1ArjK/1k9IjHY7A7K4GgHPWCfXmQp0ab27kf5UcI
	 T7p1fveQv3Sza6xQ1Pz4v3cxRQO28PC1EYizPhsQUX+5FE5bt/t3IACyuL3qS8pVV
	 pa+B8v2aD+UO7uKcaWlXs/eeSll+Idb9nQseIuDZ7kgGOpvfTgkS/hppyQAganYJn
	 wk0wc3lQ7Fiwkb7iuhlZblUtKG/ygmzwmi9Kp6t++usACj0JR9GxEL+b9YKKypjMi
	 aWEYOc2/6FBzjrqRMA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M5fxm-1spweK2BCM-00Dt6K; Wed, 02 Oct
 2024 16:14:38 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 2/5] misc: eeprom: eeprom_93cx6: Switch to BIT() macro
Date: Wed,  2 Oct 2024 10:14:08 -0400
Message-ID: <8fd3f721e7d4dcab4dd2ed1befda40e25a772f69.1727873292.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:ij6KXZAU2un7D/KYVE+SfixR/JJgAhKUewfPrghZQUMVQ0yDNTi
 ba9Irh4Y1XnO3FYv34GEUSI8ikDwujeC/k2BLa8QAxkcMoVJo+1PoGi5i5UveFkJzPz+9th
 O8FWOA5Pvu1qS4ywNxedWeQfJGGsL+NO/ExYHuHyMaGaHj5lI7kcpKLybmHgsam0LC8gUmC
 e9/B+fABNrNu/cNgZ6Khw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xjNnPogB/vw=;TyaBfoT9D2p60BJy3SW4+yXCP/8
 VKd3WNEetnI4PQv3wqmBIdQk+9THJhv0mflrC95SL+KoPpSPX80SzRhOT4aIUc/6Pm9bLUDd7
 uB1qmbRWwV2D3kropqYjrslCewIJO1SxBn0drwNjbI/FNe2lT6NflBIzEB6o1Xag/N+awHkoN
 khzAXP12eOPRnYCfGGLFHi9QfZ42eP+9G/0TbJBRYn+lCGNhXiUykm/vf7HIHAf6Bk4uh8eUM
 192uNDewfnuyRyNx1IYdu6wuCLQP4goIjZKRYHPY+N5OoN0zkaiui+TLtN4/m4WQkUXML5JZ0
 ZUZ68nqBT72f7MYHniugF8isjlTnbJ2J2fn6nhvL7KwxzFWG0JKj0suBRx7OJvTpIrJVuVLJj
 ldqXpjoLMseBN3urZgmcDwzBgYAow0jVvCKFGbGjDWaEIUJoOM4PzKCtvuAThdLJTnLgV3yQk
 yNGYy8dmaj1PSdBT87JjyIMKt7TpbfSPL0jZX9iYfRn1PAJN3o489v3QfP7SDTAUBFJfxHvkT
 OImgeOzR0433ii33rE6FegewHE1q6Ny5as5WMsAT+mVU+PXON/CkXnHT+rbQMHHALuRL3E/DI
 sxfZyaq9VVRUh+NpZvKwHkhyIEQpJ34wCIZw7to8/blSy4CdP4ZVOCjDNwHAf/Nfs2HBo3iyy
 y8QPFAAlGAJgAV7FK92ea0UwMbsYJbuMx8aW1MvSmZClr2jURzTboYzDzH/Ox0+VvVpD34UYa
 YPR8g+q5zREUpCjR7KE4qhAKFbozsDsyg==

From: Parker Newman <pnewman@connecttech.com>

Use the BIT() macro rather than (1 << (i - 1)).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

