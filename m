From: Manish RATHI <manish.rathi@st.com>
Subject: autobaud rate support and dce mode
Date: Thu, 16 Sep 2004 09:05:20 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <004001c49b9e$318feb30$fa0ab40a@dlh.st.com>
References: <20040916002304.86342.qmail@web53508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from beta.dmz-eu.st.com ([164.129.1.35]:5584 "EHLO
	beta.dmz-eu.st.com") by vger.kernel.org with ESMTP id S267405AbUIPDf0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Sep 2004 23:35:26 -0400
In-Reply-To: <20040916002304.86342.qmail@web53508.mail.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: 'roger blofeld' <blofeldus@yahoo.com>, rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

does linux kernel have a framework for autobaud rate and 
uart as dce mode.
If yes then pls tell me the interface


Manish

-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org] On Behalf Of roger blofeld
Sent: Thursday, September 16, 2004 5:53 AM
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org
Subject: [PATCH] uart_get_divisor picks better quot


I have a case where uartclk is 33000000 and baud is 115200. The quotient is
about 17.9, but the current code selects 17 as the quot. With 17 I'm getting
corrupted characters transmitted. Using 18 fixes the problem. Perhaps
rounding would be a better choice than truncation. -roger

===== drivers/serial/serial_core.c 1.87 vs edited =====
--- 1.87/drivers/serial/serial_core.c   2004-06-29 09:43:58 -05:00
+++ edited/drivers/serial/serial_core.c 2004-09-15 14:04:34 -05:00
@@ -403,7 +403,7 @@
        if (baud == 38400 && (port->flags & UPF_SPD_MASK) ==
UPF_SPD_CUST)
                quot = port->custom_divisor;
        else
-               quot = port->uartclk / (16 * baud);
+               quot = (port->uartclk + (8 * baud)) / (16 * baud);
 
        return quot;
 }



		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
-
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html

