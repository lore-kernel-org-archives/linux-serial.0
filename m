From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Hardware flowcontrol on XR17D154
Date: Tue, 30 Aug 2011 13:32:21 +0100
Message-ID: <20110830133221.304b27f0@lxorguk.ukuu.org.uk>
References: <201108301217.07468.sgh@sgh.dk>
	<20110830113433.618b2486@lxorguk.ukuu.org.uk>
	<201108301327.04542.sgh@sgh.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33268 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751658Ab1H3MdY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2011 08:33:24 -0400
In-Reply-To: <201108301327.04542.sgh@sgh.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?U8O4cmVu?= holm <sgh@sgh.dk>
Cc: linux-serial@vger.kernel.org

> My particular uart resports (status1 == 6 && status2 == 6). If that is good 
> enough I can add another porttype and add the correct register address as 
> UART_EXAR_EFR in the header file.

Try it and see. We can put it in -next for a while and then there will a
release cycle duriing which any unfortunate clashes wil get resolved.

Alternatively if it's a device attached to a specific platform create it
as a platform device of some kind in the board specific code and pick
that up in the serial driver.

> Another thought could be to write 0xFF (or some other value) to the correct 
> EFR-register and read that byte to test if the register is present. The 
> problem here is that I do not how the bus reacts to writting/reading invalid 
> addresses.

The trouble is an extra register may in fact be part of some other device
- it's generally not a great idea if there are other choices.

Alan
