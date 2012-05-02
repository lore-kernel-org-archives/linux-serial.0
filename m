From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/06] serial8250: DLL/DLM rework, Emma Mobile UART
 driver
Date: Wed, 2 May 2012 14:03:21 +0100
Message-ID: <20120502140321.54f7af9c@pyramind.ukuu.org.uk>
References: <20120502124642.30480.41373.sendpatchset@w520>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55953 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab2EBNBC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 May 2012 09:01:02 -0400
In-Reply-To: <20120502124642.30480.41373.sendpatchset@w520>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-serial@vger.kernel.org, horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, paul.gortmaker@windriver.com, lethal@linux-sh.org, olof@lixom.net, dan.j.williams@intel.com, alan@linux.intel.com

On Wed, 02 May 2012 21:46:42 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> serial8250: DLL/DLM rework, Emma Mobile UART driver
> 
> [PATCH 01/06] serial8250: Add dl_read()/dl_write() callbacks
> [PATCH 02/06] serial8250: Use dl_read()/dl_write() on Alchemy
> [PATCH 03/06] serial8250: Use dl_read()/dl_write() on RM9K
> [PATCH 04/06] serial8250: Clean up default map and dl code
> [PATCH 05/06] serial8250: Introduce serial8250_register_8250_port()
> [PATCH 06/06] serial8250-em: Add Emma Mobile UART driver
> 
> This series cleans up and adjusts the 8250 code base to allow
> hooking in a driver for the UART in Emma Mobile SoCs.
> 
> In short:
> - Patch 1-4 tie in 8250-specific dl_read()/dl_write() callbacks.
> - Patch 5 adds a new register function to use new callbacks.
> - Patch 6 adds a new driver that makes use of the above.
> 
> I'd be happy to rework the above patches if needed. The
> main challenge for Emma Mobile UART support is the non-
> standard offsets for DLL and DLM registers.
> 
> Note that there is no DT support included at this point,
> but it boils down to a 10 line change. The boot loader on
> my board does not do DT so I'd like to use kexec for DT
> development (as usual), but to use kexec I first need to
> get a non-DT kernel working. Which is basically this. =)
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Alan Cox <alan@linux.intel.com>
