From: Greg KH <greg@kroah.com>
Subject: Re: [ patch 1/7] drivers/serial/jsm: new serial device driver
Date: Sun, 27 Feb 2005 22:57:52 -0800
Message-ID: <20050228065752.GD23595@kroah.com>
References: <422259EF.90104@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mail.kroah.org ([69.55.234.183]:18076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261498AbVB1G6J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Feb 2005 01:58:09 -0500
Content-Disposition: inline
In-Reply-To: <422259EF.90104@us.ltcfwd.linux.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, Feb 27, 2005 at 06:38:23PM -0500, Wen Xiong wrote:
> +static struct pci_device_id jsm_pci_tbl[] = {
> +	{	DIGI_VID, PCI_DEVICE_NEO_4_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,		0 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_8_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,		1 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2DB9_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	2 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2DB9PRI_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	3 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2RJ45_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	4 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2RJ45PRI_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	5 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_1_422_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	6 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_1_422_485_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	7 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2_422_485_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	8 },

Use the PCI_DEVICE() macro to make this smaller.

thanks,

greg k-h
