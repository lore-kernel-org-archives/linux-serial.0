From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH 00/10] serial: sh-sci fixes - console PM, SCIFB, SMP lockup,
 etc.
Date: Wed, 07 Nov 2012 15:57:28 +0900
Message-ID: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:48661 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab2KGG5b (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 01:57:31 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, rjw@sisk.pl, alan@linux.intel.com, gregkh@linuxfoundation.org, takashi.yoshii.zj@renesas.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org

Hi Paul and serial forks,

Here are sh-sci serial driver fixes that have been cooking for months
privately on my end:
* console PM rework with the help of serial-core's uart_change_pm()
* provide missing piece in SCIFB support (from Yoshii-san)
* address console write function vs. SMP lockup issue

and so on.  Comments and suggestions are welcome.

Build tested with vanilla v3.6, but not boot- nor PM-tested with
newer kernels after v3.4.  Anyone with can-sleep shmobile systems,
please give it try.

Thanks in advance,

----------------------------------------------------------------
Shinya Kuribayashi (5):
      Revert "sh-sci / PM: Avoid deadlocking runtime PM"
      Revert "sh-sci / PM: Use power.irq_safe"
      Partially revert "serial: sh-sci: console Runtime PM support"
      serial: sh-sci: add locking to console write function to avoid SMP lockup
      serial: sh-sci: fix possible race cases on SCSCR register accesses

Takashi YOSHII (4):
      serial: sh-sci: fix condition test to set SCBRR
      serial: sh-sci: support lower baud rate
      serial: sh-sci: mask SCTFDR/RFDR according to fifosize
      serial: sh-sci: fix common SCIFB regmap definition

Teppei Kamijou (1):
      serial: sh-sci: console runtime PM support (revisit)

 drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 84 deletions(-)

-- 
Shinya Kuribayashi
Renesas Electronics
