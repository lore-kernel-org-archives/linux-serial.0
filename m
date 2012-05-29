From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] serial/8250: Add LPC3220 standard UART type
Date: Tue, 29 May 2012 15:39:44 +0000
Message-ID: <201205291539.44705.arnd@arndb.de>
References: <1338282570-19799-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62691 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab2E2PlR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 May 2012 11:41:17 -0400
In-Reply-To: <1338282570-19799-1-git-send-email-stigge@antcom.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk

On Tuesday 29 May 2012, Roland Stigge wrote:
> 
> LPC32xx has "Standard" UARTs that are actually 16550A compatible but have
> bigger FIFOs. Since the already supported 16X50 line still doesn't match here,
> we agreed on adding a new type.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
