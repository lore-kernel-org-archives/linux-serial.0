From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: NetMos nm9855 patch
Date: Tue, 10 May 2005 09:06:32 -0600
Message-ID: <200505100906.32825.bjorn.helgaas@hp.com>
References: <20050510033341.GB2908@gewi.kfunigraz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:8644 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261669AbVEJPHF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 11:07:05 -0400
In-Reply-To: <20050510033341.GB2908@gewi.kfunigraz.ac.at>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Schitter <ms@gewi.kfunigraz.ac.at>
Cc: rmk+serial@arm.linux.org.uk, philb@gnu.org, linux-parport@lists.infradead.org, linux-serial@vger.kernel.org

On Monday 09 May 2005 9:33 pm, Martin Schitter wrote:
> could you please test/approve this little patch and include it to the kernel
> sources.

I don't actually have any Netmos cards at all, so I can't test it,
but the patch looks good to me.  Thanks a lot for debugging and
fixing this!  If RMK doesn't object, I suggest that you add a
"Signed-off-by: Martin Schitter <ms@gewi.kfunigraz.ac.at>" line
and send it to Andrew Morton.

> patch tor the NetMos nm9855 (parport_pc/parport_serial):
> 
> kernel 2.6.12-rc2 adopted some code by Bjorn Helgaas supporting NetMos combo
> controller cards. this implementation doesn't work for nm9855 based cards!
> 
> there are two reasons:
> 
>       a) the module 'parport_pc' doesn't want to give the resonsibility for
>          the netmos_9855 to 'parport_serial' and can not handle the serial
>          lines -- trivial to fix...
> 	 
> 	 http://lists.infradead.org/pipermail/linux-parport/2005-February/000250.html
> 	 http://lkml.org/lkml/2005/3/24/199
> 	 
>       b) the support for the nm9855 in 'parport_serial' still doesn't work
>          because of wrong assumptions about the relevant BARs 
> 	 
> 	 port address layout for this chip:
> 
> 	 0000:00:09.0 Communication controller:
>          	      NetMos Technology PCI 9855 
>          	      Multi-I/O Controller (rev 01)        
> 	 	      (= 9710:9855)
>          Subsystem: LSI Logic / Symbios Logic 1P4S (= 1000:0014)
>   	 Flags: medium devsel, IRQ 177
> 	 I/O ports at a800 [size=8]  (= parport)
> 	 I/O ports at a400 [size=8]  
> 	 I/O ports at a000 [size=8]  (= serial)
> 	 I/O ports at 9800 [size=8]  (= serial)
> 	 I/O ports at 9400 [size=8]  (= serial)
> 	 I/O ports at 9000 [size=16] (= serial)
> 
> 
> the following patch will fix the problem:
> 
> --- linux-2.6.12-rc4/drivers/parport/parport_pc.c.orig	2005-05-09 23:22:38.000000000 +0200
> +++ linux-2.6.12-rc4/drivers/parport/parport_pc.c	2005-05-09 23:24:05.000000000 +0200
> @@ -2751,7 +2751,6 @@
>  	netmos_9755,
>  	netmos_9805,
>  	netmos_9815,
> -	netmos_9855,
>  };
>  
>  
> @@ -2826,7 +2825,6 @@
>          /* netmos_9755 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
>  	/* netmos_9805 */               { 1, { { 0, -1 }, } }, /* untested */
>  	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
> -	/* netmos_9855 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
>  };
>  
>  static struct pci_device_id parport_pc_pci_tbl[] = {
> @@ -2907,8 +2905,6 @@
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9805 },
>  	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9815,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
> -	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
>  	{ 0, } /* terminate list */
>  };
>  MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
> --- linux-2.6.12-rc4/drivers/parport/parport_serial.c.orig	2005-05-09 23:23:05.000000000 +0200
> +++ linux-2.6.12-rc4/drivers/parport/parport_serial.c	2005-05-09 23:34:16.000000000 +0200
> @@ -34,6 +34,7 @@
>  	titan_110l = 0,
>  	titan_210l,
>  	netmos_9xx5_combo,
> +	netmos_9855,
>  	avlab_1s1p,
>  	avlab_1s1p_650,
>  	avlab_1s1p_850,
> @@ -87,6 +88,7 @@
>  	/* titan_110l */		{ 1, { { 3, -1 }, } },
>  	/* titan_210l */		{ 1, { { 3, -1 }, } },
>  	/* netmos_9xx5_combo */		{ 1, { { 2, -1 }, }, netmos_parallel_init },
> +	/* netmos_9855 */		{ 1, { { 0, -1 }, }, netmos_parallel_init },
>  	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
>  	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
>  	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
> @@ -120,7 +122,7 @@
>  	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
>  	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
>  	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
>  	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
>  	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
> @@ -207,6 +209,7 @@
>  /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
>  /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
>  /* netmos_9xx5_combo */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200, 0, 0, netmos_serial_init },
> +/* netmos_9855 */	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 1, 115200, 0, 0, netmos_serial_init },
>  /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
>  /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
>  /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> 
> 
> 
