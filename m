From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty/vt: Return EBUSY if deallocating VT1 and it is busy
Date: Fri, 14 Jun 2013 21:48:24 -0700
Message-ID: <20130615044824.GA13946@kroah.com>
References: <20130614213543.GA1896@kroah.com>
 <1371248665-1176-1-git-send-email-rosslagerwall@gmail.com>
 <51BBA0E4.6030602@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49144 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab3FOEru (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Jun 2013 00:47:50 -0400
Content-Disposition: inline
In-Reply-To: <51BBA0E4.6030602@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Ross Lagerwall <rosslagerwall@gmail.com>, linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, linux-serial@vger.kernel.org

On Fri, Jun 14, 2013 at 07:01:56PM -0400, Peter Hurley wrote:
> On 06/14/2013 06:24 PM, Ross Lagerwall wrote:
> >Commit 421b40a6286e ("tty/vt: Fix vc_deallocate() lock order") changed
> >the behavior when deallocating VT 1.  Previously if trying to
> >deallocate VT1 and it is busy, we would return EBUSY.  The commit
> >changed this to return 0 (success).
> >
> >This commit restores the old behavior.
> >
> >Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
> 
> Thanks.
> 
> Acked-by: Peter Hurley <peter@hurleysoftware.com>

Thanks for this, I'll queue it up for Linus soon.

greg k-h
