From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
 early_acpi_os_unmap_memory()
Date: Fri, 26 Feb 2016 13:33:17 +0300
Message-ID: <56D029ED.6020406@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
 <1455559532-8305-2-git-send-email-aleksey.makarov@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDBB@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDCF@SHSMSX101.ccr.corp.intel.com>
 <56C470C5.2080203@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4D2DA@SHSMSX101.ccr.corp.intel.com>
 <56C63FB5.2030907@hurleysoftware.com>
 <1AE640813FDE7649BE1B193DEA596E883BB4D5A0@SHSMSX101.ccr.corp.intel.com>
 <56C6F660.9020407@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4D949@SHSMSX101.ccr.corp.intel.com>
 <56CB21FA.1090302@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB5D340@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB5D340@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org



On 02/26/2016 09:39 AM, Zheng, Lv wrote:
> Hi, Aleksey
> 
> Though I promised you to have this done in 1 week:
> https://github.com/zetalog/acpica/commit/a234569
> I implemented the idea and tried the cleanup in Linux.
> But unfortunately the cleanup triggered several locking issues inside of ACPICA table API users.
> So it doesn't seem to be so easy and quick to make it upstreamed.
> And I have to continue to test and improve the cleanup.
> 
> I'm sorry for that, hope you can find substitute solutions before the cleanup is upstreamed.

That's fine, I use the approach I described in the last mail, it works.

Thank you
Aleksey Makarov

> 
> Thanks and best regards
> -Lv
> 
>> From: Aleksey Makarov [mailto:aleksey.makarov@linaro.org]
>> Sent: Monday, February 22, 2016 10:58 PM
>> Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
>> early_acpi_os_unmap_memory()
>>
>> Hi,
>>
>> On 02/22/2016 05:24 AM, Zheng, Lv wrote:
>>> Hi,
>>>
>>>> From: Aleksey Makarov [mailto:aleksey.makarov@linaro.org]
>>>> Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
>>>> early_acpi_os_unmap_memory()
>>>>
>>>> Hi Lv,
>>>>
>>>> On 02/19/2016 05:58 AM, Zheng, Lv wrote:
>>>>> Hi,
>>>>>
>>>>>> From: Peter Hurley [mailto:peter@hurleysoftware.com]
>>>>>> Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
>>>>>> early_acpi_os_unmap_memory()
>>>>>>
>>>>>> On 02/17/2016 07:36 PM, Zheng, Lv wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>>> From: Aleksey Makarov [mailto:aleksey.makarov@linaro.org]
>>>>>>>> Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
>>>>>>>> early_acpi_os_unmap_memory()
>>>>>>>>
>>>>>>>> Hi Lv,
>>>>>>>>
>>>>>>>> Thank you for review.
>>>>>>>>
>>>>>>>> On 02/17/2016 05:51 AM, Zheng, Lv wrote:
>>>>>>>>
>>>>>>>> [..]
>>>>>>>>
>>>>>>>>>>> early_acpi_os_unmap_memory() is marked as __init because it calls
>>>>>>>>>>> __acpi_unmap_table(), but only when acpi_gbl_permanent_mmap
>> is
>>>> not
>>>>>>>> set.
>>>>>>>>>>>
>>>>>>>>>>> acpi_gbl_permanent_mmap is set in __init acpi_early_init()
>>>>>>>>>>> so it is safe to call early_acpi_os_unmap_memory() from anywhere
>>>>>>>>>>>
>>>>>>>>>>> We need this function to be non-__init because we need access to
>>>>>>>>>>> some tables at unpredictable time--it may be before or after
>>>>>>>>>>> acpi_gbl_permanent_mmap is set.  For example, SPCR (Serial Port
>>>>>> Console
>>>>>>>>>>> Redirection) table is needed each time a new console is registered.
>>>>>>>>>>> It can be quite early (console_initcall) or when a module is inserted.
>>>>>>>>>>> When this table accessed before acpi_gbl_permanent_mmap is set,
>>>>>>>>>>> the pointer should be unmapped.  This is exactly what this function
>>>>>>>>>>> does.
>>>>>>>>>> [Lv Zheng]
>>>>>>>>>> Why don't you use another API instead of
>>>>>> early_acpi_os_unmap_memory()
>>>>>>>> in
>>>>>>>>>> case you want to unmap things in any cases.
>>>>>>>>>> acpi_os_unmap_memory() should be the one to match this purpose.
>>>>>>>>>> It checks acpi_gbl_ppermanent_mmap in acpi_os_unmap_iomem().
>>>>>>>>
>>>>>>>> As far as I understand, there exist two steps in ACPI initialization:
>>>>>>>>
>>>>>>>> 1. Before acpi_gbl_permanent_mmap is set, tables received with
>>>>>>>> acpi_get_table_with_size()
>>>>>>>>    are mapped by early_memremap().  If a subsystem gets such a pointer
>> it
>>>>>>>> should be unmapped.
>>>>>>>>
>>>>>>>> 2  After acpi_gbl_permanent_mmap is set this pointer should not be
>>>>>> unmapped
>>>>>>>> at all.
>>>>>>>>
>>>>>>> [Lv Zheng]
>>>>>>> This statement is wrong, this should be:
>>>>>>> As long as there is a __reference__ to the mapped table, the pointer
>> should
>>>>>> not be unmapped.
>>>>>>> In fact, we have a series to introduce acpi_put_table() to achieve this.
>>>>>>> So your argument is wrong from very first point.
>>>>>>>
>>>>>>>> That exactly what early_acpi_os_unmap_memory() does--it checks
>>>>>>>> acpi_gbl_permanent_mmap.
>>>>>>>> If I had used acpi_os_unmap_memory() after
>> acpi_gbl_permanent_mmap
>>>>>> had
>>>>>>>> been set,
>>>>>>>> it would have tried to free that pointer with an oops (actually, I
>> checked
>>>> that
>>>>>>>> and got that oops).
>>>>>>>>
>>>>>>>> So using acpi_os_unmap_memory() is not an option here, but
>>>>>>>> early_acpi_os_unmap_memory()
>>>>>>>> match perfectly.
>>>>>>> [Lv Zheng]
>>>>>>> I don't think so.
>>>>>>> For definition block tables, we know for sure there will always be
>>>> references,
>>>>>> until "Unload" opcode is invoked by the AML interpreter.
>>>>>>> But for the data tables, OSPMs should use them in this way:
>>>>>>> 1. map the table
>>>>>>> 2. parse the table and convert it to OS specific structures
>>>>>>> 3. unmap the table
>>>>>>> This helps to shrink virtual memory address space usages.
>>>>>>>
>>>>>>> So from this point of view, all data tables should be unmapped right
>> after
>>>>>> being parsed.
>>>>>>> Why do you need the map to be persistent in the kernel address space?
>>>>>>> You can always map a small table, but what if the table size is very big?
>>>>>>>
>>>>>>>>
>>>>>>>>>> And in fact early_acpi_os_unmap_memory() should be removed.
>>>>>>>>
>>>>>>>> I don't think so -- I have explained why.  It does different thing.
>>>>>>>> Probably it (and/or other functions in that api) should be renamed.
>>>>>>>>
>>>>>>> [Lv Zheng]
>>>>>>> Just let me ask one more question.
>>>>>>> eary_acpi_os_unmap_memory() is not used inside of ACPICA.
>>>>>>> How ACPICA can work with just acpi_os_unmap_memory()?
>>>>>>> You can check drivers/acpi/tbxxx.c.
>>>>>>> Especially: acpi_tb_release_temp_table() and the code invoking it.
>>>>>>>
>>>>>>>>> [Lv Zheng]
>>>>>>>>> One more thing is:
>>>>>>>>> If you can't switch your driver to use acpi_os_unmap_memory()
>> instead
>>>> of
>>>>>>>> early_acpi_os_unmap_memory(),
>>>>>>>>> then it implies that your driver does have a defect.
>>>>>>>>
>>>>>>>> I still don't understand what defect, sorry.
>>>>>>> [Lv Zheng]
>>>>>>> If you can't ensure this sequence for using the data tables:
>>>>>>> 1. map the table
>>>>>>> 2. parse the table and convert it to OS specific structure
>>>>>>> 3. unmap the table
>>>>>>> It implies there is a bug in the driver or a bug in the ACPI subsystem core.
>>>>>>
>>>>>> Exactly.
>>>>> [Lv Zheng]
>>>>> So it looks to me:
>>>>> Changing __init to __ref here is entirely not acceptable.
>>>>> This API should stay being invoked during early stage.
>>>>> Otherwise, it may leave us untrackable code that maps tables during early
>>>> stage and leaks maps to the late stage.
>>>>> If Linux contains such kind of code, I'm afraid, it will become impossible to
>>>> introduce acpi_put_table() to clean up the mappings.
>>>>> Because when acpi_put_table() is called during the late stage to free a map
>>>> acquired during the early stage, it then obviously will end up with panic.
>>>>
>>>> Can you please sugggest a common method to access ACPI tables that
>>>> works both before *and* after acpi_gbl_permanent_mmap is set and __init
>>>> code
>>>> is removed?
>>> [Lv Zheng]
>>> Do not change __init for now.
>>>
>>> Currently you should:
>>> 1. before acpi_gbl_permanent_mmap is set:
>>> acpi_get_table_with_size()
>>> parse the table
>>> early_acpi_os_unmap_memory()
>>> Do your driver early stuff here
>>>
>>> 2. after acpi_gbl_permanent_mmap is set:
>>> acpi_get_table()
>>> Parse the table
>>> Do your driver late stuff here
>>> <- note there is no API now being an inverse of acpi_get_table().
>>
>> That's fine.  These are two different methods to access the table.
>> I need one that works in both cases.  Of course, they could be combined,
>> but I am not sure if I can access the acpi_gbl_permanent_mmap variable--it
>> seems to be an implementation detail of ACPI code.
>>
>> Instead I am going to use the 1st method once and cache the result like this:
>>
>>
>> static int __init parse(void)
>> {
>> 	static bool parsed;
>>
>> 	if (!parsed) {
>> 		acpi_get_table_with_size()
>> 		/* parse the table and cache the result */
>> 		early_acpi_os_unmap_memory()
>> 		parse = true;
>> 	}
>> }
>>
>> arch_initcal(parse());
>>
>> int __ref the_handler_where_I_need_the_parse_results(void)
>> {
>> 	parse();
>>
>> 	/* use the data */
>> }
>>
>> I hope you are OK with it.
>>
>>> Besides, I'm about to insert error messages between 1 and 2.
>>> If an early map is not release, error message will be prompted to the
>> developers.
>>
>> AFAICS, there is such an error message and I saw it.
>> Refer to check_early_ioremap_leak() at mm/early_ioremap.c
>>
>>> And if you don't follow the above rules, it mean you are trying to lay a mine,
>> waiting for me to step on it.
>>> That's why this change is entirely not acceptable.
>>
>> Ok, I see.
>>
>>> I'm about to send out the cleanup series in 1 week, and will Cc you.
>>> You can rebase your code on top of the cleanup series.
>>
>> Thank you
>> Aleksey Makarov
>>
>>>
>>> Thanks and best regards
>>> -Lv
>>>
>>>>
>>>>> Thanks and best regards
>>>>> -Lv
>>>>>
>>>>>> The central problem here is the way Aleksey is trying to hookup a console.
>>>>>>
>>>>>> What should be happening in this series is:
>>>>>> 1. early map SPCR
>>>>>> 2. parse the SPCR table
>>>>>> 3. call add_preferred_console() to add the SPCR console to the console
>>>> table
>>>>>> 4. unmap SPCR
>>>>>>
>>>>>> This trivial and unobtrusive method would already have a 8250 console
>>>>>> running via SPCR. I've already pointed this out in previous reviews.
>>>>>>
>>>>>> Further, the above method *will be required anyway* for the DBG2 table
>> to
>>>>>> start an earlycon, which I've already pointed out in previous reviews.
>>>>>>
>>>>>> Then to enable amba-pl011 console via ACPI, add a console match()
>> method
>>>>>> similar to the 8250 console match() method, univ8250_console_match().
>>>>>>
>>>>>> FWIW, PCI earlycon + console support was already submitted once before
>>>> but
>>>>>> never picked up by GregKH. I think I'll just grab that and re-submit so
>>>>>> you would know what to emit for console options in the
>>>>>> add_preferred_console().
>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Peter Hurley
>>>>>>
>>>>>>
>>>>>>>>> There is an early bootup requirement in Linux.
>>>>>>>>> Maps acquired during the early stage should be freed by the driver
>> during
>>>>>> the
>>>>>>>> early stage.
>>>>>>>>> And the driver should re-acquire the memory map after booting.
>>>>>>>>
>>>>>>>> Exactly.  That's why I use early_acpi_os_unmap_memory().  The point is
>>>> that
>>>>>>>> that code can be
>>>>>>>> called *before* acpi_gbl_permanent_mmap is set (at early initialization
>>>> of
>>>>>> for
>>>>>>>> example 8250 console)
>>>>>>>> or *after* acpi_gbl_permanent_mmap is set (at insertion of a module
>>>> that
>>>>>>>> registers a console),
>>>>>>>> We just can not tell if the received table pointer should or sould not be
>>>> freed
>>>>>>>> with early_memunmap()
>>>>>>>> (actually __acpi_unmap_table() or whatever) without checking
>>>>>>>> acpi_gbl_permanent_mmap,
>>>>>>>> but that's all too low level.
>>>>>>> [Lv Zheng]
>>>>>>> The driver should make sure that:
>>>>>>> Map/unmap is paired during early stage.
>>>>>>> For late stage, it should be another pair of map/unmap.
>>>>>>>
>>>>>>>>
>>>>>>>> Another option, as you describe, is to get this pointer early, don't free it
>>>>>>> [Lv Zheng]
>>>>>>> I mean you should free it early.
>>>>>>>
>>>>>>>> untill acpi_gbl_permanent_mmap is set, then free it (with
>>>>>>>> early_acpi_os_unmap_memory(), that's
>>>>>>>> ok because acpi_gbl_permanent_mmap is set in an init code), then get
>>>> the
>>>>>>>> persistent
>>>>>>>> pointer to the table.  The problem with it is that we can not just watch
>>>>>>>> acpi_gbl_permanent_mmap
>>>>>>>> to catch this exact moment.  And also accessing
>>>> acpi_gbl_permanent_mmap
>>>>>> is
>>>>>>>> not good as it probably is
>>>>>>>> an implementation detail (i. e. too lowlevel) of the ACPI code.
>>>>>>>> Or I probably miss what you are suggesting.
>>>>>>>>
>>>>>>> [Lv Zheng]
>>>>>>> I mean, you should:
>>>>>>> During early stage:
>>>>>>> acpi_os_map_memory()
>>>>>>> Parse the table.
>>>>>>> acpi_os_unmap_memory().
>>>>>>>
>>>>>>>>> This is because, during early bootup stage, there are only limited slots
>>>>>>>> available for drivers to map memory.
>>>>>>>>> So by changing __init to __ref here, you probably will hide many such
>>>>>> defects.
>>>>>>>>
>>>>>>>> What defects?  This funcions checks acpi_gbl_permanent_mmap.
>>>>>>>> BTW, exactly the same thing is done in the beginning of
>>>>>>>> acpi_os_unmap_memory() and than's ok,
>>>>>>>> that function is __ref.
>>>>>>>>
>>>>>>>>> And solving issues in this way doesn't seem to be an improvement.
>>>>>>>>
>>>>>>>> Could you please tell me where I am wrong?  I still don't understand
>> your
>>>>>> point.
>>>>>>> [Lv Zheng]
>>>>>>> But anyway, the defect should be in ACPI subsystem core.
>>>>>>> The cause should be the API itself - acpi_get_table().
>>>>>>>
>>>>>>> So I agree you can use early_acpi_os_unmap_memory() during the
>> period
>>>> the
>>>>>> root causes are not cleaned up.
>>>>>>> But the bottom line is: the driver need to ensure that
>>>>>> early_acpi_os_unmap_memory() is always invoked.
>>>>>>> As long as you can ensure this, I don't have objections for deploying
>>>>>> early_acpi_os_unmap_memory()  for now.
>>>>>>>
>>>>>>> Thanks and best regards
>>>>>>> -Lv
>>>>>>>
>>>>>>>>
>>>>>>>> Thank you
>>>>>>>> Aleksey Makarov
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks and best regards
>>>>>>>>> -Lv
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks and best regards
>>>>>>>>>> -Lv
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>>>>>>>>>> ---
>>>>>>>>>>>  drivers/acpi/osl.c | 6 +++++-
>>>>>>>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>>>>>>>>>> index 67da6fb..8a552cd 100644
>>>>>>>>>>> --- a/drivers/acpi/osl.c
>>>>>>>>>>> +++ b/drivers/acpi/osl.c
>>>>>>>>>>> @@ -497,7 +497,11 @@ void __ref acpi_os_unmap_memory(void
>>>> *virt,
>>>>>>>>>>> acpi_size size)
>>>>>>>>>>>  }
>>>>>>>>>>>  EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
>>>>>>>>>>>
>>>>>>>>>>> -void __init early_acpi_os_unmap_memory(void __iomem *virt,
>>>>>> acpi_size
>>>>>>>>>> size)
>>>>>>>>>>> +/*
>>>>>>>>>>> + * acpi_gbl_permanent_mmap is set in __init acpi_early_init()
>>>>>>>>>>> + * so it is safe to call early_acpi_os_unmap_memory() from
>>>> anywhere
>>>>>>>>>>> + */
>>>>>>>>>>> +void __ref early_acpi_os_unmap_memory(void __iomem *virt,
>>>>>> acpi_size
>>>>>>>>>> size)
>>>>>>>>>>>  {
>>>>>>>>>>>  	if (!acpi_gbl_permanent_mmap)
>>>>>>>>>>>  		__acpi_unmap_table(virt, size);
>>>>>>>>>>> --
>>>>>>>>>>> 2.7.1
>>>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
>> in
>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-
>>>> info.html
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-
>> info.html
>>>>>
