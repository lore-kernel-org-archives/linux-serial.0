From: Arnout Vandecappelle <arnout@mind.be>
Subject: Driver for SPI-based 8250 serial port
Date: Wed, 05 Sep 2012 14:47:11 +0200
Message-ID: <504749CF.50709@mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:56612
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab2IEMrS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 08:47:18 -0400
Received: from [172.16.2.6]
	by viper.mind.be with esmtp (Exim 4.69)
	(envelope-from <arnout@mind.be>)
	id 1T9F0i-0006hE-Si
	for linux-serial@vger.kernel.org; Wed, 05 Sep 2012 14:47:16 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

[Please CC me, I'm not on the list]

  Hi,

  I need a driver for the Exar's XR20M1280 SPI-based serial port.  It's a
16C950 compatible serial port, it just performs the register accesses over
an SPI (or I2C) bus rather than memory-mapped.

  As far as I can determine, no driver for such a device exists yet.  So I'll
develop one.

  A few questions before I start:

- I guess I should preferably write it as generically as possible, even though
I can test it on only one device?

- Should I add a UPIO_SPI to the global I/O types, or should I override the
serial_in/serial_out functions in struct plat_serial8250_port?

- I guess there should be a 8250_spi file that registers the platform
device?

- I guess it doesn't make sense to try autoconfig_irq for such a device?
The IRQ is typically a gpio which the platform code has to configure as an IRQ.

- I'm not sure how to set the uartclk. The XR20M1280's BRG is derived from a
24MHz clock, but other devices or other boards may have different values.
Should it be part of platform data?  Should I define a new platform data struct
for that?

  Any other suggestions are also welcome.

  Regards,
  Arnout

-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F
