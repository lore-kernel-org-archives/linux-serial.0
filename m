From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/4] serial: move towards tty_port
Date: Wed, 19 May 2010 13:13:47 +0100
Message-ID: <20100519121234.18011.51870.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36514 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752775Ab0ESM4Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:56:16 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

We really want to be using tty_port here so that we can dump all the nasty
horrible complicated locking and POSIX tty behaviour into one place for all
users. This gets us to the point of the block_til_ready helper doing much of
the work.

---

Alan Cox (4):
      serial: Use block_til_ready helper
      serial: trim locking on the helpers
      serial: add port helpers
      serial: Change the wait for carrier locking


 drivers/serial/serial_core.c |  131 +++++++++++++++---------------------------
 1 files changed, 46 insertions(+), 85 deletions(-)

-- 
Zendemonium


