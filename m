Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A59C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 10:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B10D6128B
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 10:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbhGNKr2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 06:47:28 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:60952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239148AbhGNKr0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 06:47:26 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4D6742AF17;
        Wed, 14 Jul 2021 10:44:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 5B78427DD3E;
        Wed, 14 Jul 2021 10:44:32 +0000 (UTC)
Message-ID: <91d4f67011eb83c4e4b17c7cfb4f4b8aef190978.camel@perches.com>
Subject: Re: [PATCH v1 1/4] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Date:   Wed, 14 Jul 2021 03:44:31 -0700
In-Reply-To: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: htenwmm663a1y4q5mmh17wpywfynss3u
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5B78427DD3E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/8sEb/SnuH+4J1L45TBkLGiY5c7ic2qm8=
X-HE-Tag: 1626259472-225770
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2021-07-13 at 13:40 +0300, Andy Shevchenko wrote:
> The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
> This reduces code base and makes it easier to read and understand.
[]
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
[]
> @@ -897,37 +897,31 @@ static int pci_netmos_init(struct pci_dev *dev)
>  /* enable IO_Space bit */
>  #define ITE_887x_POSIO_ENABLE		(1 << 31)
>  
> 
> +/* inta_addr are the configuration addresses of the ITE */
> +static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0, 0x200, 0x280, };

Why move this outside the only function it's used in?
The trailing comma isn't necessary/useful and possibly confusing too.

>  static int pci_ite887x_init(struct pci_dev *dev)
>  {
> -	/* inta_addr are the configuration addresses of the ITE */
> -	static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0,
> -							0x200, 0x280, 0 };
>  	int ret, i, type;
>  	struct resource *iobase = NULL;
>  	u32 miscr, uartbar, ioport;
> 
>  	/* search for the base-ioport */
> -	i = 0;
> -	while (inta_addr[i] && iobase == NULL) {
> -		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
> -								"ite887x");
> +	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
> +		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE, "ite887x");
>  		if (iobase != NULL) {

continue and unindent the block below?

>  			/* write POSIO0R - speed | size | ioport */
>  			pci_write_config_dword(dev, ITE_887x_POSIO0,
>  				ITE_887x_POSIO_ENABLE | ITE_887x_POSIO_SPEED |
>  				ITE_887x_POSIO_IOSIZE_32 | inta_addr[i]);
>  			/* write INTCBAR - ioport */
> -			pci_write_config_dword(dev, ITE_887x_INTCBAR,
> -								inta_addr[i]);
> +			pci_write_config_dword(dev, ITE_887x_INTCBAR, inta_addr[i]);
>  			ret = inb(inta_addr[i]);
>  			if (ret != 0xff) {
>  				/* ioport connected */
>  				break;
>  			}
>  			release_region(iobase->start, ITE_887x_IOSIZE);
> -			iobase = NULL;
>  		}
> -		i++;
>  	}
>  
> 
>  	if (!inta_addr[i]) {


