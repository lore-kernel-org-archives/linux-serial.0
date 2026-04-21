Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D02368276;
	Tue, 21 Apr 2026 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751202; cv=none; b=Fk6p79MV2g3Ql1BtDcVvId1ZT9bvZ0gCo6kSI7g+e/iTm7pGXrY8PRy3TYitM67cah6nRSENDQNT+50Mm9ClwzxZk1CHHZZfyX+niDHqbc0ADni8s7K6uim1DXQlGPmzQaJ8wFc26Wkidqaa4nS6Bzbz4LUiJT/K1Uekb765Ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751202; c=relaxed/simple;
	bh=nlzC/TkdOL8Fx2Pa2jwa6BfY6uq0jPunb9jzlydHx7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HoOdQ0g4+Jli5MLaBLXowi6a4/L0I85AzLwVGQLNZqv4IAmAhM+yAkoj12V4qI9m3jEh7B+4YPLHzsH8NEcaK3bHDdf/77M+zbPPSy72VSp0cOu0CkDvAzsJnJ/AMzhQUfBSMUpH7VlO46wsGLl00QHEt38OZf/OiLPGux3a2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=kAVzyhPr; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="kAVzyhPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Subject:Date:Message-Id:
	MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc; bh=pv
	2U/fmy1reiP+MQCpzdYmztXgUgUtkA06G8kvdTjMo=; b=kAVzyhPropr4lSGuxv
	9Hw9HCWdsJVvqMDAD8dEYrifdSEBRQ4CGtGQfAXBT3oUGaT7LLuhVDul+cW8V4LE
	fZbVr5yFTn55bIBmtq/dJbe/Rcyq7Lt4XJFuA1jU0qdBmaV1g1XmCWqVZLDcYm2b
	NA8v3D51P/TGnnodToLo8HlXI=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkNyEudpn5ACAA--.1518S2;
	Tue, 21 Apr 2026 14:00:19 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Subject: [PATCH v3 0/2] serial: 8250_dw: Add support for UltraRISC DP1000
 uart
Date: Tue, 21 Apr 2026 13:58:50 +0800
Message-Id: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoS52kC/4XNTQ6CMBQE4KuQt7amP1iElfcwLkp5lRoE00KjI
 dzdFo0LXbicZOabGTw6ix6qbAaHwXo79DGITQa6Vf0ZiW1iBk65pIKWZOpGp5z1mqSl6ojMjZG
 iwMZwCXF2c2jsfSWPp1f2U31BPSYnNVrrx8E91s/AUu/NM/nLB0Yo0Xl8EVgKoXaHT2Wrhyuki
 8D/ITwiUtUCC6P2JdPfyLIsTypzDLULAQAA
X-Change-ID: 20260309-ultrarisc-serial-64ff637edf26
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776751174; l=1735;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=nlzC/TkdOL8Fx2Pa2jwa6BfY6uq0jPunb9jzlydHx7w=;
 b=xYvHnO/glTxpq7fhEoZSLCbJsgh3Ri6zI5A6Opg3VG6rMIhDENYJXBRhBsdU0Iru4u5e4fBsj
 3kvBSWUDzG1C7Y0rOAm5keuXs+hOGg4MUPgQhQNOEUl6Q2MsN9+mosD
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnEkNyEudpn5ACAA--.1518S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1DJryfAw1DJFW8Aw15twb_yoW8Ar4rpF
	nI9Fsxur9xtryjka97tw1xAF4xuF47AryjqF1jkwn8ta98ZF1IqrWfKw45Za4DZrn5Wr40
	kF15ur1rKa429aUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQADEWnlor4ACwAFsN

This patch series adds support for the UltraRISC DP1000 UART controller.

The series includes two patches:
1. Document the DP1000-specific compatible string for this UART variant.
2. Update 8250_dw to use a fixed CPR value for the DP1000 UART.

The patches have been tested on Ultrarisc DP1000 development board with
Linux v7.0-rc7, verifying basic UART functionality.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
Changes in v3:
- Rebased on Linux v7.0-rc7.
- Patch 1:
   * Removed separate `items` entry for DP1000, merging it into the
     existing `enum` to comply with the schema.
   * Updated commit message to describe DP1000 UART hardware differences.
- Patch 2:
   * Drop the custom quirk for missing CPR register.
   * Switch to using DW_UART_QUIRK_CPR_VALUE to provide a fixed CPR value.
- Link to v2: https://patch.msgid.link/20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com

Changes in v2:
- Rebased on Linux v7.0-rc4 (previously on v7.0-rc2).
- Reordered patch series: DT binding patch comes before driver changes.
- Updated commit message for DT binding patch.
- Link to v1: https://patch.msgid.link/20260316-ultrarisc-serial-v1-0-c464f3e933a5@ultrarisc.com

---
Jia Wang (2):
      dt-bindings: serial: snps-dw-apb-uart: Add UltraRISC DP1000 UART
      serial: 8250_dw: Use a fixed CPR value for UltraRISC DP1000 UART

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 drivers/tty/serial/8250/8250_dw.c                              | 7 +++++++
 2 files changed, 8 insertions(+)
---
base-commit: e774d5f1bc27a85f858bce7688509e866f8e8a4e
change-id: 20260309-ultrarisc-serial-64ff637edf26

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>

