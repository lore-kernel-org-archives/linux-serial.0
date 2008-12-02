From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] 8250: Don't clobber spinlocks.
Date: Tue, 2 Dec 2008 11:20:10 +0000
Message-ID: <20081202112010.6b25af1c@lxorguk.ukuu.org.uk>
References: <4934774E.6080805@caviumnetworks.com>
	<1228175368-5536-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60867 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754219AbYLBLUj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Dec 2008 06:20:39 -0500
In-Reply-To: <1228175368-5536-1-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

On Mon,  1 Dec 2008 15:49:25 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> In serial8250_isa_init_ports(), the port's lock is initialized.  We
> should not overwrite it.  In early_serial_setup(), only copy in the
> fields we need.  Since the early console code only uses a subset of
> the fields, these are sufficient.

> -	serial8250_ports[port->line].port.ops	= &serial8250_pops;

You seem to drop the assignment of port.ops ?
