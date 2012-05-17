From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/5] serial: delete the MCA specific 8250 support.
Date: Thu, 17 May 2012 12:59:06 -0400
Message-ID: <20120517165905.GA27789@windriver.com>
References: <1337272841-25931-1-git-send-email-paul.gortmaker@windriver.com>
 <1337272841-25931-4-git-send-email-paul.gortmaker@windriver.com>
 <20120517164610.GA22327@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43512 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758313Ab2EQQ7R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 May 2012 12:59:17 -0400
Content-Disposition: inline
In-Reply-To: <20120517164610.GA22327@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, JBottomley@parallels.com, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, David Miller <davem@davemloft.net>

[Re: [PATCH 3/5] serial: delete the MCA specific 8250 support.] On 17/05/2012 (Thu 09:46) Greg Kroah-Hartman wrote:

> On Thu, May 17, 2012 at 12:40:39PM -0400, Paul Gortmaker wrote:
> > The support for CONFIG_MCA is being removed, since the 20
> > year old hardware simply isn't capable of meeting today's
> > software demands on CPU and memory resources.
> > 
> > This commit removes the MCA specific 8250 UART code.
> > 
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Do you want me to take this through my tty tree, or are you sending this
> through some other means?

Since it depends on Linus pulling net-next 1st (otherwise we'll
get allyesconfig fails in tokenring), it probably makes sense for
me to just sit on all of it and then feed it to Linus after I've
seen him pull Dave's net-next with the token ring removal.

Unless someone has a better plan?

Thanks,
Paul.
--

> 
> thanks,
> 
> greg k-h
