From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/5] serial: Patches for OCTEON CPU support.
Date: Tue, 25 Nov 2008 16:14:52 -0800
Message-ID: <492C94FC.9070906@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19415 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbYKZAPE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2008 19:15:04 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips <linux-mips@linux-mips.org>

Previously I have posted these five patches as part of the larger CPU
support patch set.  I am separating them out now as I have
incorporated changes as suggested by Alan Cox, and these are ready for
review now.

Changes from previous version:

* I/O functions now called serial_{in,out}.

* UART_BUG_OCTEON_IIR workaround moved to OCTEON serial_in function
   and out of this patch set.

Since these are the only non-mips specific patches required for OCTEON
cpu support, it is necessary to get these Signed-off-by before the
full OCTEON patch set can proceed.  Also since serial is lacking
active maintainers, I am sending directly to akpm and Alan in hopes
that one or more of them will review the patches.


Five patches to follow.

David Daney (5):
   8250: Don't clobber spinlocks.
   8250: Serial driver changes to support future Cavium OCTEON serial
     patches.
   Serial: Allow port type to be specified when calling
     serial8250_register_port.
   8250: Allow port type to specify bugs that are not probed for.
   Serial: UART driver changes for Cavium OCTEON.

  drivers/serial/8250.c        |  230 
+++++++++++++++++++++++++++++++-----------
  drivers/serial/8250.h        |    2 +
  drivers/serial/serial_core.c |    7 +-
  include/linux/serial_8250.h  |    3 +
  include/linux/serial_core.h  |    7 +-
  5 files changed, 185 insertions(+), 64 deletions(-)

