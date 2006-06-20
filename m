From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Tue, 20 Jun 2006 08:50:04 +0100 (BST)
Message-ID: <20060620075004.85981.qmail@web52906.mail.yahoo.com>
References: <20060620010011.GA25527@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web52906.mail.yahoo.com ([206.190.49.16]:15225 "HELO
	web52906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965143AbWFTHuG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jun 2006 03:50:06 -0400
In-Reply-To: <20060620010011.GA25527@neo.rr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

--- Adam Belay <ambx1@neo.rr.com> wrote:
> Yes, if a driver is available for the device, it will enable it regardless of
> the initial state.  Most manual BIOS configuration options don't actually
> disable the device in the commonly understood sense.  Rather, they tell the
> BIOS not to waste any time configuring the device, as the operating system
> is fully capable of doing so.  On operating systems that aren't PnP capable
> these options might have a greater effect.

OK, but I really do need that IRQ for the network card, and don't need that serial device on the
motherboard. So how can I tell Linux not to activate it, please?

Thanks,
Chris



	
	
		
___________________________________________________________ 
All new Yahoo! Mail "The new Interface is stunning in its simplicity and ease of use." - PC Magazine 
http://uk.docs.yahoo.com/nowyoucan.html
