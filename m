From: Aaron Durbin <adurbin@chromium.org>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Date: Sun, 1 Apr 2018 11:54:41 -0700
Message-ID: <CAE2855tmMwbOWDOs-iJS7i35=Y7gt0xun4ApfhZyY9Kr5N3NJA@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
 <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
 <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
 <20180326192428.71c23abf@alans-desktop> <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
 <20180329143400.6d9256a5@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329143400.6d9256a5@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Aaron Durbin <adurbin@chromium.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Doug Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy <jeffy.chen@rock-chips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 29, 2018 at 6:34 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Mon, 26 Mar 2018 20:56:45 -0600
> Aaron Durbin <adurbin@chromium.org> wrote:
>
>> On Mon, Mar 26, 2018 at 12:24 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >> Sadly, this situation
>> >> is not unique to this hardware. There is hardware all over that does
>> >> not meet the current assumptions being made in the early uart drivers
>> >> within the kernel.
>> >
>> > Is there any fundamental reason you can't just embed dt entries in the
>> > ACPI table to describe the other features you need. I appreciate it
>> > doesn't solve the generic PC case but it ought to help for anything where
>> > the firmware cares about Linux ?
>>
>> What's the method for doing that? Using _DSD methods? Or have a
>> pointer to examples? Sorry, I haven't spelunked into the current state
>> of bridging ACPI and devicetree in a while.
>
> ACPI 5.1 adds an _DSD method UUID for device properties.
>
> The kernel device_property_* interface will pick them up just as if they
> came from DT tables etc.

But we don't have the full ACPI interpreter up in the early part of
the kernel. All these 'early' devices have their own setup/config
which is the source of the issue. Or maybe I am wrong about the full
interpreter and the early drivers are just not taking advantage of the
ACPI device binding?

-Aaron
