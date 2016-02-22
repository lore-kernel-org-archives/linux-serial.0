From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
 early_acpi_os_unmap_memory()
Date: Sun, 21 Feb 2016 21:37:39 -0800
Message-ID: <56CA9EA3.9020000@hurleysoftware.com>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
 <1455559532-8305-2-git-send-email-aleksey.makarov@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDBB@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDCF@SHSMSX101.ccr.corp.intel.com>
 <56C470C5.2080203@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4D2DA@SHSMSX101.ccr.corp.intel.com>
 <56C63FB5.2030907@hurleysoftware.com> <56C6F19D.7070206@linaro.org>
 <56C733FE.8070308@hurleysoftware.com>
 <79D370BB-B7A3-4540-B7FB-81D5806853D6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <79D370BB-B7A3-4540-B7FB-81D5806853D6@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, harba@codeaurora.org
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 02/19/2016 09:20 AM, Christopher Covington wrote:
> 
> 
> On February 19, 2016 10:25:50 AM EST, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 02/19/2016 02:42 AM, Aleksey Makarov wrote:
>>> Hi Peter,
>>>
>>> Thank you for review.
>>>
>>> On 02/19/2016 01:03 AM, Peter Hurley wrote:
>>>> On 02/17/2016 07:36 PM, Zheng, Lv wrote:
>>>>> Hi,
>>>>>
>>>>>> From: Aleksey Makarov [mailto:aleksey.makarov@linaro.org]
>>>>>> Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
>>>>>> early_acpi_os_unmap_memory()
>>>>>>
>>>>>> Hi Lv,
>>>>>>
>>>>>> Thank you for review.
>>>>>>
>>>>>> On 02/17/2016 05:51 AM, Zheng, Lv wrote:
>>>>>>
>>>>>> [..]
>>>>>>
>>>>>>>>> early_acpi_os_unmap_memory() is marked as __init because it
>> calls
>>>>>>>>> __acpi_unmap_table(), but only when acpi_gbl_permanent_mmap is
>> not
>>>>>> set.
>>>>>>>>>
>>>>>>>>> acpi_gbl_permanent_mmap is set in __init acpi_early_init()
>>>>>>>>> so it is safe to call early_acpi_os_unmap_memory() from
>> anywhere
>>>>>>>>>
>>>>>>>>> We need this function to be non-__init because we need access
>> to
>>>>>>>>> some tables at unpredictable time--it may be before or after
>>>>>>>>> acpi_gbl_permanent_mmap is set.  For example, SPCR (Serial Port
>> Console
>>>>>>>>> Redirection) table is needed each time a new console is
>> registered.
>>>>>>>>> It can be quite early (console_initcall) or when a module is
>> inserted.
>>>>>>>>> When this table accessed before acpi_gbl_permanent_mmap is set,
>>>>>>>>> the pointer should be unmapped.  This is exactly what this
>> function
>>>>>>>>> does.
>>>>>>>> [Lv Zheng]
>>>>>>>> Why don't you use another API instead of
>> early_acpi_os_unmap_memory()
>>>>>> in
>>>>>>>> case you want to unmap things in any cases.
>>>>>>>> acpi_os_unmap_memory() should be the one to match this purpose.
>>>>>>>> It checks acpi_gbl_ppermanent_mmap in acpi_os_unmap_iomem().
>>>>>>
>>>>>> As far as I understand, there exist two steps in ACPI
>> initialization:
>>>>>>
>>>>>> 1. Before acpi_gbl_permanent_mmap is set, tables received with
>>>>>> acpi_get_table_with_size()
>>>>>>    are mapped by early_memremap().  If a subsystem gets such a
>> pointer it
>>>>>> should be unmapped.
>>>>>>
>>>>>> 2  After acpi_gbl_permanent_mmap is set this pointer should not be
>> unmapped
>>>>>> at all.
>>>>>>
>>>>> [Lv Zheng] 
>>>>> This statement is wrong, this should be:
>>>>> As long as there is a __reference__ to the mapped table, the
>> pointer should not be unmapped.
>>>>> In fact, we have a series to introduce acpi_put_table() to achieve
>> this.
>>>>> So your argument is wrong from very first point.
>>>>>
>>>>>> That exactly what early_acpi_os_unmap_memory() does--it checks
>>>>>> acpi_gbl_permanent_mmap.
>>>>>> If I had used acpi_os_unmap_memory() after acpi_gbl_permanent_mmap
>> had
>>>>>> been set,
>>>>>> it would have tried to free that pointer with an oops (actually, I
>> checked that
>>>>>> and got that oops).
>>>>>>
>>>>>> So using acpi_os_unmap_memory() is not an option here, but
>>>>>> early_acpi_os_unmap_memory()
>>>>>> match perfectly.
>>>>> [Lv Zheng] 
>>>>> I don't think so.
>>>>> For definition block tables, we know for sure there will always be
>> references, until "Unload" opcode is invoked by the AML interpreter.
>>>>> But for the data tables, OSPMs should use them in this way:
>>>>> 1. map the table
>>>>> 2. parse the table and convert it to OS specific structures
>>>>> 3. unmap the table
>>>>> This helps to shrink virtual memory address space usages.
>>>>>
>>>>> So from this point of view, all data tables should be unmapped
>> right after being parsed.
>>>>> Why do you need the map to be persistent in the kernel address
>> space?
>>>>> You can always map a small table, but what if the table size is
>> very big?
>>>>>
>>>>>>
>>>>>>>> And in fact early_acpi_os_unmap_memory() should be removed.
>>>>>>
>>>>>> I don't think so -- I have explained why.  It does different
>> thing.
>>>>>> Probably it (and/or other functions in that api) should be
>> renamed.
>>>>>>
>>>>> [Lv Zheng] 
>>>>> Just let me ask one more question.
>>>>> eary_acpi_os_unmap_memory() is not used inside of ACPICA.
>>>>> How ACPICA can work with just acpi_os_unmap_memory()?
>>>>> You can check drivers/acpi/tbxxx.c.
>>>>> Especially: acpi_tb_release_temp_table() and the code invoking it.
>>>>>
>>>>>>> [Lv Zheng]
>>>>>>> One more thing is:
>>>>>>> If you can't switch your driver to use acpi_os_unmap_memory()
>> instead of
>>>>>> early_acpi_os_unmap_memory(),
>>>>>>> then it implies that your driver does have a defect.
>>>>>>
>>>>>> I still don't understand what defect, sorry.
>>>>> [Lv Zheng] 
>>>>> If you can't ensure this sequence for using the data tables:
>>>>> 1. map the table
>>>>> 2. parse the table and convert it to OS specific structure
>>>>> 3. unmap the table
>>>>> It implies there is a bug in the driver or a bug in the ACPI
>> subsystem core.
>>>>
>>>> Exactly.
>>>>
>>>> The central problem here is the way Aleksey is trying to hookup a
>> console.
>>>>
>>>> What should be happening in this series is:
>>>> 1. early map SPCR
>>>> 2. parse the SPCR table
>>>> 3. call add_preferred_console() to add the SPCR console to the
>> console table
>>>> 4. unmap SPCR
>>>
>>> This does not work.  
>>>
>>> SPCR specifies address of the console, but add_preferred_console()
>> accepts
>>> name of console and its index.  There are no general method to
>> translate address
>>> to name at such an early stage.
>>
>>
>> 	add_preferred_console(uart, 0, "io,0x3f8,115200");
>>
>> This will start a console with the 8250 driver. I've already pointed
>> this out to you in an earlier review. This is what existing firmware
>> already does.
>>
>> This is also the method you will use to start an earlycon from the
>> DBG2 table, by additionally calling setup_earlycon().
> 
> Can the device specified in DBG2 be used for both earlycon and KGDB?

I don't see why not. Since earlycon is a bootconsole, it's disabled when
the first regular console starts. I use earlycon + KGDB now on the same
device (ttyS0 == uart0 @ mmio 0x44e09000):

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc2+ (peter@thor) (gcc version 5.1.1 20150608 (Linaro GCC 5.1-2015.08) ) #60 PREE
MPT Sun Feb 21 20:17:16 PST 2016
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: TI AM335x BeagleBone Black
[    0.000000] earlycon: omap8250 at MMIO 0x44e09000 (options '')
[    0.000000] bootconsole [omap8250] enabled

....

[    3.086800] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
[    3.099818] console [ttyS0] disabled
[    3.112402] 44e09000.serial: ttyS0 at MMIO 0x44e09000 (irq = 158, base_baud = 3000000) is a 8250
[    3.121575] console [ttyS0] enabled
[    3.121575] console [ttyS0] enabled
[    3.128678] bootconsole [omap8250] disabled
[    3.128678] bootconsole [omap8250] disabled
[    3.152397] 481a8000.serial: ttyS4 at MMIO 0x481a8000 (irq = 159, base_baud = 3000000) is a 8250
[    3.176393] 481aa000.serial: ttyS5 at MMIO 0x481aa000 (irq = 160, base_baud = 3000000) is a 8250
[    3.185998] KGDB: Registered I/O driver kgdboc
[    3.200374] KGDB: Waiting for connection from remote gdb...


> If it can only be used for one, let's make sure the choice of
> earlycon vs KGDB is intentional rather than accidental.

If anything, a future feature would be to run KGDB over earlycon.

Regards,
Peter Hurley
