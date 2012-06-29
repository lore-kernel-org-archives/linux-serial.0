From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: artpec.c / serial_core.c hardware flow control problem
Date: Fri, 29 Jun 2012 17:31:26 +0100
Message-ID: <20120629173126.162d1bbf@pyramind.ukuu.org.uk>
References: <4FEC7857.6010006@axis.com>
	<20120628172421.4cb91ada@pyramind.ukuu.org.uk>
	<4BEA3FF3CAA35E408EA55C7BE2E61D055C79D9B622@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44456 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2F2Q1X (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Jun 2012 12:27:23 -0400
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D055C79D9B622@xmail3.se.axis.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Adolfsson <johan.adolfsson@axis.com>
Cc: Mikael Lars Johansson <mikaeljo@axis.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, Johan Adolfsson <johana@axis.com>

> Do you mean the entire if () { return; } statement or just the RELEVANT_IFLAG part?

It's not enough to check the iflag in this case - a termios changing
c_cc[VSTOP) - which is what STOP_CHAR(tty) is, also might need
the stop handling reprogramming.

Alan

