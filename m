From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
Date: Tue, 21 Oct 2008 10:38:33 +0100
Message-ID: <20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
References: <48F51114.2010105@caviumnetworks.com>
	<20081020141750.d0610586.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36831 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751476AbYJUJjG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2008 05:39:06 -0400
In-Reply-To: <20081020141750.d0610586.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com

> But yes, copying a spinlock by value is quite wrong.  Perhaps we could
> retain the struct assigment and then run spin_lock_init() to get the
> spinlock into a sane state?

Kind of irrelevant now however, the split of patches that caused the
original bug is over and the NR_IRQ removal patch half of it hit Linus
tree.

Alan
