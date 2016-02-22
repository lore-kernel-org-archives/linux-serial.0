From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
 early_acpi_os_unmap_memory()
Date: Mon, 22 Feb 2016 17:35:00 +0300
Message-ID: <56CB1C94.1030107@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
 <1455559532-8305-2-git-send-email-aleksey.makarov@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDBB@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDCF@SHSMSX101.ccr.corp.intel.com>
 <56C470C5.2080203@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4D2DA@SHSMSX101.ccr.corp.intel.com>
 <56C63FB5.2030907@hurleysoftware.com> <56C6F19D.7070206@linaro.org>
 <56C733FE.8070308@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C733FE.8070308@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 02/19/2016 06:25 PM, Peter Hurley wrote:
> On 02/19/2016 02:42 AM, Aleksey Makarov wrote:
>> Hi Peter,
>>
>> Thank you for review.
>>
>> On 02/19/2016 01:03 AM, Peter Hurley wrote:
>>> On 02/17/2016 07:36 PM, Zheng, Lv wrote:
>>>> Hi,
>>>>
>>>>> From: Aleksey Makarov [mailto:aleksey.makarov@linaro.org]
>>>>> Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
>>>>> early_acpi_os_unmap_memory()
>>>>>
>>>>> Hi Lv,
>>>>>
>>>>> Thank you for review.
>>>>>
>>>>> On 02/17/2016 05:51 AM, Zheng, Lv wrote:
>>>>>
>>>>> [..]
>>>>>
>>>>>>>> early_acpi_os_unmap_memory() is marked as __init because it calls
>>>>>>>> __acpi_unmap_table(), but only when acpi_gbl_permanent_mmap is not
>>>>> set.
>>>>>>>>
>>>>>>>> acpi_gbl_permanent_mmap is set in __init acpi_early_init()
>>>>>>>> so it is safe to call early_acpi_os_unmap_memory() from anywhere
>>>>>>>>
>>>>>>>> We need this function to be non-__init because we need access to
>>>>>>>> some tables at unpredictable time--it may be before or after
>>>>>>>> acpi_gbl_permanent_mmap is set.  For example, SPCR (Serial Port Console
>>>>>>>> Redirection) table is needed each time a new console is registered.
>>>>>>>> It can be quite early (console_initcall) or when a module is inserted.
>>>>>>>> When this table accessed before acpi_gbl_permanent_mmap is set,
>>>>>>>> the pointer should be unmapped.  This is exactly what this function
>>>>>>>> does.
>>>>>>> [Lv Zheng]
>>>>>>> Why don't you use another API instead of early_acpi_os_unmap_memory()
>>>>> in
>>>>>>> case you want to unmap things in any cases.
>>>>>>> acpi_os_unmap_memory() should be the one to match this purpose.
>>>>>>> It checks acpi_gbl_ppermanent_mmap in acpi_os_unmap_iomem().
>>>>>
>>>>> As far as I understand, there exist two steps in ACPI initialization:
>>>>>
>>>>> 1. Before acpi_gbl_permanent_mmap is set, tables received with
>>>>> acpi_get_table_with_size()
>>>>>    are mapped by early_memremap().  If a subsystem gets such a pointer it
>>>>> should be unmapped.
>>>>>
>>>>> 2  After acpi_gbl_permanent_mmap is set this pointer should not be unmapped
>>>>> at all.
>>>>>
>>>> [Lv Zheng] 
>>>> This statement is wrong, this should be:
>>>> As long as there is a __reference__ to the mapped table, the pointer should not be unmapped.
>>>> In fact, we have a series to introduce acpi_put_table() to achieve this.
>>>> So your argument is wrong from very first point.
>>>>
>>>>> That exactly what early_acpi_os_unmap_memory() does--it checks
>>>>> acpi_gbl_permanent_mmap.
>>>>> If I had used acpi_os_unmap_memory() after acpi_gbl_permanent_mmap had
>>>>> been set,
>>>>> it would have tried to free that pointer with an oops (actually, I checked that
>>>>> and got that oops).
>>>>>
>>>>> So using acpi_os_unmap_memory() is not an option here, but
>>>>> early_acpi_os_unmap_memory()
>>>>> match perfectly.
>>>> [Lv Zheng] 
>>>> I don't think so.
>>>> For definition block tables, we know for sure there will always be references, until "Unload" opcode is invoked by the AML interpreter.
>>>> But for the data tables, OSPMs should use them in this way:
>>>> 1. map the table
>>>> 2. parse the table and convert it to OS specific structures
>>>> 3. unmap the table
>>>> This helps to shrink virtual memory address space usages.
>>>>
>>>> So from this point of view, all data tables should be unmapped right after being parsed.
>>>> Why do you need the map to be persistent in the kernel address space?
>>>> You can always map a small table, but what if the table size is very big?
>>>>
>>>>>
>>>>>>> And in fact early_acpi_os_unmap_memory() should be removed.
>>>>>
>>>>> I don't think so -- I have explained why.  It does different thing.
>>>>> Probably it (and/or other functions in that api) should be renamed.
>>>>>
>>>> [Lv Zheng] 
>>>> Just let me ask one more question.
>>>> eary_acpi_os_unmap_memory() is not used inside of ACPICA.
>>>> How ACPICA can work with just acpi_os_unmap_memory()?
>>>> You can check drivers/acpi/tbxxx.c.
>>>> Especially: acpi_tb_release_temp_table() and the code invoking it.
>>>>
>>>>>> [Lv Zheng]
>>>>>> One more thing is:
>>>>>> If you can't switch your driver to use acpi_os_unmap_memory() instead of
>>>>> early_acpi_os_unmap_memory(),
>>>>>> then it implies that your driver does have a defect.
>>>>>
>>>>> I still don't understand what defect, sorry.
>>>> [Lv Zheng] 
>>>> If you can't ensure this sequence for using the data tables:
>>>> 1. map the table
>>>> 2. parse the table and convert it to OS specific structure
>>>> 3. unmap the table
>>>> It implies there is a bug in the driver or a bug in the ACPI subsystem core.
>>>
>>> Exactly.
>>>
>>> The central problem here is the way Aleksey is trying to hookup a console.
>>>
>>> What should be happening in this series is:
>>> 1. early map SPCR
>>> 2. parse the SPCR table
>>> 3. call add_preferred_console() to add the SPCR console to the console table
>>> 4. unmap SPCR
>>
>> This does not work.  
>>
>> SPCR specifies address of the console, but add_preferred_console() accepts
>> name of console and its index.  There are no general method to translate address
>> to name at such an early stage.
> 
> 
> 	add_preferred_console(uart, 0, "io,0x3f8,115200");

First argument here should be (char *), the name of the console.
We can not tell it just from the SPCR ACPI table without
introducing new made up names and writting which/case that should be 
supported all the linux lifetime.

I am also not quite shure I can tell the number of tty line (the 0 argument)
just from the address.

Did you mean "uart" here?  As far as I can see, this would match the *earlycon*,
not a regular console, that is not what this patch is about.
It is about selecting regular (non-boot) consoles.

I think translating address to string and then parsing it again is not
unaceptable, but definitely worse than the approach in my patch, where
I compare it directly.

> This will start a console with the 8250 driver. I've already pointed
> this out to you in an earlier review. This is what existing firmware
> already does.
> 
> This is also the method you will use to start an earlycon from the
> DBG2 table, by additionally calling setup_earlycon().
> 
> 
>> There is another reason why I prefer to parse SPCR each time a console is registered.
>> Some consoles can be registered very early in the initialization process and
>> we have to be sure add_preferred_console() is called before that.
> 
> However, since you're not adding a preferred console until uart driver
> loads, there may already be a preferred console selected and running.
> 
> This leads to weird issues like duplicated output on the serial console
> when an earlycon is disabled by the dummy VGA/FB console then the
> serial console starts and reprints the entire boot log on the same
> terminal the earlycon already printed.

Yes, misconfigured systems often misbehave.  In this case I would
question why there is an enabled console (we rely on ACPI to enable it).
And I probably do not understand the scenario, but 
- "earlycon is disabled by the dummy VGA/FB console"
and
- "earlycon already printed"
seem a bit contradictory.

> Better just to parse both the DBG2 and SPCR tables before or at
> early param, and add_preferred_consoles then.

I still don't see why it's better, but I think I explained why it's worse.

>> Of course, I could just parse it once and cache the results, but
>> this still requires accessing SPCR before acpi_gbl_permanent_mmap
>> is set *or* after that.
>>
>>> This trivial and unobtrusive method would already have a 8250 console
>>> running via SPCR. I've already pointed this out in previous reviews.
>>>
>>> Further, the above method *will be required anyway* for the DBG2 table to
>>> start an earlycon, which I've already pointed out in previous reviews.
>>>
>>> Then to enable amba-pl011 console via ACPI, add a console match() method
>>> similar to the 8250 console match() method, univ8250_console_match().
>>
>> So are you suggesting a separate method for each possible console?
>> This is not acceptable.
> 
> All 1 of them???

DBG2 specifies these subtypes of serial drivers:

- Fully 16550-compatible
- 16550 subset compatible with DBGP Revision 1
- ARM PL011 UART
- (deprecated) ARM SBSA (2.x only) Generic UART supporting only 32-bit accesses
- ARM SBSA Generic UART
- ARM DCC
- BCM2835

So it's at least 4 (or 3, I am not sure about ARM DCC) different types and
the list is open.  We would have to support it.

> The 8250 driver already does this, so no work for you there.

"uart" is for boot console, so it is not relevant.  Or did you refer to something else?

> That leaves you needing to write a trivial match() method for just
> the amba-pl011 driver.

Yes, that's probably OK, but in my series drivers should not be modified at all.
I believe that's better.

>> Do you suggest making up separate new name (like "uart" for 8250) for each type
>> of conosole SPCR can specify?
> 
> These are the documented names of the earlycons, which you'll be using
> when you add the DGB2 table parsing.

SPCR is not about earlycons.

Thank you
Aleksey Makarov

>>> FWIW, PCI earlycon + console support was already submitted once before but
>>> never picked up by GregKH. I think I'll just grab that and re-submit so
>>> you would know what to emit for console options in the add_preferred_console().
>>
>> Please do.  Or just send a link to to that submission.
> 
> Ok, will dig through and find it.
> 
>> Do you mean the Leif Lindholm's patches:
> 
> No.
> 
>> https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org
>>
>> He did same thing as I did in my v3 exept 1) he parses ACPI tree to match device
>> (I just match SPCR against data that struct uart_port already has)
>> 2) As you are suggesting, he parses SPCR once at a predefined point in initialization.
>> And that's why his submission is RFC: he had troubles with the order of initialization.
>>
>> Thank you
>> Aleksey Makarov
>>
>>> Regards,
>>> Peter Hurley
>>>
>>>
>>>>>> There is an early bootup requirement in Linux.
>>>>>> Maps acquired during the early stage should be freed by the driver during the
>>>>> early stage.
>>>>>> And the driver should re-acquire the memory map after booting.
>>>>>
>>>>> Exactly.  That's why I use early_acpi_os_unmap_memory().  The point is that
>>>>> that code can be
>>>>> called *before* acpi_gbl_permanent_mmap is set (at early initialization of for
>>>>> example 8250 console)
>>>>> or *after* acpi_gbl_permanent_mmap is set (at insertion of a module that
>>>>> registers a console),
>>>>> We just can not tell if the received table pointer should or sould not be freed
>>>>> with early_memunmap()
>>>>> (actually __acpi_unmap_table() or whatever) without checking
>>>>> acpi_gbl_permanent_mmap,
>>>>> but that's all too low level.
>>>> [Lv Zheng] 
>>>> The driver should make sure that:
>>>> Map/unmap is paired during early stage.
>>>> For late stage, it should be another pair of map/unmap.
>>>>
>>>>>
>>>>> Another option, as you describe, is to get this pointer early, don't free it
>>>> [Lv Zheng] 
>>>> I mean you should free it early.
>>>>
>>>>> untill acpi_gbl_permanent_mmap is set, then free it (with
>>>>> early_acpi_os_unmap_memory(), that's
>>>>> ok because acpi_gbl_permanent_mmap is set in an init code), then get the
>>>>> persistent
>>>>> pointer to the table.  The problem with it is that we can not just watch
>>>>> acpi_gbl_permanent_mmap
>>>>> to catch this exact moment.  And also accessing acpi_gbl_permanent_mmap is
>>>>> not good as it probably is
>>>>> an implementation detail (i. e. too lowlevel) of the ACPI code.
>>>>> Or I probably miss what you are suggesting.
>>>>>
>>>> [Lv Zheng] 
>>>> I mean, you should:
>>>> During early stage:
>>>> acpi_os_map_memory()
>>>> Parse the table.
>>>> acpi_os_unmap_memory().
>>>>
>>>>>> This is because, during early bootup stage, there are only limited slots
>>>>> available for drivers to map memory.
>>>>>> So by changing __init to __ref here, you probably will hide many such defects.
>>>>>
>>>>> What defects?  This funcions checks acpi_gbl_permanent_mmap.
>>>>> BTW, exactly the same thing is done in the beginning of
>>>>> acpi_os_unmap_memory() and than's ok,
>>>>> that function is __ref.
>>>>>
>>>>>> And solving issues in this way doesn't seem to be an improvement.
>>>>>
>>>>> Could you please tell me where I am wrong?  I still don't understand your point.
>>>> [Lv Zheng] 
>>>> But anyway, the defect should be in ACPI subsystem core.
>>>> The cause should be the API itself - acpi_get_table().
>>>>
>>>> So I agree you can use early_acpi_os_unmap_memory() during the period the root causes are not cleaned up.
>>>> But the bottom line is: the driver need to ensure that early_acpi_os_unmap_memory() is always invoked.
>>>> As long as you can ensure this, I don't have objections for deploying early_acpi_os_unmap_memory()  for now.
>>>>
>>>> Thanks and best regards
>>>> -Lv
>>>>
>>>>>
>>>>> Thank you
>>>>> Aleksey Makarov
>>>>>
>>>>>>
>>>>>> Thanks and best regards
>>>>>> -Lv
>>>>>>
>>>>>>>
>>>>>>> Thanks and best regards
>>>>>>> -Lv
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>>>>>>> ---
>>>>>>>>  drivers/acpi/osl.c | 6 +++++-
>>>>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>>>>>>> index 67da6fb..8a552cd 100644
>>>>>>>> --- a/drivers/acpi/osl.c
>>>>>>>> +++ b/drivers/acpi/osl.c
>>>>>>>> @@ -497,7 +497,11 @@ void __ref acpi_os_unmap_memory(void *virt,
>>>>>>>> acpi_size size)
>>>>>>>>  }
>>>>>>>>  EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
>>>>>>>>
>>>>>>>> -void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size
>>>>>>> size)
>>>>>>>> +/*
>>>>>>>> + * acpi_gbl_permanent_mmap is set in __init acpi_early_init()
>>>>>>>> + * so it is safe to call early_acpi_os_unmap_memory() from anywhere
>>>>>>>> + */
>>>>>>>> +void __ref early_acpi_os_unmap_memory(void __iomem *virt, acpi_size
>>>>>>> size)
>>>>>>>>  {
>>>>>>>>  	if (!acpi_gbl_permanent_mmap)
>>>>>>>>  		__acpi_unmap_table(virt, size);
>>>>>>>> --
>>>>>>>> 2.7.1
> 
> 
