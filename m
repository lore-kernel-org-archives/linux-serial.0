From: "Paul Chiha" <paul.chiha@greyinnovation.com>
Subject: OMAP2+:UART driver help
Date: Mon, 17 Oct 2011 15:48:21 +1100
Message-ID: <51A4F524D105AA4C93787F33E2C90E62EE59C2@greysvr02.GreyInnovation.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eth1683.vic.adsl.internode.on.net ([150.101.217.146]:50241 "EHLO
	greyinnovation.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752349Ab1JQFCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Oct 2011 01:02:37 -0400
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm a newbie and would like some help with serial drivers in the kernel.

I've got an OMAP35x EVM (with UARTs 1/2-3 on board), and I would like to
write
my own driver which uses UART 3.  I'm not sure of the best way to do
this.
I don't know how to use the existing ttyO2 device and omap-serial driver
for my
own purpose.  Basically I want to write a driver which sits between the
application and the omap-serial driver, but only for UART 3.  Is there a
simple
mechanism to do this, or do I need to replace omap_serial with my own?
Also,
is there an existing driver that does something similar to what I want
that I
can base my driver on?

Paul
