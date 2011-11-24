From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 01/16] pmac_zilog: fix unexpected irq
Date: Thu, 24 Nov 2011 15:28:38 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE1@saturn3.aculab.com>
References: <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
Sender: linux-m68k-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

 
> On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be 
> masked. This can be a problem when pmac_zilog starts up.

Wouldn't this also happen if the interrupt were shared?
Hopefully nothing vaguely modern uses the borked Zilog 8530 SCC
(which I presume is the part in question - brings back
too many nightmares....)

	David
