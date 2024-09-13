Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57C4AEE5;
	Fri, 13 Sep 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239725; cv=none; b=FzvA8ijwVSepuw0G2id4O8TgbHl1DELzTFnF++qq37LhKyIpz+9h5q8G404zPs4KcCrU8p/8mYEfNEjsaWoO9r6VsthnPgL3o0ol7XU7R+oT9//Eq6r5H96MGwjFcg2VA9x0DrRbA9nH/QzlXjA3EJH5Syrp+5DpbBZWAvU1W84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239725; c=relaxed/simple;
	bh=ESKLF8yFEtUQytc0bKQ3oBD2aW2a9E9kSXQeLosTxeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE8mqwowBxuJRezJ+A/LEFt2K5P2wemlXh7OEwnUQKzZ1tutSRGrD1oKMDDCUP+vRsF7DIePqbRXIOoOcCkxedR7Q1+6cbgyJFJfZbwnnstIb6P3qeWifJhq9S3e/PQrGMHTiUhF1bBbAJkFyChzXvNSPXUqEVmJpAEU0nJMBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=vt/aSyrG; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="vt/aSyrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726239721; x=1726844521; i=parker@finest.io;
	bh=2o7ADJUQgRYhhYBqQX29IqghXTlpdQRGn0FGNbn1NUI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vt/aSyrGR0pI0utiyKc+KclswpULP4ACa8uNh00+H6SEfQC52JMi74QE2A+SUf/L
	 PX5/lk3vlwenK4FLgl2z1aBNII96vhLhpQseB8P4GhJuNefpgmfc7le72a97IF9Fd
	 n0Vu7N3PTKRQAOvlmotvJvhA2v3tD4oeHs/sw27rg9FWVMsJOfJUzWIIh2efFKz0p
	 fPs874M6J6j1QfNl5S/U850+Qpx7VvmDVLbbvXq5WWtynegFUYC9IxBVp9gjP0Hxu
	 TA0DIBqK05mLDwQabSXck+Ullrj8Zz2O8tPGq/pGAwBEwPkbTNDI3a1KR/4Hzoz6h
	 Dxya9IPaMrGSW67XiQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MQdh4-1sbI5p0r26-00Ijhc; Fri, 13 Sep
 2024 16:56:31 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 6/6] serial: 8250_exar: Add select EEPROM_93CX6 in Kconfig
Date: Fri, 13 Sep 2024 10:55:43 -0400
Message-ID: <b6444935804fb0e745d7f374cf2a0c9116a2b3e9.1726237379.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:ajSEOcGFWwOl3ZVKbnLk5A4JCktIcIR++kmKHBG9KY4PhRwnsKq
 gFQWdnF4kErSeMUGkRa8Tit2TjYHtLJpmxCmi9zfc4ndO1RM20ITIiceoZo9ODltrLhlCwa
 mjDx76qXS252rPgX40mY7MBkCkz387RJEUcBpq13g7Ci0yGUmldKgDagyKIQAgoZjmOzG8X
 ctfGuLLPyOjjqJDDhN1Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K8dNiyVWNQI=;0F0kA9AYH9Cy3j0YwgV/acixk0h
 5YGkt5o3KYsm4hAYt0+TYpzonADsI75g6kF1NH2vpKO+ZKLRjmRnBiF6gq3LRlt0GI9iI5dVK
 BJ06aFpXEWE0Pmrpult0dibntcMT3Xm8eF0CZ8UhDoXSn8AxTtEfS6GMv7qOovlg1HDqK7a7a
 +8+fdlwplcgw0yMOwit6Osr76ToDjAtb53q7P9gmb7+ZP5kxuxydB6g1E42vcuBcjXPsBaqOA
 XvhwNDEF2oYykanIRAcmAPo2ZktPtiHsIHPX0BEgoVnls+MS/DAVzIciWMvxyEkhJQt6N1WnZ
 8Qa7DWsYe5ROZJaYtg+dRSrjjBnaHd4pbRjPhWtSS6MhVR9ddjRuQDT8SfM/vodkvjhZZoip4
 aTs/49AJ6SovsXZimJ71mo98y4ouzNaRCa5hkLq3DyGewno9eIa0bS08M/vC8+Qv1DBmFfBu7
 w3mZg627RHe/D4Qpwrdx503PCPWq9TveBaVMuTxGbBJ1/qLldcAbrmwGvV8/ujBHxGLOud3L4
 NPO71TX7j4C987umx/s9j2KWFML9SrhN7F6W7WTwcwx8z5KlqBfHXcKUQd9+2Ed/Mlndiy+kN
 YedLTRGGCGYkNDKOJea5+UIFng8T5EoCJg3Rzw2PFfJBwFEywvY/K6oc/6jNrdGo932WXEcas
 ZCGrO62S+40EQMATsvc3NRh4gqw3EwK09JLceYBc+TRnlB0ye9ORdLaYzYmkwGaafGfz2g0ni
 c0chnqXagLl4Alyv8ImDw9pYLYJjOvIbw==

From: Parker Newman <pnewman@connecttech.com>

Add "select EEPROM_93CX6" to config SERIAL_8250_EXAR to ensure
eeprom_93cx6 driver is also compiled when 8250_exar driver is selected.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kco=
nfig
index 47ff50763c04..94910ced8238 100644
=2D-- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -150,6 +150,7 @@ config SERIAL_8250_EXAR
 	tristate "8250/16550 Exar/Commtech PCI/PCIe device support"
 	depends on SERIAL_8250 && PCI
 	select SERIAL_8250_PCILIB
+	select EEPROM_93CX6
 	default SERIAL_8250
 	help
 	  This builds support for XR17C1xx, XR17V3xx and some Commtech
=2D-
2.46.0

