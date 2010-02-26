From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
Date: Fri, 26 Feb 2010 15:21:15 -0500
Message-ID: <4B882D3B.5050003@windriver.com>
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com> <EB2B2912-24C3-46C9-B894-0A84D593570F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41592 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966031Ab0BZUVU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Feb 2010 15:21:20 -0500
In-Reply-To: <EB2B2912-24C3-46C9-B894-0A84D593570F@kernel.crashing.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org

On 10-02-26 02:42 PM, Kumar Gala wrote:
> 
> On Feb 26, 2010, at 1:25 PM, Paul Gortmaker wrote:
> 

[...]

>>
>> +	if ((up->bugs&  UART_BUG_PPC)&&  (status == UART_LSR_RFE_ERROR_BITS)) {
>> +		spin_unlock_irqrestore(&up->port.lock, flags);
>> +		return;
>> +	}
>> +

[...]

> 
> is there harm caused if we have SERIAL_8250_PPC_BUG set and dont need it?

In theory, no -- strip away all the window dressing and we are
left with the above change.  So, you'd have to have some UART
implementation that was setting those bits and still relying
on its interrupt event to be processed normally.  But since
there are so many different 8250 implementations out there,
I was being cautious and taking the absolute safe approach.

P.

> 
> - k

