From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 15:51:06 -0400
Message-ID: <1367005866.3971.15.camel@thor.lan>
References: <51781A19.5030707@compro.net>
	  <1366926071.3452.17.camel@thor.lan> <517A79E1.8060504@compro.net>
	  <1366983913.3452.33.camel@thor.lan> <517A8EF1.8040006@compro.net>
	 <1366994272.689.4.camel@thor.lan> <517AC4C2.3010702@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:34728 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab3DZTvK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 15:51:10 -0400
In-Reply-To: <517AC4C2.3010702@compro.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: markh@compro.net
Cc: linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On Fri, 2013-04-26 at 14:17 -0400, Mark Hounschell wrote:
> On 04/26/2013 12:37 PM, Peter Hurley wrote:
> > These drivers weren't really current at 3.4 though, either. I'm not sure
> > what else you're going to find that doesn't work.
> >
> 
> No, I have kept them current, or I should say functional, to the best of 
> my ability from 2.6 up to and including 3.4.x.

By 'current', I mean 'similar in structure and functionality to in-tree
drivers'.

The structure of this driver is more akin to a 2.5 driver (back when
there were separate serial and callout tty drivers).

>  What I have here works 
> with kernels up to 3.4.x. I have not tried anything between 3.4 and 3.8. 
>   As far as building against 3.8, the only issues were the change from 
> *termios to termios and the "structn_tty_data" no longer in an include 
> file so not easily directly accessible.

What is this driver accessing in N_TTY's private data?

> > For both PCI and PCI-e, these drivers should _at a minimum_ be pci
> > drivers that register the tty driver at module init and register _only_
> > the tty devices for that particular PCI device at PCI probe time. Look
> > at the end of synclink_gt.c for how this is supposed to look.
> >
> 
> I'll look at it some more but I have been there.

Specifically, review:
	struct pci_driver
	device_init()
	init_one()
	remove_one()
	sglt_init()
	sglt_exit()

Regards,
Peter Hurley

