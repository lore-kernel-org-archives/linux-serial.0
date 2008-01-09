From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: RE: Handling RTS
Date: Wed, 9 Jan 2008 15:35:43 -0500
Message-ID: <008101c852ff$36201730$a2604590$@com>
References: <OFAF597FC5.42D5FDAE-ONC12573CB.0060EF59-C12573CB.00648213@cemitec.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:4770 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbYAIVId (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jan 2008 16:08:33 -0500
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id m09Ka8rD096566
	for <linux-serial@vger.kernel.org>; Wed, 9 Jan 2008 15:36:08 -0500 (EST)
	(envelope-from cdore@connecttech.com)
Received: from cdore ([206.130.75.122]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id m09KZk023268 for <linux-serial@vger.kernel.org>; Wed, 9 Jan 2008 15:35:46 -0500 (EST)
In-Reply-To: <OFAF597FC5.42D5FDAE-ONC12573CB.0060EF59-C12573CB.00648213@cemitec.com>
Content-Language: en-ca
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> owner@vger.kernel.org] On Behalf Of JZabalza@cemitec.com
> Sent: January 9, 2008 1:18 PM
> 
> If there is not another way, which shall be the best strategy to implement
> this (activate RTS when uart is transmiting data and deactivate when
> transmision is finish. It would be another protocol different but similar
> to RTS/CTS protocol) on linux driver (modifying serial_core.c  to accept a
> new CFLAG?) ?

What UART are you using?  Some newer UARTs have built-in capabilities for
the RTS framing.  So instead of having to toggle RTS manually, you can flip
a bit and let the UART do it for you whenever it transmits...unless that
won't work for you.


.Chris


