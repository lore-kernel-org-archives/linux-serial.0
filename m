From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [SERIAL] qe-uart: add support for Freescale QUICCEngine
 UART
Date: Tue, 15 Jan 2008 09:03:32 -0600
Message-ID: <478CCB44.3000805@freescale.com>
References: <11999217062265-git-send-email-timur@freescale.com> <11999217072674-git-send-email-timur@freescale.com> <119992170854-git-send-email-timur@freescale.com> <1CFD37C9-F06C-4C7E-836D-31C94EF464DF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:44804 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYAOPEY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jan 2008 10:04:24 -0500
In-Reply-To: <1CFD37C9-F06C-4C7E-836D-31C94EF464DF@kernel.crashing.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

Kumar Gala wrote:

> what is the define for?  you commented all the others :)

I thought you said there were no more issues? :-)

>> +#define UCC_WAIT_CLOSING 100

This is how long to wait after receiving a close request for characters to be 
sent out before actually closing the device.  I just used the same value as the 
CPM serial driver.


>> +    u16 tx_state;       /* 0xC6, TX state */
> 
> __be16?

Oops.

>> +/*
>> + * Set the modem control lines
>> + *
>> + * We currently don't support setting modem control lines, but this 
>> function
>> + * needs to exist, otherwise the kernel will panic.
>> + */
>> +void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> +{
>> +}
> 
> What's the issue w/support of this?  (maybe a comment related to why its 
> not supported -- if not here in the git commit message)

I didn't want to add any serial functionality that wasn't in the CPM serial 
driver, mostly because I don't really understand the technical details of serial 
communication at this level.  I figured if it's okay for the CPM driver not to 
handle modem control, then the QE driver doesn't have to do it either.

>> +static void qe_uart_enable_ms(struct uart_port *port)
>> +{
> 
> same question as above.

Same answer!

I suppose you want me to post another version of this patch?

-- 
Timur Tabi
Linux kernel developer at Freescale
