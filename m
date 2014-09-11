From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] tty: Always allow tcflow(TCOON) to unwedge terminal
Date: Thu, 11 Sep 2014 11:19:30 +0100
Message-ID: <20140911111930.7227abbf@alan.etchedpixels.co.uk>
References: <1410384499-4982-1-git-send-email-peter@hurleysoftware.com>
	<20140911000343.GA5328@kroah.com>
	<5410E8A2.5030802@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:41888 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbaIKKTo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 06:19:44 -0400
In-Reply-To: <5410E8A2.5030802@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> It's not common knowledge (and its certainly counterintuitive) that
> turning off output when output is already turned off (ie., tcflow(TCOOFF))
> is the required trickery to unwedge a terminal.
> 
> Unwedging directly seems the straightforward approach.

Putting the off/on in the man page might be safer still ?
