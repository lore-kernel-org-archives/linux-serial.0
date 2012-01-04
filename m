From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: USB disconnect -> kernel panic
Date: Wed, 4 Jan 2012 23:26:59 +0000
Message-ID: <20120104232659.05da01ee@pyramind.ukuu.org.uk>
References: <87mxahk3d1.fsf@gag.com>
	<20120102182255.GC8562@xanatos>
	<20120103235847.GF21311@kroah.com>
	<87fwfwmaeo.fsf@gag.com>
	<20120104230149.GA16655@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43733 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2ADX0k (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2012 18:26:40 -0500
In-Reply-To: <20120104230149.GA16655@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Bdale Garbee <bdale@gag.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Oliver Neukum <oliver@neukum.name>, keithp@keithp.com, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

> Ok, can you try the patch below and let me know if it solves the problem
> or not?

If it does the right fix is to stop clearing tty->driver_data. If
tty->driver_data can go NULL outside of the final release then its
probably an exploitable hole.
