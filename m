From: Steven Cole <elenstev@mesatop.com>
Subject: Re: Someting's busted with serial in 2.6.11 latest
Date: Thu, 10 Mar 2005 18:04:52 -0700
Message-ID: <200503101804.52770.elenstev@mesatop.com>
References: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net> <4230CCCB.6030909@mesatop.com> <20050310225939.G1044@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from nacho.zianet.com ([216.234.192.105]:39954 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S263036AbVCKBHi
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Mar 2005 20:07:38 -0500
In-Reply-To: <20050310225939.G1044@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thursday 10 March 2005 03:59 pm, Russell King wrote:
> On Thu, Mar 10, 2005 at 03:40:11PM -0700, Steven Cole wrote:
> > I'll test current bk tonight, but I don't see any recent fix to
> > drivers/serial/8250.c when browsing linux.bkbits.net/linux-2.6.
> 
> Ok, so Stephen's bug is already fixed.  After testing the latest bk, if
> you find your bug isn't resolved, please try to isolate the change by
> applying this patch.  If this doesn't resolve it, then your change of
> behaviour hasn't been caused by changes to 8250.c, but must be down to
> some other part of the kernel.

OK, latest 2.6.11-bk works just fine.  Although I thought I had a failure
with a fairly recent snapshot, I must have had a version before the fix.
Sorry for any confusion.

FWIW, the failing kernels reported: ttyS0 at I/O 0x3f8 (irq = 4) is a XScale

But now, all is fine.  Thanks.

Steven
