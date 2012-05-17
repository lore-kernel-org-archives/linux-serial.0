From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/5] serial: delete the MCA specific 8250 support.
Date: Thu, 17 May 2012 17:02:20 -0400
Message-ID: <20120517210219.GB27789@windriver.com>
References: <1337272841-25931-4-git-send-email-paul.gortmaker@windriver.com>
 <20120517164610.GA22327@kroah.com>
 <20120517165905.GA27789@windriver.com>
 <20120517.161656.1149344441984193661.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:49610 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab2EQVC2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 May 2012 17:02:28 -0400
Content-Disposition: inline
In-Reply-To: <20120517.161656.1149344441984193661.davem@davemloft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, JBottomley@parallels.com, torvalds@linux-foundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org

[Re: [PATCH 3/5] serial: delete the MCA specific 8250 support.] On 17/05/2012 (Thu 16:16) David Miller wrote:

> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Thu, 17 May 2012 12:59:06 -0400
> 
> > Since it depends on Linus pulling net-next 1st (otherwise we'll
> > get allyesconfig fails in tokenring), it probably makes sense for
> > me to just sit on all of it and then feed it to Linus after I've
> > seen him pull Dave's net-next with the token ring removal.
> > 
> > Unless someone has a better plan?
> 
> Sounds good.
> 
> Meanwhile, Paul, if you respin patch #2 I can toss that directly into
> my net-next tree since that's all networking stuff anyways.

OK.  I'm just double checking with an allyesconfig on the respin of
the #2 in isolation and then I'll follow up in the #2 thread with it.

Thanks,
Paul.

> 
> Thanks.
