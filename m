From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 23/26] Serial: UART driver changes for Cavium OCTEON.
Date: Thu, 20 Nov 2008 20:06:30 +0000
Message-ID: <20081120200630.33111a2f@lxorguk.ukuu.org.uk>
References: <49233FDE.3010404@caviumnetworks.com>
	<1227047057-4911-5-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53102 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753458AbYKTUGZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2008 15:06:25 -0500
In-Reply-To: <1227047057-4911-5-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

> +		if ((up->bugs & UART_BUG_OCTEON_IIR) && (iir & 0xf) == 7) {
> +			/* Busy interrupt */
> +			serial_in(up, UART_OCTEON_USR);
> +			iir = serial_in(up, UART_IIR);
> +		}

Could this not be hidden in the register read method for the octeon and
thus kept out of core code ?
