From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH RESEND 1/5] tty/serial: atmel_serial: Fix device tree documentation
Date: Tue, 13 May 2014 20:20:41 +0200
Message-ID: <1400005245-11943-2-git-send-email-richard.genoud@gmail.com>
References: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:53743 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbaEMSVG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 May 2014 14:21:06 -0400
Received: by mail-wi0-f176.google.com with SMTP id n15so6739309wiw.15
        for <linux-serial@vger.kernel.org>; Tue, 13 May 2014 11:21:05 -0700 (PDT)
In-Reply-To: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

RTS pin is an active low pin.
For now, this doesn't change anything as the ACTIVE_LOW flag is not
handled in atmel_serial, but it will be in 3.16.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 17c1042..2f7aad7 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -35,7 +35,7 @@ Example:
 		clock-names = "usart";
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
-		rts-gpios = <&pioD 15 0>;
+		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
 	};
 
 - use DMA:
-- 
1.7.10.4

