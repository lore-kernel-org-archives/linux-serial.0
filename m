From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Tue, 17 Jan 2012 20:17:21 -0800
Message-ID: <20120118041720.GA2431@linux.vnet.ibm.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
 <1326826563-32215-3-git-send-email-sjg@chromium.org>
 <20120117201036.6d99f98f@pyramind.ukuu.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:37531 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab2ARERa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jan 2012 23:17:30 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 17 Jan 2012 21:17:29 -0700
Content-Disposition: inline
In-Reply-To: <20120117201036.6d99f98f@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Simon Glass <sjg@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Tue, Jan 17, 2012 at 08:10:36PM +0000, Alan Cox wrote:
> On Tue, 17 Jan 2012 10:56:03 -0800
> Simon Glass <sjg@chromium.org> wrote:
> 
> > Since serial_core now does not make serial ports wake-up capable by
> > default, add a parameter to support this feature in the 8250 UART.
> > This is the only UART where I think this feature is useful.
> 
> NAK
> 
> Things should just work for users. Magic parameters is not an
> improvement. If its a performance problem someone needs to fix the rcu
> sync overhead or stop using rcu on that path.

I must say that I lack context here, even after looking at the patch,
but the synchronize_rcu_expedited() primitives can be used if the latency
of synchronize_rcu() is too large.

							Thanx, Paul

