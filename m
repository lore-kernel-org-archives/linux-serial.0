Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D953E0730
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630628; cv=none; b=GCI9HSwtl8FGi1u4I/79xQH+YP1qARUb7VboP8WJmtsHhRJU0EpjDsDCxwImHPpfhrl2pmMn+jg8yb/3wT5KPWQELjyKN/MY0ewuBiJvH8rPoiWdVOo0UPWdiLzZdP37AzwV98AkWH7mIqzRVcIbMRDh+7L4fUc/rgoQZl+kM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630628; c=relaxed/simple;
	bh=6OBP/KYeRYDKgBThz4/HFtSQVBBoXa610eilBSNGfv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bReu4l258PiQksm0RypvPLmZ0czkzlk52laZrpBfdNtaLmob0BkBdhi1aWoTtT4+GTmJNpG7BK76ZW1Ia3//t4pdZCzKWrvYKgUwKyERSI2ftqMxY4cmwSzchxcggH3P5K64B4ydfRDcSxLgtbRd+6ll9Zh/Rj07m4aMGxZ2wGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhBX1nvR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhBX1nvR"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so197887f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630625; x=1784235425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=63iZQAM7RJLn09riXo0ene6klrJLz5v8YHBQUwmsJ6s=;
        b=ZhBX1nvRsqxMGhA4Pkyu9DlXgzdBx+t81+yDQuNhACZSeprWF0kFnCA9YVXwWaKQ2N
         RjhT4Nqeb4GJvBEMiJlQh2nQa5sgvkhDoQIrSPc17Ke28+w55rTuNQd5ef7VkRt2EbcM
         Mu9fcIC5qajkybIt8ibniesEm9EOkjMD+zvxgw3hKDQSWwlhC8CzkRdFSCeb5ogZvxq2
         USSiWnySEROt+XThCJnpsASPL6hBitF6zEPC3hG4O3d3NrdoC9eQCKxZvYc5JVjVNhBN
         CRrgh44VV2buZ0XjsljEeC0e/qI9Gdzg8GJFb6Sb+GycsK795REfjOi0YwAPCzmmUbrX
         OPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630625; x=1784235425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=63iZQAM7RJLn09riXo0ene6klrJLz5v8YHBQUwmsJ6s=;
        b=quyHTvcr/safDr3XA3KAmomkYBbGv0tcTygRjwrxwPrsmdEtdR5SdCBFExgQMoFIFb
         7HeEU7hwhyq1T+y0POsQS0LND2TgfWv2EMHAmcQ2Xj9MJqj+DUko3mFj4J3qIp8WPfuk
         ljckJarJvPC/aW0Q5+hHIMoVxBUnDWQszs63L5nvDMFkUxMQWEvjOa57MIfTj1Tciv0S
         7V3a2v+QQz7g7936Hy6gZGSNlzxYFFUVTwPi5//Ho4G6b0/QqF9aGK8mspmQxRqoabX9
         rL9yekK1UOK/Y8Im4NFW/BUXKWDOL14Qj62OhiRbCcZco2Iz+ciINqly3BiHny7oAAOT
         Y+yg==
X-Forwarded-Encrypted: i=1; AHgh+Rqy6W/CgFM5H8zGHy12kbC2iREpdIMNH01DHCX2TXv8bFfhavO7+GQW+9NSuILvePeq2p0DIgVlsf9zILs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUCnbEVWailMYQHHPq1n/2KQwMShaA+uFMqYWuJ8hP60GYUCy
	jZIVWIUt5RWhTlK0IQ0/IlKJNCGN1q+Pl1rf6SZ7Cr+n6ss8frZGqMOU
X-Gm-Gg: AfdE7clkwnIBnUCIflno4kY+4aPBHLyQcePGbkOzu6g9yOPeGWwBFnRbzsfOzEzq+A5
	hSl7bvQ6i6CwXiOlODvizVD9kzo/grpkFhsWaXHZeHstU3RXY4s5q3M494m7LjY3gcJqRA3XJY+
	iJCKJxCvOsG+emSmGpEGfTCodcowg11Z8DfePpVTFbkaUQ4q3I/WY3z5XGbMOJqLXtwpgbEkZEK
	4qiDgav7zmyEX0TpL5ccCEwpLabDWDgIJs+bmFoi/2ODXM8P+FC4vD415+3dNfEEmVM4encQtoc
	K2h8eSu4FNpI6GCogbwPaZIY8WQ3F3zdJtobrTegoLGuu3XVXILbEYbDDGODB9tLjI7BiDE7rDE
	gQJGsSvNiX+lPXhn2zHmtaJPzoXTJvC3/NA2tEDsIcT0YEAxkycC3zaPN2vHkuzUkDJCU39ELoP
	m6j+PWP20rK+Fo1+hapRw5yVxI+dfOvP5ftWkd2NyMTUbop8vOlvJSiTjkKjkVqLi06sIYI5wDK
	+C01B8C
X-Received: by 2002:a05:6000:26ce:b0:470:2fb1:3dbc with SMTP id ffacd0b85a97d-47df07894d8mr9639468f8f.35.1783630624617;
        Thu, 09 Jul 2026 13:57:04 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm52894965f8f.6.2026.07.09.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:57:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/4] serial: 8250: Add AN7581 UART support
Date: Thu,  9 Jul 2026 22:56:48 +0200
Message-ID: <20260709205656.319531-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of [1] to support UART driver for
Airoha SoC.

One additional function was needed serial8250_get_baud_rate()
for the driver to work correctly for baud rate calculation.

While at it also try to clarify a long standing issue with
new UART driver when adding new ids for uart_config[].

[1] https://lore.kernel.org/all/20250209210241.2622309-1-benjamin.larsson@genexis.eu/

Changes compared to [1]:
- Fix all formal error
- Use better compatible names
- Drop unneeded header
- Drop usage of irq (it's filled by the generic function)
- General code cleanup and reorg
- Split to patch and add the UAPI map patch

Benjamin Larsson (1):
  dt-bindings: serial: 8250: Add Airoha compatibles

Christian Marangi (3):
  serial: 8250: export serial8250_get_baud_rate()
  serial: 8250: map UAPI port type to internal enum
  serial: 8250: Add Airoha SoC UART and HSUART support

 .../devicetree/bindings/serial/8250.yaml      |   5 +
 drivers/tty/serial/8250/8250.h                | 126 ++++++++++++
 drivers/tty/serial/8250/8250_airoha.c         | 190 ++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c           |  95 +++++----
 drivers/tty/serial/8250/Kconfig               |  11 +
 drivers/tty/serial/8250/Makefile              |   1 +
 include/linux/serial_8250.h                   |   4 +
 7 files changed, 393 insertions(+), 39 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

-- 
2.53.0

