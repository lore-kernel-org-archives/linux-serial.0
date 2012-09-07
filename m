From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] 8250: blacklist IR ports
Date: Fri, 7 Sep 2012 11:25:10 +0100
Message-ID: <20120907112510.3c2eb62f@pyramind.ukuu.org.uk>
References: <cover.1346969721.git.sean@mess.org>
	<a9565dd624c186917c71a4e431e6bcab712dbf08.1346969721.git.sean@mess.org>
	<20120907010135.6a4d0a20@pyramind.ukuu.org.uk>
	<20120907093020.GA26788@pequod.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48088 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab2IGKUe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Sep 2012 06:20:34 -0400
In-Reply-To: <20120907093020.GA26788@pequod.mess.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, David =?UTF-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

> At least for the nsc-ircc driver, user space must manually remove the
> the uart driver and then load the nsc-ircc driver. This patch also 

The nsc can be driven in both SIR and FIR mode can it not. The serial
driver should drive it in SIR mode if so which means we need to be a spot
more careful.

> fixes that for nsc-ircc devices. It should work although I am unable to 
> find the hardware to test it on yet, I used to have one of these. Testers 
> would be appreciated. See:

Until it can be tested can we keep the nsc-ircc case separate. At most we
might need two identifiers (PORT_8250_CIR PORT_8250_FIR etc)

Alan
