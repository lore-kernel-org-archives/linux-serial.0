From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] 8250_pci: Fix kernel panic when pch_uart is disabled
Date: Wed, 12 Oct 2011 19:17:25 +0100
Message-ID: <20111012191725.179db127@bob.linux.org.uk>
References: <1317962389-21786-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12996 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab1JLSHy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Oct 2011 14:07:54 -0400
In-Reply-To: <1317962389-21786-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com

On Fri,  7 Oct 2011 13:39:49 +0900
Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com> wrote:

> Currently, ".setup" function is not set. 
> As a result, when detecting our IOH's uart device without pch_uart,
> kernel panic occurs at the following of pciserial_init_ports().
> 
> 	for (i = 0; i < nr_ports; i++) {
> 		if (quirk->setup(priv, board, &serial_port, i))
> 			break;
> 
> So, this patch adds the ".setup" function.
> We can use pci_default_setup because our IOH's uart is compatible
> with 16550.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>

Acked-by: Alan Cox <alan@linux.intel.com>
