From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] serial: 8250pci: Recast inb return value
Date: Tue, 17 Aug 2010 11:04:35 +0100
Message-ID: <20100817110435.45e6ed8b@lxorguk.ukuu.org.uk>
References: <1282031947-16483-1-git-send-email-monstr@monstr.eu>
	<1282031947-16483-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55352 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756784Ab0HQJtw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Aug 2010 05:49:52 -0400
In-Reply-To: <1282031947-16483-2-git-send-email-monstr@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Lennert Buytenhek <buytenh@wantstofly.org>, Lytochkin Boris <lytboris@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 17 Aug 2010 09:59:07 +0200
Michal Simek <monstr@monstr.eu> wrote:

> inb returns u8 that's why is necessary to do recast.

ret is an int, inb returns a u8, neither are pointers and the cast
required is implict and defined by the spec.


> drivers/serial/8250_pci.c: In function 'pci_ite887x_init':
> drivers/serial/8250_pci.c:825: warning: cast to pointer from integer of different size
