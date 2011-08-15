From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] mips: msp71xx/serial: convert to pr_foo() helpers
Date: Mon, 15 Aug 2011 13:47:51 +0100
Message-ID: <20110815124750.GA25767@linux-mips.org>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
 <1313399875-11006-4-git-send-email-jamie@jamieiles.com>
 <20110815124448.GA25544@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33907 "EHLO linux-mips.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751967Ab1HOMsh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Aug 2011 08:48:37 -0400
Content-Disposition: inline
In-Reply-To: <20110815124448.GA25544@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, arnd@arndb.de

On Mon, Aug 15, 2011 at 01:44:48PM +0100, Ralf Baechle wrote:

> Thanks, queued for 3.2.
> 
> But please cc all MIPS patches to linux-mips@linux-mips.org.

I notice that patch 4/5 depends on this one so I'm going to drop this one
again from my patch queue; preferably you should merge both 3/5 and 4/5.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
