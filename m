From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/4] tty, pps: decouple pps
Date: Wed,  6 Feb 2013 10:55:12 -0500
Message-ID: <1360166116-30797-1-git-send-email-peter@hurleysoftware.com>
References: <20130204010303.24971.qmail@science.horizon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130204010303.24971.qmail@science.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Spelvin <linux@horizon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rodolfo Giometti <giometti@enneenne.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The recent breakage of the N_PPS line discipline is due to the tight coupling
pps has created in the tty subsystem. Since the extension of the line discipline
api to accomodate the needs of pps, this level of coupling is unnecessary and
undesirable.

Peter Hurley (4):
  pps: Decouple N_PPS from N_TTY
  pps: Don't crash the machine when exiting will do
  pps: Use lookup list to reduce ldisc coupling
  tty: Remove ancient hardpps()

 drivers/pps/clients/pps-ldisc.c     | 76 ++++++++++++++++++++++++++++++++-----
 drivers/staging/speakup/selection.c |  1 +
 drivers/tty/amiserial.c             |  5 ---
 drivers/tty/n_tty.c                 |  3 +-
 drivers/tty/serial/serial_core.c    | 23 ++++-------
 drivers/tty/tty_buffer.c            |  1 +
 include/linux/serial_core.h         |  1 -
 include/linux/tty_ldisc.h           | 11 ++----
 8 files changed, 83 insertions(+), 38 deletions(-)

-- 
1.8.1.2
