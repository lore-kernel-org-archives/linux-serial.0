From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Serial 8250: Handle saving the clear-on-read bits from
 the LSR and MSR
Date: Fri, 6 Jul 2007 21:09:18 +0100
Message-ID: <20070706210918.255a6a68@the-village.bc.nu>
References: <20070706194244.GA18371@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41245 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764075AbXGFUDE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jul 2007 16:03:04 -0400
In-Reply-To: <20070706194244.GA18371@localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Russell King <rmk+lkml@arm.linux.org.uk>, linux-serial@vger.kernel.org

On Fri, 06 Jul 2007 14:42:44 -0500
Corey Minyard <minyard@acm.org> wrote:

> I haven't heard anything on this patch.  This is moved up to 2.6.22-rc7.
> Is there anything that needs to change to get it included?

Testing for some time in -mm in case of side effects and then pushing it
to an early -rc of a new kernel
