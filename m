From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: serial flow control appears broken
Date: Mon, 30 Jul 2007 10:36:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0707301035060.12082@blysk.ds.pg.gda.pl>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no> <46A84B4A.6070902@shaw.ca>
 <46A8C6F1.4080309@howardsilvan.com> <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl>
 <46AA2748.80703@howardsilvan.com> <Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl>
 <46AA355E.20901@howardsilvan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1682 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965929AbXG3JgF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Jul 2007 05:36:05 -0400
In-Reply-To: <46AA355E.20901@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

On Fri, 27 Jul 2007, Lee Howard wrote:

> >The serial drivers have nothing to do about it -- all they can do is pushing
> >data upstream, to the discipline driver.  They can provide an interface to
> >hardware flow control features though, if implemented by a given UART.
> >
> 
> Thank you for this clarification.  So I should have more correctly been saying
> that "tty flow control appears broken".  Right?

 Probably.  It might be, as Alan suggested, that it is meant to work, but 
the latency kills it.

  Maciej
