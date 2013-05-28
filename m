From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v2 2/5] ARM: davinci: da850: override device name of UART in DT kernel
Date: Tue, 28 May 2013 13:58:03 +0530
Message-ID: <1369729686-6595-3-git-send-email-prakash.pm@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933390Ab3E1I1N (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 May 2013 04:27:13 -0400
In-Reply-To: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-serial@vger.kernel.org
Cc: nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Populate OF_DEV_AUXDATA with desired device name so as to prevent
clk_get failures.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 961aea8..e429945 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -47,6 +47,9 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01d0d000, "serial8250.2", NULL),
 	{}
 };
 
-- 
1.7.4.1

