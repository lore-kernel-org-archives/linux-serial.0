From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] fix error management in 8250_pci.c pciserial_resume_one
Date: Tue, 13 Feb 2007 11:18:03 +0000
Message-ID: <20070213111803.34292562@localhost.localdomain>
References: <20070213113010.27125d53@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36068 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751278AbXBMLES (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Feb 2007 06:04:18 -0500
In-Reply-To: <20070213113010.27125d53@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stefano Brivio <stefano.brivio@polimi.it>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 13 Feb 2007 11:30:10 +0100
Stefano Brivio <stefano.brivio@polimi.it> wrote:

>   CC      drivers/serial/8250_pci.o
> drivers/serial/8250_pci.c: In function 'pciserial_resume_one':
> drivers/serial/8250_pci.c:1830: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
> 
> This patch fixes it.

NAK. as ith the past several times people proposed this. The bug is in
the pci_enable_device header being must_check
