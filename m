From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] serial/arc-uart: Urgent DT related update
Date: Mon, 11 Feb 2013 14:11:40 +0530
Message-ID: <1360572101-12744-1-git-send-email-vgupta@synopsys.com>
References: <201302090928.43929.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:49244 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab3BKInt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 03:43:49 -0500
In-Reply-To: <201302090928.43929.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Greg,

Here's an update to arc-uart driver given Grant's recent review comments.
As discussed in the thread, can you consider this a bug fix and apply to
tty-next for 3.9. If you don't, please let me know as the corresponding DT file
change would have to be to be seperately applied to arch/arc/boot/*.

Patch is Based off linux-next of today.

Thx,
-Vineet

Vineet Gupta (1):
  serial/arc-uart: Miscll DT related updates (Grant's review comments)

 .../devicetree/bindings/tty/serial/arc-uart.txt    |    4 ++--
 drivers/tty/serial/arc_uart.c                      |   10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

-- 
1.7.4.1

