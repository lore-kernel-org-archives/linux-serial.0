From: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: 8250_pci and OXPCIe952
Date: Wed, 10 Nov 2010 13:18:24 -0200
Message-ID: <4CDAB7C0.40606@linux.vnet.ibm.com>
References: <4CD96169.2060705@linux.vnet.ibm.com> <20101109154513.GA5970@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:58789 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654Ab0KJPSb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 10:18:31 -0500
Received: from mailhub1.br.ibm.com (mailhub1.br.ibm.com [9.18.232.109])
	by e24smtp04.br.ibm.com (8.14.4/8.13.1) with ESMTP id oAAFBakH002156
	for <linux-serial@vger.kernel.org>; Wed, 10 Nov 2010 13:11:36 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id oAAFP7pA323784
	for <linux-serial@vger.kernel.org>; Wed, 10 Nov 2010 13:25:10 -0200
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id oAAFIPtW022661
	for <linux-serial@vger.kernel.org>; Wed, 10 Nov 2010 13:18:26 -0200
In-Reply-To: <20101109154513.GA5970@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-serial@vger.kernel.org

Greg,

On 11/09/2010 01:45 PM, Greg KH wrote:
> How many should there be?
Only two UARTs in this chipset.

> What should the address and irq be?
These address seems to be fine, although the driver is not working. I 
suppose that there is something that is broken in the device driver.

Thanks
