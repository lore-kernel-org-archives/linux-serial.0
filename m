From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH 08/14] tty/serial/kgdboc: Add and wire up clear_irqs
 callback
Date: Mon, 10 Sep 2012 10:57:04 -0700
Message-ID: <20120910175704.GA11392@lizard>
References: <20120910040802.GA1261@lizard>
 <20120910041357.GH29537@lizard>
 <20120910121624.226c1a88@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35199 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab2IJR7m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Sep 2012 13:59:42 -0400
Received: by pbbrr13 with SMTP id rr13so2807096pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 10 Sep 2012 10:59:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120910121624.226c1a88@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

On Mon, Sep 10, 2012 at 12:16:24PM +0100, Alan Cox wrote:
> > serial port, the CPU receives NMI exception, and we fall into KDB
> > shell.  So, it is our "debug console", and it is able to interrupt
> > (and thus debug) even IRQ handlers themselves.
> 
> You seem to have an assumption of single core here. What happens if
> the NMI hits CPU #0 and the serial IRQ hits CPU #1 simultaneously ?

If you can't redirect all serial IRQs to NMI context, e.g. sometimes you get
NMIs, sometimes IRQs, then your NMI handling is not deterministic, and surely
this is not supported.

The whole concept of clearing IRQs is needed if serial IRQ is routed to the
NMI/FIQ (on all CPUs), which by definition guarantees that serial IRQ routine
is never triggered. We "steal" all and every serial port's IRQs.

Thanks!
