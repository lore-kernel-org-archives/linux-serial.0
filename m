From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH][2/3] serial: fix vr41xx_siu interface select
Date: Sat, 14 Jul 2007 21:24:15 +0900
Message-ID: <20070714212415.4a44aae9.yoichi_yuasa@tripeaks.co.jp>
References: <20070714211904.13d0a53b.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mfo30.po.2iij.NET ([210.128.50.51]:19448 "EHLO
	mfo30.po.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757767AbXGNMfB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2007 08:35:01 -0400
In-Reply-To: <20070714211904.13d0a53b.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: yoichi_yuasa@tripeaks.co.jp, akpm@linux-foundation.org, ralf@linux-mips.org

only PORT_VR41XX_SIU can select interface.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X siu/Documentation/dontdiff siu-orig/drivers/serial/vr41xx_siu.c siu/drivers/serial/vr41xx_siu.c
--- siu-orig/drivers/serial/vr41xx_siu.c	2007-05-29 10:22:07.753690500 +0900
+++ siu/drivers/serial/vr41xx_siu.c	2007-05-29 10:21:47.776442000 +0900
@@ -800,7 +800,8 @@ static int __init siu_console_setup(stru
 		port->membase = ioremap(port->mapbase, siu_port_size(port));
 	}
 
-	vr41xx_select_siu_interface(SIU_INTERFACE_RS232C);
+	if (port->type == PORT_VR41XX_SIU)
+		vr41xx_select_siu_interface(SIU_INTERFACE_RS232C);
 
 	if (options != NULL)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
