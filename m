From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] tty: serial: altera_uart: Check for NULL platform_data
 in probe.
Date: Thu, 29 Mar 2012 21:38:55 +0200
Message-ID: <20120329193855.GW21503@distanz.ch>
References: <1333007727-24045-1-git-send-email-tklauser@distanz.ch>
 <20120329161337.GA28858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:55655 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759079Ab2C2Trf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 15:47:35 -0400
Content-Disposition: inline
In-Reply-To: <20120329161337.GA28858@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Yuriy Kozlov <ykozlov@ptcusa.com>

On 2012-03-29 at 18:13:37 +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 29, 2012 at 09:55:27AM +0200, Tobias Klauser wrote:
> > From: Yuriy Kozlov <ykozlov@ptcusa.com>
> > 
> > Follow altera_jtag_uart.  This fixes a crash if there is a mistake in the DTS.
> 
> Is this something you have seen in the wild?  Is this something to be
> backported to stable kernels?

Not that I know of. But nevertheless it might be worthwhile. Shall I
send the patch again with Cc: stable@kernel.org?

Thanks
Tobias
