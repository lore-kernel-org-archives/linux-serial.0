From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/4] 8250: Don't clobber spinlocks.
Date: Tue, 02 Dec 2008 09:01:13 -0800
Message-ID: <493569D9.1030708@caviumnetworks.com>
References: <4934774E.6080805@caviumnetworks.com>	<1228175368-5536-1-git-send-email-ddaney@caviumnetworks.com> <20081202112010.6b25af1c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:34352 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbYLBRBr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Dec 2008 12:01:47 -0500
In-Reply-To: <20081202112010.6b25af1c@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

Alan Cox wrote:
> On Mon,  1 Dec 2008 15:49:25 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
>> In serial8250_isa_init_ports(), the port's lock is initialized.  We
>> should not overwrite it.  In early_serial_setup(), only copy in the
>> fields we need.  Since the early console code only uses a subset of
>> the fields, these are sufficient.
> 
>> -	serial8250_ports[port->line].port.ops	= &serial8250_pops;
> 
> You seem to drop the assignment of port.ops ?
> 

The port.ops are initialized in the preceding call to 
serial8250_isa_init_ports(), we don't have to set it again as we are no 
longer clobbering it with a full structure assignment.

Perhaps the patch commentary should be adjusted to mention this.

David Daney
