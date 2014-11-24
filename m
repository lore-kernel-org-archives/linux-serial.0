From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 0/4] serial: samsung: fixes for serial driver
Date: Mon, 24 Nov 2014 07:56:20 +0100
Message-ID: <1416812184-4496-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34351 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaKXG4s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 01:56:48 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>

Hi,

This series contains fixes for samsung serial driver. There is one patch
with important fix, which, I think, should be also applied to stable
trees, two patches fixing FIFO handling (they are not critical but,
they can provide better FIFO usage) and one patch with code cleanup.

Best regards,
Robert Baldyga

Robert Baldyga (4):
  serial: samsung: wait for transfer completion before clock disable
  serial: samsung: fix style problems
  serial: samsung: prefer to use fifosize from driver data
  serial: samsung: use port->fifosize instead of hardcoded values

 drivers/tty/serial/samsung.c | 63 ++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

-- 
1.9.1

