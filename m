From: Aaron Durbin <adurbin@chromium.org>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
Date: Sat, 3 Mar 2018 12:12:21 -0700
Message-ID: <CAE2855vimGkRscxZ4tOQ90NGECWe8x2Xg=OV0hgh=Ktf41SU=g@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
 <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
 <CAE2855vbQyMwu8pmH-Sq1kA+=h5TJPWddTWPQoVdEqOn6sAyBw@mail.gmail.com> <CAHp75Vcnuc48xb167hu5nz3iv9uSp2jRw+M-w=yBihex6RTXYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vcnuc48xb167hu5nz3iv9uSp2jRw+M-w=yBihex6RTXYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Aaron Durbin <adurbin@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Brian Norris <briannorris@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <cdall@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, Tom Saeger <tom.saeger@oracle.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, open li
List-Id: linux-serial@vger.kernel.org

On Sat, Mar 3, 2018 at 8:38 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 11:24 PM, Aaron Durbin <adurbin@chromium.org> wrote:
>> On Thu, Mar 1, 2018 at 1:02 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>>>> On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <andy.shevchenko@gmail.com>
>>>> wrote:
>>>
>>>> "earlycon simply does not utilize the information".
>>>>
>>>> earlycon parses iotype, mapbase and baud (from options).  However, it is
>>>> hard-coded to assume that the clock used to generate the UART bitclock is
>>>> always "BASE_BAUD * 16" (1843200).  While this may be true for many UARTs,
>>>> it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48 MHz
>>>> clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk" and
>>>> uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
>>>> actually a set up in acpi_apd.c when there is an acpi match for "AMD0020",
>>>> with a rate read from the .fixed_clk_rate param of the corresponding
>>>> apd_device_desc.
>>>>
>>>> This patch attempts to add a way to inform earlycon about this clock.  As
>>>> noted above, the information is actually already in the kernel and used by
>>>> 8250_dw - I would happy be to hear recommendations for wiring this data
>>>> into earlycon that doesn't require adding another command line arg.
>>>
>>> And it should not require that for sure!
>>
>> But it does require that. There's an input clock to the uart ip block.
>> That is a design constraint by the hardware and is required to make
>> baud calculation work.
>
> I mean it should not be user's headache to provide this information to
> the system.
>
>> It's not a firmware problem.
>
> If it's ACPI, then it's definitely firmware issue, since SPCR provides
> a baudrate.
>

earlycon is another implemetnation of driver binding/settings that is
done before the rest of the kernel driver stack. SPCR provides
baudrate, but that's only one piece to the puzzle. You need to know
the UART input clock which you admit is hard coded in the current
driver. It's not possible to configure the divisor in the UART without
knowing the external clock. That's a real dependency that can't be
worked around. The moment the code attempts to configure the baud it
has to know the input clock -- otherwise the calculation is inherently
wrong. Or are you suggesting to lie about the baud such that the the
math works out even though the values are not real?

>> Its the driver's problem in that it
>> assumes an input clock to the uart block that does not reflect
>> reality.
>
> So, driver can't get this info from device tree or what?

There is no device tree on x86. And ACPI driver binding is not fully
initialized when earlycon is being processed. Yes, this can be solved
by getting up the entire ACPI stack, but then that's not really
'early' in the kernel's initialization sequence.

>
>>> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.
>>
>> That's only possible if there is a clock divider on the front end of
>> the uart block. For this hardware that's not the case. I actually did
>> this very thing on intel chromebook devices, but it was only possible
>> because there was a hardware divider that could be tuned to reach the
>> assumed clock that the code currently assumes.
>
> OK.
>
> --
> With Best Regards,
> Andy Shevchenko
