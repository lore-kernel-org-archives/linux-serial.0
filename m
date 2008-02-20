From: "Kevin Wilson" <Kevin.Wilson@comtrol.com>
Subject: serial driver code port question
Date: Wed, 20 Feb 2008 07:32:14 -0600
Message-ID: <B1F576FE19C55C43B8D2E31F061B50C0C4BBE4@exchange.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exchange.comtrol.com ([204.73.219.163]:46233 "EHLO
	Exchange.comtrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbYBTNcP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Feb 2008 08:32:15 -0500
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

In 2.6 the name and slot_name structure members were removed from pci_dev. I know they replaced slot_name with the function call to pci_name() but what did they do for getting the info that was once stored in the name[90] buffer?

Thanks a bunch.

Kevin
