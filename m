Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E05228;
	Fri, 13 Sep 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239721; cv=none; b=uZDL2F+bOY6fLXFbrFeIQtuiN6pvU5qadL5ECwPfwMuYIv2kCPPJk/lHIxXq9aF5qeDP8GIpPr/cXGFRq+A3Sti2gtMH7spqvWPAydYgUPv/6T2Hua6uIya21cPBDF2JycTg+0tnorSLi2SjFNm3PBTw0oyt5WlRtLllpeyzoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239721; c=relaxed/simple;
	bh=3h8jinm1SdDaK4W4DSDn9yq0QU4lEyKGoFK+u5TfO8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbRo8IjddpOW2JWXgOd3lxQT4WXKd9sElI5K6aivtQ2v2rKwcZWhR9ZNhjnveIRFbikDQPsU1ywDBYfynKAGd3Rf4AxqheEKwewhhvV9kaswiQ8bkyDPUIngY82W0nZZnjc5VNqiIL7UcDpy6T7baJEeIk2UwX2lguEGGSWETvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=qe8RCx8w; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="qe8RCx8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726239716; x=1726844516; i=parker@finest.io;
	bh=oIq9RnNEQW4Xv0SaenfD3RdSE47NhFTAj2gl3GlSmCo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qe8RCx8wLenfbPX6XkmOligvduwSmgWHt5E14w3YSRZijr22GNq9SlzsxiG9xrux
	 277+fjKdDeGYW2yTzsGzDXObElCm3VmLb8ZkxtJTTw+dxa0dGrhHisSCXV49g++rd
	 IVTGyhbc9vN4i7Y3CkexRoJCuw2NTFS3h7L/QZ5O/VCbnbUtezHQe6c/2i1hAWUe0
	 AnPvuS+0nm3Q6xHyYBneuAPfpHdQnOkZVyHELqkL9xyqt4eyYbv1/QkSygOOznAyv
	 DyGKaTrMJ2YYhxykHMQNaSCm2/fa3uuCFXT5DUX0rDgDu82JRtD7kaDdM6kz9Wfa+
	 S/PmWJEZHFjtGsvJeg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MfHtf-1sNTfT00uB-00bva5; Fri, 13 Sep
 2024 16:56:28 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 0/6] serial: 8250_exar: Replace custom EEPROM code with eeprom_93cx6
Date: Fri, 13 Sep 2024 10:55:37 -0400
Message-ID: <cover.1726237379.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8KlvLOuOy+TZj1iyvqdZngYG5Zxe/DEjpySsXbrBGbA//v02fsH
 gRIbcRdNS65efWZkW306svjv71wETrkEqZk4PiSR6VNFBDMg1Dw6ytJAhlGFqjgDLQxsjnF
 QDB+9RuVqAuaZxULr8Fl9FFHOLqWBiOCGHB6f+T+JPIfXPcTySqjIRwHmfdKkfgnhNILSLI
 lh2LvkLhwL9g0swvs4Hpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JwwQSWwv8A4=;oLiH9vWwicPFTEeeIqk61Rc1iB8
 AOcysHx1i3ghIQdqmdnT2Xu/5atKeruM9fT4RvM93tuqH2/urOWkG+E1kzVd3B19v3TD0Rt9m
 ii/JaG+HgGGUYVi205sVQYGnb31bR/uYJ7ra0nFgeqq7Yi6SfKqep0w4hXPC9hgWv91QltAVy
 DwvrUPmSvRZTcT3ooiHSMz+ZNod56OBkdS1wTMHZYnGM2BQKp5I3MciV3SpHHTo/Hj5mqVtkK
 MUaSSvDOKlW1/uUf8uLpqY/FOYFYpnfzUFPanAqDOiCkO34mHayz35HJA2QJMgMi2hiBGGjOq
 aTKGJilPT3ACqp8OZ2wxVroqHrPOPoIMc+jpwAIuGiyCMSW7cBDOyBU6LSTjNpMMLGK2Kw3ue
 pPdHew+GUvjImAZr4oMfyVPRiVONoV3+bxaP/3O0rQEi34Liz11EjDUEECtwyb7i/ykkffcDi
 m4XphSD46BhTk3a1/Kw/SR0lzZ9thB996c9IDStjMjwWW5tLqqYLnCCfJDjCZRcrxZ9NdszjQ
 p1lNxdWw8n47JtHhWtyH2ae+W5qV6Akgq/4URaIRPNDCCv7Q4JuTf87HUa1NM65cCGQNCgjuV
 dnJKs6WY57sFVd6RIMY1y0BFeKppsEY2vB2fsHWm4KkSHwBUoju27spnraDpU+OStufDpRfhC
 QsyOs0b37uzcxztiRXYDuRu/64UhdMPt7Fr0FGCJ3rvKvGjFetEkufGRDXYR9craBfYOVuXqY
 FlNdNtT9cljDYrzhr1cRoSyf68O0C9nNQ==

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

Parker Newman (6):
  misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
  misc: eeprom: eeprom_93cx6: Switch to BIT() macro
  misc: eeprom: eeprom_93cx6: Replace printk(KERN_ERR ...) with pr_err()
  serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
  serial: 8250_exar: Remove old exar_ee_read() and other unneeded code
  serial: 8250_exar: Add select EEPROM_93CX6 in Kconfig

 drivers/misc/eeprom/eeprom_93cx6.c  |  22 ++++-
 drivers/tty/serial/8250/8250_exar.c | 122 +++++++---------------------
 drivers/tty/serial/8250/Kconfig     |   1 +
 include/linux/eeprom_93cx6.h        |   7 ++
 4 files changed, 58 insertions(+), 94 deletions(-)


base-commit: 5ed771f174726ae879945d4f148a9005ac909cb7
=2D-
2.46.0

