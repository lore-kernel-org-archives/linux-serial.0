From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 04/12] 8250_pci: Fix missing const from merges
Date: Tue, 28 Jun 2011 21:20:40 -0700
Message-ID: <20110629042040.GA17260@suse.de>
References: <20110628153856.GB32710@kroah.com>
 <1309277029-1532-1-git-send-email-gregkh@suse.de>
 <1309277029-1532-4-git-send-email-gregkh@suse.de>
 <6.2.5.6.2.20110628183349.025eea30@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58523 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab1F2E1j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Jun 2011 00:27:39 -0400
Content-Disposition: inline
In-Reply-To: <6.2.5.6.2.20110628183349.025eea30@roeck-us.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guenter Roeck <guenter@roeck-us.net>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.jf.intel.com>, Alan Cox <alan@linux.intel.com>, Antony Pavlov <antony@niisi.msk.ru>, Borislav Petkov <bp@alien8.de>, Vasily Averin <vvs@sw.ru>, Guenter Roeck <linux@roeck-us.net>

On Tue, Jun 28, 2011 at 06:36:23PM -0700, Guenter Roeck wrote:
> At 09:03 AM 6/28/2011, Greg Kroah-Hartman wrote:
> >From: Alan Cox <alan@linux.jf.intel.com>
> >
> >Signed-off-by: Alan Cox <alan@linux.intel.com>
> >Signed-off-by: Antony Pavlov <antony@niisi.msk.ru>
> >Signed-off-by: Borislav Petkov <bp@alien8.de>
> >Signed-off-by: Vasily Averin <vvs@sw.ru>
> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> I may be getting old, but I don't fully understand why I am in the
> Sign-off path for this one ???

Because you sent me a patch that did this same thing, as did others, so
I merged them all together so everyone could get the credit.

greg k-h
