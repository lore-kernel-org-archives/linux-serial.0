From: Arnout Vandecappelle <arnout@mind.be>
Subject: Re: Driver for SPI-based 8250 serial port
Date: Wed, 05 Sep 2012 18:29:33 +0200
Message-ID: <50477DED.602@mind.be>
References: <504749CF.50709@mind.be> <20120905141218.7556f902@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:53249
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab2IEQ3g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 12:29:36 -0400
In-Reply-To: <20120905141218.7556f902@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On 09/05/12 15:12, Alan Cox wrote:
>> >  - Should I add a UPIO_SPI to the global I/O types, or should I override the
>> >  serial_in/serial_out functions in struct plat_serial8250_port?
> I am not sure you'll make the 8250 driver handle the device because I
> suspect a lot of the serial_in/serial_out calls occur with interrupts
> disabled on the assumption that they are basically atomic fast operations.

  Argh, that's right.

  So it will be a completely new driver then.  Using the tty layer directly seems
to be a good suggestion: it looks like the uart layer (like the 8250 driver) is
carrying a lot of cruft for supporting all those quirks in the different devices.

  ifx6x60 looks like a good source of inspiration.


  Regards,
  Arnout
-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F
