From: Angelo Butti <buttiangelo@alice.it>
Subject: Pericom PCIe Serial board Support (12d8:7952/4/8) - Chip PI7C9X7952/4/8
Date: Wed, 26 Jun 2013 17:25:29 +0200
Message-ID: <CAO5Y4f2pszuzTYewAwzJ91BHeoNeSJsMynscyY7CjFTspeaYzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:36862 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3FZPZa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Jun 2013 11:25:30 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so11365662veb.6
        for <linux-serial@vger.kernel.org>; Wed, 26 Jun 2013 08:25:29 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,
my name is Angelo and I have a problem with some Pericom Serial boards.
This hardware is compatible to 16C550 but is not working good.

Now I can workaround the problem, I understand it but I'm not able to make some
patch for the serial driver inside the linux kernel. So, now I want
try to explain the
problems and if you can adjust the driver also for this device will be
great; or if you can
explain me with some example how I can do it and send to you the patch .....

Anyway, the problem is related to Pericom serial boards, pci-id:
12d8:7952 (2 serials)
12d8:7954 (4 serials)
12d8:7958 (8 serials)

The first problem is related to the kind of the serial ports. This
hardware can be
232-422-4852W-4854W mode, and must be set inside the PCI express
registers at the offset b4h.
For example if you have a 2 serial port 485-2W board, before use it
you must set that
register to 0xFF ( I make this with setpci command and all is ok)

Te second problem, more critical for me, is the bps setting. The board
that I want use have
on board a 14.7456 Mhz, and there are a table inside datasheet with
the configuration example
and the formula to set proper bps settings. The problem is related to
the standard linux driver that use the clock equal to  1.8432 MHz.
So every time that I open the serial, this bps isn't correct. I must
adjust it writing inside the registers (after open) to fix the
problem.
Is possible add this kind of board inside the standard linux driver to
have a good bps setting ?

En example, to set 115200bps:
Standard linux driver: DLL:0x1 DLH:0x0
Pericom formula: DLL:0x8 DLH:0x0

(Ref. PI7C9X7952/4/8 (Datasheet))

Thanks, best regards
Angelo
