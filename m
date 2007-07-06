From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Serial 8250: Handle saving the clear-on-read bits from
 the LSR and MSR
Date: Fri, 6 Jul 2007 22:41:39 +0100
Message-ID: <20070706224139.4be889d6@the-village.bc.nu>
References: <20070706194244.GA18371@localdomain>
	<20070706210918.255a6a68@the-village.bc.nu>
	<468EB4DD.7070800@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:50360 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761664AbXGFVfW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jul 2007 17:35:22 -0400
In-Reply-To: <468EB4DD.7070800@acm.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Russell King <rmk+lkml@arm.linux.org.uk>, linux-serial@vger.kernel.org

> > Testing for some time in -mm in case of side effects and then pushing it
> > to an early -rc of a new kernel
> >   
> I just pulled 2.6.22-rc6-mm1 and I looked in all the previous 2.6.22 mm 
> patches and I don't see it.  Am I missing something?

Getting it submitted into -mm as a starting point.

Alan
