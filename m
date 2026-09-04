Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60C3A7D9E;
	Fri,  4 Sep 2026 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506446; cv=none; b=s11GTKHirIr4veOuxI6lK+o5gIwK80Ig9jPdPNyxyMRQrA21R7IemXrIj/hegH381T1jRtFWiENrmcHFFwA/qD8z01TcGGiqTib0c7wdjTiYrNK/nplwr8hn75rIsI2woKf+SR21RtGFuUnu9aIAyqVv/6iuG4MIcT9ZRegR6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506446; c=relaxed/simple;
	bh=14SgjsL+nrXR9BDwdKIB6cc8Vros70Xd1LH+flFnrBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1hF5Pj/sPWsPNbr1Z315IWHzCkVZhWtcfeSRUtYPmvAftCy6N//thLwLPrDQWobWxEv1NmHyYAvL7JYgtsvi7amsY29rFCcGbCgF5DZMcY5ce+LpVEWPF2J4xYC3XZL9XtKo6tFEew7jm8fAf38/Ksoif5a+3+W5epnHu1Mexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1261946|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00263352-0.00325272-0.994114;FP=16268922686470117870|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j5G7hly_1788506428;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j5G7hly_1788506428 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 15:20:29 +0800
From: zjzhao <zjzhao@edatec.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/2] WK2xxx SPI to UART bridge driver
Date: Fri,  4 Sep 2026 15:20:25 +0800
Message-ID: <20260904072027.67473-1-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a driver for the WK2xxx SPI to UART bridge ICs
(WK2124, WK2132, WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai
Microelectronics). Each IC exposes two or four full-duplex UART channels
with 256-byte RX/TX FIFOs through a single SPI slave interface and one
interrupt line.

The driver is a rework of the vendor driver (https://github.com/britus/
wk2xxx) modeled after the NXP sc16is7xx driver. It registers ttyWK0..N
lines (IDA-allocated), uses devm_request_threaded_irq with a kthread
worker for register access, falls back to polling when the interrupt
line is not described, and supports hardware flow control and RS485
where the IC provides them.

Patch 1 adds the driver, the PORT_WK2XXX (124) type and the
SERIAL_WK2XXX Kconfig option. Patch 2 documents the DT binding and
registers the wkmic vendor prefix.

Tested on Raspberry Pi 5 boards (EDATEC IPC1200 with WK2132 on SPI0 and
SBC2300 with WK2204 on SPI1); loopback TX/RX tests pass.

zjzhao (2):
  serial: wk2xxx: Add WK2xxx SPI UART driver
  dt-bindings: serial: Document WK2xxx SPI UART bindings

 .../bindings/serial/wkmic,wk2xxx.yaml         |   69 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/tty/serial/Kconfig                    |   17 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/wk2xxx.c                   | 1245 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 6 files changed, 1337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
 create mode 100644 drivers/tty/serial/wk2xxx.c


base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
-- 
2.43.0

