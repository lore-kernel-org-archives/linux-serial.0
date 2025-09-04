Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3A278751;
	Thu,  4 Sep 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021110; cv=none; b=jsnWymmPouN1ulnRcI2ur//ShWo2Gm6mlTW5vnMofcsGyuUivjLigy2cvWWE4hrKIp110fJMGeGhmGJhkMxFvlNnIZlrgR+GBr6licT0C7hvczeQJkDvHUUI7XSeQK8AM1oM4lVP/nueaXkVu/schl4FAK3yZg34UCrggr5YTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021110; c=relaxed/simple;
	bh=8Yeh/tAVOAYkSI0FRSgjmVSkAYxuZ9zbAdCdxFJkaJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kBT45ciLqGrevR3Y4uRUc8yqy+9vWJZ6o3yMgEB7ZYM7v+RbyiG7iWxt32Z+GRjdHH6SGipDSynNuk7foVdc6E0m93z+dc9K0olJogoM8yJopKRaJ4hYpWFGPFTM3q4oCxhtL04EiTKeHN4fKiWjEnJBYtWNk5k1+iexVyg91mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rLE+MT2E; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rLE+MT2E"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LOwRV3104322;
	Thu, 4 Sep 2025 16:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757021098;
	bh=W+7k4iMDy3tPbRxwd98DTYf2oybvEfzGMmh8cURrCmg=;
	h=From:To:CC:Subject:Date;
	b=rLE+MT2EsLwL45Qi+zX5/TxKSxsrRerZ0ZRN/aFJYEVqwq+I+ZD6Bje3gy9xr+3qd
	 xCS87Ynl2PO/dmzIzf9UWCA0HwP0IWn9HyM1CFMWdhzn+49lGY5r2Nhw8WDzAzrWr2
	 AQ4msLeW8PXxpYl2DrSZ9T/fRJIO3rLsA6XMXCRY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LOv9w405688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:24:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:24:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:24:57 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LOvld3611150;
	Thu, 4 Sep 2025 16:24:57 -0500
From: Kendall Willis <k-willis@ti.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <k-willis@ti.com>, <john.ogness@linutronix.de>,
        <andriy.shevchenko@linux.intel.com>, <yujiaoliang@vivo.com>,
        <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
Subject: [PATCH 0/3] serial: 8250: omap: Add wakeup support
Date: Thu, 4 Sep 2025 16:24:52 -0500
Message-ID: <20250904212455.3729029-1-k-willis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
series:

1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
   wakeup state": Patch which skips setting constraints for wakeup sources
   that use pinctrl state 'wakeup'.

2. "serial: 8250: omap: Add wakeup support" (this series): Implements
   wakeup from the UARTs for TI K3 SoCs

3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
   functionality to wakeup the system from the Main UART

Testing
-------
Tested on a SK-AM62B-P1 board with all series and dependencies
implemented. Suspend/resume verified with the Main UART wakeup source
by entering a keypress on the console.

[1] https://lore.kernel.org/all/20240523075819.1285554-1-msp@baylibre.com/
[2] https://lore.kernel.org/all/20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com/

Kendall Willis (1):
  dt-bindings: serial: 8250_omap: Update wakeup-source type property

Markus Schneider-Pargmann (2):
  dt-bindings: serial: 8250_omap: Add wakeup pinctrl state
  serial: 8250: omap: Support wakeup pinctrl state on suspend

 .../devicetree/bindings/serial/8250_omap.yaml | 25 ++++++++++++-
 drivers/tty/serial/8250/8250_omap.c           | 36 +++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)


base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
-- 
2.34.1

