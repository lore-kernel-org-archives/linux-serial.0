From: "Dale Whitchurch" <DaleW@sealevel.com>
Subject: 9-bit Protocol
Date: Tue, 4 May 2004 08:05:44 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <B39AA5DB06510C4591C6EDDD580B0B816133F2@mail.int.sealevel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sealevel.com ([206.74.63.254]:11452 "EHLO mail.sealevel.com")
	by vger.kernel.org with ESMTP id S264316AbUEDMC2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 May 2004 08:02:28 -0400
Content-Class: urn:content-classes:message
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello all,

Just out of curiosity, has anyone ever seen an implementation for the nine-bit data protocol for async UARTs?  I know the Oxford 950 UART supports nine-bit and I am wondering if a driver has been developed to utilize that.  Specifically, the protocol is where the ninth bit signifies whether the byte is an address byte or a data byte.  I have seen different implementations of this, including storing the ninth bytes in a separate buffer, or identifying the bytes individually, but these have only been in other operating systems.

Thanks!

DaleW
