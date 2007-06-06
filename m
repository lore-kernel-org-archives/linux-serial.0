From: "V. Ananda Krishnan" <mansarov@linux.vnet.ibm.com>
Subject: Re: [PATCH TRIVIAL] icom whitespace cleanups
Date: Wed, 06 Jun 2007 09:16:11 -0500
Message-ID: <4666C1AB.2070209@linux.vnet.ibm.com>
References: <4665D3EC.60404@redhat.com> <18021.55632.359206.105260@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:52869 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761681AbXFFOVA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jun 2007 10:21:00 -0400
In-Reply-To: <18021.55632.359206.105260@cargo.ozlabs.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Chris Snook <csnook@redhat.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Paul Mackerras wrote:
> Chris Snook writes:
> 
>> Clean up whitespace and comments in drivers/serial/icom.c
> 
> These changes seem totally unnecessary, as the existing indentation is
> according to a commonly-accepted style and is quite reasonable:
> 
I agree with Paul.

>> @@ -149,23 +149,23 @@ static void free_port_memory(struct icom
>>  	trace(icom_port, "RET_PORT_MEM", 0);
>>  	if (icom_port->recv_buf) {
>>  		pci_free_consistent(dev, 4096, icom_port->recv_buf,
>> -				    icom_port->recv_buf_pci);
>> +			icom_port->recv_buf_pci);
>>  		icom_port->recv_buf = NULL;
>>  	}
>>  	if (icom_port->xmit_buf) {
>>  		pci_free_consistent(dev, 4096, icom_port->xmit_buf,
>> -				    icom_port->xmit_buf_pci);
>> +			icom_port->xmit_buf_pci);
> 
> etc. etc.  The comment changes I agree on but not most of the other
> whitespace changes.
The comment changes are fine with me too.
> 
> Also you don't seem to have cc'd the driver author.
> 
Current contacts for the driver are: Ananda (mansarov@us.ibm.com) and 
Wendy (wenxiong@us.ibm.com)

:- Ananda

> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

