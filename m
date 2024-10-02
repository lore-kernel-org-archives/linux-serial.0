Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D81D0964;
	Wed,  2 Oct 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881986; cv=none; b=hRDHZkwyw0+tJfNlDhdS8w2bQSBGXCMlFUMUDbj00wFWNNoE+Zfw/BVWvoo/AyDxIgwMVU3BQWt9QxtPnQTvZpDoGpZPPtebYh14W4SuZ5TSu3MOR/0/5cp7l2/KevHespPC+wUvuaFLcf2xmRK25t1xCGcwpYMAdfiPG0J1LgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881986; c=relaxed/simple;
	bh=KndFyGM1uAUMUOnpOlWVUKPyDe0gPzTWSQrE7Ofea8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFphE+KkYa1KcG528xga7gSuw8KT60srsekwGo0ZBoB4THdijFy1eF2EKJxhc2dIVtXHayAcPBRmFjbzuWvQKtVPbqMxz9E6u8wTDWq7W+ohdXs9Ukyggm4d79fbxUDK2ckazzYaeD05n6xT7fClcUYi8zmwVuWUKVndPkwNuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=vXzMflkY; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="vXzMflkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727881975; x=1728486775; i=parker@finest.io;
	bh=z4NFjvndw+1Z7Ias/lvqJM5lh4X+wHBD6u0I1U1F6AE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vXzMflkYhGzwZMu2Ro1c2aPMKG4Uw/oXyWkOIGwCm1uy1uge0UwiUwHfjDtrZ7WE
	 /NekFq6rsokrY0wY8mKPDDV+EG83pU8KrGcebXsT3EpXs3ktyEokqnTSCwQhUIqdl
	 PNdVcezAmCicwWrqpIL83thtPxKjt09pjps6zU4cTkjB8oLtfMTpQzBDD0PqD4C0J
	 0Hw4ma1aZX6KAyhv2RMA0d9rC8p9qbV297BINEqDRm6Euq5ILyH+GohnSBLQf1D1u
	 Omat5+yWHunY2x6PTmbcBRk1pTH1LZ6e2qXcxaS0Mg5zeYfx8/DoFqHIgONDbjlUu
	 fabaQq0OtFKEs7m1Mg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mdb4M-1sWg7H2WOS-00SEQY; Wed, 02 Oct
 2024 17:12:55 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 2/5] misc: eeprom: eeprom_93cx6: Switch to BIT() macro
Date: Wed,  2 Oct 2024 11:12:34 -0400
Message-ID: <f40d21d284816a62003975e237a58b489d77c7d4.1727880931.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:JpEuZct7St0gxOxpHZdJfy5r7hibV4sXThH8fxrqFjjb5KEn6gI
 4tS1hEWpJFzoo1YpBVdKDsebNHi4ZRznst7tGz2w2SfvuFK1nA1Q83NGB/cZN+ftmZ5+sW7
 mNXIWNHMDoxg1UMeHV7TcB8O1mowSRhfzEIekGTYp85BPxHpmL8YHEJSfNefUXRZsMCRMF+
 dddVyTZmAiF/P2R1U8tpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JbZ0Iz2Jb3U=;b9oBAHyIrmrqUnvsjq/ltxvNVxr
 S1oUYvQwdnJ6VK+fPiS5zaeO78rNRfimEXyy8DJHA4XT/eQ/aUgD1uLVu8/2ukZL6szbJMMjU
 31VseIQGUk/EdBYJEjttPfv9kbxfd3J0lb6e5UHns/zshj2rVIjxbULKEGDDCns0JzAEvCGGq
 9nGfAgceKtOWGoY1UCsFd2H49dkZDQbXAijAi6yD5rEaMDOCVqIGoFrXPAv9CKXZ9xpbR3hPg
 OMUtV1lcqhGjBP9Bs0Wu55bIj0K3j5atxXVFsdqUenknJw/dayK1aeMuI25f8/5IsAwy70fTW
 2WOllPiaYBgo4Rl/HOU7avYXfPkximr/+Wv0Relz19MMU0DfX0XYCYBapA8zM1ewZps4SQGdF
 5OWmfj9l+74kXGiUdnpMA1gOJ75KL0c9NMPYbyHqg1IZMVZtd5dMCQIK/PP0AKMVKJNVWkU+o
 EH8z5ZauGwYPFENYZ5CfZDI3NC7ICHNVNKym41m/0oENQX4cR9F8e5iKaPfjKtp7r/O31Fw2F
 fwNSIvIlJxVTqcjqmO372Cqg+ldm0ahUOdT6ahKRZG1B6AEpm0HbiYGbRBVX3JWyco2erEbdr
 EX16unHVqRU9J/R7gwDintj86zgnYImPbzU1RMm1u31Q6H/hPu8e1UcZm8WpJStXA+ujzlMZe
 C3OnnN4M0Z3uMMj78JuEkrtp8gi1R5ronuTFw6Ls41Frz2RYwUa8E8jDIktsLmRXBXNLH1C2R
 WFg8iMe6VJfV4u9btWMqM3KUko5lzRTJw==

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

