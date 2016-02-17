From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v3 1/5] ACPI: change __init to __ref for
 early_acpi_os_unmap_memory()
Date: Wed, 17 Feb 2016 16:08:21 +0300
Message-ID: <56C470C5.2080203@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
 <1455559532-8305-2-git-send-email-aleksey.makarov@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDBB@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB4BDCF@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB4BDCF@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Lv,

Thank you for review.

On 02/17/2016 05:51 AM, Zheng, Lv wrote:

[..]

>>> early_acpi_os_unmap_memory() is marked as __init because it calls
>>> __acpi_unmap_table(), but only when acpi_gbl_permanent_mmap is not set.
>>>
>>> acpi_gbl_permanent_mmap is set in __init acpi_early_init()
>>> so it is safe to call early_acpi_os_unmap_memory() from anywhere
>>>
>>> We need this function to be non-__init because we need access to
>>> some tables at unpredictable time--it may be before or after
>>> acpi_gbl_permanent_mmap is set.  For example, SPCR (Serial Port Console
>>> Redirection) table is needed each time a new console is registered.
>>> It can be quite early (console_initcall) or when a module is inserted.
>>> When this table accessed before acpi_gbl_permanent_mmap is set,
>>> the pointer should be unmapped.  This is exactly what this function
>>> does.
>> [Lv Zheng]
>> Why don't you use another API instead of early_acpi_os_unmap_memory() in
>> case you want to unmap things in any cases.
>> acpi_os_unmap_memory() should be the one to match this purpose.
>> It checks acpi_gbl_ppermanent_mmap in acpi_os_unmap_iomem().

As far as I understand, there exist two steps in ACPI initialization:

1. Before acpi_gbl_permanent_mmap is set, tables received with acpi_get_table_with_size()
   are mapped by early_memremap().  If a subsystem gets such a pointer it should be unmapped.

2  After acpi_gbl_permanent_mmap is set this pointer should not be unmapped at all.

That exactly what early_acpi_os_unmap_memory() does--it checks acpi_gbl_permanent_mmap.
If I had used acpi_os_unmap_memory() after acpi_gbl_permanent_mmap had been set,
it would have tried to free that pointer with an oops (actually, I checked that and got that oops).

So using acpi_os_unmap_memory() is not an option here, but early_acpi_os_unmap_memory()
match perfectly.

>> And in fact early_acpi_os_unmap_memory() should be removed.

I don't think so -- I have explained why.  It does different thing.
Probably it (and/or other functions in that api) should be renamed.

> [Lv Zheng] 
> One more thing is:
> If you can't switch your driver to use acpi_os_unmap_memory() instead of early_acpi_os_unmap_memory(),
> then it implies that your driver does have a defect.

I still don't understand what defect, sorry.

> There is an early bootup requirement in Linux.
> Maps acquired during the early stage should be freed by the driver during the early stage.
> And the driver should re-acquire the memory map after booting.

Exactly.  That's why I use early_acpi_os_unmap_memory().  The point is that that code can be
called *before* acpi_gbl_permanent_mmap is set (at early initialization of for example 8250 console)
or *after* acpi_gbl_permanent_mmap is set (at insertion of a module that registers a console), 
We just can not tell if the received table pointer should or sould not be freed with early_memunmap()
(actually __acpi_unmap_table() or whatever) without checking acpi_gbl_permanent_mmap,
but that's all too low level.

Another option, as you describe, is to get this pointer early, don't free it untill
acpi_gbl_permanent_mmap is set, then free it (with early_acpi_os_unmap_memory(), that's 
ok because acpi_gbl_permanent_mmap is set in an init code), then get the persistent 
pointer to the table.  The problem with it is that we can not just watch acpi_gbl_permanent_mmap
to catch this exact moment.  And also accessing acpi_gbl_permanent_mmap is not good as it probably is 
an implementation detail (i. e. too lowlevel) of the ACPI code.
Or I probably miss what you are suggesting.

> This is because, during early bootup stage, there are only limited slots available for drivers to map memory.
> So by changing __init to __ref here, you probably will hide many such defects.

What defects?  This funcions checks acpi_gbl_permanent_mmap.
BTW, exactly the same thing is done in the beginning of acpi_os_unmap_memory() and than's ok, 
that function is __ref.

> And solving issues in this way doesn't seem to be an improvement.

Could you please tell me where I am wrong?  I still don't understand your point.

Thank you
Aleksey Makarov

> 
> Thanks and best regards
> -Lv
> 
>>
>> Thanks and best regards
>> -Lv
>>
>>>
>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>> ---
>>>  drivers/acpi/osl.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>> index 67da6fb..8a552cd 100644
>>> --- a/drivers/acpi/osl.c
>>> +++ b/drivers/acpi/osl.c
>>> @@ -497,7 +497,11 @@ void __ref acpi_os_unmap_memory(void *virt,
>>> acpi_size size)
>>>  }
>>>  EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
>>>
>>> -void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size
>> size)
>>> +/*
>>> + * acpi_gbl_permanent_mmap is set in __init acpi_early_init()
>>> + * so it is safe to call early_acpi_os_unmap_memory() from anywhere
>>> + */
>>> +void __ref early_acpi_os_unmap_memory(void __iomem *virt, acpi_size
>> size)
>>>  {
>>>  	if (!acpi_gbl_permanent_mmap)
>>>  		__acpi_unmap_table(virt, size);
>>> --
>>> 2.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
