Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7C18054;
	Fri, 13 Sep 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239720; cv=none; b=ezRlJ+EkNCMc7CukEbASRoBSozUgna5XxPn7xfwWEGEPasuO9fUfMyGe29VGiNClES4Z/zyj6+eLqMCLSN9chaz8vSdbnP76qRad88Engj2K4HRw7u31p/hffX0SG40NOi8RzCldNoziQYDioE+vpqDA1YhIneMagIOeOzpzx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239720; c=relaxed/simple;
	bh=Prop8X1u5n9vXxzf5jOSP/AMviBnOLDj1YxG3MfeTSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjlZqMR8JXPJ2XPfat4Ssi65S0Qk6RH0ZW1Qe+fh6KwYYlZGebzb8xiQs79EH56wooS9Xlu2dCGUZE2kxed4iOyHAR3OXIr3I2jY75eAJ52xNZ8qHVxBJN2+RUe8s0G8kVFObgcR/Uk0Uwnflbn94Xb0Byhl8jYkhhqHnlfDPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=Zzx54NxF; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="Zzx54NxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726239715; x=1726844515; i=parker@finest.io;
	bh=XcKN6q0TBp89e0wB0f+FMk1TLd9btuVWG0QWEJAGodg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zzx54NxFb57Q7WyGm26DIn5KWtSXiVALR08QXN6C7IIz45yqCRd4dCnj1rj8ijYS
	 nSjCn0ub1ORyC9iwjY1bnsEEkPePy6I1lnDYDCKhLnOHvBJ1v3PCpY60taovBU7po
	 j5CdI14nSLRHfR2B7GuOa9umAtd/CMVJh2PWSHQ1BSFrak+yQg3gYlN0xK1Spt8fH
	 LVrLPQX6/SZ0qbeQoeKEtYobIj7ZfuelWAuciVWPWVyMc1SoG7VX8/1axIlVKM7Ik
	 sCQOMjx29qaMYut/F4TnZ926Gdwbvj8IHpRu9DzeFPACNFWZkIfIf4t4WFOkBxOI7
	 6Kk+rO7Ezs/5Ko3fVw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MsIT8-1s19Sp3HEw-00xbIG; Fri, 13 Sep
 2024 16:56:29 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace printk(KERN_ERR ...) with pr_err()
Date: Fri, 13 Sep 2024 10:55:40 -0400
Message-ID: <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:mPfsegP9z14MiUC6IhNn4jM/ANnsdT/sOovmOq6y+rpXz6nvaf/
 9qskY9F0kghKN5DS9mtdl17qS43tf1AmB8Pz3ew2mOXJ8HLs8KfvwVhZICsJ25wFafgrs52
 p26+nHka0/fnZU9d4G8Ukxz25vs6dcJKme2jtXDW1a4KpuYYA+ywQEpqdGl5ZVGPBHERXXs
 DGLU84D7meXUutgfa/U2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J23xp/a1mPk=;fdT3TA1eWzuORCpVRS//uRqJz+G
 2+5B7bKjm+cXMVQXHFr+9+4f0vwjx0pQyF2gFWnT3JMVyu5CzbLw9WUWY46WPa0/j+K4FqGMt
 X5LXzEBt4A99g8i7L0MjjT2932q5ZSChJCgA3MBCr7ts7XAs0xE7liADPg19hpNIRLG5Tcb0G
 Q9fjMRiqxcwpnMbtVTU0V4FrdCHTM+i1mxvfOnojozSQR+4b/cz+9Aw6gOcAEmjX3AjE1j1pU
 5uGJW+y1KQAoLA2aEKePGWQ/IZWBtXkfi0IIrZ3M7pGzCSql5ACKBe1QCQ8dVC7hW+oX0hLjl
 oJxzyzWYfMz5U8K22Q1khS4k+Mr/6NH+3CoCqzBHCn3RNxo/zwP/hZJFfhg4eMpLkVxWrIIhS
 tZun6O7qboHJcX6IoRb5I4HE15MVLqVmxae1ssXyXfnKV0UMWqNBYDiUj8CCHqMVUFGuYIJ0/
 IDCv9U+JGV3DqL6N3UlFc7Or7qaLpi4mola55N9bW41L2rST7wOgmx+tNRlSl9tsIQ72vIC+l
 dASqouuJxHzfPSWLotPPwFLDsp4GZD8xOckgLHZArBy77tifPJl8j357qFo5lVzuP0CqC9Utl
 Gxt+pBJ7vSKiydme7D3lUVyAv2YoFa8CkbpPhPAe25OWKt2zry8x/wT4eWaPqyxeC+RnhTZoC
 jreC7xvYd6zsEYA7CMsPTfUtU3SnFo8G4/neE9ZihrtlQ5khIqEGnETxZgmqWVSHCh8ZJf4yy
 L1lwODX8i4C/SgOoBBP+MuuKBc7iyqHrQ==

From: Parker Newman <pnewman@connecttech.com>

Replace printk(KERN_ERR ...) with pr_err() to improve readability.

Fixes checkpatch warning:

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
+			printk(KERN_ERR "%s: timeout\n", __func__);

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/misc/eeprom/eeprom_93cx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eepr=
om_93cx6.c
index 64da22edefa4..755be9a4ffd4 100644
=2D-- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -378,7 +378,7 @@ void eeprom_93cx6_write(struct eeprom_93cx6 *eeprom, u=
8 addr, u16 data)
 		usleep_range(1000, 2000);

 		if (--timeout <=3D 0) {
-			printk(KERN_ERR "%s: timeout\n", __func__);
+			pr_err("%s: timeout\n", __func__);
 			break;
 		}
 	}
=2D-
2.46.0

