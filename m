From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] serial base baud misdetected in 2.6.27
Date: Tue, 4 Nov 2008 20:36:43 +0000
Message-ID: <20081104203643.77cdfa6c@lxorguk.ukuu.org.uk>
References: <4910936D.4030605@nortel.com>
	<20081104192253.151d6ef3@lxorguk.ukuu.org.uk>
	<4910B0AD.3020802@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57159 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753698AbYKDUgl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 15:36:41 -0500
In-Reply-To: <4910B0AD.3020802@nortel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> like it's hanging off the PCI bus.  The vendor/device matches to an Exar 
> Corp. XR17C152, which is given a base_baud of 921600 in 
> drivers/serial/8250_pci.c.
> 
> According to the chip specs, 921600 is correct with the default crystal 
> and control register values.  However, other crystals can be used and 
> there's also a control register bit to enable a prescalar which cuts the 
> baud rate by a factor of four.  I suspect that one of these has been 
> done on our boards.

Probably. Did your vendor have the sense to set subvendor/subdevice
identifiers that can be used to identify that specific unit ?

