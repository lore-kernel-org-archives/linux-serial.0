Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282661F4C90;
	Tue, 13 May 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173587; cv=none; b=tHd/reQs4wueelXi9RSrEd1dnwZp/QIgFwI4p3K2sCEGOnafVcWXIrJqBhjoA6GoUkkhJloU3YQwaM7JUb58A13jFpJQ6EZg2Xnn1An7pIz8G9OzqBn6waLIAZGnXtvt1FZh7yvjmPf9qQAAa0tiqzsgAzGTlRQqw3XSyyA7tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173587; c=relaxed/simple;
	bh=BtounoG/vKSbu3tsaWeS/rSZEDXAUdtFU0rHDEv38No=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Js72Yc1pnZppHAKXIepS/AW9cgcgj3wttpgs34jSYSbNLKTK9vp2k9mQK6w93O1hVDvRXlta8sb0NsF/fnb7lwCpUFLjm/pNKyJ0DGnmX/itl0tkuOaM3wi3HsVFw5si1OSVFoczUAOKj3maGYtQB/dkxOdFh0S2764eNoxdqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p3Lt/g9G; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p3Lt/g9G"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxaSb2425891;
	Tue, 13 May 2025 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747173576;
	bh=eg2RLq5HKtaxZ8TLlhhXyUxGYIdmPjE+5+PbHdsfi00=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=p3Lt/g9G0a88NqAQhNyRc900jqn7/juwG4vqL1a5QKK8GUYbq7PuZFU7gJczi7B7p
	 qmJNbN3TTH3CYnP03w90YQDRjluasJwCTBfDeIVyiLzUQnjLWse+zmB3dcF0fnypkB
	 Gxt7nep74RR/gTXh2YRIQ+TUqXizNF+VdxGbm/uw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54DLxZpw1915694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 13 May 2025 16:59:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 16:59:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 16:59:35 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxYdH111031;
	Tue, 13 May 2025 16:59:35 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 6/7] DONOTMERGE: arm64: dts: ti: k3-am62-main: Add PRU UART node
Date: Tue, 13 May 2025 16:59:33 -0500
Message-ID: <20250513215934.933807-7-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513215934.933807-1-jm@ti.com>
References: <20250513215934.933807-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There is one PRU UART module in the PRU subsystem for am62 SoC.

Add a PRU UART child node in PRUSS node in am62 main voltage
domain .dtsi file for am62x device.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 9e0b6eee9ac7..c012f33f4609 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -1144,6 +1144,15 @@ pruss_intc: interrupt-controller@20000 {
 					  "host_intr6", "host_intr7";
 		};
 
+		pruss_uart: serial@28000 {
+			compatible = "ti,pruss-uart";
+			reg = <0x28000 0x40>;
+			clocks = <&k3_clks 81 13>; /* pruss_uart_clk */
+			interrupt-parent = <&pruss_intc>;
+			interrupts = <6 4 4>;
+			status = "disabled";
+		};
+
 		pru0: pru@34000 {
 			compatible = "ti,am625-pru";
 			reg = <0x34000 0x3000>,
-- 
2.49.0

