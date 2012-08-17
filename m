From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCHv3 1/1] [RFC] uartclk from serial_core exposed to sysfs
Date: Fri, 17 Aug 2012 16:07:28 +0100
Message-ID: <20120817160728.3207637a@bob.linux.org.uk>
References: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
	<1345214637-4189-1-git-send-email-tmshlvck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46852 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359Ab2HQOt7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Aug 2012 10:49:59 -0400
In-Reply-To: <1345214637-4189-1-git-send-email-tmshlvck@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, marek.vasut@gmail.com

On Fri, 17 Aug 2012 16:43:57 +0200
Tomas Hlavacek <tmshlvck@gmail.com> wrote:

> Added file /sys/devices/.../tty/ttySX/uartclk to allow reading
> uartclk value in struct uart_port in serial_core via sysfs.
> 
> It simplifies initialization verification of no-name cards that
> have non-standard oscillator speed while having no distinguishing
> PCI IDs to allow autodetection.
> 
> Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>
