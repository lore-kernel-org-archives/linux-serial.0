From: George Spelvin <linux@horizon.com>
Subject: [PATCH 0/7] 3.8-rc regression with pps-ldisc due to 70ece7a731
Date: Fri, 8 Feb 2013 02:05:40 -0500
Message-ID: <cover.1360307140.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36256 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946082Ab3BHJQg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 04:16:36 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, giometti@linux.it

The standard N_TTY line discipline used to not use the tty->disc_data
field, so N_PPS felt free to use it.  That has now changed, requiring
that N_PPS use a different method to find its private data.

(In the current, buggy, state, N_PPS follows a wild pointer and explodes
in an interrupt hander as soon as a pulse actually arrives.)

Strictly speaking, only patches 5 and 6 are the bugfix proper; the
rest are various cleanups enabled by the looser coupling of the
line disciplines.

George Spelvin (4):
  pps: Additional cleanups in uart_handle_dcd_change
  pps: Add pps_lookup_dev() function
  pps: Use pps_lookup_dev to reduce ldisc coupling
  tty/tty_ldisc.c: use test_and_clear_bit in tty_ldisc_close

Peter Hurley (3):
  pps: Decouple N_PPS from N_TTY
  pps: Don't crash the machine when exiting will do
  tty: Remove ancient hardpps()

 drivers/pps/clients/pps-ldisc.c     | 33 +++++++++++++++++++++++----------
 drivers/pps/pps.c                   | 35 +++++++++++++++++++++++++++++++++++
 drivers/staging/speakup/selection.c |  1 +
 drivers/tty/amiserial.c             |  5 -----
 drivers/tty/n_tty.c                 |  3 ++-
 drivers/tty/serial/serial_core.c    | 24 +++++++-----------------
 drivers/tty/tty_buffer.c            |  1 +
 drivers/tty/tty_ldisc.c             |  3 +--
 include/linux/pps_kernel.h          | 17 ++++++++++++++---
 include/linux/serial_core.h         |  1 -
 include/linux/tty_ldisc.h           | 11 ++++-------
 11 files changed, 88 insertions(+), 46 deletions(-)

-- 
1.8.1.2

