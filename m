From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] n_gsm: Copy n2 over when configuring via ioctl
 interface
Date: Thu, 4 Nov 2010 16:08:33 +0000
Message-ID: <20101104160833.063c603f@lxorguk.ukuu.org.uk>
References: <20101104151623.21790.64456.stgit@localhost.localdomain>
	<20101104160429.GB3770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58141 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750759Ab0KDQKB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2010 12:10:01 -0400
In-Reply-To: <20101104160429.GB3770@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

On Thu, 4 Nov 2010 09:04:29 -0700
Greg KH <greg@kroah.com> wrote:

> On Thu, Nov 04, 2010 at 03:16:24PM +0000, Alan Cox wrote:
> > From: Ken Mills <ken.k.mills@intel.com>
> > 
> > The n2 field is settable but didn't get propogated
> > 
> > Signed-off-by: Ken Mills <ken.k.mills@intel.com>
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> Is this for .37 or .38?

Could be either - its all pretty trivial stuff for an experimental
driver. Up to Linus. The N2 and length ones it would be good to get fixed
ASAP, the encoding 0 stuff could wait.

(and I guess I should have added some complicated must have new feature
patch to persuade him ;))

Alan
