From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug in USB FTDI SIO driver
Date: Sat, 8 Sep 2012 18:54:01 +0100
Message-ID: <20120908185401.5faa8c1f@pyramind.ukuu.org.uk>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
	<20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
	<20120908192037.20412mlnvfniwkmd@webmail.axiris.be>
	<20120908183015.2ca02043@pyramind.ukuu.org.uk>
	<20120908193516.11911xl64w1z7lxw@webmail.axiris.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49755 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab2IHRtO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 13:49:14 -0400
In-Reply-To: <20120908193516.11911xl64w1z7lxw@webmail.axiris.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: peter.sheeren@axiris.be
Cc: linux-serial@vger.kernel.org

On Sat, 08 Sep 2012 19:35:16 +0200
peter.sheeren@axiris.be wrote:

> 
> I'm sorry, I've no experience with compiling a driver for Linux.
> 
> Q: When I plug in the USB device without even using it, should  
> ftdi_sio and usbserial remain loaded after I unplug the USB device?

Thats up to your distribution.
