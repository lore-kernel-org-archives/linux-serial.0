From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: Serial: sc26xx device name
Date: Sat, 21 Nov 2009 14:51:36 +0100
Message-ID: <4B07F068.1090801@gmail.com>
Reply-To: mfuzzey@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:36402 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410AbZKUNvk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Nov 2009 08:51:40 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de
Cc: linux-kernel@vger.kernel.org

Hi all,
I noticed the sc26xx driver uses ttySC205 / ttySC206 for device name.

grep ttySC Documentation/devices.txt gives
          8 = /dev/ttySC0        SCI serial port (SuperH) - port 0
          9 = /dev/ttySC1        SCI serial port (SuperH) - port 1
         10 = /dev/ttySC2        SCI serial port (SuperH) - port 2
         11 = /dev/ttySC3        SCI serial port (SuperH) - port 3
         205 = /dev/ttySC0        SC26xx serial port 0
         206 = /dev/ttySC1        SC26xx serial port 1
         207 = /dev/ttySC2        SC26xx serial port 2
         208 = /dev/ttySC3        SC26xx serial port 3
          8 = /dev/cusc0        Callout device for ttySC0
          9 = /dev/cusc1        Callout device for ttySC1
         10 = /dev/cusc2        Callout device for ttySC2
         11 = /dev/cusc3        Callout device for ttySC3

Removing the line:
    sc26xx_reg.tty_driver->name_base = sc26xx_reg.minor;
makes it revert to ttySC0

So two questions:
1) Who is right (the driver or devices.txt)?
2) How are device name conflicts handled?

Cheers,

Martin

