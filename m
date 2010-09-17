From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/3] Fix the TIOCGICOUNT problem for good
Date: Thu, 16 Sep 2010 21:56:39 -0700 (PDT)
Message-ID: <20100916.215639.172549193.davem@davemloft.net>
References: <20100916171747.25987.33573.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42360
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551Ab0IQE4U (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Sep 2010 00:56:20 -0400
In-Reply-To: <20100916171747.25987.33573.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com, drosenberg@vsecurity.com

From: Alan Cox <alan@linux.intel.com>
Date: Thu, 16 Sep 2010 18:21:06 +0100

> Remembering to clear fields is something driver authors are simply never
> going to remember to get right every new driver. Instead take the problem
> away from them and give them a simple interface to do the job.
> 
> ---
> 
> Alan Cox (3):
>       tty: icount changeover for other main devices
>       tty: Convert the USB drivers to the new icount interface
>       tty: Make tiocgicount a handler

This is a good plan for the next merge window, but for the current
-rc series and -stable we'd better just fix the individual cases.
