From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: mfd: adjust the baud rate setting
Date: Thu, 18 Nov 2010 20:03:25 -0800
Message-ID: <20101119040325.GA20116@kroah.com>
References: <1290135708-6784-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:47921 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab0KSELk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 23:11:40 -0500
Content-Disposition: inline
In-Reply-To: <1290135708-6784-1-git-send-email-feng.tang@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: linux-serial@vger.kernel.org, alan@linux.intel.com

On Fri, Nov 19, 2010 at 11:01:48AM +0800, Feng Tang wrote:
> Previous baud rate setting code only has been tested with 3.5M/9600/
> 115200/230400/460800 bps, and recently we got a 3M bps device to test,
> which needs to modify current MUL register setting, and with this
> patch 2.5M/2M/1.5M/1M/0.5M should also work as they just use a MUL
> value scale down from 3M's.
> 
> Also got some reference register setting from silicon guys for
> different baud rates, which tries to keep the pre-scalar register value
> to 16.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Wonderful, now that's a change log entry :)

One final question, this should go into .37, right?  Is it also
applicable for .36-stable and older?

thanks,

greg k-h
