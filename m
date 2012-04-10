From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 1/3] tegra, serial8250: add ->handle_break() uart_port
 op
Date: Tue, 10 Apr 2012 15:14:51 -0600
Message-ID: <4F84A2CB.8040301@wwwdotorg.org>
References: <20120410210438.13805.40525.stgit@dwillia2-linux.jf.intel.com> <20120410211053.13805.18954.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34011 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab2DJVO4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Apr 2012 17:14:56 -0400
In-Reply-To: <20120410211053.13805.18954.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org, Sudhakar Mamillapalli <sudhakar@fb.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Nhan H Mai <nhan.h.mai@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>

On 04/10/2012 03:10 PM, Dan Williams wrote:
> The "KT" serial port has another use case for a "received break" quirk,
> so before adding another special case to the 8250 core take this
> opportunity to push such quirks out of the core and into a uart_port op.
> 
> Stephen says:
> "If the callback function is to no longer live in 8250.c itself,
>  arch/arm/mach-tegra/devices.c isn't logically a good place to put it,
>  and that file will be going away once we get rid of all the board files
>  and move solely to device tree."
> 
> ...so since 8250_pci.c houses all the quirks for pci serial devices this
> quirk is similarly housed in of_serial.c.  Once the open firmware
> conversion completes the infrastructure details
> (include/linux/of_serial.h, and the export) can all be removed to make
> this self contained to of_serial.c.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Tested-by: Stephen Warren <swarren@wwwdotorg.org>
