From: "Kevin Wilson" <Kevin.Wilson@comtrol.com>
Subject: multiport serial cards & pci express mainboards
Date: Wed, 22 Aug 2007 09:19:13 -0500
Message-ID: <B1F576FE19C55C43B8D2E31F061B50C04E5F79@exchange.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exchange.comtrol.com ([204.73.219.163]:54496 "EHLO
	Exchange.comtrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759388AbXHVOcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Aug 2007 10:32:25 -0400
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

In the past, when you added multiple pci serial cards to slots 0, 1, 2, 3 the lspci would show the cards in slot order with slot 0 closest to the center edge of the mainboard. Also, in serial drivers, you could iterate through your pci device collection and simply know that the first pci serial device was in slot 0, etc. In other words, you could always identify the physical location of a card from code via the order depicted in lspci. With the introduction of PCI Express lspci no longer shows cards in an order that correlates to the card's physical location on the mainboard. Does anyone have any knowledge or insight as to why this is since pci express was supposed to be a transparent implementation?

Thanks,

Kevin 
