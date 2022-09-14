Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7FCECAAD8
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 11:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiINLDV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiINLDU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 07:03:20 -0400
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A93FA1D
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663153392; h=from:subject:to:date:message-id;
        bh=gv1tPYdcu8TuEz4nZqAQt3G9favxTEC0KvlTgk8gveE=;
        b=ADY175KjbLfV3G7dB2SvieACAcL+luKK+WafN8t3edC8a7Eah/aquVLyLRB3Q/GOXTd2DxO6IDd
        VFDXFSgTMD/ZjXY3ytSH4pdc3eHemdPaBDCkgaPukcNsnaWWyC8f9TPz6bOBrUIZWPX4k6aOouBiO
        /MzvAILK8o7+7GQFuwx1+dByYEhWHnUZ5NGOCsX32JLFl3VUjGCRUCUm2/+69CGflibDfwRFj9/o9
        j4ABWWkgF8HqCNaH8YfnMxTpLNL7GGdvdFbWtWDFDfj08nqfFR8f1K6lCTjVC+mtqVRpklRjewMju
        on8+UxGx4br349tBqNNcW+W/dbZG7tfjIdfw==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Wed, 14
 Sep 2022 13:03:12 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Wed, 14
 Sep 2022 13:01:03 +0200
Message-ID: <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se>
Date:   Wed, 14 Sep 2022 13:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Pavel Machek <pavel@ucw.cz>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
 <YyB4AtFJx++PeA6S@kroah.com>
 <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
 <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
 <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
 <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se>
 <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc009.uw.lu.se (130.235.59.253) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSUe6XjNA=;oid=AAAAAMCENUM=;bar=wip;cid=AFRb3DDViAQ08ILSDHAc86NA4A==;iss=y;loc=hp;s=VVnjVwZh+9AXid0/xnD3rxCoomBWCWf6//QiHdRlmluqgQCS7/LNdQxdkzbD8ZLm4r5KyiDmddc6hcmmwqblDw==
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022-09-14 02:00, Maciej W. Rozycki wrote:
> On Tue, 13 Sep 2022, Anders Blomdell wrote:
> 
>> Seems like CPR/CPR2 does not affect baudrate, so maybe EFR bit 4 (enhance
>> mode) is not set?
> 
>   Thanks for assessing the problem.  I've thought already it could be
> misconfiguration.
> 
>> If CPR is stuck at 8 (1.0 scaling), it all makes sense, these corresponds to
>> what the oscilloscope gives:
>>
>> 2400 ->  tcr: 9, cpr: 18, quot: 1286
>>           62500000/9/(8*.125)/1286 -> 5400
>> 4800 -> tcr: 7, cpr: 23, quot: 647
>> 	2500000/7/(8*.125)/647 -> 13799
>> 9600 -> tcr: 9, cpr: 9, quot: 643
>>          62500000/9/(8*.125)/643 -> 10800.
>> 19200 -> tcr: 8, cpr: 31, quot: 105
>>          62500000/7/(8*.125)/105 -> 85034
>> 38400 -> 62500000/14/(8*.125)/30 -> 148809
> 
>   Agreed.
> 
>   As the first debug aid could you please enable DEBUG_AUTOCONF at the top
> of drivers/tty/serial/8250/8250_port.c and paste the relevant piece of
> 8250 initialisation recorded in the kernel log?  This will confirm (or
> contradict) correct operation of the port configuration sequence.

Modifications done:

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index c89cb881d9b0..f25e824d626e 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -115,11 +115,17 @@ struct serial8250_config {
  
  static inline int serial_in(struct uart_8250_port *up, int offset)
  {
-	return up->port.serial_in(&up->port, offset);
+       int result;
+	result =  up->port.serial_in(&up->port, offset);
+       printk(KERN_INFO "serial_in(%px, 0x%02x) -> 0x%02x\n",
+              up, offset, result);
+       return result;
  }
  
  static inline void serial_out(struct uart_8250_port *up, int offset, int value)
  {
+       printk(KERN_INFO "serial_out(%px, 0x%02x, 0x%02x)\n",
+              up, offset, value);
  	up->port.serial_out(&up->port, offset, value);
  }
  
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2b86c55ed374..b5c1b1faff34 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -44,7 +44,7 @@
  /*
   * Debugging.
   */
-#if 0
+#if 1
  #define DEBUG_AUTOCONF(fmt...)	printk(fmt)
  #else
  #define DEBUG_AUTOCONF(fmt...)	do { } while (0)


Captured data:


[    3.830006] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.830141] ttyS0: autoconf (0x03f8, 0x0000000000000000):
[    3.830146] serial_in(ffffffffb6b97520, 0x01) -> 0xff
[    3.830271] serial_out(ffffffffb6b97520, 0x01, 0x00)
[    3.830338] serial_in(ffffffffb6b97520, 0x01) -> 0xff
[    3.830400] serial_out(ffffffffb6b97520, 0x01, 0x0f)
[    3.830468] serial_in(ffffffffb6b97520, 0x01) -> 0xff
[    3.830530] serial_out(ffffffffb6b97520, 0x01, 0xff)
[    3.830594] IER test failed (0f, 0f)
[    3.830595] iir=255
[    3.830656] type=unknown
[    3.830888] ttyS1: autoconf (0x02f8, 0x0000000000000000):
[    3.830892] serial_in(ffffffffb6b97800, 0x01) -> 0xff
[    3.831016] serial_out(ffffffffb6b97800, 0x01, 0x00)
[    3.831080] serial_in(ffffffffb6b97800, 0x01) -> 0xff
[    3.831141] serial_out(ffffffffb6b97800, 0x01, 0x0f)
[    3.831208] serial_in(ffffffffb6b97800, 0x01) -> 0xff
[    3.831269] serial_out(ffffffffb6b97800, 0x01, 0xff)
[    3.831332] IER test failed (0f, 0f)
[    3.831333] iir=255
[    3.831393] type=unknown
[    3.831595] ttyS2: autoconf (0x03e8, 0x0000000000000000):
[    3.831598] serial_in(ffffffffb6b97ae0, 0x01) -> 0xff
[    3.831720] serial_out(ffffffffb6b97ae0, 0x01, 0x00)
[    3.831783] serial_in(ffffffffb6b97ae0, 0x01) -> 0xff
[    3.831844] serial_out(ffffffffb6b97ae0, 0x01, 0x0f)
[    3.831907] serial_in(ffffffffb6b97ae0, 0x01) -> 0xff
[    3.831969] serial_out(ffffffffb6b97ae0, 0x01, 0xff)
[    3.832040] IER test failed (0f, 0f)
[    3.832041] iir=255
[    3.832101] type=unknown
[    3.832305] ttyS3: autoconf (0x02e8, 0x0000000000000000):
[    3.832309] serial_in(ffffffffb6b97dc0, 0x01) -> 0xff
[    3.832431] serial_out(ffffffffb6b97dc0, 0x01, 0x00)
[    3.832497] serial_in(ffffffffb6b97dc0, 0x01) -> 0xff
[    3.832562] serial_out(ffffffffb6b97dc0, 0x01, 0x0f)
[    3.832627] serial_in(ffffffffb6b97dc0, 0x01) -> 0xff
[    3.832688] serial_out(ffffffffb6b97dc0, 0x01, 0xff)
[    3.832760] IER test failed (0f, 0f)
[    3.832761] iir=255
[    3.832820] type=unknown
[    3.835202] ttyS4: autoconf (0x0000, 0x(____ptrval____)):
[    3.835207] serial_in(ffffffffb6b980a0, 0x01) -> 0x00
[    3.836170] serial_out(ffffffffb6b980a0, 0x01, 0x00)
[    3.836170] serial_in(ffffffffb6b980a0, 0x01) -> 0x00
[    3.836170] serial_out(ffffffffb6b980a0, 0x01, 0x0f)
[    3.836170] serial_in(ffffffffb6b980a0, 0x01) -> 0x0f
[    3.836170] serial_out(ffffffffb6b980a0, 0x01, 0x00)
[    3.836170] serial_in(ffffffffb6b980a0, 0x04) -> 0x00
[    3.836170] serial_in(ffffffffb6b980a0, 0x03) -> 0x00
[    3.836170] serial_out(ffffffffb6b980a0, 0x03, 0xbf)
[    3.836170] serial_out(ffffffffb6b980a0, 0x02, 0x00)
[    3.836170] serial_out(ffffffffb6b980a0, 0x03, 0x00)
[    3.836170] serial_out(ffffffffb6b980a0, 0x02, 0x01)
[    3.836170] serial_in(ffffffffb6b980a0, 0x02) -> 0xc1
[    3.836170] serial_out(ffffffffb6b980a0, 0x03, 0x00)
[    3.836170] serial_out(ffffffffb6b980a0, 0x04, 0x00)
[    3.836170] serial_out(ffffffffb6b980a0, 0x02, 0x01)
[    3.836170] serial_out(ffffffffb6b980a0, 0x02, 0x07)
[    3.836170] serial_out(ffffffffb6b980a0, 0x02, 0x00)
[    3.836170] serial_in(ffffffffb6b980a0, 0x00) -> 0x78
[    3.836170] serial_out(ffffffffb6b980a0, 0x01, 0x00)
[    3.837488] iir=193
[    3.837490] type=16550A
[    3.837606] 0000:07:00.0: ttyS4 at MMIO 0xe3601000 (irq = 17, base_baud = 15625000) is a 16550A
[    3.837685] serial_out(ffffffffb6b980a0, 0x04, 0x80)
[    3.837914] ttyS5: autoconf (0x0000, 0x(____ptrval____)):
[    3.837918] serial_in(ffffffffb6b98380, 0x01) -> 0x00
[    3.838041] serial_out(ffffffffb6b98380, 0x01, 0x00)
[    3.838104] serial_in(ffffffffb6b98380, 0x01) -> 0x00
[    3.838165] serial_out(ffffffffb6b98380, 0x01, 0x0f)
[    3.838229] serial_in(ffffffffb6b98380, 0x01) -> 0x0f
[    3.838290] serial_out(ffffffffb6b98380, 0x01, 0x00)
[    3.838353] serial_in(ffffffffb6b98380, 0x04) -> 0x00
[    3.838417] serial_in(ffffffffb6b98380, 0x03) -> 0x00
[    3.838479] serial_out(ffffffffb6b98380, 0x03, 0xbf)
[    3.838541] serial_out(ffffffffb6b98380, 0x02, 0x00)
[    3.838602] serial_out(ffffffffb6b98380, 0x03, 0x00)
[    3.838667] serial_out(ffffffffb6b98380, 0x02, 0x01)
[    3.838731] serial_in(ffffffffb6b98380, 0x02) -> 0xc1
[    3.838791] serial_out(ffffffffb6b98380, 0x03, 0x00)
[    3.838853] serial_out(ffffffffb6b98380, 0x04, 0x00)
[    3.838891] serial_out(ffffffffb6b98380, 0x02, 0x01)
[    3.838891] serial_out(ffffffffb6b98380, 0x02, 0x07)
[    3.838891] serial_out(ffffffffb6b98380, 0x02, 0x00)
[    3.838891] serial_in(ffffffffb6b98380, 0x00) -> 0x1d
[    3.838891] serial_out(ffffffffb6b98380, 0x01, 0x00)
[    3.839232] iir=193
[    3.839233] type=16550A
[    3.839347] 0000:07:00.0: ttyS5 at MMIO 0xe3601200 (irq = 17, base_baud = 15625000) is a 16550A
[    3.839424] serial_out(ffffffffb6b98380, 0x04, 0x80)

Running this small test program:

#!/usr/bin/python3

import serial

p2 = serial.Serial('/dev/ttyS4', 19200)
p2.write(b'\x55')

Gives:

[  132.325041] serial_out(ffffffffb6b980a0, 0x02, 0x01)
[  132.325055] serial_out(ffffffffb6b980a0, 0x02, 0x07)
[  132.325060] serial_out(ffffffffb6b980a0, 0x02, 0x00)
[  132.325077] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.325105] serial_out(ffffffffb6b980a0, 0x04, 0x88)
[  132.325119] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.325134] serial_in(ffffffffb6b980a0, 0x06) -> 0xb0
[  132.325140] serial_out(ffffffffb6b980a0, 0x07, 0x02)
[  132.325144] serial_out(ffffffffb6b980a0, 0x05, 0x09)
[  132.325148] serial_out(ffffffffb6b980a0, 0x07, 0x01)
[  132.325151] serial_out(ffffffffb6b980a0, 0x05, 0x09)
[  132.325155] serial_out(ffffffffb6b980a0, 0x07, 0x03)
[  132.325158] serial_out(ffffffffb6b980a0, 0x05, 0x00)
[  132.325162] serial_out(ffffffffb6b980a0, 0x00, 0x83)
[  132.325165] serial_out(ffffffffb6b980a0, 0x01, 0x02)
[  132.325169] serial_out(ffffffffb6b980a0, 0x04, 0x88)
[  132.325175] serial_out(ffffffffb6b980a0, 0x04, 0x8b)
[  132.325245] serial_out(ffffffffb6b980a0, 0x07, 0x02)
[  132.325251] serial_out(ffffffffb6b980a0, 0x05, 0x08)
[  132.325254] serial_out(ffffffffb6b980a0, 0x07, 0x01)
[  132.325257] serial_out(ffffffffb6b980a0, 0x05, 0x1f)
[  132.325261] serial_out(ffffffffb6b980a0, 0x07, 0x03)
[  132.325264] serial_out(ffffffffb6b980a0, 0x05, 0x00)
[  132.325267] serial_out(ffffffffb6b980a0, 0x00, 0x69)
[  132.325271] serial_out(ffffffffb6b980a0, 0x01, 0x00)
[  132.325274] serial_out(ffffffffb6b980a0, 0x04, 0x8b)
[  132.325377] serial_out(ffffffffb6b980a0, 0x01, 0x07)
[  132.325385] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.325389] serial_out(ffffffffb6b980a0, 0x00, 0x55)
[  132.325393] serial_out(ffffffffb6b980a0, 0x01, 0x05)
[  132.325623] serial_in(ffffffffb6b980a0, 0x05) -> 0xe9
[  132.325633] serial_in(ffffffffb6b980a0, 0x00) -> 0x78
[  132.325640] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.325647] serial_in(ffffffffb6b980a0, 0x06) -> 0xb0
[  132.325758] serial_in(ffffffffb6b980a0, 0x05) -> 0xe9
[  132.325768] serial_in(ffffffffb6b980a0, 0x00) -> 0x1e
[  132.325773] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.325780] serial_in(ffffffffb6b980a0, 0x06) -> 0xb0
[  132.325935] serial_in(ffffffffb6b980a0, 0x05) -> 0xe9
[  132.325943] serial_in(ffffffffb6b980a0, 0x00) -> 0x78
[  132.325948] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.325955] serial_in(ffffffffb6b980a0, 0x06) -> 0xb0
[  132.326602] serial_in(ffffffffb6b980a0, 0x05) -> 0x61
[  132.326610] serial_in(ffffffffb6b980a0, 0x00) -> 0xfe
[  132.326615] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.326622] serial_in(ffffffffb6b980a0, 0x06) -> 0xb0
[  132.473966] serial_in(ffffffffb6b980a0, 0x05) -> 0x60
[  132.473978] serial_out(ffffffffb6b980a0, 0x04, 0x88)
[  132.473990] serial_out(ffffffffb6b980a0, 0x04, 0x80)
[  132.473996] serial_out(ffffffffb6b980a0, 0x02, 0x01)
[  132.474000] serial_out(ffffffffb6b980a0, 0x02, 0x07)
[  132.474004] serial_out(ffffffffb6b980a0, 0x02, 0x00)





  
>   Also I have identified a code piece that handles the EFR in a destructive
> manner, which I must have previously missed, namely a conditional block
> guarded by UART_CAP_EFR in `serial8250_do_set_termios'.  It should likely
> be fixed, however it is supposed not to matter for OxSemi chips due to:
> 
> 		/* UART_CAP_EFR breaks billionon CF bluetooth card. */
> 		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
> 
> which then leads to:
> 
> serial 0000:07:00.3: detected caps 00000700 should be 00000500
> 
> and consequently UART_CAP_EFR gets cleared and this code block isn't
> supposed to be reached.  Can you confirm the presence of a similar message
> in your log?
Can not see any such message in my dmsg

>   NB it seems to me too big a hammer to have a generic serial port feature
> globally disabled to work around an unidentified problem with an attached
> particular serial device.  Pavel, as the originator of commit d0694e2aeb81
> ("serial: unbreak billionton CF card") can you please explain what the
> motivation was here?
> 
>   I could only track down two message threads related to the problem:
> 
> <https://lore.kernel.org/lkml/20110106134254.68fa27ac@lxorguk.ukuu.org.uk/>
> 
> and:
> 
> <https://lore.kernel.org/linux-serial/4D001AF1.80902@mainpine.com/>
> 
> but no attempt to actually narrow the issue down (also ISTM like a feature
> such as flow control ought to be controlled via a termios call rather than
> globally disabled).  Also could the corruption of the EFR in what is now
> `serial8250_do_set_termios' (and used to be `serial8250_set_termios' then)
> mentioned above be the culprit?
> 

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
