From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 0/3] tty: xuartps: Fix build
Date: Mon, 21 Oct 2013 16:40:58 -0700
Message-ID: <1382398861-21542-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47205 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3JUXlK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Oct 2013 19:41:10 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>

This should fix the issues in the x86 build of the xuartps driver. The
issues are:
 - [tty:tty-next 72/75] drivers/tty/serial/xilinx_uartps.c:436:7: error=
:
   'PRE_RATE_CHANGE' undeclared
 - [tty:tty-next 73/75] drivers/tty/serial/xilinx_uartps.c:1227:21:
   error: 'xuartps_uart_driver' undeclared

Additionally I found some build warnings while fixing those issues.

There are some additional comments regarding patches 1 and 3 in their
respective email.
This series is based on the tty-next tree.

	Thanks,
	S=C3=B6ren

Soren Brinkmann (3):
  tty: xuartps: Fix "may be used uninitialized" build warning
  tty: xuartps: Fix build error due to missing forward declaration
  tty: xuartps: Fix build error when COMMON_CLK is not set

 drivers/tty/serial/xilinx_uartps.c | 38 +++++++++++++++++++++++-------=
--------
 1 file changed, 23 insertions(+), 15 deletions(-)

--=20
1.8.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
