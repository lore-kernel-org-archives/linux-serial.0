From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/4] n_gsm: Copy n2 over when configuring via ioctl
	interface
Date: Thu, 4 Nov 2010 09:04:29 -0700
Message-ID: <20101104160429.GB3770@kroah.com>
References: <20101104151623.21790.64456.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58791 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab0KDQHd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2010 12:07:33 -0400
Content-Disposition: inline
In-Reply-To: <20101104151623.21790.64456.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

On Thu, Nov 04, 2010 at 03:16:24PM +0000, Alan Cox wrote:
> From: Ken Mills <ken.k.mills@intel.com>
> 
> The n2 field is settable but didn't get propogated
> 
> Signed-off-by: Ken Mills <ken.k.mills@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Is this for .37 or .38?

thanks,

greg k-h
