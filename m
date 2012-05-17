From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/5] serial: delete the MCA specific 8250 support.
Date: Thu, 17 May 2012 16:16:56 -0400 (EDT)
Message-ID: <20120517.161656.1149344441984193661.davem@davemloft.net>
References: <1337272841-25931-4-git-send-email-paul.gortmaker@windriver.com>
	<20120517164610.GA22327@kroah.com>
	<20120517165905.GA27789@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:34716 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965962Ab2EQURC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 May 2012 16:17:02 -0400
In-Reply-To: <20120517165905.GA27789@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: paul.gortmaker@windriver.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, JBottomley@parallels.com, torvalds@linux-foundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 17 May 2012 12:59:06 -0400

> Since it depends on Linus pulling net-next 1st (otherwise we'll
> get allyesconfig fails in tokenring), it probably makes sense for
> me to just sit on all of it and then feed it to Linus after I've
> seen him pull Dave's net-next with the token ring removal.
> 
> Unless someone has a better plan?

Sounds good.

Meanwhile, Paul, if you respin patch #2 I can toss that directly into
my net-next tree since that's all networking stuff anyways.

Thanks.
