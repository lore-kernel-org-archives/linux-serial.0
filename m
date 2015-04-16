From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2] serial: of-serial: Remove device_type = "serial" registration
Date: Thu, 16 Apr 2015 09:28:24 +0200
Message-ID: <900e91b8-16c8-4033-90f7-6237b8927e40@BY2FFO11OLC015.protection.gbl>
References: <ffb577a257d14087e1d2d0347a071f5aef519e52.1429005786.git.michal.simek@xilinx.com>
 <552E4691.5040501@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552E4691.5040501@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On 04/15/2015 01:08 PM, Peter Hurley wrote:
> On 04/14/2015 06:03 AM, Michal Simek wrote:
>> Do not probe all serial drivers by of_serial.c which are using
>> device_type = "serial"; property. Only drivers which have valid
>> compatible strings listed in the driver should be probed.
>>
>> When PORT_UNKNOWN is setup probe will fail anyway.
>>
>> Arnd quotation about driver historical background:
>> "when I wrote that driver initially, the idea was that it would
>> get used as a stub to hook up all other serial drivers but after
>> that, the common code learned to create platform devices from DT"
>>
>> This patch fix the problem with on the system with xilinx_uartps and
>> 16550a where of_serial failed to register for xilinx_uartps and because
>> of irq_dispose_mapping() removed irq_desc. Then when xilinx_uartps was asking
>> for irq with request_irq() EINVAL is returned.
> 
> The problem is that irq_create_mapping()/irq_dispose_mapping()
> is not symmetrical, which breaks the device probe model. With that
> fixed, no change would be required here.

But even when this is fixed this device_type = "serial"; registration is
not needed at all and just slow down boot process.

I am not an expert but maybe you will know. A lot of drivers are calling
platform_get_irq which create mapping but in error path this mapping is
not removed. Not sure if this is done by core but based on my chat with
Arnd probably not.

Arnd: Can you please ACK this patch?

Thanks,
Michal
