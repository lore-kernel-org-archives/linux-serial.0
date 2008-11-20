From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 21/26] Serial: Allow port type to be specified when calling
 serial8250_register_port.
Date: Thu, 20 Nov 2008 13:00:47 -0800
Message-ID: <4925CFFF.9010502@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>	<1227047057-4911-3-git-send-email-ddaney@caviumnetworks.com> <20081120200256.73f98e09@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:54772 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbYKTVE7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2008 16:04:59 -0500
In-Reply-To: <20081120200256.73f98e09@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org

Alan Cox wrote:
> On Tue, 18 Nov 2008 14:24:15 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
>> Add flag value UPF_FIXED_TYPE which specifies that the UART type is
>> known and should not be probed.  For this case the UARTs properties
>> are just copied out of the uart_config entry.
> 
> Looks fine to me

Re-adding the lists...

Does that mean I an add Acked-by you to this patch?

David Daney
