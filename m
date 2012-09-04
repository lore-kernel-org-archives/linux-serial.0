From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] parport_serial: Add support for the WCH353 2S/1P
 multi-IO card
Date: Tue, 4 Sep 2012 15:37:36 +0100
Message-ID: <20120904153736.3f64bddb@pyramind.ukuu.org.uk>
References: <20120904144416.25377.7952.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43153 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757011Ab2IDOdA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Sep 2012 10:33:00 -0400
In-Reply-To: <20120904144416.25377.7952.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, greg@kroah.com

On Tue, 04 Sep 2012 15:44:24 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> From: Guainluca Anzolin <gianluca@sottospazio.it>
> 
> To allow parport_serial to handle the card the same PCI ids are blacklisted
> in 8250_pci.c using the existing software blacklist mechanism.

Doh ignore that one... I need to fold another fix in first
