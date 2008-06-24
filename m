From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt] serial: 8250: fix shared interrupts issues under
	RT kernels
Date: Tue, 24 Jun 2008 02:12:21 +0200
Message-ID: <20080624001221.GA20685@elte.hu>
References: <20080623232957.GA5111@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46108 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbYFXAMl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Jun 2008 20:12:41 -0400
Content-Disposition: inline
In-Reply-To: <20080623232957.GA5111@polina.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> 8250's initialization routines relies on the fact that _irqsave 
> spinlock will disable local hardirqs, so that the driver can issue 
> IRQ-triggering operations before registering the port in the IRQ 
> chain.
> 
> With RT kernels and preemptable hardirqs this isn't true, _irqsave 
> spinlock does not disable local hardirqs, and this causes following 
> trace:

again, please let the -rt maintainers sort out which patches need to be 
propagated to upstream maintainers.

	Ingo
