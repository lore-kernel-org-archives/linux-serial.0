Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F3309F07;
	Wed, 10 Sep 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539439; cv=none; b=leUbZuey13GYH6iCaLeOpnx6hNy82lRYJC65XmRtm+GkM9rpX2dLZo4kDK2Wb29jc5T4bU8M5iB/pSfJt9HFwISxGhAzkUFgTJQa5CMH9aRjPCvETuqmXZ9KLJALgRgAHQeO8rDmkOR1gBTXIZu9Q+iepGgVv0Pqnlhst4SlCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539439; c=relaxed/simple;
	bh=biTn94UYUWgbB4jzZfQ+pzMLwiSvOn6MtuyjJZkNgKQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Iz1/dnyaaiv+Nn16g0/fuWrVhRsj0sWrjG1uzWTSWxBUtmbHCL5Fm1WDTe4gnLHmefopUggVuJkmvLzj1aVn1XO01tkX3aPfeIWKDrprWjNYqZsO2JzxU2XMRr1UDjJUMkDmMFGg1/dKXZmkUTNyrHNlYWHoazYBG4mZeyN6kmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cern/LBe; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cern/LBe"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ALNoL4226940;
	Wed, 10 Sep 2025 16:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757539430;
	bh=bmEY0WfaxpzoYR06q8U/9vAuoR60sOBVOraHfKIbfgs=;
	h=From:Subject:Date:To:CC;
	b=Cern/LBe0Av9vMSEe1cKDTioXiRPAXYG/uW/6j29e90j62M1J5WAhv7GuwFjuBaCv
	 mqcsIO5Ckp2enUju20rYROuQxab7V8NlNogrlEDNteF5aysSh7UCoyFcSalDNVuO76
	 H4oiik8YvQkuAd2DGkgiamr45n+lQjronFopDnR0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ALNnA2572645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 16:23:49 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 16:23:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 16:23:49 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ALNnZ31097742;
	Wed, 10 Sep 2025 16:23:49 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v2 0/2] serial: 8250: omap: Add wakeup support
Date: Wed, 10 Sep 2025 16:23:30 -0500
Message-ID: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLswWgC/03Myw6CMBCF4Vchs3ZIO7RgXfkexkUDg0wESlq8h
 fDuNq5c/jkn3waJo3CCU7FB5KckCXMOOhTQDn6+MUqXG0iRVU4rfPi4YuclfTAfZMZjHjBMfsG
 qNo7b2jfaWsjAErmX9w+/XHP3MUy4DpH9H6kMaTLWllVDTpFDjXd8yThKOq9StmGCff8CBlorG
 6cAAAA=
X-Change-ID: 20250910-uart-daisy-chain-8250-omap-3649ec6a7155
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <a-kaur@ti.com>, <andriy.shevchenko@linux.intel.com>,
        <yujiaoliang@vivo.com>, <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>,
        Kendall Willis
	<k-willis@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds wakeup support for the serial 8250_omap driver. On the
TI K3 AM62 family of devices, the UARTs are able to wakeup the system
from various low power modes by using I/O daisy-chaining.

The wakeup functionality is implemented by adding the pinctrl state
'wakeup' in which specific flags are set on the pins to enable wakeup
via I/O daisy-chain. If the 'wakeup' pinctrl state exists for the serial
device, the 'wakeup' pinctrl state is selected on suspend. Upon resume,
the pinctrl 'default' state is selected.

The commits "dt-bindings: serial: 8250_omap: Add wakeup pinctrl state"
and "serial: 8250: omap: Support wakeup pinctrl state on suspend" were
picked from this series [1]. The commit "dt-bindings: serial: 8250_omap:
Add wakeup pinctrl state" was updated to follow the structure of a
similar patch [2] by Markus for the m_can driver. The commit "serial:
8250: omap: Support wakeup pinctrl state on suspend" was updated to only
include s2ram functionality instead of a poweroff state.

Implementation
--------------
This series is intended to be implemented along with the following
series. This patch has no dependencies on any of the other series:

1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
   wakeup state" [3]: Patch which skips setting constraints for wakeup
   sources that use pinctrl state 'wakeup'.

2. "serial: 8250: omap: Add wakeup support" (this series): Implements
   wakeup from the UARTs for TI K3 SoCs

3. "arm64: dts: ti: k3-am62: Support Main UART wakeup" [4]: Implements
   the functionality to wakeup the system from the Main UART

Testing
-------
Tested on a AM62P SK EVM board with all series and dependencies
implemented. Suspend/resume verified with the Main UART wakeup source
by entering a keypress on the console.

This github branch [5] has all the necessary patches to test the series
using linux-next.

Links
-----
[1] https://lore.kernel.org/all/20240523075819.1285554-1-msp@baylibre.com/
[2] https://lore.kernel.org/all/20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com/
[3] https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-pmdomain
[4] https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts
[5] https://github.com/kwillis01/linux/tree/uart-daisy-chain

Previous Versions
-----------------
v1: https://lore.kernel.org/all/20250904212455.3729029-1-k-willis@ti.com/

Changes from v1 to v2:
 - Drop patch for updated wakeup-source binding
 - Update dt binding for pinctrl to only use either default or sleep
   states and change commit message to reflect the change

base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
---
Markus Schneider-Pargmann (2):
      dt-bindings: serial: 8250_omap: Add wakeup pinctrl state
      serial: 8250: omap: Support wakeup pinctrl state on suspend

 .../devicetree/bindings/serial/8250_omap.yaml      | 16 ++++++++++
 drivers/tty/serial/8250/8250_omap.c                | 36 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)
---
base-commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
change-id: 20250910-uart-daisy-chain-8250-omap-3649ec6a7155

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

