From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] zs: Move to the serial subsystem
Date: Wed, 30 May 2007 10:54:59 +0100
Message-ID: <465D49F3.7010005@shadowen.org>
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl> <20070530011224.bf36d2df.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:3513 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbXE3Jyz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 May 2007 05:54:55 -0400
In-Reply-To: <20070530011224.bf36d2df.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 29 May 2007 14:03:54 +0100 (BST) "Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> Hey, you have volatiles and checkpatch.pl didn't complain.  Andy, a
> reference to Documentation/volatile-considered-harmful.txt would suit.
> 
> (That's
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.22-rc2/2.6.22-rc2-mm1/broken-out/volatile-considered-harmful-take-3.patch)

Added ...

Use of volatile is usually wrong: see
Documentation/volatile-considered-harmful.txt
PATCH: XXX.eml:374:
FILE: linux-2.6.22-rc2/drivers/serial/zs.c:131:
+       volatile void __iomem *control = zport->port.membase +

[...]

I will batch up any changes to checkpatch.pl and send you them as a blob
when they get "interesting" if that suits.

-apw
