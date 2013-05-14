From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: PL011: add support for extended FIFO-size of PL011-r1p5
Date: Tue, 14 May 2013 15:03:14 -0600
Message-ID: <5192A692.4010700@wwwdotorg.org>
References: <007301ce375e$bcf6d6b0$36e48410$@lge.com> <5191D200.3040604@wwwdotorg.org> <01fd01ce5072$d6b9fcd0$842df670$@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01fd01ce5072$d6b9fcd0$842df670$@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jongsung Kim <neidhard.kim@lge.com>
Cc: 'Russell King' <linux@arm.linux.org.uk>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 05/14/2013 01:15 AM, Jongsung Kim wrote:
> Stephen Warren <swarren@wwwdotorg.org> :
>> For reference, the AMBA periphid of the UART device there is 0x00341011.
>> The nibble "3" is the revision being tested in:
> 
> The UART device has periphid 0x00341011, and is compatible with the
> original PL011 prior to r1p5. Not with r1p5. It could be a possible
> way to specify the compatible periphid (such as 0x00241011) instead
> of just 0x0 when initializing the amba_device for the UART.
> 
>>> +static unsigned int get_fifosize_arm(unsigned int periphid)
>>> +{
>>> +	unsigned int rev = (periphid >> 20) & 0xf;
>>> +	return rev < 3 ? 16 : 32;
>>> +}
...
> Doesn't the BCM2835 UART have anything different from the ARM PL011?
> What about the UARTPCellID registers? They are set to 0xb105f00d with
> the ARM PL011.

Looking at BCM2835-ARM-Peripherals.pdf (i.e. the public documentation
for the BCM2835 chip), I see:

=====
The UART provides:
* Separate 16x8 transmit and 16x12 receive FIFO memory.
...
For the in-depth UART overview, please, refer to the ARM PrimeCell UART
(PL011) Revision: r1p5 Technical Reference Manual.
=====

That seems to imply that not all r1p5 PL011s actually have a depth-32
FIFO. Perhaps this is a configurable property of the IP block, not
something that all r1p5 have?

I can't check the UARTPCellID registers right now.
