From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: OCTEON: Fix breakage due to 8250 changes.
Date: Tue, 14 Aug 2012 14:46:55 -0700
Message-ID: <20120814214655.GB19349@kroah.com>
References: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
 <20120814165607.GA29888@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:49175 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab2HNVsb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Aug 2012 17:48:31 -0400
Received: by ghrr11 with SMTP id r11so1041625ghr.19
        for <linux-serial@vger.kernel.org>; Tue, 14 Aug 2012 14:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120814165607.GA29888@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, David Daney <david.daney@cavium.com>, Alan Cox <alan@linux.intel.com>

On Tue, Aug 14, 2012 at 06:56:07PM +0200, Ralf Baechle wrote:
> On Tue, Aug 14, 2012 at 09:42:39AM -0700, David Daney wrote:
> 
> > From: David Daney <david.daney@cavium.com>
> > 
> > The changes in linux-next removing serial8250_register_port() cause
> > OCTEON to fail to compile.
> > 
> > Lets make OCTEON use the new serial8250_register_8250_port() instead.
> 
> I think this one should go via the serial tree.
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Ok, I'll take it there, thanks.

greg k-h
