From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PL2303 Driver Issue
Date: Fri, 12 Oct 2012 23:30:14 +0100
Message-ID: <20121012233014.577566b5@pyramind.ukuu.org.uk>
References: <523E9909A6DFCF469669581BEB8DA7AA56928B25@G2W2441.americas.hpqcorp.net>
	<20121007144700.GA18178@kroah.com>
	<523E9909A6DFCF469669581BEB8DA7AA5692A2B7@G2W2441.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37571 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab2JLWZW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 18:25:22 -0400
In-Reply-To: <523E9909A6DFCF469669581BEB8DA7AA5692A2B7@G2W2441.americas.hpqcorp.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Reddy Kaveri, Praveen Kumar" <praveen-kumar.reddy-kaveri@hp.com>
Cc: Greg KH <greg@kroah.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, 12 Oct 2012 22:15:08 +0000
"Reddy Kaveri, Praveen Kumar" <praveen-kumar.reddy-kaveri@hp.com> wrote:

> Hi Greg,
> 
> Thanks for your assistance.
> 
> I am using RXTXComm API for getting list of serial ports and available USB ports. I have attached the java code for your kind glance.
> For some of the point of sales machines the telxon device is working. 

Make sure your Java implementation rxtxcomm isn't too stupid to look for
USB ports. There were endless problems with some old versions of rxtx with
JMRI and USB serial ports.

Also as the same user try  stty -a </dev/ttyUSB0. That will if it's
behaving sensibly dump the terminal state (speed etc) on your screen.

If that works you've almost certainly got a problem with your java.
