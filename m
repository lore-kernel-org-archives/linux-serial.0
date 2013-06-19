From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] tty/8250_dw: Add support for OCTEON UARTS.
Date: Thu, 20 Jun 2013 00:42:18 +0200
Message-ID: <201306200042.19064.arnd@arndb.de>
References: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com> <1371677849-23912-3-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59035 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934961Ab3FSWmi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Jun 2013 18:42:38 -0400
In-Reply-To: <1371677849-23912-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>

On Wednesday 19 June 2013, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> A few differences needed by OCTEON:
> 
> o These are DWC UARTS, but have USR at a different offset.
> 
> o Internal SoC buses require reading back from registers to maintain
>   write ordering.
> 
> o 8250 on OCTEON appears with 64-bit wide registers, so when using
>   readb/writeb in big endian mode we have to adjust the membase to hit
>   the proper part of the register.
> 
> o No UCV register, so we hard code some properties.
> 
> Because OCTEON doesn't have a UCV register, I change where
> dw8250_setup_port(), which reads the UCV, is called by pushing it in
> to the OF and ACPI probe functions, and move unchanged
> dw8250_setup_port() earlier in the file.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
