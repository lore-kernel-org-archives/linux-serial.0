Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378653365;
	Thu,  1 May 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746059493; cv=none; b=TjKi0lY8uZcP2wKRKtgqPoxXRHar6TBkcENo/bF1yTYiijlp7AukKp2Dc/RXoaDhBnRc1OQdS0nmuLIHoqdY5XxxU04dCKqFj9YIOkqZcvX5YczZlcC9E3+N/sFuO3povy+3byVZFBLlp7YzER64DkljzXa/VA7eH3GIFve8hVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746059493; c=relaxed/simple;
	bh=rl1FDHVGHUrVmjB/Hve1Su6EGMKlnkzzN/XniVB/oWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=obK+e6Mkb9yxNsCmjp11G99XlSpVGh2reKLaEwYTgEqYJUxRplk/RfTqkYL31FePcWO58/b1immR9HuRwh/u1pYPAt8G9vTman8r/J03spGCWy35SXH1J+6zM1LCEwpFXhYjuJ0Xbn4Sj2yWoTg6Oalu6Jq9uF5DGtImfQNqtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KrJaFAYu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KrJaFAYu"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5410VDIY3512346
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746059473;
	bh=uDS0OCdhY4JbwsMlVZ9q0ISV0TqgbRByeSMH8N+QwPI=;
	h=From:To:CC:Subject:Date;
	b=KrJaFAYuf+g+8Q3V5tP51sTeId+SBMyBdrasr34FBjRmnzsxtrVrU3w9FRyJaaeUs
	 hTN2vJiUBp4emmG11RJtVSVl+arTFchpc5s83VRxtp4wVnaPl9LbaIoNr+0Mtti6/q
	 GrwIStD7xgqJaQu8Pc2HGwv2BQFw7MINvwFMIgo4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5410VDj3014734
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Apr 2025 19:31:13 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 19:31:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 19:31:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5410VDaC044266;
	Wed, 30 Apr 2025 19:31:13 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>
CC: Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH RFC 0/2] Introduce PRU UART driver
Date: Wed, 30 Apr 2025 19:31:11 -0500
Message-ID: <20250501003113.1609342-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch series is sent as an RFC to get some initial comments
on the PRU UART driver.

The ICSSM modules on am64x SoC and the PRUSS module on am62 SoC or am335x
SoCs have a UART sub-module. This patch series introduces the driver and the
corresponding binding documentation for this sub-module.

The DTS patches for adding PRU nodes and enabling PRU UART will be added
in a later v1 version of the series if accepted.

This driver has been previously tested on the following boards:
am64x SK, am62x SK, and am335x SK boards.

Bin Liu (2):
  dt-bindings: serial: add binding documentation for TI PRUSS UART
  serial: 8250: Add PRUSS UART driver

 .../bindings/serial/ti,pruss-uart.yaml        |  54 +++++
 drivers/tty/serial/8250/8250_pruss.c          | 213 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  10 +
 drivers/tty/serial/8250/Makefile              |   1 +
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ti,pruss-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_pruss.c

-- 
2.49.0

