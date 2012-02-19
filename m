From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/2] Two trivial omap/serial patches
Date: Sun, 19 Feb 2012 13:29:31 +1100
Message-ID: <20120219022841.8254.86264.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34724 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab2BSCaH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Feb 2012 21:30:07 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, "Govindraj . R" <govindraj.raja@ti.com>

Just a couple of small clean-ups following the recent major changes.

Thanks,
NeilBrown

---

NeilBrown (2):
      ARM: OMAP2: remove some orphan function declarations.
      ARM: OMAP2+: UART: remove unused fields in omap_uart_state.


 arch/arm/mach-omap2/pm.h                 |    1 -
 arch/arm/mach-omap2/serial.c             |    4 ----
 arch/arm/plat-omap/include/plat/serial.h |    1 -
 3 files changed, 0 insertions(+), 6 deletions(-)

-- 
Signature

