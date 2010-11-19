From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] serial: mfd: adjust the baud rate setting
Date: Fri, 19 Nov 2010 13:15:01 +0800
Message-ID: <20101119131501.0daa268a@feng-i7>
References: <1290135708-6784-1-git-send-email-feng.tang@intel.com>
	<20101119040325.GA20116@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37890 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab0KSElY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 23:41:24 -0500
In-Reply-To: <20101119040325.GA20116@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>

On Fri, 19 Nov 2010 12:03:25 +0800
Greg KH <greg@kroah.com> wrote:

> On Fri, Nov 19, 2010 at 11:01:48AM +0800, Feng Tang wrote:
> > Previous baud rate setting code only has been tested with 3.5M/9600/
> > 115200/230400/460800 bps, and recently we got a 3M bps device to
> > test, which needs to modify current MUL register setting, and with
> > this patch 2.5M/2M/1.5M/1M/0.5M should also work as they just use a
> > MUL value scale down from 3M's.
> > 
> > Also got some reference register setting from silicon guys for
> > different baud rates, which tries to keep the pre-scalar register
> > value to 16.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Wonderful, now that's a change log entry :)
> 
> One final question, this should go into .37, right?  Is it also
> applicable for .36-stable and older?

This patch should be in stable git too, but don't know if it could
be applied to stable tree directly. Thanks,

- Feng 
