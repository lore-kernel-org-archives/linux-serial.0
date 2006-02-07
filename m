From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH] Fix compile error in 8250_au1x00.c
Date: Tue, 7 Feb 2006 14:15:00 -0700
Message-ID: <20060207211500.GC5227@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=YZ5djTAD1cGYuMQK
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from amdext4.amd.com ([163.181.251.6]:59362 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932401AbWBGVL7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Feb 2006 16:11:59 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch fixes a compile error when building the 8250_au1x00 driver
for the DB1550, which doesn't have a UART2 defined, resulting in a 
compile error.

There are additional rumors of strangeness on the DB1550, but those
are unsubstantiated at this point.  At least with this patch, it will
compile.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--YZ5djTAD1cGYuMQK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=8250_fixup.patch
Content-Transfer-Encoding: 7bit

[PATCH]:  Fixup for the AU1X00 8250 driver

The DB1550 actually doesn't have a UART2.  Remove it from the list.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/serial/8250_au1x00.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
index 06ae8fb..8d8d7a7 100644
--- a/drivers/serial/8250_au1x00.c
+++ b/drivers/serial/8250_au1x00.c
@@ -56,7 +56,6 @@ static struct plat_serial8250_port au1x0
 #elif defined(CONFIG_SOC_AU1550)
 	PORT(UART0_ADDR, AU1550_UART0_INT),
 	PORT(UART1_ADDR, AU1550_UART1_INT),
-	PORT(UART2_ADDR, AU1550_UART2_INT),
 	PORT(UART3_ADDR, AU1550_UART3_INT),
 #elif defined(CONFIG_SOC_AU1200)
 	PORT(UART0_ADDR, AU1200_UART0_INT),

--YZ5djTAD1cGYuMQK--

