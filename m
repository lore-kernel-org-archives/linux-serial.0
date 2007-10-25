From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] serial: do not call ->pm() on initialization for
 console port
Date: Fri, 26 Oct 2007 01:05:10 +0900 (JST)
Message-ID: <20071026.010510.59032545.anemo@mba.ocn.ne.jp>
References: <20071019.011355.39154656.anemo@mba.ocn.ne.jp>
	<20071018161827.GB16244@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756177AbXJYQDa@vger.kernel.org>
In-Reply-To: <20071018161827.GB16244@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-serial@vger.kernel.org

On Thu, 18 Oct 2007 17:18:27 +0100, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > Attached patch fixes this problem.  Is this a right way?
> > If not, I will fix the serial_txx9 driver to skip the initialization in
> > ->pm() if oldstate was -1.
> 
> I'll have to investigate further to refresh myself with what's going
> on here, but your patch looks wrong.

Now rc1 is released.  Any chances for this patch?
If none, I should push other workaround to fix this issue on 2.6.24.

---
Atsushi Nemoto
