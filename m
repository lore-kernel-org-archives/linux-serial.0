From: "Tobias Arp" <tobiasarp@gmx.de>
Subject: Re: ST16C654 stoppes transmitting after a while
Date: Tue, 17 Jul 2012 12:05:21 +0200
Message-ID: <20120717100521.219440@gmx.net>
References: <20120717074355.80180@gmx.net>
 <20120717105229.17b578a5@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:43741 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752421Ab2GQKM0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jul 2012 06:12:26 -0400
In-Reply-To: <20120717105229.17b578a5@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

I run kernel 3.2. Upgrading to a newer kernel would be not se easy at the moment.

I am not sure how to check if this change is really lost.

-------- Original-Nachricht --------
> Datum: Tue, 17 Jul 2012 10:52:29 +0100
> Von: Alan Cox <alan@lxorguk.ukuu.org.uk>
> An: "Tobias Arp" <tobiasarp@gmx.de>
> CC: linux-serial@vger.kernel.org
> Betreff: Re: ST16C654 stoppes transmitting after a while

> > I found out that the hw_stopped flag is set to 1 but not set to 0 again
> although CTS is set (measuring with the oscilloscope and reading out the
> modem status register are confirming this / i modified the
> serial8250_get_mctrl function to print out these values).
> > 
> > It seems to me that an CTS change (UART_MSR_DCTS) is lost.
> > Could this cause this behaviour?
> 
> Possibly you'd need to instrument your kernel as well to prove it. It
> could also be a race in the kernel drivers somewhere. We certainly had
> those in old kernels here and there.
>  
> > Any suggestions for a workaround are appreciated.
> 
> What kernel are you running ?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
