From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Date: Tue, 18 Jun 2013 22:28:36 +0100
Message-ID: <20130618212836.GB3440@maple>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37789 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932974Ab3FRV2k (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 17:28:40 -0400
Received: by mail-wi0-f181.google.com with SMTP id hq4so3681942wib.14
        for <linux-serial@vger.kernel.org>; Tue, 18 Jun 2013 14:28:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>

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

Looks good!

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

for the series.

Thanks,

Jamie
