From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/4] serial: Patches for OCTEON CPU support (version 2).
Date: Mon, 01 Dec 2008 15:46:22 -0800
Message-ID: <4934774E.6080805@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:46768 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYLAXqm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2008 18:46:42 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips <linux-mips@linux-mips.org>


The previous patch set was Signed-off-by: Andrew Morton and added to
the -mm tree, however comments from Shinya Kuribayashi prompted me to
make some improvements.

The first three patches are unchanged from the previous set (I hope it
is not a breach of etiquette to include them again).  The forth which
allows uart bug types to be statically specified is completely
removed.  And the fifth (now forth) is simplified and now only adds a
uart type for the OCTEON uart.

And as I previously said:
Since these are the only non-mips specific patches required for OCTEON
cpu support, it is necessary to get these Signed-off-by before the
full OCTEON patch set can proceed.


Four patches to follow.

Thanks,

David Daney (4):
   8250: Don't clobber spinlocks.
   8250: Serial driver changes to support future Cavium OCTEON serial
     patches.
   Serial: Allow port type to be specified when calling
     serial8250_register_port.
   Serial: UART driver changes for Cavium OCTEON.

  drivers/serial/8250.c        |  225 
+++++++++++++++++++++++++++++++-----------
  drivers/serial/serial_core.c |    7 +-
  include/linux/serial_8250.h  |    3 +
  include/linux/serial_core.h  |    7 +-
  4 files changed, 179 insertions(+), 63 deletions(-)

