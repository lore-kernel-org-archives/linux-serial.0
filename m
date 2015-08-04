From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] serial: don't announce CIR serial ports
Date: Wed, 5 Aug 2015 01:25:26 +0200
Message-ID: <55C149E6.7040407@maciej.szmigiero.name>
References: <55BE8725.6090303@maciej.szmigiero.name>
 <55C0196C.7090308@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C0196C.7090308@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

Thanks for looking into it.

On 04.08.2015 03:46, Peter Hurley wrote:
> Hi Maciej,
> 
> On 08/02/2015 05:09 PM, Maciej S. Szmigiero wrote:
>> CIR type serial ports aren't real serial ports.
>> This is just a way to prevent legacy serial driver
>> from probing and eventually binding some resources
>> so don't announce them like normal serial ports.
> 
> I'd like to keep some form of reporting so that we know the
> port was properly probed; what about extending uart_report_port()
> to including CIR + disabled status?

Currently the printed message looks like this:
"00:01: ttyS2 at I/O 0x3e8 (irq = 7, base_baud = 115200) is a CIR port".

I think it would be best to skip a device file name in this case,
since this is how user sees (and uses) a real serial port.
The message would be then:
"00:01 at I/O 0x3e8 (irq = 7, base_baud = 115200) is a CIR port".

The dev name will always be present since the only current
"source" of CIR ports is PNP 8250 driver which sets 
dev pointer uncondtionally.

> Secondly, good catch! Because we should not be trying to
> register a console on this port, nor driving modem signals.
> 
> So maybe an early exit after uart_report_port?

All right, I will resubmit updated patch tomorrow.

> Regards,
> Peter Hurley

Best regards,
Maciej Szmigiero
