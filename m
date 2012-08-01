From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: n_gsm issues
Date: Wed, 1 Aug 2012 22:23:22 +0100
Message-ID: <20120801222322.345d0bc2@pyramind.ukuu.org.uk>
References: <440_1343835403_50194D0B_440_1588_1_OF108ABE84.7A08D19F-ONC1257A4D.00556998-C1257A4D.0055C11D@sagemcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56901 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab2HAVTb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Aug 2012 17:19:31 -0400
In-Reply-To: <440_1343835403_50194D0B_440_1588_1_OF108ABE84.7A08D19F-ONC1257A4D.00556998-C1257A4D.0055C11D@sagemcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guillaume JUAN <guillaume.juan@sagemcom.com>
Cc: linux-serial@vger.kernel.org

> Who can I contact to discuss issues / submit fixes ?

This list and me more specifically.

> - When a virtual tty is closed from user-space, the operation is not fully
> synchronous: DISC requests can be sent on the DLCI after the system call
> has returned.
> This is because gsmtty_close does not wait for event DLCI_CLOSED after
> calling gsm_dlci_begin_close.

That one is intentional.

> - On line discipline attach, n_gsm use default settings that have no chance
> to match what I set in the modem
> and when I do the TIOCSETCONF ioctl to configure it correctly, this
> previous settings cause it to call gsm_cleanup_mux(), leading to delays and
> useless commands to the modem (that won't be answered).

We start in passive mode to tyr and avoid useless commands but could
certainly be improved.

> - The CLD command encoding is not strictly compliant with 3GPP 27.010
> The TLV built does not have any L byte, whereas it should have one
> indicating a zero length for the value field.
> The modem I use accept this variant but some may not.

What kernel verison is this ?

> This issue is the most disturbing for me, as I consequently can see no way
> to end mux session in a fully satisfying way.

Probably we need to split 'ldisc close' and 'ending a mux'

(eg have an ioctl for 'mux shutdown')

Alan
