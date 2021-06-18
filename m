Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1852C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985C361209
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFRGTk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhFRGSa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5C9621B7B;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8GxyXPxzMGx7zlg6fd+xLgPxH3RcZPHEn9DJ8iIKxw=;
        b=b12GCBR3N1j2jj+Qq8hiqTTtFyHrUlygEjmlsDkkSDN4tke0IIr5QfIUFZ1bw5XIntjQc0
        5IqZedYEaawzc1IixreTSQWn1TAUQOTTFV5zNwfjlJ6/QKHVINzuCX5QwdSPgEoJHvdJyK
        k8ne9ByxY1XAjEX231o1ksSzrGhiDUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8GxyXPxzMGx7zlg6fd+xLgPxH3RcZPHEn9DJ8iIKxw=;
        b=/3In8MpJbJp0pDddJ9mkImnNBBAtTZBdjGuoH4y7fLSJmW5DnYHZsSKkNNjnfRWd5qH1Uj
        RDJDpYKqaUIjmABg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B5F49A3BCD;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 69/70] mxser: Documentation, fix typos
Date:   Fri, 18 Jun 2021 08:15:15 +0200
Message-Id: <20210618061516.662-70-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix some typos in the mxser's documentation.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 .../driver-api/serial/moxa-smartio.rst        | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/serial/moxa-smartio.rst b/Documentation/driver-api/serial/moxa-smartio.rst
index 838888f81b6d..af25bc5cc3e6 100644
--- a/Documentation/driver-api/serial/moxa-smartio.rst
+++ b/Documentation/driver-api/serial/moxa-smartio.rst
@@ -20,7 +20,7 @@ Copyright (C) 2021, Jiri Slaby
 ^^^^^^^^^^^^^^^
 
    The Smartio/Industio/UPCI family Linux driver supports following multiport
-   boards.
+   boards:
 
     - 2 ports multiport board
 	CP-102U, CP-102UL, CP-102UF
@@ -63,10 +63,10 @@ Copyright (C) 2021, Jiri Slaby
    GNU General Public License in this version. Please refer to GNU General
    Public License announcement in each source code file for more detail.
 
-   In Moxa's Web sites, you may always find latest driver at
+   In Moxa's Web sites, you may always find the latest driver at
    https://www.moxa.com/.
 
-   This version of driver can be installed as Loadable Module (Module driver)
+   This version of driver can be installed as a Loadable Module (Module driver)
    or built-in into kernel (Static driver). Before you install the driver,
    please refer to hardware installation procedure in the User's Manual.
 
@@ -89,9 +89,9 @@ Copyright (C) 2021, Jiri Slaby
 PCI/UPCI board
 --------------
 
-   You may need to adjust IRQ usage in BIOS to avoid from IRQ conflict
-   with other ISA devices. Please refer to hardware installation
-   procedure in User's Manual in advance.
+   You may need to adjust IRQ usage in BIOS to avoid IRQ conflict with other
+   ISA devices. Please refer to hardware installation procedure in User's
+   Manual in advance.
 
 PCI IRQ Sharing
 ---------------
@@ -132,7 +132,7 @@ msdiag - Diagnostic
 ===================
 
    This utility provides the function to display what Moxa Smartio/Industio
-   board found by driver in the system.
+   board was found by the driver in the system.
 
 msmon - Port Monitoring
 =======================
@@ -162,23 +162,23 @@ msterm - Terminal Emulation
 
    Supported Setserial parameters are listed as below.
 
-   ============== =========================================================
-   uart		  set UART type(16450-->disable FIFO, 16550A-->enable FIFO)
-   close_delay	  set the amount of time(in 1/100 of a second) that DTR
+   ============== =============================================================
+   uart		  set UART type(16450 --> disable FIFO, 16550A --> enable FIFO)
+   close_delay	  set the amount of time (in 1/100 of a second) that DTR
 		  should be kept low while being closed.
-   closing_wait   set the amount of time(in 1/100 of a second) that the
+   closing_wait   set the amount of time (in 1/100 of a second) that the
 		  serial port should wait for data to be drained while
-		  being closed, before the receiver is disable.
-   spd_hi	  Use  57.6kb  when  the application requests 38.4kb.
-   spd_vhi	  Use  115.2kb	when  the application requests 38.4kb.
-   spd_shi	  Use  230.4kb	when  the application requests 38.4kb.
-   spd_warp	  Use  460.8kb	when  the application requests 38.4kb.
-   spd_normal	  Use  38.4kb  when  the application requests 38.4kb.
-   spd_cust	  Use  the custom divisor to set the speed when  the
+		  being closed, before the receiver is disabled.
+   spd_hi	  Use 57.6kb when the application requests 38.4kb.
+   spd_vhi	  Use 115.2kb when the application requests 38.4kb.
+   spd_shi	  Use 230.4kb when the application requests 38.4kb.
+   spd_warp	  Use 460.8kb when the application requests 38.4kb.
+   spd_normal	  Use 38.4kb when the application requests 38.4kb.
+   spd_cust	  Use the custom divisor to set the speed when the
 		  application requests 38.4kb.
-   divisor	  This option set the custom division.
-   baud_base	  This option set the base baud rate.
-   ============== =========================================================
+   divisor	  This option sets the custom division.
+   baud_base	  This option sets the base baud rate.
+   ============== =============================================================
 
 6. Troubleshooting
 ^^^^^^^^^^^^^^^^^^
-- 
2.32.0

