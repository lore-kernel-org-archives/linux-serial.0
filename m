From: roger blofeld <blofeldus@yahoo.com>
Subject: [PATCH] uart_get_divisor picks better quot
Date: Wed, 15 Sep 2004 17:23:04 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040916002304.86342.qmail@web53508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web53508.mail.yahoo.com ([206.190.37.69]:21902 "HELO
	web53508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267507AbUIPAXH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Sep 2004 20:23:07 -0400
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

I have a case where uartclk is 33000000 and baud is 115200. The
quotient is about 17.9, but the current code selects 17 as the quot.
With 17 I'm getting corrupted characters transmitted. Using 18 fixes
the problem. Perhaps rounding would be a better choice than truncation.
-roger

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
