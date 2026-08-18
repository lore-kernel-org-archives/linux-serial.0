Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786703A7F68;
	Tue, 18 Aug 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045975; cv=none; b=BaIHfwkScZzCNnhRXddKcoH87eY3Jdr/CdoJj1lNDeBawRpjloozT9DsGNOH2cyFomm6FHCwVCFpJKKSQvgkg/gw73t68eRv3LwgUxrJ8PvaZlLRDV/gf62vB8K79lle0N3cN1ptykIPRSfd0p1E+mQ/jrEcWfY4zqKGczs3O44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045975; c=relaxed/simple;
	bh=/XtTuNs3/JlrkArWyQfN+kR+xmmmXARsCLQxHTw6K5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fer3dyPYi0ONBdy6j0sa1O6aFbwGemhW2Phe0hQ2UxS5M+vw0LVQfyGFG31VTOCD26RpPKlxob6HP2ACbxAXlrd7CGlvFJn8P7hLUkCV+yEZRBvxLId7fAgpxkHeJgKt9DfY88W0osCI6L6It2lfsT2mOaS4Jbyn1dFu4gYg4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b2738d769ae811f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0744c12c-f52d-4a1e-b993-7638cb2102ea,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:f3350b344739e159ec54e6e9f4b4af7a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b2738d769ae811f19a56ed5b684f684d-20260818
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1492018790; Tue, 18 Aug 2026 17:39:24 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH 0/3] serial: 8250_mxpcie: probe and console fixes
Date: Tue, 18 Aug 2026 17:39:15 +0800
Message-Id: <20260818093918.3190686-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three fixes for the Moxa PCIe serial driver, found by reading the code
that was split out of 8250_pci.c and extended during this cycle.  The
driver is not in mainline yet, so the series is against tty-next.

Patch 1 fixes a NULL pointer dereference during probe on the boards
without RS232 support: the serial core calls ->rs485_config() from
within serial8250_register_8250_port(), which happens before
pci_set_drvdata() has published the board.

Patch 2 makes the probe fail when a port cannot be registered.  Today it
returns success, and removal then unregisters ports that were never
registered: line 0 for the entries the loop did not reach, and a
negative line number for the one that failed.

Patch 3 stops set_termios() from dereferencing port->state->port.tty,
which is NULL when the serial core sets the line up for a console or for
kgdboc.

I have no Moxa board here, so the series is compile-tested only: W=1
allmodconfig build of drivers/tty/serial/8250/ and checkpatch --strict,
both clean.

Linmao Li (3):
  serial: 8250_mxpcie: set the driver data before registering ports
  serial: 8250_mxpcie: fail the probe when a port cannot be registered
  serial: 8250_mxpcie: take the line settings from the new termios

 drivers/tty/serial/8250/8250_mxpcie.c | 34 ++++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)


base-commit: 8b0b29fdcb47907ae0296b8fe829e918e05e300f
-- 
2.25.1

