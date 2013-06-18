From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Date: Tue, 18 Jun 2013 21:36:18 +0200
Message-ID: <20130618193618.GA1401@linux-mips.org>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:52937 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3FRTgg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 15:36:36 -0400
Content-Disposition: inline
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>

On Tue, Jun 18, 2013 at 12:12:50PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> Get rid of the custom OCTEON UART probe code and use 8250_dw instead.
> 
> The first patch just gets rid of Ralf's Kconfig workarounds for the
> real problem, which is OCTEON's inclomplete serial support.
> 
> Then we just make minor patches to 8250_dw, and rip out all this
> OCTEON code.
> 
> Since the patches are all interdependent, we might want to merge them
> via a single tree (perhaps Ralf's MIPS tree).

Looks good - I was trying to come up with a kludge good enough for 3.10;
this may be a bit too large ...

  Ralf
