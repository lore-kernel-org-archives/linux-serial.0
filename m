From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: tty/serial eating \n regression in 3.13-rc1
Date: Thu, 28 Nov 2013 10:46:14 -0700
Message-ID: <20131128174614.GB28055@obsidianresearch.com>
References: <20131127181348.GA22723@obsidianresearch.com>
 <1385652419-4732-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51110 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781Ab3K1RqU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 12:46:20 -0500
Content-Disposition: inline
In-Reply-To: <1385652419-4732-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Nov 28, 2013 at 10:26:57AM -0500, Peter Hurley wrote:

> Please test out the attached patch and let me know if that solves
> the login whitespace problem.

Yes, it certainly does:
Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

My bisection search showed this should go into 3.12 stable and 3.13..

> Also, please retest the 'cat enable' problem; I have doubts that this
> patch fixes that problem, though.

Correct, this case is still broken, I had guessed they were the same..

Hmm.. it behaves that way in 3.10 as well.. And the issue happens when
the line exceeds 80 cols, and things visually look sane if my x
terminal is 80 cols. So this is something different and probably
expected behavior.

Thanks!
Jason
