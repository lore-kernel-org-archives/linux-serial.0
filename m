Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB11A6813;
	Tue,  1 Sep 2026 04:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236139; cv=none; b=SmLTTUTGEcjxq6B9zKSSfLVeshwvXIAbmm1YULNMtG1kNkirrPioROI8y2nNbdvRAOZoVCfmORpOiAsynMcGw6DhzZGQ2lvjulmg3Gbn0zFxOCbxmsqj9J9UFox7J4pODLHuAkdJ4IAGWV/hvJgjHugXCWmyyXWNNmpIKCgLemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236139; c=relaxed/simple;
	bh=r3+GXqBAFaI8akqMxU6selu9DsbY88ttxn4dwcCKo24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c/SsqSsYA7D3FDK16My+M9SVKE7P+XxGRFLeNQRdYvlExwFwdzMUItDM+cL4eEMgx2tFWRnpzI4UCbYOLCu5+ILuFm9O6CW3DL3zTBu9l5fqXflOaVMTx9ttNZkHjE+Xulmv7QQBA5JK7qMCdZwFNaZTKEfeRRn8ysWF66eRzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c60a3cd0a5bb11f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:befef9f6-68fa-42df-9c3a-61de88febb02,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:9a3abb9b94d30d80a0db2679609df97c,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c60a3cd0a5bb11f19a56ed5b684f684d-20260901
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1231077963; Tue, 01 Sep 2026 12:15:32 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v2 0/3] serial: 8250_mxpcie: probe and console fixes
Date: Tue,  1 Sep 2026 12:15:16 +0800
Message-Id: <20260901041519.114737-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three fixes for the Moxa PCIe serial driver, found by reading the code
that was split out of 8250_pci.c and extended during the 7.3 merge
window.  That code is in mainline now but has not been in a released
kernel, so the series is against tty-linus.

Patch 1 fixes a NULL pointer dereference during probe: the serial core
calls ->rs485_config() from within serial8250_register_8250_port(),
before pci_set_drvdata() has published the board.  It takes a board
without RS232 support and SER_RS485_ENABLED still set once
uart_get_rs485_mode() has run - on Crescent's ACPI machine the firmware
node clears that flag, which is why it does not crash there.

Patch 2 makes removal unregister only the ports that were registered.
v1 failed the probe instead; as Andy pointed out that is a behavioural
change, and keeping the ports that do work is what pciserial_init_ports()
in 8250_pci.c does, so v2 keeps it and restores only the missing count.

Patch 3 stops set_termios() from dereferencing port->state->port.tty,
which is NULL when the serial core sets the line up for a console or for
kgdboc.

I have no Moxa board here.  Crescent Hsieh tested patch 3 with kgdboc on
a CP-168EL-A, and looked for patch 1's crash on a CP-134EL-A; the rest is
compile-tested only, W=1 allmodconfig build of drivers/tty/serial/8250/
and checkpatch --strict, both clean.

v2:
- 1/3: no code change; the commit message now says the crash needs
  SER_RS485_ENABLED to survive uart_get_rs485_mode() (Crescent Hsieh).
- 2/3: keep the ports that registered successfully, record how many and
  unregister only those, instead of failing the probe (Andy Shevchenko).
  Retitled accordingly.
- 3/3: drop the cflag local and read new->c_cflag directly, and pick up
  Crescent Hsieh's Tested-by.

Link to v1:
https://lore.kernel.org/all/20260818093918.3190686-1-lilinmao@kylinos.cn/

Linmao Li (3):
  serial: 8250_mxpcie: set the driver data before registering ports
  serial: 8250_mxpcie: only unregister the ports that were registered
  serial: 8250_mxpcie: take the line settings from the new termios

 drivers/tty/serial/8250/8250_mxpcie.c | 30 +++++++++++++++------------
 1 file changed, 17 insertions(+), 13 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.25.1

