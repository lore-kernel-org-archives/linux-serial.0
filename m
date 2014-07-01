From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/3] s/FOOTBRIDGE/ARCH_FOOTBRIDGE/
Date: Tue,  1 Jul 2014 22:37:03 +0200
Message-ID: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39451 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaGAUiM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Jul 2014 16:38:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hello Russell,

I'm not sure that FOOTBRIDGE and ARCH_FOOTBRIDGE are semantically
identical; if not, feel free to nack this series.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (3):
  serial: DC21285: depend on ARCH_FOOTBRIDGE instead of FOOTBRIDGE
  watchdog: get rid of FOOTBRIDGE in dependencies
  ARM: drop Kconfig symbol FOOTBRIDGE

 arch/arm/Kconfig                 |  1 -
 arch/arm/Kconfig.debug           | 14 +++++++-------
 arch/arm/mach-footbridge/Kconfig |  4 ----
 drivers/tty/serial/Kconfig       |  2 +-
 drivers/watchdog/Kconfig         |  4 ++--
 5 files changed, 10 insertions(+), 15 deletions(-)

--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
