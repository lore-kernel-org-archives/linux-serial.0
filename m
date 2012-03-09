From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v2 0/7] serial: cleanups that strive to do nothing
Date: Thu,  8 Mar 2012 19:12:07 -0500
Message-ID: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44795 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab2CIAM1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 19:12:27 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

Hi Greg, Alan.

This is the same as the earlier series[1] with the following
exceptions:

 -fix the naming inconsistency that Alan pointed out[2]

 -reorder the patches to put the above serial_out_sync
  commmit last.

 -update context to allow for the is_real_interrupt removal that
  Alan did in d4e33fac ("serial: Kill off NO_IRQ").

I've retested on an mpc8349 based board, using these commits on
the tty-next baseline of today -- 58112dfbf "tty: moxa: fix bit test
in moxa_start()"

Aside from Alan's one comment (now fixed) there were no other
issues pointed out, so it would be nice to have these applied
to tty-next.

Thanks,
Paul.

[1] http://marc.info/?l=linux-serial&m=133065565930327&w=2
[2] http://marc.info/?l=linux-serial&m=133068650007688&w=2

---

The following changes since commit 58112dfbfe02d803566a2c6c8bd97b5fa3c62cdc:

  tty: moxa: fix bit test in moxa_start() (2012-03-08 12:55:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git serial_8250_cleanup

for you to fetch changes up to 57bf9e9f6fce0d077031a401b435c17733e601b1:

  serial: remove back and forth conversions in serial_out_sync (2012-03-08 18:52:32 -0500)

----------------------------------------------------------------

Paul Gortmaker (7):
  serial: delete last unused traces of pausing I/O in 8250
  serial: make 8250's serial_in shareable to other drivers.
  serial: delete useless void casts in 8250.c
  serial: reduce number of indirections in 8250 code
  serial: introduce generic port in/out helpers
  serial: use serial_port_in/out vs serial_in/out in 8250
  serial: remove back and forth conversions in serial_out_sync

 drivers/tty/serial/8250/8250.c |  724 ++++++++++++++++++++--------------------
 drivers/tty/serial/8250/8250.h |   10 +
 include/linux/serial_core.h    |   10 +
 3 files changed, 381 insertions(+), 363 deletions(-)

-- 
1.7.9.1

