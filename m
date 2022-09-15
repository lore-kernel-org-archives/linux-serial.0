Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D7BECAAD3
	for <linux-serial@archiver.kernel.org>; Thu, 15 Sep 2022 10:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIOKKY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Sep 2022 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIOKKV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Sep 2022 06:10:21 -0400
Received: from wedge009.net.lu.se (wedge009.net.lu.se [130.235.56.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC42F38A
        for <linux-serial@vger.kernel.org>; Thu, 15 Sep 2022 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663236614; h=from:subject:to:date:message-id;
        bh=xPNF5FNZj0az+m7+jxLpJPPRE8O4T0wxV/25VkLLl8g=;
        b=c6lytPrMZIDpcibkx8QNejAxJWBQR3yFwMH4HQ/+TUtaJ6vhJtofPf3CU8jqq39iWbk3M47xlmU
        GgsM48LuZHkQOm4NnOUrbDEtGuDzIIKnyrfBCxwpKJl7ClF0SXuGfhf/21CmzyNv4NPGEdpwi3Luc
        0X6iFjR8k1mAxR5olhkhvgBtY9n+bJqbW/I26byV+Wum2WXfaR97C8Nl82bm77Ri/ERLWWG5n5+bc
        Mbl1KgRo6sxR50JRmMpfsLdDaBTYKqhc0Qj6JR//excW95XEARbohtLGwdviie2nu6VcV7XiQAwu5
        P8ltrikorv/3zEQ5+kw4T+pLCvriLyHA7AZA==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Thu, 15
 Sep 2022 12:10:14 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Thu, 15
 Sep 2022 12:09:23 +0200
Message-ID: <12a346f8-afc9-e832-1b91-80e458819df8@control.lth.se>
Date:   Thu, 15 Sep 2022 12:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Pavel Machek <pavel@ucw.cz>, <linux-serial@vger.kernel.org>
References: <YyB4AtFJx++PeA6S@kroah.com>
 <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
 <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
 <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
 <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se>
 <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk>
 <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se>
 <alpine.DEB.2.21.2209141224370.60554@angie.orcam.me.uk>
 <alpine.DEB.2.21.2209141456460.60554@angie.orcam.me.uk>
 <YyHr6wD8F8KxyK5m@kroah.com>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <YyHr6wD8F8KxyK5m@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc010.uw.lu.se (130.235.59.254) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSPWU3GxY=;oid=AAAAAJ/vdc8=;bar=wip;cid=CkEH+aCenQTtoKmWBCSG6rGzcA==;iss=n;s=tsziNTIflPr9wgHrNK7wHYw+MDCoprCdYRKHaGoqBkc9gbPdxRl35UQCkH96TMCQi4DWSnxGDUGNGND1rf6SAA==
Received-SPF: Pass (wedge009.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge009.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge009.net.lu.se
X-OrganizationHeadersPreserved: wedge009.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022-09-14 16:57, Greg Kroah-Hartman wrote:
> On Wed, Sep 14, 2022 at 03:15:52PM +0100, Maciej W. Rozycki wrote:
>> On Wed, 14 Sep 2022, Maciej W. Rozycki wrote:
>>
>>> I'll examine your I/O conversation log in detail and will see if I can
>>> come up with a possible explanation.
>>
>>   I think I know what is going on here.  Can you please confirm that you
>> have the CONFIG_SERIAL_8250_16550A_VARIANTS option disabled (default to
>> "off" for x86 only)?  That would explain things.
>>
>>   Offhand I am not sure what to do here.  There are several options to
>> choose from I can think of right now:
>>
>> 1. Disable new OxSemi Tornado clock code iff !SERIAL_8250_16550A_VARIANTS,
>>     bringing back buggy calculation for rates above 115200bps and coarse
>>     BOTHER granularity.
>>
>> 2. Same as above, but additionally limit the baud rates to 115200bps to
>>     avoid buggy rates.
> 
> Maybe this one?  That feels odd that we do different things for this old
> config option, that's not good.  So making this "just work" should be
> the best idea if at all possible.
> 
>>
>> 3. Force SERIAL_8250_16550A_VARIANTS to "y" if SERIAL_8250_PCI != "n".
>>
>> 4. Remove SERIAL_8250_16550A_VARIANTS altogether and execute code it
>>     guards unconditionally (does it still matter nowadays?).
>>
>> 5. Something else not yet determined.
We could force an EFR probe for this specific driver only.

Pros: driver behaves the same regardless of CONFIG_SERIAL_8250_16550A_VARIANTS
       other chips/drivers will not get probed
Cons: autoconfig code will be somewhat bigger since code after the test will be reachable
       change in unrelated part (8250_core.c) to propagate .probe flags

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 82726cda6066..b9f28f95cfd5 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1011,6 +1011,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
  		uart->rs485_start_tx	= up->rs485_start_tx;
  		uart->rs485_stop_tx	= up->rs485_stop_tx;
  		uart->dma		= up->dma;
+		uart->probe		= up->probe;
  
  		/* Take tx_loadsz from fifosize if it wasn't set separately */
  		if (uart->port.fifosize && !uart->tx_loadsz)
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index f6732c1ed238..b0b21e49ec6c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1242,6 +1242,7 @@ static int pci_oxsemi_tornado_setup(struct serial_private *priv,
  		up->port.get_divisor = pci_oxsemi_tornado_get_divisor;
  		up->port.set_divisor = pci_oxsemi_tornado_set_divisor;
  		up->port.set_mctrl = pci_oxsemi_tornado_set_mctrl;
+		up->probe |= UART_PROBE_EFR;
  	}
  
  	return pci_default_setup(priv, board, up, idx);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2b86c55ed374..b207d9982936 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1029,9 +1029,9 @@ static void autoconfig_16550a(struct uart_8250_port *up)
  	up->port.type = PORT_16550A;
  	up->capabilities |= UART_CAP_FIFO;
  
-	if (!IS_ENABLED(CONFIG_SERIAL_8250_16550A_VARIANTS))
+	if (!IS_ENABLED(CONFIG_SERIAL_8250_16550A_VARIANTS) &&
+	    !(up->probe & UART_PROBE_EFR))
  		return;
-
  	/*
  	 * Check for presence of the EFR when DLAB is set.
  	 * Only ST16C650V1 UARTs pass this test.
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ff84a3ed10ea..0855316468e2 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -112,6 +112,7 @@ struct uart_8250_port {
  	unsigned char		probe;
  	struct mctrl_gpios	*gpios;
  #define UART_PROBE_RSA	(1 << 0)
+#define UART_PROBE_EFR	(1 << 1)
  
  	/*
  	 * Some bits in registers are cleared on a read, so they must

> 
> We can't just remove it, as for x86 the default is disabled due to this
> only being relevant for very old hardware.
> 
> thanks,
> 
> greg k-h

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
