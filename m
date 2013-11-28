From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] serial: jsm: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 09:35:42 -0200
Message-ID: <20131128113542.GC24646@oc0268524204.ibm.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
 <000801ceebdd$5b984a50$12c8def0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp01.br.ibm.com ([32.104.18.85]:47684 "EHLO
	e24smtp01.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759205Ab3K1Lfu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 06:35:50 -0500
Received: from /spool/local
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <cascardo@linux.vnet.ibm.com>;
	Thu, 28 Nov 2013 09:35:48 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id B9FA3352006A
	for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2013 06:35:44 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rASBZnGG3883098
	for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2013 09:35:49 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rASBZiSK008021
	for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2013 09:35:45 -0200
Content-Disposition: inline
In-Reply-To: <000801ceebdd$5b984a50$12c8def0$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Thu, Nov 28, 2013 at 10:58:39AM +0900, Jingoo Han wrote:
> This macro is used to create a struct pci_device_id array.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/tty/serial/jsm/jsm_driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
> index a47d882..4e4899b 100644
> --- a/drivers/tty/serial/jsm/jsm_driver.c
> +++ b/drivers/tty/serial/jsm/jsm_driver.c
> @@ -202,7 +202,7 @@ static void jsm_remove_one(struct pci_dev *pdev)
>  	kfree(brd);
>  }
> 
> -static struct pci_device_id jsm_pci_tbl[] = {
> +static DEFINE_PCI_DEVICE_TABLE(jsm_pci_tbl) = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 0, 0, 0 },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 0, 0, 1 },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 0, 0, 2 },
> -- 
> 1.7.10.4
> 
> 

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

