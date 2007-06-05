From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH TRIVIAL] icom whitespace cleanups
Date: Wed, 6 Jun 2007 07:44:48 +1000
Message-ID: <18021.55632.359206.105260@cargo.ozlabs.ibm.com>
References: <4665D3EC.60404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48597 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765761AbXFEWjl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Jun 2007 18:39:41 -0400
In-Reply-To: <4665D3EC.60404@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Chris Snook writes:

> Clean up whitespace and comments in drivers/serial/icom.c

These changes seem totally unnecessary, as the existing indentation is
according to a commonly-accepted style and is quite reasonable:

> @@ -149,23 +149,23 @@ static void free_port_memory(struct icom
>  	trace(icom_port, "RET_PORT_MEM", 0);
>  	if (icom_port->recv_buf) {
>  		pci_free_consistent(dev, 4096, icom_port->recv_buf,
> -				    icom_port->recv_buf_pci);
> +			icom_port->recv_buf_pci);
>  		icom_port->recv_buf = NULL;
>  	}
>  	if (icom_port->xmit_buf) {
>  		pci_free_consistent(dev, 4096, icom_port->xmit_buf,
> -				    icom_port->xmit_buf_pci);
> +			icom_port->xmit_buf_pci);

etc. etc.  The comment changes I agree on but not most of the other
whitespace changes.

Also you don't seem to have cc'd the driver author.

Paul.
