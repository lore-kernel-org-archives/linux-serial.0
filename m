From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] ACPI: parse SPCR and enable matching console
Date: Thu, 28 Jan 2016 11:40:51 -0800
Message-ID: <56AA6EC3.2040804@hurleysoftware.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-3-git-send-email-aleksey.makarov@linaro.org>
 <56A64E07.10106@hurleysoftware.com> <56A8CCCE.2080509@linaro.org>
 <56A964A2.9040802@hurleysoftware.com> <56AA165F.4010200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56AA165F.4010200@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 01/28/2016 05:23 AM, Aleksey Makarov wrote:
> 
> 
> On 01/28/2016 03:45 AM, Peter Hurley wrote:
>> On 01/27/2016 05:57 AM, Aleksey Makarov wrote:
>>>
>>>
>>> On 01/25/2016 07:32 PM, Peter Hurley wrote:
>>>> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>>>>> 'ARM Server Base Boot Requiremets' [1] mention SPCR (Serial Port
>>>>> Console Redirection Table) [2] as a mandatory ACPI table that
>>>>> specifies the configuration of serial console.
>>>>>
>>>>> Parse this table and check if any registered console match the
>>>>> description.  If it does, enable that console.
>>>>>
>>>>> To implement that, introduce a new member int (*acpi_match)(struct
>>>>> console *, struct acpi_table_spcr *) of struct console.  It allows
>>>>> drivers to check if they provide a matching console device.
>>>>
>>>> Many, many platform proms with all sorts of binary table layout are
>>>> already supported by the existing console infrastructure. Why is ACPI
>>>> different, that requires extensive (and messy) changes to console
>>>> initialization?
>>>
>>> Without this patch, when linux calls register_console(), that function
>>> checks if any console has been enabled so far. 1) If not, it enables the
>>> console being registered. 2) If there exists any enabled console, it
>>> looks at the console_cmdline array. That array holds a list of
>>> consoles that user wishes to enable. There are two ways to append
>>> an item to that list: first is to pass "console=..." option in command
>>> line and second is to call add_preferred_console(char *name, int idx,
>>> char *options). As it is clear from the signature, the function
>>> requires the name of the driver (like "ttyS") and the line id. On the
>>> other hand, the SPCR ACPI table describes console by specifying the
>>> address of it's registers or PCI Device ID / PCI Vendor ID or PCI Bus
>>> Number / PCI Device Number. So to use this function we would need to
>>> have a method to translate this info to the name of terminal and line
>>> index. I could not figure out any way to do that.
>>
>> I'm not sure how this answers my question.
> 
> It does not.  For the actual answer please scroll down.

Where?
All I see is random descriptions of _what_ this patchset does, not _why_.

For example, below you say the first implementation had the wrong order
of initialization. I ask what the "wrong order" is, what the "right order"
should be and how adding "match_acpi()" fixes it.

Your reply:
> There is a race between initialization/registration of consoles and 
> parsing SPCR table.  By the time the console is registered we should 
> have SPCR table parsed and add_preferred_console() called.

1. There's no race because early kernel init is single-threaded.
2. If by "race", you mean static-but-wrong order-of-execution, then I'm
   left to assume you mean that the "right order" is
     a. parse the SPCR table
     b. add_preferred_console
     c. register_console

I agree that this is the correct order-of-initialization.
However, this is not what this patch does.

You continue:
> In the original submission add_preferred_console() was called from
> uart registration code, that requires to parse ACPI table very early
> (and nobody can say how early, because uarts can be registered very
> early.  pl011 is initialized with arch_initcall() for example).

You fail to describe why this is wrong.

You continue:
> I decided to fix this with retrying registration of consoles after
> ACPI is parsed.

Fix what? That your patchset doesn't mandate fixed order-of-initialization
between parsing ACPI for console information and initializing the uart
driver (or any console driver)?

Why not? What is *better* about randomizing the order-of-initialization?


*The reason I brought up earlycon* is because you won't be able to do
this same crazy deferred initialization with earlycon, so you'll be forced
to parse ACPI early, thus rendering the whole retry-console-initialization
pointless.



>> Which existing drivers/arch setup have you studied to conclude that
>> the existing console mechanisms don't work? 
> 
> I studied how add_preferred_console() is used in drivers/of/base.c,
> grepped the tree for it and studied each instance.
> Almost everything I see is dumb calls to this 
> function with hardcoded tty name and line index.  I don't see 
> how this can help.

But did you notice that _none_ of them needed retry loops?
   

>> Have you actually looked
>> at the in-tree callers of add_preferred_console()?
> 
> Yes I have. It looks like you are implying that there is some drivers/arch
> setup that would help to implement this correctly. Could you please
> give me a reference to it?

What does this do?

	add_preferred_console("uart", 0, "io,0x3f8,115200n8");


>>> In the initial version of the patch after getting the reference to the
>>> SPCR ACPI table the full tree of ACPI devices was searched to find any
>>> device with the same address.  When uart_add_one_port() was called
>>> to register a new serial port, the ACPI companion of this port was
>>> compared to the found device. If it was the same device, the code
>>> called add_preferred_console() (the terminal name and line index are
>>> known in uart_add_one_port()).
>>
>> Yeah, I wasn't a fan of that.
>>
>> But I think it was a bad choice to pick SPCR as table format, in the
>> first place. At least DBG2 has the actual ACPI device identifier :/
> 
> I am working on parsing DBG2 to implement earlycon based on 
> info from it.  As I understand,
> - SPCR specifies which existing console should be enabled (= made preferred).
> - DBG2 specifies how kernel can add a new earlycon to the system.
> These are two differend subsystems and both make sense.

This seems an arbitrary distinction.
Many setups just start an earlycon as an option of the normal console.
This is what devicetree does for "stdout-path".


> Also I don't understand how having (optional) ACPI device identifier
> in DBG2 table can help to implement earlycon introduction.

I didn't say it would. But it would help for _console_ because the
device association is clear (as opposed to searching by register address).
Earlycon doesn't need or use devices (in the device model sense).


>>> This original approach had two problems: 
>>>
>>>     1) It works with the SPCR tables that describe consoles only by
>>> the address of the registers. I do not think that consoles that are
>>> described by PCI info will appear in the near future, but decided to
>>> implement this in a generic way. I would like to discuss if this
>>> decision was good.
>>>
>>>     2) Wrong order of initialization.  Many console drivers have already
>>> been registered by the time uart_add_one_port() adds an item to the
>>> console_cmdline array.  There is a similar problem with my
>>> implementation,  but having a dedicated acpi_match() callback I
>>> believe made it simpler to circumwent.
>>
>> I don't see how the "wrong order of initialization" and the need for
>> acpi_match() correlate. What do you mean by "wrong order"? What is the
>> "right order"?
> 
> There is a race between initialization/registration of consoles and 
> parsing SPCR table.  By the time the console is registered we should 
> have SPCR table parsed and add_preferred_console() called.
> 
> In the original submission add_preferred_console() was called from
> uart registration code, that requires to parse ACPI table very early
> (and nobody can say how early, because uarts can be registered very
> early.  pl011 is initialized with arch_initcall() for example).
> 
> I decided to fix this with retrying registration of consoles after
> ACPI is parsed.  I do not like it either, but it is the simplest 
> solution I could suggest.  But it's quite difficult do implement 
> such deferring code in the uart registration and, more important,
> it is wrong as there may be non-uart consoles.
> 
> So acpi_match() is a part of registration retrying mechanism and
> the right place for it is at console registration.

Once you get DBG2 parsed so that you can start an earlycon from
that information, all this "retry" mechanism won't be necessary
because you'll be parsing ACPI early enough to start earlycon
which will be early enough to be before any console registrations too.
You can parse SPCR at the same time.

The way I see it you're taking the existing ACPI code as a given,
and trying to make the rest of the kernel workaround that.
But your approach really needs to be the other way around.

devicetree had to deal with many of these same issues, which is why
there is special-case devicetree code for parsing the flat devicetree
for earlycon startup and other stuff.

And devicetree manages to parse the "stdout-path" before device
initialization as well, which means there's no race wrt console
initialization.

Unfortunately, the easiest way is not always the best way.


>>> That's why I believe we need to add a new funcion pointer to struct
>>> console. On the other hand, I do not understand which existing
>>> structure you are referring.
>>>
>>>> How is this going to work with earlycon?
>>>
>>> If an earlycon that matches SPCR is being registered, the code will enable it.
>>
>> I think you should review how and when an earlycon is specified, initialized
>> and registered before you conclude that this will magically work.
> 
> I reviewed that again and the only issue that I can imagine is that
> ACPI can not make earlycon preferred.  Is it that you are afraid of?
> I believe it should not.  What problems do you see?

I was asking how this would _start_ an earlycon but I see now from
your answers elsewhere that you don't intend to start an earlycon
from the information in SPCR, ever.

I disagree on this distinction. If anything DBG2 should _also_ start a console.
And both should be capable of (optionally) starting an earlycon.

Regards,
Peter Hurley


>>> While it is harmless. Even so I will check for earlycon in the next version
>>> of the patch set, thank you.
>>>
>>>> This commit log is missing the reasoning behind adding locks,
>>>> refactoring into delete_from_console_list(), and retry loops.
>>>
>>> I will add this to the next verion of the series.
>>>
>>> Thank you
>>> Aleksey Makarov
>>>
>>>
>>>>> [1]
>>>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
>>>>>
>>>>> [2] http://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
>>>>>
>>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>>
>>> [ .. ]
>>>
>>

