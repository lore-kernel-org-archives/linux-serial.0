From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Support specifying DW APB UARTSs in device
 platform_data
Date: Thu, 20 Dec 2007 21:39:19 +0000
Message-ID: <20071220213919.79ff17f1@the-village.bc.nu>
References: <87a5b0800712200648o7cc48af9ic38d7d568affdbc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52677 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752656AbXLTVqd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Dec 2007 16:46:33 -0500
In-Reply-To: <87a5b0800712200648o7cc48af9ic38d7d568affdbc8@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, 20 Dec 2007 14:48:45 +0000
"Will Newton" <will.newton@gmail.com> wrote:

> This patch allows the private_data field to be specified in
> platform_data for the standard 8250/16550 UART. This field is used by
> DW APB type UARTs and without this patch it's only possible to set
> this field when registering the port by hand. If private_data is not
> set then the
> driver will potentially oops with a NULL pointer dereference.


Fine by me. 

Alan
