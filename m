From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 12:32:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no> <46A84B4A.6070902@shaw.ca>
 <46A8C6F1.4080309@howardsilvan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4359 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936926AbXG0Lc6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 07:32:58 -0400
In-Reply-To: <46A8C6F1.4080309@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

On Thu, 26 Jul 2007, Lee Howard wrote:

> If the application were to use TIOCM_RTS how would it know when to apply it or
> not?  Is there some approach that the application could take to manage flow
> control on the serial port?  What about software flow control?  Does the

 Well, an application could negate RTS when it receives a character and 
is running out of resources for further processing of incoming data.

 Smarter UARTs may be able to negate RTS themselves based on the amount of 
data in their receive FIFO.  The threshold may be configurable.

  Maciej
