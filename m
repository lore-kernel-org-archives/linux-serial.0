From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v5] serial/arc-uart: Add new driver
Date: Mon, 29 Oct 2012 16:48:02 +0530
Message-ID: <508E65EA.2080402@synopsys.com>
References: <1351252996-28484-1-git-send-email-vgupta@synopsys.com> <1351252996-28484-2-git-send-email-vgupta@synopsys.com> <20121026121032.GD26342@arwen.pp.htv.fi> <508B8536.1080303@synopsys.com> <20121029110650.GA29410@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:62236 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2J2LSR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2012 07:18:17 -0400
In-Reply-To: <20121029110650.GA29410@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, arc-linux-dev@synopsys.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

I've already posted a v7 of the driver - with all your comments.
If you think it's ok - can you ACK it please !

TIA,
-Vineet

On Monday 29 October 2012 04:36 PM, Felipe Balbi wrote:
> On Sat, Oct 27, 2012 at 12:24:46PM +0530, Vineet Gupta wrote:
>> On Friday 26 October 2012 05:40 PM, Felipe Balbi wrote:
>>> On Fri, Oct 26, 2012 at 05:33:16PM +0530, Vineet.Gupta1@synopsys.com wrote:
>>>> +/*
>>>> + * Release the memory region(s) being used by 'port'.
>>>> + */
>>>> +static void arc_serial_release_port(struct uart_port *port)
>>>> +{
>>>> +}
>>>> +
>>>> +/*
>>>> + * Request the memory region(s) being used by 'port'.
>>>> + */
>>>> +static int arc_serial_request_port(struct uart_port *port)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Verify the new serial_struct (for TIOCSSERIAL).
>>>> + */
>>>> +static int
>>>> +arc_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
>>>> +{
>>>> +	return 0;
>>>> +}
>>> why all these empty functions with wrong comments above them ??
>> Actually serial_core.c invokes the reqest/release callbacks w/o
>> verifying for a NULL pointer check. Thus they need to be in there even
>> if empty. I've removed the offending comments though !
> fair enough ;-)
>

