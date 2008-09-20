From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] max3100 driver
Date: Sat, 20 Sep 2008 06:56:52 -0700
Message-ID: <20080920065652.11d76780@infradead.org>
References: <1221895208650-git-send-email-chripell@gmail.com>
	<20080920012454.e40f03cc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44285 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYITN5F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 09:57:05 -0400
In-Reply-To: <20080920012454.e40f03cc.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Pellegrin <chripell@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Christian Pellegrin <chripell@fsfe.org>

\> > +	int rx_enabled:1;	/* if we should rx chars */
> > +
> > +	int irq;		/* irq assigned to the max3100 */
> > +
> > +	int minor;		/* minor number */
> > +	int crystal:1;		/* 1 if 3.6864Mhz crystal 0
> > for 1.8432 */
> > +	int loopback:1;		/* 1 if we are in loopback
> > mode */
> > +	int only_edge_irq:1;	/* 1 if we have only edge irqs
> > (like PXA) */
> 
> Lots of dittoes.
> 
> These bitfields perhaps could be reordered to save a bit of space, but
> that depends on the implicit locking rules for them.
> 

I do have a question though: what does a signed bitfield of 1 mean?
I mean.. the variables are "int", so signed.... where will the compiler
store the sign bit???


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
