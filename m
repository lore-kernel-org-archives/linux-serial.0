From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Fri, 20 Jan 2012 01:03:34 +0100
Message-ID: <201201200103.34296.rjw@sisk.pl>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org> <201201190102.58788.rjw@sisk.pl> <20120119013731.GK2431@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120119013731.GK2431@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Simon Glass <sjg@chromium.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday, January 19, 2012, Paul E. McKenney wrote:
> On Thu, Jan 19, 2012 at 01:02:58AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, January 18, 2012, Paul E. McKenney wrote:
> > > On Wed, Jan 18, 2012 at 02:15:59PM -0800, Simon Glass wrote:
[...] 
> > Yes, you can, but then I'd say it's not necessary for user space to
> > be able to carry that out in a tight loop.  So, it seems, alternatively,
> > we could make that loop a bit less tight, e.g. by adding an arbitrary
> > sleep to the user space interface for the "disable" case.
> 
> Good point, that would work just as well and be simpler.

Thanks for the confirmation! :-)

By the way, I wonder, would it help to add synchronize_rcu() to
wakeup_source_add() too?  Then, even if device_wakeup_enable() and
device_wakeup_disable() are executed in a tight loop for the same
device, the list_add/list_del operations will always happen in
different RCU cycles (or at least it seems so).

Thanks,
Rafael
