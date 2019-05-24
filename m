From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/2 v2] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
Date: Fri, 24 May 2019 14:09:16 +0200
Message-ID: <2036b776-8b8e-d1fd-00b4-c3b046f25a2f@micronovasrl.com>
References: <20190524094825.16151-1-sr@denx.de>
 <20190524102002.GT2781@lahna.fi.intel.com>
 <CAHp75VcMVrYv1MXmmqE9fDXShS=Y8pPdWZ4f1neo=ne88TLZDg@mail.gmail.com>
 <287cdcc8-9a8f-4583-8be9-bd1f95936733@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <287cdcc8-9a8f-4583-8be9-bd1f95936733@denx.de>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hello Stefan,

Il 24/05/2019 13:29, Stefan Roese ha scritto:
> On 24.05.19 13:11, Andy Shevchenko wrote:
>> On Fri, May 24, 2019 at 1:21 PM Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>>>
>>> On Fri, May 24, 2019 at 11:48:24AM +0200, Stefan Roese wrote:
>>>> This patch adds a check for the GPIOs property existence, before the
>>>> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
>>>> support is added (2nd patch in this patch series) on x86 platforms using
>>>> ACPI.
>>>>
>>>> Here Mika's comments from 2016-08-09:
>>>>
>>>> "
>>>> I noticed that with v4.8-rc1 serial console of some of our Broxton
>>>> systems does not work properly anymore. I'm able to see output but input
>>>> does not work.
>>>>
>>>> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
>>>> ("tty/serial/8250: use mctrl_gpio helpers").
>>>>
>>>> The reason why it fails is that in ACPI we do not have names for GPIOs
>>>> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
>>>> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
>>>> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
>>>> UART device in Broxton has following (simplified) ACPI description:
>>>>
>>>>       Device (URT4)
>>>>       {
>>>>           ...
>>>>           Name (_CRS, ResourceTemplate () {
>>>>               GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>>                       "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>>               {
>>>>                   0x003A
>>>>               }
>>>>               GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>>                       "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>>               {
>>>>                   0x003D
>>>>               }
>>>>           })
>>>>
>>>> In this case it finds the first GPIO (0x003A which happens to be RX pin
>>>> for that UART), turns it into GPIO which then breaks input for the UART
>>>> device. This also breaks systems with bluetooth connected to UART (those
>>>> typically have some GPIOs in their _CRS).
>>>>
>>>> Any ideas how to fix this?
>>>>
>>>> We cannot just drop the _CRS index lookup fallback because that would
>>>> break many existing machines out there so maybe we can limit this to
>>>> only DT enabled machines. Or alternatively probe if the property first
>>>> exists before trying to acquire the GPIOs (using
>>>> device_property_present()).
>>>> "
>>>>
>>>> This patch implements the fix suggested by Mika in his statement above.
>>>>
>>
>> We have a board where ASL provides _DSD for CTS and RxD pins.
>> I'm afraid this won't work on it.
> 
> With "won't work" you mean, that the GPIO can't be used for modem
> control in this case in the current implementation (with this
> patchset)? Or do you mean, that the breakage (input does not work
> on Broxton systems) will not be solved by this patch?
> 
> If its the former, then I think that solving this issue is something
> for a new patch, to support modem-control on such platforms as well
> (if needed).
> 
> Please note that this patch is not trying to get modem-control working
> on such ACPI based systems. Its targeted for device-tree enabled
> platforms, using the 8250 serial driver, here specifically a MIPS
> MT7688 based board. And just wants to fix the latter issue mentioned
> above so that the 8250 modem-control support can be accepted in
> mainline.

Take a look here:
https://lkml.org/lkml/2018/6/5/253

It's about waking up 8250 UART.
As I remember that is the problem.
I wanted to try to fix it but had no time.

What it broken as I remember is the capability to wake up linux on uart 
RX. Hope I've understood right at that time.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

>> Basically we need to understand the use of the GPIOs in UART. In our
>> case it's an out-of-band wake up source for UART.
>> Simply requiring GPIOs to be present is not enough.
>>
>> Perhaps property like 'modem-control-gpio-in-use' (this seems a bad
>> name, given for sake of example).
> 
> Thanks,
> Stefan
> 
