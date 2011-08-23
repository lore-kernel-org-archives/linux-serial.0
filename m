From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] atmel_serial: RS485: receiving enabled when sending
 data
Date: Tue, 23 Aug 2011 11:14:38 +0100
Message-ID: <20110823111438.5d6b286d@lxorguk.ukuu.org.uk>
References: <4E492CFF.7040905@pwrnet.de>
	<20110822211832.GA8023@kroah.com>
	<4E536536.3030004@evidence.eu.com>
	<20110823093035.GB19622@n2100.arm.linux.org.uk>
	<4E537BB3.60001@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E537BB3.60001@evidence.eu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bernhard Roth <br@pwrnet.de>
List-Id: linux-serial@vger.kernel.org

> atmel_serial: RS485: receiving enabled when sending data
> 
> By default the atmel_serial driver in RS485 mode disables receiving data until
> all data in the send buffer has been sent. This flag allows to receive data
> even whilst sending data.
> 
> Signed-off-by: Bernhard Roth <br@pwrnet.de> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>

Acked-by: Alan Cox <alan@linux.intel.com>

(although when we have people having a serious meta discussion about four
 spaces, or a tab or neither rather than functionality I despair)

This is sensible functionality and relevant to various interfaces so
makes sense.
