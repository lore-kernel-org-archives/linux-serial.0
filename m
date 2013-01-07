From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 0/5] serial: imx: Some fixes and cleanups
Date: Mon,  7 Jan 2013 10:25:01 +0530
Message-ID: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:64405 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab3AGFDQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 00:03:16 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so10433518pad.35
        for <linux-serial@vger.kernel.org>; Sun, 06 Jan 2013 21:03:15 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, shawn.guo@linaro.org, s.hauer@pengutronix.de, sachin.kamat@linaro.org, patches@linaro.org

This series build tested using imx_v4_v5_defconfig against
linux-next tree (20130107).

Sachin Kamat (5):
  serial: imx: Fix checkpatch errors related to spacing
  serial: imx: Use <linux/io.h> instead of <asm/io.h>
  serial: imx: Fix coding style issue
  serial: imx: Use pr_info instead of printk
  serial: imx: Use devm_* APIs

 drivers/tty/serial/imx.c |  263 ++++++++++++++++++++++------------------------
 1 files changed, 125 insertions(+), 138 deletions(-)

-- 
1.7.4.1

