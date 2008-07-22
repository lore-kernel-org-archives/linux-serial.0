From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fix oops in the 8250 serial driver when accessing a
 removed device
Date: Tue, 22 Jul 2008 16:54:08 +0100
Message-ID: <20080722165408.38a75a57@lxorguk.ukuu.org.uk>
References: <200807221737.06224.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35088 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751234AbYGVQLd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jul 2008 12:11:33 -0400
In-Reply-To: <200807221737.06224.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org

> When a plug-and-play 8250 device is detected, the driver reuses one of the
> dummy ports. If that device is later removed, the port goes pack to the dummy
> ports pool. The capabilities field is not reset, which causes a oops when
> trying to access the port.

Some day we need to allocate new dummy ports so there is always one free.

> This patch resets the capabilities field when a 8250 device is unregistered.

Looks good to me. Would appreciate Russell's view though.

Alan
