Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2D1D223F;
	Wed,  2 Oct 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878491; cv=none; b=DyWnIi0X8yyk1M20nsX2HVL45xPlT3YRE1v36CxM0mDtKpa5OuMXczXfC/zanLE6l0PVMXa6cPgbcoHKZi6NR2gixvI58oybzOCgdKchZjEu/8Gor18dazOykdulU2Egigs2UK011CW3kjVr9LtuxjTSjBWw7zik0ywfIC1tcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878491; c=relaxed/simple;
	bh=Ur+8GMaBc/m0BewN7ELCb9d98QduintxnzIpZkHlM6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN00bej7AdGduFUG6MLztMQug/1fRRyl57Gz7teG+15pjsLvBumyFaV1ijxqSjMdWHPzZrzO+ZRkNYyomvmmmMb4AnR2eQCCetmuU67Uz7G7OeFIFiVVSuaDeFWrOBi6nYfrhB4M002XWKkdCuu1FGtLGp6XtG+OD7NlfMA+XqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=KxJZEyZn; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="KxJZEyZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727878480; x=1728483280; i=parker@finest.io;
	bh=s6jCD22F4BqKArbBW8kPW52KEa/QcItcl8sp3x+bNI4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KxJZEyZnKGpt30Ywuf+z3AWPcGE4myi+1vCSArzbAMj5IXa+XrQkeEheLrNhqs6Y
	 cHR1zNwYqioFME1RqQSnY0EpuAeHt9vT96N+u/BGwWmYPY6jll4TlZi+/97EAx62H
	 g6LwZQeSya+RrrIoFDx6g4/Ocsh58UX0+DOOQ7Pawx7ANcmbFt7+FWs6FOFIoMhM+
	 wlvbFBUI2DXkEX52eeN5ar93Dk6BIG3tErUr2sWTs1P9MgXL8uiguZcl3SMOZVQo/
	 tT6A+A/2QNNycvrjemQmqAxc3KQ/Bt2a7XsQTUV0y7+0d2lMUQslDtZwKX17hefXi
	 XoehU8yx/Giwu2IW/w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MOAS5-1sXRtW4C5J-00VHUl; Wed, 02 Oct
 2024 16:14:40 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 5/5] serial: 8250_exar: Group CTI EEPROM offsets by device
Date: Wed,  2 Oct 2024 10:14:11 -0400
Message-ID: <641122b5fa5c5fae58f45372574f3633ca505224.1727873292.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:OKRFvDjNCNrSpHu/58YvWUhPAiATePXnBEEeUqzrCMjrxi1yl0Y
 WphRcWqNbaVsjQ1s8GcdqSIAEUZznO5pmUusPxpNj4CYBl5eQX6NKVQEm8w1OSe2o8tZ368
 C/E9cbNvaw3KzVdEJqYmARrRepdjoSH00SqWBLlDgWk4HzISq+BoFnDcnqeWjPueiis5SvZ
 oyZt9MgSGF1aYlb7Rxsnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o/ngSX8peq4=;zaTET7vCHpunyoVYj3txBbnIE9v
 6ZEkmlyBEJErEUE+nds1OSVUr1ACHwD0NDp+o8GdICtAx2HULRinsZoGOgtBu2ulrG89Jo6Ru
 SA6Jjm/sW/fhZDXV9QK8MD8UF9HXlM2OZrHw4t+cFlBZphWZaE3tee4w7nmFCYezjJ28coeRU
 v3MROXqc5qLX5FzBrGJ9/Qaud2IILmYVQISLmQ36xKRJJHGj1PJwmRrhNF2OVAk02swkILKnJ
 2mZq3rGoFQlUvEREmgN1iohbalKitLB5JcUtDWLji19twZxmG6z85kVfjSBfsGrSG5zIR1Glb
 LTqaVHRaZPFtain8kL51i4DfHEkeJ+SzFjFG+c+a6fB89T0stcASV2yYPxvceXoNoqDhFf2ik
 HBCLMeaCq7CXcnkSTsFhRI9OwWuQ2L0oAgvQdaNMjNSCXel5lCS+k4QIv+Tp6ygGX1yePqu9l
 NV9BTrIiNr3FyhvbgPtsKQh6GdxIgyzlJJ3lQGdRm/CVLRkHjYA22EcfZ/7bo5bwsiP4MC+St
 H67wtusZxYhk0ZCLYWe/Ki9C8oAWT8tYPzumEnMGxtiS5qeNjc4PfcgfKdNeZpf9fkVrXsAzS
 9797NBfhlSpYJ9YPSUqDg8JjUSfZ5U6b3/EqFS9jR9AH0vbln98biNlUbDAGJKivxiVPu3dax
 JbL68tu42VwL+9dTAX2wQ3yTbi0kUrtWye5PlR1pRLXGDCmbUKTipj8wmDzcZxDloA0JciDHm
 w7O5Ohup5fEenly3Mq5Ct/Jq5l4tEhMCQ==

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

