Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD7EED6;
	Fri, 13 Sep 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239410; cv=none; b=I80pkynWsocCl7VM8tjrttFcuDUNtQZXocHR2BqfYC0y6A1Qjzo+wrA4iye1mKVfNP8Pf7xKLBtIPfymZbm2gvFP8ZhVqtVpodWccd/AfUBDh2tZiiC4fWmM84vBMhB4JzHx59UEbGJRb7QT5TrnfhkOJqugXaBf8DVGZ0aJKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239410; c=relaxed/simple;
	bh=2S5EjdohUtafJVN0LclLZOeaa5BwcEKgqmTqIaUCLXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5x2LBWVweBSCI/l8nDmoxJ0+O6/QWgrFpVNa+VGNAxWpxMgBSUd43erDOrxsLJC0eaFcxdFLfzQ/vAIZEsqNFA+N/a36QoBJOF8S9iIsOqmuma8el3PBCQKWufankoIygYewRL67sF5e6gQB5hyqDCZy0segHRUMvZlGGcnyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=S6+8schn; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="S6+8schn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726239389; x=1726844189; i=parker@finest.io;
	bh=u5dwxRXFP0sPzsc3PAhsuP1tz7y0KsCKMmM5JoZ61c0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S6+8schnQyYE9E1UzQ0d2WibxsyuUHFfaNNaEaAqYNZlcDegNsMd6p3fck+ZUCR+
	 jTiaL1yFJG/UJKZEmik7MGGr3EyzFe+JskAEtzzou8mPD4vu0JpQmTOWv+EE7zh2x
	 irbGXdw/7CgEq0jejOm8iwYWFGPGNGcJJUDDjPTYog7+m3VO3DktFk1IcPSfVZIcM
	 MGTjL7JnsozcQq2xrCg0aXzq1KMMxtczYWnUDJqy68ktcNx/Qs7QrxfqB7jnRAvpF
	 /jXrCJpOiNv7TgiTpkmr9GWQ/h4vqqpG7w0no+a+JI+2u/r5sdJBLpGjj49rCq+1H
	 bozUG8kq1Y60jrnUXQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MS4SF-1sRivG1Kbj-00XIwz; Fri, 13 Sep
 2024 16:56:29 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 2/6] misc: eeprom: eeprom_93cx6: Switch to BIT() macro
Date: Fri, 13 Sep 2024 10:55:39 -0400
Message-ID: <ef318e16db5c0743c792950d0f2504d80b52a106.1726237379.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:7Ukjgtuaq5ajxqwDz4KN63U3de7irQDKJlYjSATh7lgk4iC8Nk5
 gV+YfHiij48dGxQzvmy1BiSEjRJjR4T29agpIp8ZFm8dJe7prEeh3mpyz6oRLA6cz6tKonj
 hVhkeeu7NJlTCbIcpjgdVjEQONU2fDnVDEllzINn+tqsb1wZ5q+9IYC5xuFhtcTWBCiz7va
 fVB152x/pwjb29yHZehxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AmqoMiT8DMo=;2rLNuGc/xbAutWzEOqKdaNbc/+K
 7wi1nJjKW4JAVN4gcZdiJEUVD9fv7qQ68gFbGfiFs0XtbVWI7VcZ0y3Km1ouvCkHxTLo2SJ7g
 2h+E96oedng6jGdzA5az7jGdINjLQON0U9U3mMbzApNxkCLwceoMG6a119qD0PMe0q9n15WPR
 jG7qkgzS+QGpP1qNyhn97BzZFjY841AuuRw+es+YVLK/GP6yEZuh1vu3iWEYuQOa+MMRmC0fb
 JeYscpUmM2X9JsYzj1ah/DqXKnRR3PhDwucM0yM++COuK1TzmlQKvA26QGVyVMjosbgsgvtvU
 UqSBPaRamXaiTs7DvqVFgZXmakTHFGAFC7/yJdXPs387QZ5EwBW9BofugegHYgO+Tvq3HXPuJ
 PWwDYvtkW/a1w9/3MWmY7X3kT8QAVCHSGUhCXcra2o9512I+VZpbDjKbZXECiHM+fPOm+Xfue
 yu1HaqR3kC/QMZjnKXaEzAi7yIo52VIYTb6jpsC+4/c5u+bcEctbCPTV1MU8npLp0MupL+Tld
 KmbspvORxmLwauvKYF3PDGRzEhGl5d5A9XiYn+0GavzheIz1tRoVlowfon2ntpf3Z2CGibT75
 mMAK2dvKQxBkJOX7jJ6ISdFdVeFWPOERSPv7EQuM9rR+Efk1PVrX/UM6HJB9EP5yT+A9sGx5R
 NiD7/Vzto0Imeolew0UIXujXfQBvq1JZhceU5T4mXKdPJVzXumqdrMZMclLWmwMQcO3PjTMEU
 x/08Jwuy1rK8aD/rQsGVtKI8Ugi0UYj2w==

From: Parker Newman <pnewman@connecttech.com>

Use the BIT() macro rather than (1 << (i - 1))

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/misc/eeprom/eeprom_93cx6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eepr=
om_93cx6.c
index 0f52d3c4bc1d..64da22edefa4 100644
=2D-- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -8,6 +8,7 @@
  * Supported chipsets: 93c46 & 93c66.
  */

+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -107,7 +108,7 @@ static void eeprom_93cx6_write_bits(struct eeprom_93cx=
6 *eeprom,
 		/*
 		 * Check if this bit needs to be set.
 		 */
-		eeprom->reg_data_in =3D !!(data & (1 << (i - 1)));
+		eeprom->reg_data_in =3D !!(data & BIT(i - 1));

 		/*
 		 * Write the bit to the eeprom register.
@@ -157,7 +158,7 @@ static void eeprom_93cx6_read_bits(struct eeprom_93cx6=
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

