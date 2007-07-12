From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] sb1250-duart.c: SB1250 DUART serial support
Date: Thu, 12 Jul 2007 18:43:20 +0100
Message-ID: <20070712174320.GA22332@linux-mips.org>
References: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:40565 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbXGLR6a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2007 13:58:30 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Mason <mason@broadcom.com>, Andy Whitcroft <apw@shadowen.org>, Randy Dunlap <rdunlap@xenotime.net>, Joel Schopp <jschopp@austin.ibm.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 12, 2007 at 06:39:00PM +0100, Maciej W. Rozycki wrote:

>  This is a driver for the SB1250 DUART, a dual serial port implementation 
> included in the Broadcom family of SOCs descending from the SiByte SB1250 
> MIPS64 chip multiprocessor.  It is a new implementation replacing the 
> old-fashioned driver currently present in the linux-mips.org tree.  It 
> supports all the usual features one would expect from a(n asynchronous) 
> serial driver, including modem line control (as far as hardware supports 
> it -- there is edge detection logic missing from the DCD and RI lines and 
> the driver does not implement polling of these lines at the moment), the 
> serial console, BREAK transmission and reception, including the magic 
> SysRq.  The receive FIFO threshold is not maintained though.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

I'm all in favor of this patch sine the old drivers/char/ serial driver
has been slowly decaying while the kernel around it is changing.  It would
also make the kernel.org kernel finally usable for the Sibyte machines, so
it's an improvment even if it doesn't have half a decade of testing under
the belt, thus ACK.

  Ralf
