From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 0/4] Blackfin UART driver updates
Date: Wed, 27 Oct 2010 04:16:46 -0400
Message-ID: <1288167410-31554-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53070 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab0J0IQm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 04:16:42 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org

These are fine for 2.6.37 or 2.6.38.

Sonic Zhang (4):
  serial: bfin_5xx: always include DMA headers
  serial: bfin_5xx: remove redundant SSYNC to improve TX speed
  serial: bfin_5xx: disable CON_PRINTBUFFER for consoles
  serial: bfin_5xx: grab port lock before making port termios changes

 drivers/serial/bfin_5xx.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

-- 
1.7.3.2

