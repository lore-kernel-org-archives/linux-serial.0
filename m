Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCC1D014A;
	Wed,  2 Oct 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881986; cv=none; b=aZdwhy+B8PcQZUdhOsftHYBy7Pa32edGIbzSRKdzXzYYN/QvG3hH96ov7fdjiH+GYdO1kjUXhNNK2ESRfBzIiC+ajvA9IuSc1U6Uoiy/xj0OkhsWaFbrF02P+H0rHx3+9VU2QLGNuSOU/kPd4yB5UZJOqarOepHy1f/zBufZmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881986; c=relaxed/simple;
	bh=aKJWOed3vhNBD3TNTWpUzU6zEODgE81JXHEfAuV8Hmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADgM6dudJhO+d59aPUKkwuhEuKj95BeXxX8pAihUAWiPM8/PxCQy2HqvUPz+6eh+q3GYSFicVxkIJzr74i54C6GCNaQDeHt3EUJyEmQhnNm4PuohQPZuhajReJP+NVfW9g325sjyQP5XnsIQr216YpiyoU9GpP1bTm0Ib5s4+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=ljzzCBUB; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="ljzzCBUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727881974; x=1728486774; i=parker@finest.io;
	bh=j3zmQgkEL8JPVEs13z03swQgUWecSLJLlYils7wZGFQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ljzzCBUBNZdSJmPa27i2pcpgY+GDUoe9RoRSrlAjwFllpXt7+Qps6nK/kV7q7+2E
	 344urkmQ6DAk8f3But9f6FAkLkta/sw3+w6XwnrzK2I4J51PEnC5rhw4v0gKowe6V
	 wvzx/J/J9CiCEeIzsRmoMkoGUO5Bcsmzoj9oMdQgNPj7xJ2krfEBYpFEKMSniVhGg
	 ppz66TRPqEE0DsYKBGT9SVn7iff8DlII8Eyv6leeVMfrvemaA0joVvVTA3Cg1UIf0
	 GP8bb/vNKfGR3bjEe5WT86VzVXXgAFbY7vBPvQgn8pqmIhSBg434xIAid8RHcNT2O
	 BwM2sMpFKP6arlZOcA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MAg4D-1slGSD2qUd-004uWn; Wed, 02 Oct
 2024 17:12:54 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 0/5] serial: 8250_exar: Replace custom EEPROM code with eeprom_93cx6
Date: Wed,  2 Oct 2024 11:12:32 -0400
Message-ID: <cover.1727880931.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xm3WncpPphS3iuT1qvr/49nN9voH2GijmCkexta0OxAwMVlznDm
 7BJQc2/YNQEY1OrulbuWAk85FrkjQMYQEnwQqcFSx/8XJu5CidDSGaQOM02QYFdYS2LJBVi
 WJtrJuvJO1GWMf+FxzVzBRwVq/Lk9cxDIw3qwEkulWJ5jXl3P81A80z2ta8l/Pqyo2fgz3o
 HOKiaBLK8ZghSnNDRNtiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5yyLQ1mk0kA=;Csdq9h1sumLixMird7hJggXk73n
 SiiqVcwPUVnQ87YI22O4qZP+Jpey3k76fYyDP0MLiD7oStq7D+19LJzCHXOCRMGsIbCY2rG26
 ebqnVO962L4Sc/Hn70v/NqOt27GJWwlLsUmWuyuPfamEEO/4Z3XjY2X8haw4p6JHgPwXRm2yn
 5x/PH5tGUbs0uPZCREkRWK6x/SyJf0EwXbYktjzLkiroYTx1I7SCVvTJgIll3Y8mjxIuZaReb
 BAq/w8fgD2zMQMg5wSbF6/6tHkc2LJWru99uEhs2WE2EQcW8Pr1xY/bmBcigcIiUXigwr+usa
 JPzdGSnt+M/X2wVV/kqQQ3J4YPbbVoiG4jfX5UnT5bTvRvqMRnTZYcq3IbKpnd8etgI0jcOQ4
 8wjrWDNFg7oUbcSqPU9HFWCo6bnbkj0kNMdy/RIIvmLH5aoyRrQ1KJ7NZYoCKBMbo/Nc/xEjF
 5Qmqx0inslUOFHq0e6iHLtHktY6vUGDac3ERK+ommPKCwSukm7yBZ1HIu4XSp4A+v8jyfurqO
 KyVDTo2jVWuolgnYISKbjZoCgE1X5e655XNwBbPCWq1KftR/yJB/rKrT3bMcE6EPDFYpwkS99
 7PPhIC7UEo1DfcoohO3MivB9IGQCvdkiqpCM5p33LEqTFKRqhzRdceseajulU2f780Enw1YqM
 YclXTQWhU3l3geW41EX30i13d5mwABIE0OtOAgFiKPVWDl84FpYlJAy2JL6lIBFEcyBaSc7k3
 M6lWWVrlCXn3IP33bwErZHl01zSZZgfMw==

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

Changes in v3:
- Rebased to v6.12-rc1.
- Minor commit message rewording.
- Replace CTI_EE_MASK_OSC_FREQ_UPPER/LOWER with a single define in patch 4=
.
- Add patch 5 from Andy Shevchenko: "serial: 8250_exar: Group CTI EEPROM o=
ffsets by device".
Link:https://lore.kernel.org/linux-serial/20240920154430.3323820-1-andriy.=
shevchenko@linux.intel.com/

Changes in v4:
- Remove trailing newline in patch 1.
- Move CTI_EE_MASK_OSC_FREQ change from patch 4 to patch 3.

Andy Shevchenko (1):
  serial: 8250_exar: Group CTI EEPROM offsets by device

Parker Newman (4):
  misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
  misc: eeprom: eeprom_93cx6: Switch to BIT() macro
  serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
  serial: 8250_exar: Remove old exar_ee_read() and other unneeded code

 drivers/misc/eeprom/eeprom_93cx6.c  |  15 +++-
 drivers/tty/serial/8250/8250_exar.c | 130 ++++++++--------------------
 drivers/tty/serial/8250/Kconfig     |   1 +
 include/linux/eeprom_93cx6.h        |  11 +++
 4 files changed, 62 insertions(+), 95 deletions(-)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
=2D-
2.46.0

