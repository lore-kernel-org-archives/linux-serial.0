From: Tushar Behera <tushar.b@samsung.com>
Subject: [PATCH 0/2] serial: amba-pl01x: Clean up patches
Date: Thu, 26 Jun 2014 15:35:34 +0530
Message-ID: <1403777136-20202-1-git-send-email-tushar.b@samsung.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55572 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaFZKIy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jun 2014 06:08:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: jslaby@suse.cz, gregkh@linuxfoundation.org, linux@arm.linux.org.uk, daniel.thompson@linaro.org, trblinux@gmail.com

The patches are based next-20140626 and they have only been build
tested.

Tushar Behera (2):
  serial: amba-pl011: Remove redundant label
  serial: amba-pl010: Use devres APIs

 drivers/tty/serial/amba-pl010.c |   48 +++++++++++++--------------------------
 drivers/tty/serial/amba-pl011.c |   30 ++++++++----------------
 2 files changed, 26 insertions(+), 52 deletions(-)

-- 
1.7.9.5

