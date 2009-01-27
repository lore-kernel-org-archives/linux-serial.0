From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/4] Further small serial/tty fixups
Date: Tue, 27 Jan 2009 11:50:22 +0000
Message-ID: <20090127114820.6236.67019.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37018 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753461AbZA0LuW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jan 2009 06:50:22 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org


Eric Paris (1):
      tty_open can return to userspace holding tty_mutex

Ihar Hrachyshka (1):
      MIPS: enable serial UART support on PNX833X devices.

Michael Bramer (1):
      Add support for '8-port RS-232 MIC-3620 from advantech'

Uwe Kleine-K=C3=B6nig (1):
      Move jsm_remove_one to .devexit.text


 drivers/char/tty_io.c           |    4 +++-
 drivers/serial/8250_pci.c       |    6 ++++++
 drivers/serial/Kconfig          |    2 +-
 drivers/serial/jsm/jsm_driver.c |    2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

--=20
The early bird who catches the worm works for someone who comes in late
and owns the worm farm.
                -- Travis McGee
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
