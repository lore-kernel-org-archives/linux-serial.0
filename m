From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] serial/arc: Fix warning with CONSOLE_POLL
Date: Sat, 12 Jul 2014 07:45:56 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4B1DBA@IN01WEMBXA.internal.synopsys.com>
References: <53bf1d9a.l51qTAII/GCO14wJ%fengguang.wu@intel.com>
 <1405083697-10719-1-git-send-email-vgupta@synopsys.com>
 <20140712004821.GB13893@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54695 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaGLHqA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Jul 2014 03:46:00 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Saturday 12 July 2014 06:13 AM, Greg KH wrote:
> On Fri, Jul 11, 2014 at 06:31:37PM +0530, Vineet Gupta wrote:
>> | drivers/tty/serial/arc_uart.c:516:2: warning: (near initialization for 'arc_serial_pops.poll_put_char') [enabled by default]
>>
>> This partially undoes "serial/arc: use uart_console_write() helper" by
>> restoring the prototpye of poll helper and use a different one in
>> uart_console_write()
>>
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> You forgot a "Reported-by:" line here.
>
> I'll go add it...

Sorry my bad - thx for taking care of this.

-Vineet
