From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:01:38 -0400
Message-ID: <043201c6c857$5ddd6c20$294b82ce@stuartm>
References: <1156441293.3007.184.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smarthost1.sentex.ca ([64.7.153.18]:25569 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S964826AbWHYPCD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Aug 2006 11:02:03 -0400
In-Reply-To: <1156441293.3007.184.camel@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, 'Krzysztof Halasa' <khc@pm.waw.pl>
Cc: 'David Woodhouse' <dwmw2@infradead.org>, linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>

From: On Behalf Of Alan Cox
> At this point I think we need
> 
> -	An ioctl to set/get the actual baud rate input/output
> -	Some kind of termios flag to indicate they are being 
> used (as we have
> CBAUDEX now). [We could "borrow" the 4Mbit one and dual use it IMHO]
> 
> For drivers tty_get_baud_rate would return the actual speed as before.
> 
> We would need a driver ->set_speed method for the cases where
> - ioctl is called to set specific board rate
> - OR termios values for tty speed change
> - While we are at it we might want to make ->set_termios also 
> allowed to fail
> 
> [and if you had no ->set_speed method non standard speeds would be
> refused by the tty layer for back compat]
> 
> Anyone got any problems with this before I go and implement it ?

Sounds good.

..Stu

