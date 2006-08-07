From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Autodetection fails when re-loading 8250 driver
Date: Mon, 7 Aug 2006 17:11:38 +0200
Message-ID: <200608071711.38826.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from s131.mittwaldmedien.de ([62.216.178.31]:55593 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S932108AbWHGPWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Aug 2006 11:22:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 11E7F5E4173
	for <linux-serial@vger.kernel.org>; Mon,  7 Aug 2006 17:22:30 +0200 (CEST)
Received: from lin01.mn-solutions.de (pD95F8DA4.dip0.t-ipconnect.de [217.95.141.164])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 785685E5A8F
	for <linux-serial@vger.kernel.org>; Mon,  7 Aug 2006 17:21:01 +0200 (CEST)
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 65A0D1E0033
	for <linux-serial@vger.kernel.org>; Mon,  7 Aug 2006 17:11:39 +0200 (CEST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have a board with an QuadUART TI16C754B chip. I set this chip 
up using the usual

struct plat_serial8250_port serial_platform_data[] = ...
struct platform_device serial_device = ...
struct platform_device *devices[] __initdata =
platform_add_devices(devices, ARRAY_SIZE(devices));

way. When I now "insmod 8250.ko", the autoconfiguration tries and 
emits:

ttyS0: autoconf (0x0000, 0xc8858e00): iir=3 EFRv2 
950id=60:60:60:60 850id=0000 type=ST16650V2
serial8250.0: ttyS0 at MMIO 0xc00ee00 (irq = 30) is a ST16650V2

Now I "rmmod 8250" and "insmod 8250.ko" again. Now I get

ttyS0: autoconf (0x0000, 0xc8858e00): IER test failed (10, 1f) 
type=unknown


>From what I found out the bit EFR[4] keeps set when I remove the 
driver. This bit enables Enhanced functions and makes IIR[4] not 
return 0, but the state of the sleep mode. Therefore, I can 
write 0x0F into IIR and get 0x1F back.

A quick hack to get the chip working would be the setting 
UPF_BUGGY_UART bit test, but I actually think that 8250.c is 
buggy, maybe it should read IIR and and the result with 0x0f. 
Because one cannot know the state of EFR[4], one should try to 
disable the bit first with something like this:

--- linux.orig/drivers/serial/8250.c
+++ linux/drivers/serial/8250.c
@@ -902,4 +902,12 @@
        up->bugs = 0;

        if (!(up->port.flags & UPF_BUGGY_UART)) {
+               serial_outp(up, UART_LCR, 0xBF);
+               serial_outp(up, UART_EFR, UART_EFR_ECB);
+               serial_outp(up, UART_LCR, 0);
+               serial_outp(up, UART_IER, 0);
+               serial_outp(up, UART_LCR, 0xBF);
+               serial_outp(up, UART_EFR, 0);
+               serial_outp(up, UART_LCR, 0);
+
                /*


