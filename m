From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty/serial: Fix uninitialized variable warning
Date: Fri, 15 Mar 2013 13:30:10 -0700
Message-ID: <20130315203010.GA25081@kroah.com>
References: <1362360907-4439-1-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:46688 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3COUaN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Mar 2013 16:30:13 -0400
Received: by mail-pb0-f51.google.com with SMTP id un15so4289491pbc.38
        for <linux-serial@vger.kernel.org>; Fri, 15 Mar 2013 13:30:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1362360907-4439-1-git-send-email-grant.likely@secretlab.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 04, 2013 at 09:35:07AM +0800, Grant Likely wrote:
> drivers/tty/serial/8250/8250.c: In function 'serial_unlink_irq_chain':
> drivers/tty/serial/8250/8250.c:1676:19: warning: 'i' may be used uninitialized in this function
> 
> There isn't an actual bug here since the function tests the condition
> that would cause i to be uninitialized before dereferencing i. However,
> at least some versions of GCC complain as shown above. (in my case,
> powerpc gcc 2.5.2). Initializing i to NULL makes it clear to GCC and the
> casual code reviewer that i will not be dereferenced to a random
> address.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Greg, some may argue that this is a tool problem, not a kernel problem,
> but it is useful to me. If anyone objects I'm not going to spend any
> time championing for this patch.

Upgrade your tools to ones that work properly :)

greg k-h
