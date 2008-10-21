From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
Date: Tue, 21 Oct 2008 08:35:39 -0700
Message-ID: <48FDF6CB.4070605@caviumnetworks.com>
References: <48F51114.2010105@caviumnetworks.com>	<20081020141750.d0610586.akpm@linux-foundation.org> <20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3601 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYJUPgs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2008 11:36:48 -0400
In-Reply-To: <20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com

Alan Cox wrote:
>> But yes, copying a spinlock by value is quite wrong.  Perhaps we could
>> retain the struct assigment and then run spin_lock_init() to get the
>> spinlock into a sane state?
> 
> Kind of irrelevant now however, the split of patches that caused the
> original bug is over and the NR_IRQ removal patch half of it hit Linus
> tree.
> 
My original patch fixed *two* problems.  As you note here, you already fixed the first one.

As far as I know, the second problem is still present, and that is what akpm was referring to above.  Several days ago I posted a revised patch for this here:

http://marc.info/?l=linux-serial&m=122408950013741&w=2

The question is:  What is the best way to initialize some (or all) fields of a structure *except* a single lock field that was previously initialized?

We can just copy field by field as my patch does, or you could do something ugly using memcpy on portions of the structure.  In this case we know which structure elements will be used by the early console, so I just copied them.

Any comments about that patch are certainly most welcome.

Thanks,
David Daney
