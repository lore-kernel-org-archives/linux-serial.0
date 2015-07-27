From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/2] serial: 8250: Allow to skip autoconfig_irq() for
 a console
Date: Mon, 27 Jul 2015 15:44:05 -0400
Message-ID: <55B68A05.2060809@hurleysoftware.com>
References: <55717224.9060104@cp.jp.nec.com> <557173EC.5000307@cp.jp.nec.com> <559D0FCC.5040107@hurleysoftware.com> <559D1D39.9070405@redhat.com> <559D2AE8.8080603@hurleysoftware.com> <559D2CFB.1060507@redhat.com> <559E075F.8040800@cp.jp.nec.com> <55A05F56.90305@hurleysoftware.com> <55A462D1.3080709@cp.jp.nec.com> <55A56313.4050703@hurleysoftware.com> <55A78042.2090408@cp.jp.nec.com> <55AD237B.1080904@hurleysoftware.com> <55AE147D.5020808@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000404080208030609000207"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AE147D.5020808@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: Prarit Bhargava <prarit@redhat.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------000404080208030609000207
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 07/21/2015 05:44 AM, Taichi Kageyama wrote:
> Hi Peter,
> 
> On 2015/07/21 1:36, Peter Hurley wrote:
>> On 07/16/2015 05:58 AM, Taichi Kageyama wrote:
>>> On 2015/07/15 4:29, Peter Hurley wrote:
>>>> On 07/13/2015 09:16 PM, Taichi Kageyama wrote:
>>>>> On 2015/07/11 9:12, Peter Hurley wrote:
>>>>>> On 07/09/2015 01:32 AM, Taichi Kageyama wrote:
>>>>>>> On 2015/07/08 23:00, Prarit Bhargava wrote:
>>>>>>>> On 07/08/2015 09:51 AM, Peter Hurley wrote:
>>>>>>>>> On 07/08/2015 08:53 AM, Prarit Bhargava wrote:
>>>>>>>>>> On 07/08/2015 07:55 AM, Peter Hurley wrote:
>>>>>>>>>>> On 06/05/2015 06:03 AM, Taichi Kageyama wrote:
>>>>>>>>>>>> This patch provides a new parameter as a workaround of the following
>>>>>>>>>>>> problem. It allows us to skip autoconfig_irq() and to use a well-known irq
>>>>>>>>>>>> number for a console even if CONFIG_SERIAL_8250_DETECT_IRQ is defined.
>>>>>>>>>>>>
>>>>>>>>>>>> There're cases where autoconfig_irq() fails during boot.
>>>>>>>>>>>> In these cases, the console doesn't work in interrupt mode,
>>>>>>>>>>>> the mode cannot be changed anymore, and "input overrun"
>>>>>>>>>>>> (which can make operation mistakes) happens easily.
>>>>>>>>>>>> This problem happens with high rate every boot once it occurs
>>>>>>>>>>>> because the boot sequence is always almost same.
>>>>>>>>>>>>
>>>>>>>>>>>> autoconfig_irq() assumes that a CPU can handle an interrupt from a serial
>>>>>>>>>>>> during the waiting time, but there're some cases where the CPU cannot
>>>>>>>>>>>> handle the interrupt for longer than the time. It completely depends on
>>>>>>>>>>>> how other functions work on the CPU. Ideally, autoconfig_irq() should be
>>>>>>>>>>>> fixed
>>>>>>>>>>>
>>>>>>>
>>>>>>> Thank you for your comments.
>>>>>>>
>>>>>>>>>>> It completely depends on how long some other driver has interrupts disabled,
>>>>>>>
>>>>>>> Agree.
>>>>>>>
>>>>>>>>>>> which is a problem that needs fixed _in that driver_. autoconfig_irq() does not
>>>>>>>>>>> need fixing.
>>>>>>>
>>>>>>> Peter, ideally, you're right.
>>>>>>> However, we cannot assume how long other drivers disable interrupts.
>>>>>>> That's why I introduced this workaround.
>>>>>>> In my opinion, a console is important and always should be available
>>>>>>> even if other drivers have a bad behavior.
>>>>>>
>>>>>> I have no problem with wanting to make the console more robust, but
>>>>>> rather with the hacky way this is being done.
>>>>>
>>>>> Hi Peter,
>>>>>
>>>>> Thank you for your advice.
>>>>> If there is other way to fix this problem simply,
>>>>> I also think it's better than the dirty hack.
>>>>
>>>> While module parameters seem like "simple" solutions at the time,
>>>> they add real maintenance burden, because they establish userspace
>>>> requirements that must be preserved forever to avoid breakage.
>>>
>>> Yeah, I agree with you.
>>>
>>>>>> Better solutions:
>>>>>> 1. Fix autoprobing to force irq affinity to autoprobing cpu
>>>>>
>>>>> I couldn't make sure which CPU handled serial interrupt
>>>>> on all platforms before irq# was not known.
>>>>> Do you know the way to detect which CPU is used for console serial?
>>>>
>>>>
>>>> The basic idea would be:
>>>> 1. disable preemption
>>>> 2. for each irq descriptor selected for autoprobing, set the irq
>>>>      affinity to the current processor.
>>>> 3. probe the i/o port as is done now
>>>> 4. stop probing
>>>> 5. re-enable preemption.
>>>
>>> Thanks, I think it works.
>>>
>>>> With this solution, your patch 1/2 wouldn't be required either
>>>> because the worker thread that disabled interrupts wouldn't be
>>>> running on the cpu detecting the triggered irq(s).
>>>
>>> I still need my patch 1/2 which fixes also other cases (see case2 & 3).
>>> I think both port->lock and console_lock are required in your solution.
>>> to avoid deadlock because printk() can be called on every context.
>>>
>>>> I would imagine most or all of this would be done in
>>>> probe_irq_on(), possibly refactored to perform the preemption
>>>> disable and irq affinity.
>>>
>>> I think introducing new function like "probe_irq_set_affinity()" is better
>>> than modifying probe_irq_on(). I cannot test all legacy devices and
>>> I don't have any reason to break the code which works for other devices.
>>
>> That's fine, although most of the arguments for fixing this in the serial
>> driver apply equally to other users of probe_irq_on().
>>
>>
>>>>> The way is safe for all platforms?
>>>>
>>>> Please understand though, autoprobing is not safe, period.
>>>> Even says so in Kconfig.
>>>
>>> OK, I'll try to create new patch which makes autoprobing safer as possible.
>>> New patch is going to be like below.
>>>    1. console and port lock
>>>    2. probe_irq_on()
>>>    3. probe_irq_set_affinity(&cpumask)
>>>    4. probe_irq_off()
>>>    5. port and console unlock
>>
>> The port->lock can't be taken in this context because hard irq
>> has to be disabled with port->lock which defeats the purpose of
>> pinning the irq affinity to the current cpu.
> 
> My test code uses spin_lock() instead of spin_lock_irqsave().
> 
>> What are you concerned about being concurrent with autoconfig_irq()?
>> Many operations are excluded by the port->mutex.
> 
> Actually I don't have any concerns as long as console_lock() is used,
> but I thought protecting port was better during auto_irq
> or register operations as same as autoconfig().
> 
> I was thinking they are used as the following purposes;
>    console_lock()
>     + Make sure serial8250_console_write() doesn't disable interrupt,
>       try to get port->lock or touch the ctrl register of the port.
>       # serial8250_console_write() can be called in any context.
>    spin_lock()
>     + Make sure the probing runs on the current CPU only
>       to handle a serial irq by itself after setting irq affinity.
>     + Make sure any other CPUs don't touch the ctrl register of the port.
> 
> It seems my test code has been working fine so far,
> but let me know if you have any concerns about using spin_lock()
> instead of preempt_disable().

If you turn on lockdep, taking the port->lock without disabling irq will
assert.

A quick static analysis shows autoconfig_irq() reachable via 2 different
call trees:

[1]  uart_add_one_port()
        lock global port_mutex (to prevent concurrent port add/remove)
        lock port->mutex
        uart_configure_port()
           ops->config_port => serial8250_config_port()
              autoconfig_irq()

[2]  ioctl(TIOCSERCONFIG)
        uart_do_autoconfig()
           lock port->mutex
           uart_shutdown()
           ops->config_port => serial8250_config_port()
              autoconfig_irq()

Call tree #1 cannot execute concurrently with any other driver function
because the tty device doesn't even exist at that time.

ioctl(TIOCSERCONFIG) -- call tree #2 -- is pretty much a hack and tries
to do its best to prevent concurrent driver function/hardware access.
So it takes the port->mutex which prevents many concurrent operations,
and shuts down the port hardware. In other words, the autoconfig operation
is intended to be exclusive of any other concurrent hardware access (except
console).

I say 'intended' because this is broken if the line discipline is echoing;
I just fixed this in uart_close() and now realize it's possible wherever
uart_shutdown() is called -- so I need to fix that harder. But my point is
that no other lock should not be necessary.

Please feel free to double-check my work.

Regards,
Peter Hurley

PS -I attached a catalog of concurrent operations excluded by port->mutex.

--------------000404080208030609000207
Content-Type: text/plain; charset=UTF-8;
 name="port_mutex.analysis"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="port_mutex.analysis"

Cgo4MjUwX3BvcnQuYwoJdXNlcyBwb3J0LT5tdXRleCB0byBtdXR1YWxseSBleGNsdWRlIC0+
ZmNyIGNoYW5nZXMKCgoKc2VyaWFsIGNvcmU6CiAgICAgICBtdXR1YWxseSBleGNsdWRlZCBv
cGVyYXRpb25zIGd1YXJhbnRlZWQgYnkgcG9ydC0+bXV0ZXgKICAgICAgIAkJLT5jb25maWdf
cG9ydCgpCgkJLT5zZXRfdGVybWlvcygpCgoJCXVhcnRfY29uZmlndXJlX3BvcnQoKQoJCXVh
cnRfcmVzdW1lX3BvcnQoKQoJCXVhcnRfc3VzcGVuZF9wb3J0KCkKCQl1YXJ0X29wZW4oKSA9
PiB1YXJ0X3N0YXJ0dXAoKSA9PiB1YXJ0X3BvcnRfc3RhcnR1cAoJCXVhcnRfaGFuZ3VwKCkg
PT4gdWFydF9zaHV0ZG93bigpICAqKiB0b28gbXVjaCBjb3ZlcmFnZSAqKgoJCXVhcnRfY2xv
c2UoKSA9PiB1YXJ0X3NodXRkb3duKCkgICoqIHNlZSB1YXJ0X2Nsb3NlLmFuYWx5c2lzICoq
CgkJdWFydF9icmVha19jdGwoKQoJCXVhcnRfdGlvY21zZXQoKQoJCXVhcnRfdGlvY21nZXQo
KQoJCXVhcnRfYWRkX29uZV9wb3J0KCkgKiogbW9zdCBvZiB0aGlzIGluY2x1ZGluZyB0dHlf
cG9ydF9yZWdpc3Rlcl9kZXZpY2VfYXR0ciAqKgoKCQkvKiBpb2N0bHMgKi8KCQl1YXJ0X2dl
dF9pbmZvKCkJCS8vIFRJT0NHU0VSSUFMCgkJdWFydF9zZXRfaW5mbygpCQkvLyBUSU9DU1NF
UklBTAoJCXVhcnRfZG9fYXV0b2NvbmZpZygpCS8vIFRJT0NTRVJDT05GSUcKCQl1YXJ0X2dl
dF9sc3JfaW5mbygpCS8vIFRJT0NTRVJHRVRMU1IKCQl1YXJ0X2dldF9yczQ4NV9jb25maWcJ
Ly8gVElPQ0dSUzQ4NQoJCXVhcnRfc2V0X3JzNDg1X2NvbmZpZwkvLyBUSU9DU1JTNDg1CgkJ
Ly8gYW55IHNlcmlhbCBkcml2ZXIgaW9jdGwKCgoJCXVhcnRfY2hhbmdlX3BtKCkKCgkJbGlu
ay91bmxpbmsgdWFydF9zdGF0ZSA8PT4gdWFydF9wb3J0CgkJYWNjZXNzIHRvIHVhcnRfcG9y
dC0+ZmxhZ3MKCgoJCXR0eV9wb3J0X3R0eV9zZXQoKSBmb3IgdWFydCA9PSBpbmNpZGVudGFs
CgoKVE9ETwoKVElPQ01JV0FJVCBoYW5kbGluZyBpcyBtZXNzeTsgc2ltcGxpZnk=
--------------000404080208030609000207--
