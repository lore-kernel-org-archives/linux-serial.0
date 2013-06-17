From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 0/2] serial: sh-sci: HSCIF support
Date: Mon, 17 Jun 2013 11:42:12 +0900
Message-ID: <1371436934-27744-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51921 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab3FQClX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 16 Jun 2013 22:41:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Ulrich Hecht <ulrich.hecht@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Simon Horman <horms+renesas@verge.net.au>

Hi Greg, Hi All,

this short series adds HSCIF support to the sh-sci driver
and enhances the r8a7790 SoC to not use external clocks for SCIF.

I have included these two patches in a single series as the second
patch has a build-time dependency on the first.

Greg, would it be possible for you to review at least the first patch and
if it is ok either:
* Ack the first patch so I can merge it through the renesas tree or;
* Take both patches, I have supplied Acks.

In the case of the latter I can supply a pull request if you like.

Ulrich Hecht (2):
  serial: sh-sci: HSCIF support
  ARM: shmobile: r8a7790: don't use external clock for SCIFs

 arch/arm/mach-shmobile/setup-r8a7790.c |   16 ++++-
 drivers/tty/serial/sh-sci.c            |  102 +++++++++++++++++++++++++++++---
 include/linux/serial_sci.h             |   12 +++-
 include/uapi/linux/serial_core.h       |    3 +
 4 files changed, 120 insertions(+), 13 deletions(-)

-- 
1.7.10.4

