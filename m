From: David Lawyer <dave@lafn.org>
Subject: Re: PnP Rage.
Date: Sun, 23 Feb 2003 20:24:21 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030224042421.GB417@lafn.org>
References: <20030223104525.A206@lnx2.w8mch.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-21-85.rev.o1.com [66.81.21.85])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h1O6W79D059368
	for <linux-serial@vger.kernel.org>; Sun, 23 Feb 2003 22:32:07 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18nAA9-00007P-00
	for <linux-serial@vger.kernel.org>; Sun, 23 Feb 2003 20:24:21 -0800
Content-Disposition: inline
In-Reply-To: <20030223104525.A206@lnx2.w8mch.ampr.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Sun, Feb 23, 2003 at 10:45:25AM -0500, Hal MacArgle wrote:
> Greetings: Does anyone care that I LONG for the good old days of
> hardware with jumpers and silk screened instructions?
> 
> The "someone" who came up with PnP, eliminating ALL the problems we
> had with port addresses and IRQ's has done a number on us judging
> from the bazillion messages asking for help.. It seems to me the help
> messages before paled to what we have now, not to mention all the
> tools designed to help with the help.. Ugh.

PnP enables the user not to worry about setting jumpers, etc. provided
of course that the various drivers are able to recognize the myriad of
PnP devices and PnP configure them.  For MS Windows the device
manufacturer provide such a driver.  But they usually don't provide such
drivers for Linux.  So what is a boon to MS Windows becomes a bane for
Linux.  For devices used primarily on servers such as several digital
modems on a card, Linux drivers will likely be provided since Linux has
about 25% of the server market.  But for devices primarily used on
desktops, the manufacturer is unlikely to support Linux and then someone
else needs to hopefully write the driver.  This is a major problem for
Linux.

			David Lawyer
