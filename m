From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Add Cavium OCTEON UART definitions.
Date: Tue, 7 Oct 2008 11:29:32 +0100
Message-ID: <20081007112932.165fce27@lxorguk.ukuu.org.uk>
References: <48EAAF97.8050307@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59483 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbYJGK3g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Oct 2008 06:29:36 -0400
In-Reply-To: <48EAAF97.8050307@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, "Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>

> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
> +	/* UPF_FIXED_PORT indicates an internal UART.  */
> +	if (up->port.flags & UPF_FIXED_PORT)
> +		up->port.type = PORT_OCTEON;
> +	else
> +#endif

Not nice. Please keep CPU specific ifdefs out of the 8250 core code. Can
you not set a port flag for UPF_BROKEN_OCTEON or similar to clean that up
and also make the other tests that need things doing (eg the always
calling IRQ code use port flags of a more generic nature ?)
