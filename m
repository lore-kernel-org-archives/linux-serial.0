From: Thomas Koeller <thomas@koeller.dyndns.org>
Subject: Re: RM9000 code broken in 8250.c
Date: Tue, 26 Feb 2008 01:59:08 +0100
Message-ID: <200802260159.09182.thomas@koeller.dyndns.org>
References: <200712211250.18002.thomas@koeller.dyndns.org> <200802171347.03312.thomas@koeller.dyndns.org> <1203530165.6754.11.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx01.hansenet.de ([213.191.73.25]:48936 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753249AbYBZA5y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Feb 2008 19:57:54 -0500
In-Reply-To: <1203530165.6754.11.camel@lappy>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

On Mittwoch, 20. Februar 2008, Alex Williamson wrote:
>
>    The key is that I'm looking at the 2nd IIR read and expecting NO_INT.
> My UART passes the TXEN bug test, so the first interrupt is generated
> correctly.  Does this patch help at all?

The patch seems to be good. After applying it, my UART passes the
modified test. I never tried enabling the interrupt twice, as your
modified test does, and was not aware that in this case my hardware
would raise an interrupt. How did you know? Can we be sure that possible
other UARTS affected by UART_BUG_TXEN will also do this?

thanks,
Thomas


-- 
Thomas Koeller
thomas@koeller.dyndns.org
