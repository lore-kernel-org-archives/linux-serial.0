Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD49C07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891186128B
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 21:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGMVQ2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:16:28 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:53480 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229478AbhGMVQ2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 17:16:28 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2021 17:16:28 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 84A5B1856B700
        for <linux-serial@vger.kernel.org>; Tue, 13 Jul 2021 21:05:31 +0000 (UTC)
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 01CA418291090;
        Tue, 13 Jul 2021 21:05:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 0F8BF2EBF91;
        Tue, 13 Jul 2021 21:05:28 +0000 (UTC)
Message-ID: <8c2868969894ae5710147d3660e8442017438932.camel@perches.com>
Subject: Re: [PATCH v1 4/4] serial: 8250_pci: Replace dev_*() by pci_*()
 macros
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Date:   Tue, 13 Jul 2021 14:05:27 -0700
In-Reply-To: <20210713104026.58560-4-andriy.shevchenko@linux.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
         <20210713104026.58560-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F8BF2EBF91
X-Stat-Signature: fmdbu5uiam1jn1ntpfbc1itwfmnuz83w
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19wslUDz56ixfJZwEwSdX46P7sgAziArf0=
X-HE-Tag: 1626210328-779052
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2021-07-13 at 13:40 +0300, Andy Shevchenko wrote:
> PCI subsystem provides convenient shortcut macros for message printing.
> Use those macros instead of dev_*().
[]
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
[]
> @@ -4147,8 +4139,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
>  		       sizeof(struct pciserial_board));
>  		rc = serial_pci_guess_board(dev, &tmp);
>  		if (rc == 0 && serial_pci_matches(board, &tmp))
> -			moan_device("Redundant entry in serial pci_table.",
> -				    dev);
> +			moan_device("Redundant entry in serial pci_table.", dev);

Unassociated change.

