From: Nathan <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Sun, 30 Oct 2016 11:01:39 -0500
Message-ID: <532703ec-357f-24a9-cd0e-268d0430e194@sgi.com>
References: <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
 <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org>
 <20161028194225.GA233549@stormcage.americas.sgi.com>
 <20161029211647.GA25740@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161029211647.GA25740@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org



On 10/29/2016 04:16 PM, Sean Young wrote:
> On Fri, Oct 28, 2016 at 02:42:25PM -0500, Nathan Zimmer wrote:
>> On Thu, Oct 27, 2016 at 09:19:16PM +0100, Sean Young wrote:
>>> On Wed, Oct 26, 2016 at 01:16:16PM -0500, Nathan Zimmer wrote:
>>>> On 10/25/2016 03:41 PM, Sean Young wrote:
>>>>> On Mon, Oct 24, 2016 at 04:49:25PM -0500, Nathan Zimmer wrote:
>>>>>> [    1.565062] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>>>> The isa probe driver find the serial port.
>>>>>
>>>>>> [    1.566453] serial 00:04: pnp_assign_resources, try dependent set 0
>>>>>> [    1.567383] serial 00:04:   couldn't assign io 0 (min 0x2f8 max 0x2f8)
>>>>> But then decides that the port is already in use (the existing serial driver).
>>>>>> [    1.568366] serial 00:04: pnp_assign_resources failed (-16)
>>>>>> [    1.569188] serial 00:04: unable to assign resources
>>>>>> [    1.569924] serial: probe of 00:04 failed with error -16
>>>>> Please try and boot 3.7.0 with "8250.share_irqs=1", maybe it will pick
>>>>> irq 3 and it will be happy again, but that is just a guess.
>>>>>
>>>>> I think I have not fully understood what the failure is. Does the serial
>>>>> port not work or does the boot hang? What are the symptoms?
>>>> With console=ttyS1 the boot will "hang", sometimes it makes it all the way
>>>> through but may take 30 minutes, instead of the 2-4 minutes this box
>>> Where does it hang? Any error messages?
>>>
>> Shortly after mounting the root.
>> After that I get no more output...
>>
>> Here is a failure log from 4.8.
> So does the console on the serial port work on 4.8? Also what does
> "cat /proc/interrupts" say with and without my change of ordering the
> serial pnp probe before the isa probe?
>
> It could be that the serial driver picking a different irq caused another
> driver to be forced to pick another irq which does not work.
>
>
> Sean

Works is a strong word.  It produces output until it hangs in boot.

It certainly could be another driver but I don't see another irq12 in 
the dmesg log.

I'll grab some data once I back in the office tomorrow.


Nate
