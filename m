From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Rename Sibyte duart devices?
Date: Mon, 3 Dec 2007 14:30:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0712031430050.19235@blysk.ds.pg.gda.pl>
References: <20071203130818.GA6466@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:35749 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbXLCOa7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Dec 2007 09:30:59 -0500
In-Reply-To: <20071203130818.GA6466@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org

On Mon, 3 Dec 2007, Ralf Baechle wrote:

> Devices created by udev have been named duart? instead of the common
> ttyS?.  This is a nuisance because it requires changes to all sorts of
> config files such as /etc/inittab, /etc/securetty etc. to work.  I
> suggest to kill the problem by the root by something like the below
> patch.  Comments?

 Well, there is no problem with naming your device nodes in the filesystem
however you like and the only place that only cares is the "console="
command line option.  I think the root is ttyS devices should really be
only used for 8250-based devices and if you plug a standard PC serial
option card into one of the PCI slots, then all the hell will break loose.
I might be wrong though and the issue I am referring to may have gone now.

 [Sent twice to reach linux-serial.]

  Maciej
