Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE24AD7E8;
	Tue,  8 Sep 2026 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863536; cv=none; b=LNuYAbuUL/IhbIwUqOQpBlZ06DrhlCA07P3WHJKw92lY7ZFk4n+qVDcKvpaz87xSdEMLf6KdwmlUkEQZqfWM8a39W1nKvcVQsx0ve2rKAsO9PkWyh4evpWZQC6X13tDXy+nr3R8j6N6VRhrpeojd7rMQfN4nCsmYORhxh+gRSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863536; c=relaxed/simple;
	bh=eGBKc4cKDf2xrNIqX/9XGqH3aFQWpEDWqWTRdN9clu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTDtSltXzM2tHs2hOSF2eO6zoNJeT3R+NRnkzvxFCq/+u1OSobi7ZCluhIaFDtSxcLmKz3NoglU+IerVx01mKnT2AZz3tVNGD1NRVF5HYAyYS4YgviBfx2qbVzGjg/alzZ+pCDdDoAnbX1XIP4/Z18rJftJ5l0uMB4Q++ExoYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07084971|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0636042-9.08945e-05-0.936305;FP=7043896855308728948|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j8fKSye_1788863525;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j8fKSye_1788863525 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 18:32:06 +0800
From: zjzhao@edatec.cn
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Zi Jie Zhao <zjzhao@edatec.cn>
Subject: [PATCH v4 0/2] WK2xxx SPI to UART bridge driver
Date: Tue,  8 Sep 2026 18:31:27 +0800
Message-ID: <20260908103129.58085-1-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Jie Zhao <zjzhao@edatec.cn>

Add support for the WK2xxx family of SPI to UART bridge ICs from Chengdu
Weikai Microelectronics (WKmic): WK2124, WK2132, WK2168, WK2202 and WK2204.

Base the driver on the vendor's open-source implementation:
https://github.com/britus/wk2xxx/blob/master/spi-wk2xxx.c

Use the company's website domain, http://www.wkmic.com/, for the vendor
prefix.

Describe the external reference clock with the standard "clocks" property
and model each UART as a "serial@N" child node.

Changes in v4:

- Rename the binding file to "wkmic,wk2124.yaml" so its filename matches a
  compatible string;
- Replace "clock-frequency" with a required standard "clocks" input;
- Document why individual compatible strings are retained: the two-channel
  WK2132 and WK2202 do not have the hardware flow-control and RS-485
  registers present on the four-channel variants;
- Identify the maintainer as Zi Jie Zhao and document the vendor website and
  source attribution;
- Remove the unnecessary "linux/mod_devicetable.h" include;
- Describe hardware flow control and RS-485 support per chip variant;
- Retain the v3 fixes for IRQ setup and teardown, polling lifetime, SPI error
  handling, cache-safe shared buffers, and bounded IRQ processing.

Testing:

- Run dt_binding_check with the WK2xxx binding;
- Build the driver for an ARM64 target;
- IPC12 with WK2132 on SPI0: reboot, load the driver successfully, and
  register ttyWK0 and ttyWK1 with IRQ 184 and base_baud 691200;
- SBC2300 with WK2204: run four-port TX stress and repeated module
  unload/load with closed ports.

Zi Jie Zhao (2):
  dt-bindings: serial: Document WK2xxx SPI UART
  serial: wk2xxx: Add WK2xxx SPI UART driver

 .../bindings/serial/wkmic,wk2124.yaml         |  119 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/tty/serial/Kconfig                    |   17 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/wk2xxx.c                   | 1433 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 6 files changed, 1575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml
 create mode 100644 drivers/tty/serial/wk2xxx.c

-- 
2.43.0
