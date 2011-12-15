From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] atmel_serial: fix spinlock lockup in RS485 code
Date: Thu, 15 Dec 2011 10:22:30 +0000
Message-ID: <20111215102230.70ca7011@bob.linux.org.uk>
References: <4EE9B42F.50004@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52992 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab1LOKKu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Dec 2011 05:10:50 -0500
In-Reply-To: <4EE9B42F.50004@evidence.eu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Dave Bender <codehero@gmail.com>

On Thu, 15 Dec 2011 09:47:43 +0100
Claudio Scordino <claudio@evidence.eu.com> wrote:

> Subject: atmel_serial: fix spinlock lockup in RS485 code
> 
> Patch to fix a spinlock lockup in the driver that sometimes happens
> when the tasklet starts.
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> Signed-off-by: Dave Bender <codehero@gmail.com>
> Tested-by: Dave Bender <codehero@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>
