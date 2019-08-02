From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Device to write to all (serial) consoles
Date: Fri, 2 Aug 2019 21:59:06 +0200
Message-ID: <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
 <20190802160243.GA15484@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802160243.GA15484@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Donald Buczek <buczek@molgen.mpg.de>
List-Id: linux-serial@vger.kernel.org

Dear Greg,


On 02.08.19 18:02, Greg Kroah-Hartman wrote:
> On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:

>> On a lot of devices, like servers, you have more than one serial console,
>> and you do not always know, how they are numbered. Therefore, we start a
>> console on ttyS0 and ttyS1.
>>
>> In user space, we also would like to write to both consoles to not worry
>> about the numbering. Writing to `/dev/console` only write to the active
>> console.
> 
> So the same data to multiple console devices with just one userspace
> call?  Why?

Because the cable is always connected to the port on the back side, and 
sometimes the port in the front has ID 0, and the one in the back 1, and 
other times vice versa. We do not want to track that, and it would be 
convenient to just write to both ports.

>>      $ more /proc/consoles # I think
>>      tty0                 -WU (EC p  )    4:1
>>      ttyS0                -W- (E  p a)    4:65
>>      ttyS1                -W- (E  p a)    4:65
>>
>> Does a device exist, or can a device be configured so you can write to
>> all (serial) consoles from user space?
> 
> With one syscall, not that I know of, sorry.

Can such a device be created with udev or so?


Kind regards,

Paul
