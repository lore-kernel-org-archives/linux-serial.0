From: David Lawyer <dave@lafn.org>
Subject: Re: Saving data from the serial port
Date: Fri, 18 Apr 2003 23:39:39 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030419063939.GA393@lafn.org>
References: <11E89240C407D311958800A0C9ACF7D1A33E47@EXCHANGE> <20030418000627.GB442@lafn.org> <015801c305f6$2eebb9c0$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zoon.lafn.org ([206.117.18.9]:22286 "EHLO zoon.lafn.org")
	by vger.kernel.org with ESMTP id S263358AbTDSG1m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 19 Apr 2003 02:27:42 -0400
Received: from davespc1 (mail@host-66-81-182-210.rev.o1.com [66.81.182.210])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h3J6ddtO047000
	for <linux-serial@vger.kernel.org>; Fri, 18 Apr 2003 23:39:40 -0700 (PDT)
	(envelope-from dave@lafn.org)
Received: from dave by davespc1 with local (Exim 3.36 #1 (Debian))
	id 196m0i-00007a-00
	for <linux-serial@vger.kernel.org>; Fri, 18 Apr 2003 23:39:40 -0700
Content-Disposition: inline
In-Reply-To: <015801c305f6$2eebb9c0$294b82ce@connecttech.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Fri, Apr 18, 2003 at 06:02:19PM -0400, Stuart MacDonald wrote:
> From: "David Lawyer" <dave@lafn.org>
> > I don't think so (but of course you should use flow control).  There
> > just isn't any way to use flow control to protect the FIFO buffers from
> > overruns in Linux.  Flow control (for the input flow into a PC) only
> > protects the serial 8K buffer in main memory.
> 
> Not true. Many modern uarts have on-board flow control both hardware
> and software based. Turn it on and the hardware does the magic when it
> finds its fifos getting full.

Does the Linux serial driver support this?  I didn't think that it did.
			David Lawyer

> The caveat is that the remote side needs to support the same method of
> flow control obviously.

