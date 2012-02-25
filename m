From: Greg KH <greg@kroah.com>
Subject: Re: USB Smart Card reader
Date: Sat, 25 Feb 2012 08:41:18 -0800
Message-ID: <20120225164118.GA21495@kroah.com>
References: <CAAMvbhFzJv4EpQt4LavFeFusJsCDrFQ1EGhCdvgPG9q63s2AyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34517 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756859Ab2BYQot (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Feb 2012 11:44:49 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 01685209C3
	for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2012 11:44:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAAMvbhFzJv4EpQt4LavFeFusJsCDrFQ1EGhCdvgPG9q63s2AyA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: linux-serial@vger.kernel.org

On Sat, Feb 25, 2012 at 10:01:17AM +0000, James Courtier-Dutton wrote:
> Hi,
> 
> I have done some development work on the iuu_phoenix.c driver in the
> Linux kernel.
> The iuu_phoenix is a smart card reader.
> The smart card reader can be given a unique identification string of
> 16 characters/hex bytes. This ID can be read when the card reader is
> inserted into the USB port.
> I would like to be able to set up device names in /dev so that when
> inserting a card reader into the USB port, it always will appear with
> the same unique name in /dev.
> Similar to the by-uuid used for hard disk drives.

Your distro should already have /dev/serial/ which provides this for you
automatically.  Have you used that and found it somehow lacking?

greg k-h
