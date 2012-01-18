From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Wed, 18 Jan 2012 22:12:55 +0000
Message-ID: <20120118221255.5c14f382@pyramind.ukuu.org.uk>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
	<1326826563-32215-3-git-send-email-sjg@chromium.org>
	<20120117201036.6d99f98f@pyramind.ukuu.org.uk>
	<20120118041720.GA2431@linux.vnet.ibm.com>
	<CAPnjgZ1GJatR15dVsq-+hAWhD7eaLhtN737QvBaor_=0+K+6wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53170 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260Ab2ARWMX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 17:12:23 -0500
In-Reply-To: <CAPnjgZ1GJatR15dVsq-+hAWhD7eaLhtN737QvBaor_=0+K+6wA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: paulmck@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

> Let me provide a bit of context. The serial_core code seems to be the
> only place in the kernel that does this:
> 
> 		device_init_wakeup(tty_dev, 1);
> 		device_set_wakeup_enable(tty_dev, 0);
> 
> The first call makes the device wakeup capable and enables wakeup, The
> second call disabled wakeup.

> I assume we can't and shouldn't change device_init_wakeup() . We could
> add a call like device_init_wakeup_disabled() which makes the device
> wakeup capable but does not actually enable it. Does that work?

Is that not

	device_init_wakeup(tty_dev, 0)

or am I missing something ?
