From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/4] serial: 8250 driver replaceable i/o functions.
Date: Tue, 07 Oct 2008 17:29:25 -0700
Message-ID: <48EBFEE5.7010401@caviumnetworks.com>
References: <48EBF426.9080500@caviumnetworks.com> <48EBF56D.3030203@caviumnetworks.com> <48EBFAFC.3020501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:44087 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbYJHA36 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Oct 2008 20:29:58 -0400
In-Reply-To: <48EBFAFC.3020501@zytor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, "Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>

H. Peter Anvin wrote:
> David Daney wrote:
>> /* sane hardware needs no mapping */
>> -static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
>> +static inline int map_8250_in_reg(struct uart_port *p, int offset)
>> {
>> -    if (up->port.iotype != UPIO_AU)
>> +    if (p->iotype != UPIO_AU)
>>         return offset;
>>     return au_io_in_map[offset];
>> }
> 
> With your changes, these functions cannot be called with p->iotype != 
> UPIO_AU anymore, correct?  So there is no need for this test...
> 

I think you are probably correct.  However, with the patch it is 
possible to move all this target specific code out of the driver.  So if 
the patch is accepted, a better follow up would be to get rid of the 
UPIO_AU things altogether.

I gave an example of how that could be done with UPIO_TSI here:

http://marc.info/?l=linux-serial&m=122333633802691&w=2

David Daney
