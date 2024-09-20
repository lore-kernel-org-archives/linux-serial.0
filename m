Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1842D638;
	Fri, 20 Sep 2024 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841058; cv=none; b=dkSCX+YCU/j93wLVY7lTrzukNKXL1WphlzlGQEIRoY9GysPGxGQteY14SHHsj9llTe6LSOMalF7jAsk7Bf1o88ElWoLO9cvRnzBuOL44eKEOi8VfzrJoXtCJmiphuItDvTwYsGg9NzySyALJHPNXT5hDmvqElrpZ8kOS/8E+SyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841058; c=relaxed/simple;
	bh=j66VQ1fvE8/8VpS3wXfWW24Xi81y7pNfLqg+Xw7+1mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKMYLupBGU4rCr3q1VDbrmJqgGlaa3nvIhN4XmZWWP0+r98QUGM/1WWhOaDN18lcwbbaN2e0ckISI4FMlF5lJayTIXuh8JCmAnS5KGZ6u4YRfH52JKX3WQTlkb8vbmZW0kmbTwRlsfSMzZ+TVK8ao7dBjGkV3dZLSZIl38YTgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=HuGUst7y; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="HuGUst7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726841037; x=1727445837; i=parker@finest.io;
	bh=0uxUw95odIsHL7hwIEFBBP/4w7jv8NAoCGe2lMCgos4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HuGUst7yAgJyl52dvkVGi+L6zlJWjSzpfkI9+m6r2unT17sWu3/s2P+T4snRYR9D
	 i3MwA9CCE4XN6FlGneBpTGcQy2xmugfn8+u2NtbNdKXpj9iS2Xz2StKzj7UJwzp1R
	 ZZ3T38v1T32zuTOxTX6R6mYHDtIq8ECMEZWsUjTPkInKIvFfOTRebazGuFfLL2oX2
	 C8sPkDm+3JRpgvtIImXsoiTAKuddgcBfnCUGhwx63l8/EqxNWAIKWm6u3Aw6mP9jh
	 fZOdna24M3YAVLKNEk835lxpWcx3b3KLbIv/J53DxCI8Hkh7Q2VLZHSvHjwOsIK70
	 J5YHYqvuZFuzq6aq/g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MfFYy-1sctZm2fiU-00R8Fl; Fri, 20 Sep
 2024 16:03:56 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 0/4] serial: 8250_exar: Replace custom EEPROM code with eeprom_93cx6
Date: Fri, 20 Sep 2024 10:03:20 -0400
Message-ID: <cover.1726838531.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N0+wb7PVLd/XNLVLQyGzt+7m35ny9yY4/HbboVxAnFvXkrV03MK
 sUCwS7lZrfUywoQZ7Xns1FFTVdSxYVZuvWsXAlt4zstx7PG2nvUrMbQNTzlU7hkWFITgNDt
 lqHbwLMhRLbqLh/NKoRNJ5L/4Y9TAI9lFPmvz59mkKB5e6yvW1B2RoJT4DDz3FFkZZKosq8
 nSQXmtP+Gd+3HmbwQ4Xzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VuWNG6JCRno=;l9oUfQX+1R9uPe6hmRkhPe9Bjab
 xDWrT31PWqNWj3SjgxrCioolWGCsWz3DDeRKMnjbXxtBt6aX0dkMYmjfzadybpqhSq0o3yP1l
 BeTrO271kb08CD8nII/dIYX3tnB2ggpB2YKk5M1Aeclzew7+kKvSah1URp1JIzISUeX0rDIXn
 7x+RvQfvtrE8UB0hw7kEDsALVGrUtCmbLYgMQaH5/Q4+zxanuNuevti2UErWAdg9FSDbIIqVC
 OycraMzQL/3XRDVCslxyyIYhKiRApWWWGu31BVHP/x1AnMP65YRIA1rXfjqAvOVHCWKgOppTD
 B/UGFJpP3AS2WDLX5WJLMmjyVT6XwglBVufIMAVyfe6ZJMY18QDs+eBx0Fp1/gTLbq6o9xCIV
 IOy0Y/wya4HIRq8diYOXDm810AIQFsvE4y/Dfi9pt+fonFb6d2eXsqNbc0pclK3XVPbm4UzC8
 oLiMdkdyZY3Z8splfeMpkORySeQ3jmRX5MNcPdeACJ9M62hLsZKWyGylRWS/LdJgzYCk1ZoqZ
 kWkwINAGnKr/uUrwslV3ZFg1jBGiQXKb1k5Pdl6D6Bw8hpTQgxeJfLSdBypEtVZnmEyuqJ0xi
 N/CiJFNX+rIHOTroVELws7VN8ClN9Dz/1k7ZfcE1NZ8IKPz8/fWCvcEpqrvW6hyVB6vpXDf7w
 1wjLXxG5bCEJla6q5lgDFNFJv2AVp46x5Rqv12vvi5hsiXLg85L3QOBpsNGoQXjcRJQ8Z9tFc
 tyqOAaD6GAeZRyyd4PMMlbCokAo3jbJuA==

From: Parker Newman <pnewman@connecttech.com>

This series of patches replaces the custom 93cx6 EEPROM read functions in
the 8250_exar driver with the eeprom_93cx6 driver. This removes duplicate =
code
and improves code readability.

In order to use the eeprom_93cx6 driver a quirk needed to be added to add =
an
extra clock cycle before reading from the EEPROM. This is similar to the
quirk in the eeprom_93xx46 driver.

More details in associated patch and mailing list discussion with
Andy Shevchenko about these changes:
Link: https://lore.kernel.org/linux-serial/Ztr5u2wEt8VF1IdI@black.fi.intel=
.com/

Changes in v2:
- Dropped patch 3 "misc: eeprom: eeprom_93cx6: Replace printk(KERN_ERR...)=
 with pr_err()".
- Moved Kconfig change into main patch.
- Moved quirk define into struct eeprom_93cx6.
- Moved quirk check function into eeprom_93cx6.h.
- Refactored cti_read_osc_freq() based on feedback.
- Minor commit message formatting fixes.

Parker Newman (4):
  misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
  misc: eeprom: eeprom_93cx6: Switch to BIT() macro
  serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
  serial: 8250_exar: Remove old exar_ee_read() and other unneeded code

 drivers/misc/eeprom/eeprom_93cx6.c  |  15 +++-
 drivers/tty/serial/8250/8250_exar.c | 121 ++++++++--------------------
 drivers/tty/serial/8250/Kconfig     |   1 +
 include/linux/eeprom_93cx6.h        |  12 +++
 4 files changed, 58 insertions(+), 91 deletions(-)


base-commit: 5ed771f174726ae879945d4f148a9005ac909cb7
=2D-
2.46.0

