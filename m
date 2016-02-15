From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
Date: Mon, 15 Feb 2016 15:51:52 +0300
Message-ID: <56C1C9E8.2050300@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
 <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
 <CAJZ5v0i2RCEEZwCN+Ran3Qmasn4yEk1rbfWkZ5QbEkUQWvaJ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i2RCEEZwCN+Ran3Qmasn4yEk1rbfWkZ5QbEkUQWvaJ+g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org



On 02/13/2016 02:07 AM, Rafael J. Wysocki wrote:
> On Fri, Feb 12, 2016 at 6:43 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> The function acpi_table_parse() has some problems:
>> 1 It can be called only from __init code
>> 2 It does not pass any data to the handler
>> 3 It just throws out the value returned from the handler
> 
> So why are those problems?

1.  We need this function to be non-__init because we need access to
some tables at unpredictable time--it may be before or after
the init functions are removed.  For example, SPCR (Serial Port Console
Redirection) table is needed each time a new console is registered.
It can be quite early (console_initcall) or when a module is inserted.

2. Having an additional pointer to void is very useful because it allows
drivers to pass (local) data to the handler.  Without this, we would need 
to have global data and a mutex as it was done in drivers/acpi/scan.c
(vars ape, acpi_probe_count, acpi_probe_lock).

3. Passing the value returned from the callback is less important as it 
could be modelled by having a (return) field in the data passed to 
the handler.  It is very convenient though.

I use these three properties in my next patch of this series.

>> These issues are addressed in this patch
> 
> How are they addressed?

A new function acpi_table_parse2() has been created that is just 
the old acpi_table_parse() without __init, taking the handler with 
additional data pointer and respecting the value returned from 
the handler.  The old acpi_table_parse() was implemented witht this 
new function.  Dropping __init was made possible by the previous 
patch where the attribute of the function early_acpi_os_unmap_memory()
was changed from __init to __ref and by dropping __init from 
acpi_apic_instance.

I understand why this approach is not good and I am going to fix it.

Thank you
Aleksey Makarov
