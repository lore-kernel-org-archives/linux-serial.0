From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2] serial: 8250: Initialize pointer to irq_info
Date: Tue, 17 Aug 2010 09:17:20 +0100
Message-ID: <20100817091720.56183993@linux.intel.com>
References: <1282031947-16483-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2321 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756486Ab0HQIzE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Aug 2010 04:55:04 -0400
In-Reply-To: <1282031947-16483-1-git-send-email-monstr@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: michal.simek@petalogix.com, Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 17 Aug 2010 09:59:06 +0200
Michal Simek <monstr@monstr.eu> wrote:

> Initialize "i" irq_info pointer in serial_unlink_irq_chain.
> 
> Compilation warning:
>   CC      drivers/serial/8250.o
> drivers/serial/8250.c: In function 'serial8250_shutdown':
> drivers/serial/8250.c:1701: warning: 'i' may be used uninitialized in
> this function

NAK (again)

Use a newer compiler - modern ones get this right.
