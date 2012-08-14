From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: OCTEON: Fix breakage due to 8250 changes.
Date: Tue, 14 Aug 2012 18:56:07 +0200
Message-ID: <20120814165607.GA29888@linux-mips.org>
References: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:57854 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab2HNQ4T (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Aug 2012 12:56:19 -0400
Received: from localhost.localdomain ([127.0.0.1]:45399 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903741Ab2HNQ4R (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Aug 2012 18:56:17 +0200
Content-Disposition: inline
In-Reply-To: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, David Daney <david.daney@cavium.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Aug 14, 2012 at 09:42:39AM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The changes in linux-next removing serial8250_register_port() cause
> OCTEON to fail to compile.
> 
> Lets make OCTEON use the new serial8250_register_8250_port() instead.

I think this one should go via the serial tree.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
