Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DDA1D096B;
	Wed,  2 Oct 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881987; cv=none; b=QNrd7fCn02OSof5fOexZmF9lnqwlNUOdw0xKly1f+QYYFPsE2GvrKI5tYQFpjs6+XFPCLp1HI1/1QLs1AEr9cF+OvsUywxzQabE+FrJj3HGSm2vybJr0xew0bs67lhXJDaMgrjDwvWbridA1Lbn87lM9p4PNRMZwW9s86Wl6oQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881987; c=relaxed/simple;
	bh=Ur+8GMaBc/m0BewN7ELCb9d98QduintxnzIpZkHlM6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie0wmjMP3xEhE4+KGPjajTnzJtg5ZMFm7YvLrbIdjo86d/rs1UUF2nI5/0t5r8XI0uwvSHOco7lGoq/63fgq260ou92LttZ2QQ2t+c5WFRumiG1YUXiTT6CW+eVlsBhfdmleP5Ypjp9ZDHd/VtlA/AKRp/V29MlszkoFwbNbXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=lz9XHBNo; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="lz9XHBNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727881977; x=1728486777; i=parker@finest.io;
	bh=s6jCD22F4BqKArbBW8kPW52KEa/QcItcl8sp3x+bNI4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lz9XHBNoULCdnrumKA/5Wrr/J2kPxsT1YA8DP2Vaaio0wdalYasrBX7VsTMGhHP6
	 xW8s6HpftNtjDQam8g3/W+PrdgbgogLbJBx45UtTWRIW8urbbMqtR5apd2qVo5ky0
	 Ahuznb8I7sOuk+bznnaENm+wN3IUQQZISkj3/FMt7wBDi0l08Fhcj4nbf6R5yiQZ7
	 Jz+gucnnKXcmbg/0P6nD86aBowLTpU2ZJkfzwnVVpiR6pIWrvqGlbEXqiLekUYt4H
	 QPWL2DD3+baI/HV14PypKE1ty2afO7qO1Oqj0Jqp7iskEQpL5dxgqw3C/ZbKga2SM
	 EvUH/cqDWlnX6O3FPg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LcRm4-1sDZb43pWo-00gz2S; Wed, 02 Oct
 2024 17:12:57 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 5/5] serial: 8250_exar: Group CTI EEPROM offsets by device
Date: Wed,  2 Oct 2024 11:12:37 -0400
Message-ID: <c0dfa1eb129542cd6b4d5b2c5098b0d20b434772.1727880931.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:TrKMNWs0cbQ0ImVyjc2k9DSkBHDNrcj9RpDUcnBiWLapN24muAv
 ufRG0+hp8u8dCcb4jRgZ4DWd4l5jwo87Oq44d1DpLM5gouK9LQGKfzFqcx9qErCDiVkpWvT
 raDPjhfltBlNqc2cBaG1U4iHTgJJrH+Tparfngwuf3c5+qJpAQ+ll98aWcawxMn6EVSv0QQ
 hpjW3W5fkUL6aJ7IEYGjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R/vd+dXcmjM=;Tpvcr6grkeMUm93I+xp4RRUNB85
 frwamVHv0PnQk2Z3z4wrPJZ2RBbrQhMFIbpC9tOxPzSKjsGxD4IWIFJ9PHcHvI6rQJci2pA4Y
 3xZ2owZ6FEZnyuA67eRdHzNW+qnQULonqORtPYryyf1ZoMw5KRujAnJ2QV/yVJGvW0+0w/AZV
 JQs0EBJzEUweK21Nja0utd9eDpXNU4SNRwFSzWF+byTQAYXIT+coSyB0TfrAIT1uXWjIS+5mm
 nzgImDTC6v03/Fx+psQbxQatVhpF3RHJsAj+QcRP/iWKYCFAFgQ4tFxmzWS35x3COodKf+0hu
 kyD1FsvuOZIFVnhxx+lpLvhEuhBa25YzowKzIftYV0iOKYQ4cjwd5CavgnDfI2VrgB+o+p8Lf
 Y7pBJkC/RlHYBu46U5O3AA1UBPQCWH4mpxGR1Mtsh7w/G747o4sWsQquSQTSMJRJtWQBAm2N2
 mmchRlShEk70OSeD3y63KRIiXYRYwdyaNDEzkiaF6yQAlQxGWCn41ueonxBEnXhEYDz1RQ+rH
 DXurUuL0ja3xraD4qWBJDEtV/pOaP0ByW8bXBNdnjYOjHYGYL6Fmb9wY/Iw4A6XxhT6+zTxlX
 y//UgZACiE0eEi/erh6jRYTMGPR+SGXup4bh2NjKUGkIEffrRRdkbJN+pNmMkoTgWrksfC7qn
 i+UNHgu3heC3N4f11ZCWj8fk42JcXfXgU2YY/QRIvguhWVGYAy79IbwpcInYnnNOUM2V+WNr3
 tzHKnubxG3nQvnMxBbrf3ddYrIF2Rl8OQ==

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It's not obvious from the first glance that the list of the CTI EEPROM
offsets covers three different models, let's group them accordingly for
better readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 470e8128c79a..e37c10b60a7e 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -178,11 +178,13 @@

 /* CTI EEPROM offsets */
 #define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words */
-#define CTI_EE_OFF_XR17V25X_OSC_FREQ	0x08  /* 2 words */
 #define CTI_EE_OFF_XR17C15X_PART_NUM	0x0A  /* 4 words */
-#define CTI_EE_OFF_XR17V25X_PART_NUM	0x0E  /* 4 words */
 #define CTI_EE_OFF_XR17C15X_SERIAL_NUM	0x0E  /* 1 word */
+
+#define CTI_EE_OFF_XR17V25X_OSC_FREQ	0x08  /* 2 words */
+#define CTI_EE_OFF_XR17V25X_PART_NUM	0x0E  /* 4 words */
 #define CTI_EE_OFF_XR17V25X_SERIAL_NUM	0x12  /* 1 word */
+
 #define CTI_EE_OFF_XR17V35X_SERIAL_NUM	0x11  /* 2 word */
 #define CTI_EE_OFF_XR17V35X_BRD_FLAGS	0x13  /* 1 word */
 #define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word */
=2D-
2.46.0

