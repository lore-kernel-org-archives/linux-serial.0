From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: mxs-auart serial driver DMA support?
Date: Thu, 12 Jan 2012 08:30:31 +0200
Message-ID: <4F0E7E07.1020306@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:28438 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2ALGkt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 01:40:49 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel-request@lists.infradead.org

Hi,

Any plans to add DMA support for mxs-auart serial driver? I noticed it 
is impossible to archive full 3.25 Mbs speed with current one.

There is DMA supported driver on freescale's git tree:
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=drivers/serial/mxs-auart.c;hb=imx_2.6.35_11.09.01

As I understood porting DMA support from freescale's driver is not 
trivial because MXS DMA implementation has been changed to mainline version.

Regards,
Lauri Hintsala
