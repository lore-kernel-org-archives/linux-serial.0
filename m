From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/4] fix serial console suspend on PNP
Date: Wed,  5 Nov 2014 13:40:50 -0500
Message-ID: <1415212854-16944-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:47356 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750994AbaKESlS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 13:41:18 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Hi Greg,

The kernel command line parameter, no_console_suspend, enables the serial
console to continue to output kernel message during system suspend/resume.

However, the PNP bus will disable and power-down pnp devices on system
suspend, which defeats the purpose of no_console_suspend; namely to continue
to output messages in case those are the last messages before crashing.

The first patch is a cleanup of the baroque logic of uart_suspend_port().
The second patch overrides the PNP bus disabling the console device if
no_console_suspend is set. This patch uses existing PNP bus logic but
perhaps in a way not originally intended.
The third patch requires Rafael's ack, as it adds a capability to allow
the device to override the power-down function.
The fourth patch actually performs the power-down override enabled by
patch 3.

With these patches, the PNP0501 device (16550A uart) will continue to
output messages while system suspend finishes, as intended by the
no_console_suspend parameter. [System resume is another problem, which
I'm working on].

Regards,

Peter Hurley (4):
  serial: core: Simplify console suspend logic in uart_suspend_port()
  serial: 8250_pnp: Override pnp disable for no_console_suspend
  PNP: Allow device to override ACPI device sleep
  serial: 8250_pnp: Override pnp suspend for no_console_suspend

 drivers/pnp/driver.c               |  2 +-
 drivers/pnp/pnpacpi/core.c         |  2 +-
 drivers/tty/serial/8250/8250_pnp.c | 61 +++++++++++++++++++++++++++++++-------
 drivers/tty/serial/serial_core.c   | 35 +++++++++++-----------
 include/linux/pnp.h                |  3 ++
 5 files changed, 72 insertions(+), 31 deletions(-)

-- 
2.1.3

