From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Thu, 19 Jan 2012 22:12:14 -0800
Message-ID: <20120120061214.GA2551@linux.vnet.ibm.com>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
 <201201190102.58788.rjw@sisk.pl>
 <20120119013731.GK2431@linux.vnet.ibm.com>
 <201201200103.34296.rjw@sisk.pl>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:59356 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2ATGMs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Jan 2012 01:12:48 -0500
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 19 Jan 2012 23:12:47 -0700
Content-Disposition: inline
In-Reply-To: <201201200103.34296.rjw@sisk.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Simon Glass <sjg@chromium.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Fri, Jan 20, 2012 at 01:03:34AM +0100, Rafael J. Wysocki wrote:
> On Thursday, January 19, 2012, Paul E. McKenney wrote:
> > On Thu, Jan 19, 2012 at 01:02:58AM +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, January 18, 2012, Paul E. McKenney wrote:
> > > > On Wed, Jan 18, 2012 at 02:15:59PM -0800, Simon Glass wrote:
> [...] 
> > > Yes, you can, but then I'd say it's not necessary for user space to
> > > be able to carry that out in a tight loop.  So, it seems, alternatively,
> > > we could make that loop a bit less tight, e.g. by adding an arbitrary
> > > sleep to the user space interface for the "disable" case.
> > 
> > Good point, that would work just as well and be simpler.
> 
> Thanks for the confirmation! :-)
> 
> By the way, I wonder, would it help to add synchronize_rcu() to
> wakeup_source_add() too?  Then, even if device_wakeup_enable() and
> device_wakeup_disable() are executed in a tight loop for the same
> device, the list_add/list_del operations will always happen in
> different RCU cycles (or at least it seems so).

I cannot immediately see how adding a synchronize_rcu() to
wakeup_source_add() would help anything.  You only need to wait for a
grace period on removal, not (normally) on addition.  The single grace
period during removal will catch up all other asynchronous RCU grace
period requests on that CPU.

Or am I missing your point?

							Thanx, Paul

