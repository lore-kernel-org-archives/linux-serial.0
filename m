From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] serial: add support for the cell network processor
 NWP device
Date: Wed, 07 Jan 2009 14:08:14 +1100
Message-ID: <1231297694.14860.55.camel@pasglop>
References: <200811241453.32166.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50164 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbZAGDKm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Jan 2009 22:10:42 -0500
In-Reply-To: <200811241453.32166.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, Benjamin Krill <ben@codiert.org>, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>

On Mon, 2008-11-24 at 14:53 +0100, Arnd Bergmann wrote:
> From: Benjamin Krill <ben@codiert.org>
> 
> Add support for the nwp serial device which is connected to a DCR bus. It
> uses the of_serial device driver to determine necessary properties from
> the device tree.  The supported device is added as serial port number 84.
> 
> NWP stands for network processor and it is part of the QPACE - Quantum
> Chromodynamics Parallel Computing on the Cell Broadband Engine project.
> The implementation is a lightweight uart implementation with the focus
> to consume as little resources as possible and it is connected to a
> DCR bus.
> 
> Signed-off-by: Benjamin Krill <ben@codiert.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

There have been no comment nor objection about this patch.

Andrew, do we have a serial maintainer or should I merge it via the
powerpc tree ?

Cheers,
Ben.


