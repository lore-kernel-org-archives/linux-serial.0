From: Aristeu Rozanski <aris@ruivo.org>
Subject: Re: [PATCH v1] 8250: add support for DTR/DSR hardware flow control
Date: Wed, 20 Aug 2008 17:43:36 -0400
Message-ID: <20080820214336.GN17926@cathedrallabs.org>
References: <200808071032.16709.laurentp@cse-semaphore.com> <000f01c8f88c$ad29d950$2e01a8c0@acksys.local> <20080818162526.1975dace@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([66.92.68.119]:59306 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYHTWOI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Aug 2008 18:14:08 -0400
Content-Disposition: inline
In-Reply-To: <20080818162526.1975dace@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tosoni <jp.tosoni@acksys.fr>, 'Laurent Pinchart' <laurentp@cse-semaphore.com>, 'Aristeu Rozanski' <arozansk@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> > About a RS485 ioctl: could you consider the attached files which are already
> > in the Linux kernel (in include/asm-cris).
> > They define a TIOCSERSETRS485 (ioctl.h), and the data structure (rs485.h)
> > with allows to specify timings. Sounds just like what we want ?
> 
> I had a deeper look at this for RS485 and the answer is "sort of". I've
> reworked the structure to keep it the same size irrespective of 32/64bit
> systems, and to make stuff flags that can be, plus add some extra u32
> words in case we need to (.. when we need to ;)) add stuff later.
> 
> Comments, thoughts - will this do what people in the RS485 world need ?
as for DTR/DSR patch, will be used the same approach?

-- 
Aristeu

