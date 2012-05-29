From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial/8250: Add LPC3220 standard UART type
Date: Tue, 29 May 2012 11:04:56 +0100
Message-ID: <20120529110456.1faf85ad@pyramind.ukuu.org.uk>
References: <1338282570-19799-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35626 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab2E2KCe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 May 2012 06:02:34 -0400
In-Reply-To: <1338282570-19799-1-git-send-email-stigge@antcom.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, linux@arm.linux.org.uk

On Tue, 29 May 2012 11:09:29 +0200
Roland Stigge <stigge@antcom.de> wrote:

> LPC32xx has "Standard" UARTs that are actually 16550A compatible but have
> bigger FIFOs. Since the already supported 16X50 line still doesn't match here,
> we agreed on adding a new type.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Alan Cox <alan@linux.intel.com>
