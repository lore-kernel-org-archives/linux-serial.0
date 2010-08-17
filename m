From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] serial: 8250pci: Recast inb return value
Date: Tue, 17 Aug 2010 09:21:20 +0100
Message-ID: <20100817092120.79b87813@linux.intel.com>
References: <1282031947-16483-1-git-send-email-monstr@monstr.eu>
	<1282031947-16483-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7103 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756649Ab0HQI65 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Aug 2010 04:58:57 -0400
In-Reply-To: <1282031947-16483-2-git-send-email-monstr@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: michal.simek@petalogix.com, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Lennert Buytenhek <buytenh@wantstofly.org>, Lytochkin Boris <lytboris@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 17 Aug 2010 09:59:07 +0200
Michal Simek <monstr@monstr.eu> wrote:

> inb returns u8 that's why is necessary to do recast.
> 
> Compilation warning:
>   CC      drivers/serial/8250_pci.o
> drivers/serial/8250_pci.c: In function 'pci_ite887x_init':
> drivers/serial/8250_pci.c:825: warning: cast to pointer from integer

NAK - this makes no sense at all
