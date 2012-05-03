From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] RFC: Solved unnecessary schedule latency in the TTY
 layer (2/3)
Date: Thu, 3 May 2012 09:25:29 -0700
Message-ID: <20120503162529.GB3063@kroah.com>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
 <1336048663-21882-2-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63503 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2ECQZd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 May 2012 12:25:33 -0400
Received: by pbbrp8 with SMTP id rp8so2682797pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 03 May 2012 09:25:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336048663-21882-2-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ivo Sieben <meltedpianoman@gmail.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, RT <linux-rt-users@vger.kernel.org>

On Thu, May 03, 2012 at 02:37:42PM +0200, Ivo Sieben wrote:
> Solved unnecessary schedule latency in the TTY layer when used in
> realtime context:
> The global "normal" spin lock that guards the line discipline
> administration is replaced by a raw spin lock.

Why, what does this cause to have happen?  What's the difference here
that causes any speedups or latency fixes?

thanks,

greg k-h
