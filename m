From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] serial: Delete dead code for CIR serial ports
Date: Fri, 16 Jun 2017 17:13:20 +0200
Message-ID: <07ecfe3e-f6a0-c4a6-5f46-b0f296d18f74@suse.com>
References: <20170615155449.28482-1-mbrugger@suse.com>
 <1497613434.22624.145.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497613434.22624.145.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: ed.blake@imgtec.com, vigneshr@ti.com, alexander.sverdlin@nokia.com, yegorslists@googlemail.com, dhowells@redhat.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 16/06/17 13:43, Andy Shevchenko wrote:
> On Thu, 2017-06-15 at 17:54 +0200, Matthias Brugger wrote:
>> Commit e4fda3a04275 ("serial: don't register CIR serial ports") adds a
>> check for PORT_8250_CIR to serial8250_register_8250_port(). But the
>> code
>> isn't needed as the function never takes the branch when the port is
>> CIR
>> serial port.
> 
>> +		if (serial8250_isa_config != NULL)
> 
>> +			serial8250_isa_config(0, &uart->port,
>> +					&uart->capabilities);
> 
> Can't it be one line after all?
> 

No, that will exceed the 80 characters by line.

>>   
> 
>> +		ret = uart_add_one_port(&serial8250_reg,
>> +					&uart->port);
> 
> Ditto.
> 

Yes, I'll fix this in v2.

Thanks,
Matthias
