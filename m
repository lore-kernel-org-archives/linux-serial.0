From: Ravi Reddy <ravi.reddy@exar.com>
Subject: [PATCH] Serial: Support for Exar 16L580/16L2550/16L2552/16V2550/16V2552
 UARTs
Date: Tue, 07 Mar 2006 11:37:20 -0800
Message-ID: <440DE0F0.8030003@exar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.exar.com ([204.154.183.10]:33872 "EHLO smtp1.exar.com")
	by vger.kernel.org with ESMTP id S932155AbWCGTgJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Mar 2006 14:36:09 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

Hi Russel,

In the last couple of years, Exar Corporation has introduced new UART 
products, with additional features:

16L580 - 16 Byte FIFO with EFR
16L2550/52 - 16 Byte FIFO with EFR (2 channel UARTs)
16V2550/52 - 16 Byte FIFO with EFR - 3.3 volt (2 channel UARTs)

16L580 has Device ID =  0x01
and
both 16L2550/52 and 16V2550/52 has Device IDs = 0x02

Due to existing logic in the serial driver's 8250.c, the above products 
default to 16650V2 UART type (32 byte FIFO UART), causing some potential 
problems. In this regard, please verify this patch, which fixes those 
issues.

--- /usr/src/linux-2.6.13-15/drivers/serial/8250_orig.c    2006-03-07 
10:48:22.000000000 -0800
+++ /usr/src/linux-2.6.13-15/drivers/serial/8250.c    2006-03-07 
11:12:37.000000000 -0800
@@ -191,6 +191,13 @@ static const struct serial8250_config ua
         .fcr        = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
         .flags        = UART_CAP_FIFO,
     },
+    [PORT_16580] = {
+        .name        = "XR16580",
+        .fifo_size    = 16,
+        .tx_loadsz    = 16,
+        .fcr        = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+        .flags        = UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
+    },
     [PORT_CIRRUS] = {
         .name        = "Cirrus",
         .fifo_size    = 1,
@@ -590,9 +597,20 @@ static void autoconfig_has_efr(struct ua
         up->port.type = PORT_16850;
         return;
     }
+   
+    /*
+     * 0x01 - XR16L580
+     * 0x02 - XR16L2550/52 and XR16V2550/52
+     * All the above UARTs have 16 byte FIFO with EFR
+     * and are of UART type PORT_16580
+     */
+    if (id2 == 0x01 || id2 == 0x02) {
+        up->port.type = PORT_16580;
+        return;
+    }
    /*
-     * It wasn't an XR16C850.
+     * It wasn't an XR16C850 or XR16L580 or XR16x2550/52.
      *
      * We distinguish between the '654 and the '650 by counting
      * how many bytes are in the FIFO.  I'm using this for now,

Thanks and regards,
Ravi Reddy...
