From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
Date: Thu, 23 May 2019 12:46:38 +0200
Message-ID: <3bdfe2ab-daec-e222-8e2b-cac96fd218a2@xilinx.com>
References: <20190516040931.16276-1-yuehaibing@huawei.com>
 <20190517075502.GE28564@localhost> <20190521101059.GB13612@kroah.com>
 <20190523091839.GC568@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523091839.GC568@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: YueHaibing <yuehaibing@huawei.com>, jslaby@suse.com, shubhrajyoti.datta@xilinx.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Hi Johan,

On 23. 05. 19 11:18, Johan Hovold wrote:
> On Tue, May 21, 2019 at 12:10:59PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, May 17, 2019 at 09:55:02AM +0200, Johan Hovold wrote:
>>> On Thu, May 16, 2019 at 12:09:31PM +0800, YueHaibing wrote:
>>>> If ulite_probe is not called or failed to registed
>>>> uart_register_driver, unload the module will call
>>>> uart_unregister_driver, which will tigger NULL
>>>> pointer dereference like this:
>>>>
>>>> BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
>>>> Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
>>>
>>>> This patch fix this by moving uart_unregister_driver
>>>> to ulite_remove.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/tty/serial/uartlite.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>>>> index b8b912b..2e49fb6 100644
>>>> --- a/drivers/tty/serial/uartlite.c
>>>> +++ b/drivers/tty/serial/uartlite.c
>>>> @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
>>>>  	pm_runtime_disable(&pdev->dev);
>>>>  	pm_runtime_set_suspended(&pdev->dev);
>>>>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>> +	uart_unregister_driver(&ulite_uart_driver);
>>>
>>> This broken. Consider what happens if you have tho ports registered and
>>> you unbind the first.
>>>
>>> Someone else sent a fix for this here
>>>
>>> 	https://lkml.kernel.org/r/20190514033219.169947-1-wangkefeng.wang@huawei.com
>>>
>>> That fix also has some issues, but is still better given the current
>>> state this driver is in.
>>
>> I'm not taking any of these patches until people agree on what needs to
>> be done here :)
> 
> Good. :)
> 
>> Why is this driver so "special" it is having these types of problems?
>> Why can't it do what all other drivers do in this case?
> 
> Apparently some vendor-tree hacks has made it into mainline.

I have designed this change and it didn't go to vendor tree first.
I have been also asking if this is the right way to go.
You can find the whole series started with this RFC
https://lore.kernel.org/lkml/e2039dc5-92ec-d3a1-bc4f-6565a8c901ac@suse.de/t/

https://lkml.org/lkml/2018/6/6/346
and then

https://lkml.org/lkml/2018/9/3/404


And even this step was discussed before in
[RFC PATCH 0/4] serial: uartps: Dynamic allocation
which was July 2017.

And all these patches have been merged by Greg and then I have taken
them back to Xilinx Linux tree.

And the same concept was also applied to uartlite and intention is also
to apply it to pl011 driver to avoid this warning.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/amba-pl011.c?h=v5.2-rc1#n2538

> They're
> trying to register one tty/uart driver per physical port which sounds
> like a terrible idea. And even the implementation is broken as these bug
> reports indicate.

I have followed standard process and I have been asking for advices how
to do it without hardcoded any number and limiting amount of
pre-registered uarts because adding Kconfig options for NR_UARTs was
NACK in past too.
If you know better way how this can be done, please let us know.

And if there is bug we should definitely fix it.


> A series was apparently first posted for xilinks_uartps.c, but that one
> has not yet been merged AFAICT.

Series have been applied by Great 2018-09-18. Feel free to check log here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/tty/serial/xilinx_uartps.c?h=v5.2-rc1


> A similar series was later posted for
> uartlite.c, but only the first half or so got in:
> 
> 	https://lkml.kernel.org/r/1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com
> 
> Actually, it looks like the problems started already with:
> 
> 	https://lkml.kernel.org/r/1533545534-24458-1-git-send-email-shubhrajyoti.datta@gmail.com
> 
> So the first broken commit is
> 
> 	415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> 
> I think the offending patches should be reverted, but unfortunately they
> may no longer revert cleanly since there were some new features (e.g.
> runtime pm) thrown in the mix.

Similar changes have been sent for uartlite but they should use the same
concept as I started to use for uartps.
But based on what I see in linux-next these patches haven't been merged
there.
That's why I don't understand the reason for this patch.

If you want to see latest state of uartlite you can find it out here.
https://github.com/Xilinx/linux-xlnx

Thanks,
Michal
