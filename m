From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH] serial: add support for various Titan PCI cards
Date: Fri, 04 Jun 2010 10:01:05 +0200
Message-ID: <4C08B2C1.2070803@visionsystems.de>
References: <4C0675CE.4090305@visionsystems.de> <20100603173558.GB9307@kroah.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:35743 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0FDIBN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Jun 2010 04:01:13 -0400
In-Reply-To: <20100603173558.GB9307@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, gregkh@suse.de

Greg KH schrieb:
> On Wed, Jun 02, 2010 at 05:16:30PM +0200, Yegor Yefremov wrote:
>> Index: b/include/linux/pci_ids.h
> 
> If you look at the top of this file, it says we are not adding new
> entries to it except for ids that are in more than one file.
> 
> So, care to redo this patch without touching this file?  I'll be glad to
> take it that way.

O.K. I've pasted the IDs into 8250_pci.c. I hope the section "This should be in linux/pci_ids.h" is O.K.

Regards,
Yegor
