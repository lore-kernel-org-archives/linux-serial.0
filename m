From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Patchset for kernel 3.10 (fixing lockup in printk)
Date: Tue, 29 Apr 2014 05:03:40 -0700
Message-ID: <20140429120340.GA32696@kroah.com>
References: <535F9015.5090309@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55664 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933447AbaD2MCu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Apr 2014 08:02:50 -0400
Content-Disposition: inline
In-Reply-To: <535F9015.5090309@gmx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Naumann <alexandernaumann@gmx.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Apr 29, 2014 at 01:42:13PM +0200, Alexander Naumann wrote:
> Hallo all,
> 
> attached to this mail you will find a couple of patches fixing one bug I
> have with kernel 3.10 (all subreleases).
> These patches have been developed originally by Jan Kara (jack@suse.cz,
> I guess you
> know him better than I do) for kernel 3.13 and can be found here:
> https://lkml.org/lkml/2014/3/25/343
> I just have backported them to kernel 3.10.

Patches have to be accepted into Linus's kernel tree before I can accept
them into any stable kernel release.  Please see the kernel file,
Documentation/stable_kernel_rules.txt for the details on how this all
works.

Once the patches get merged, please let us know what the git commit ids
they are in Linus's tree and I will be glad to queue them up.

thanks,

greg k-h
