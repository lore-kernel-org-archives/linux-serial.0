Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DA1D0DC8;
	Wed,  2 Oct 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878490; cv=none; b=Iy/POlMSe+XQs9D12mjefNWIwNZap/TctOM4TSwPcZWYR8Rx5uD3jGK06v8nbaK2BPcauLXOMvhqymH2NpTlDvuvkl0C6CfVSYeM3jkNISPwV+B1HOswyp8Mr1fYrniOef4dNgDnxMlKpmi7Uu4zrJ/l5B+NtWNPp3LJIFTEehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878490; c=relaxed/simple;
	bh=OyS183jf67mwBWsh4j88c8tRLda0kQJja6uWtxNnKBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zt8sKZkmJeilgonX85rzKCR4BPwESPAAJYizDC8GZezXl20i6KxdHOHXBgqisZUwPSeU7tFBDWTHIf7ExwmiN9YnKDhbW11eTH5rR776REISkmLWm1UaXAejLibCeda6Ue0RcMv4IeZw4sDeiFL1yPNNuoOYnDg1fMtF7UK3mN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=V+wLyxcq; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="V+wLyxcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727878477; x=1728483277; i=parker@finest.io;
	bh=/ZT84YaV0vocSEpWm92lvDoMRyfuTXqlQ7/V9g+7jNY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V+wLyxcqdKDei7MN8RJ58D2szKxFuMVKYobESge4X1tAyLNIJk11BDwq/no9Nexd
	 tdvu/oVASW9q1vWAhjt6owBgIxtAV5bXYbaGYcILiC8SVxInSUUYVIlcjLWQnYy1q
	 BYXwvnv9bEVJxxSpquhpaKUPqDnu5v+8pADhLzxP79qHRnq1vWiVifgvsEjWPMjJr
	 LeGkFjoMw9G38FD6J8S2ek3hbIChMyq6B67sZM8gMmRRvYJT1S/xfFgZZeItjfqzf
	 lSEz8uBE15tL2Xx7PDsDppryno7JCm66Hv/IJ8daadRnoPkUT3z+rkFg36/Nenq4H
	 2KjA1s2QpyiMArBNJg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MgfCq-1sFEFl2MUG-00nVIg; Wed, 02 Oct
 2024 16:14:37 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 0/5] serial: 8250_exar: Replace custom EEPROM code with eeprom_93cx6
Date: Wed,  2 Oct 2024 10:14:06 -0400
Message-ID: <cover.1727873292.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h+sbhQTjMriMRpQb84DQBsWDS++iAvuO0BZXCLhgTamyLy2Ps2b
 kqTteege1eTnNy7pwvukNVwnLJRRpax4UUP71pdiQF5YsGnjdLEP4M9N5GMdMwC1BWYNUbN
 jt2sF4ZMaEy+FGTwUbQY7ZA9uvDw+AeExT1/AnOvoARGta9eJ2IYHqxhnmZinxRvpomZeDa
 Fov8qfGM953Q/HdsSVuZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hvPTFnEG13A=;vqaSg7o26ysBiq87yIKXnbGT8eS
 2ab+wT+qZ1hOoPIfsvYlb5WzIMTf2Rf69SJiQlo+rIzwntgP4a9BbRm+zdauyIz27/pEnqiMi
 XsOJq6THMrPQY4dmg9UPJSGfsr+SPFHwE/OW/gMIP7M4Lo3seDlOhSMH54DCqACnurBXaNoch
 WCshq43HaU/9RdmYXJXsNQiXQe4sIpAu1FcMFMuzZJNqb+Y2S5/bZv3rhiXSTdI5f+QpXMM63
 m+s30WzZxuUFE297ZbflCCMeD50olWROIaykDPCo54C9rShanUHBxel1NwmyUeUzu7MiR9KzH
 bcGVb+nQ8nOFYZFn1XjMaAMOcZhTE62wSz1r4vESOxNP0HK7x9bcH4/KAWc0QWGiUh+oWlddp
 /t6h60+5VffZR/K7hGQQ5PRjUCDjAAH+wMDbKzNbWuC42c5xNK0gXuMF0W0XXrIjCzLhmYSAJ
 LAcQmcFMrT8ns9hOGmPMXkNXKal7ifFcVVpGt+m7GffWAA2PfbPohmRztrvuHA7PD91jWMxuY
 UeUkqeVlSXvqrfllcMTHIVWiI7YExun0veHj8UT2yk5JTjTm2ljTIsAtL7At3jsokh2Aj6EmM
 j7SEYmWjDmlCEx5AOSXWN9d4J4wogxQ9QKEgceOdOl6gT2DzeM8MV5gTSZoUAQDjQiLMGRNKl
 W8nazXnvZsdIxcHcWf9fGbLersJL2lXcrP5Hbql3YWZpFyLkUiUjnuQ15zduNLT7EFZ5LJ9u/
 eA1iOzgw0hRteGAQ111nLCsfeTGTdMTsQ==

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
 include/linux/eeprom_93cx6.h        |  12 +++
 4 files changed, 63 insertions(+), 95 deletions(-)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
=2D-
2.46.0

