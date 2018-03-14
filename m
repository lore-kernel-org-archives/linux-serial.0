From: Aaron Durbin <adurbin@chromium.org>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 11:12:33 -0600
Message-ID: <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com> <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Aaron Durbin <adurbin@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Doug Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy <jeffy.chen@rock-chips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 14, 2018 at 10:38 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 6:29 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> On Wed, Mar 14, 2018 at 4:54 AM Ricardo Ribalda Delgado <
>> ricardo.ribalda@gmail.com> wrote:
>>> On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org>
>> wrote:
>
>> In fact, the recommended way is to have firmware specify an ACPI SPCR table
>> with OEMID="AMDCZ " (see https://patchwork.kernel.org/patch/10281307/) to
>> configure proper access and address.
>
> Hmm... I was thinking it's already there. And thus, this is just a
> quirk for *existing* firmware that doesn't correctly configured
> hardware.
> (Yes, I'm aware about one nuance in SPCR specification I'm trying to
> address via official ways)
>
>>  With an SPCR table in place,  the
>> kernel command line just becomes "earlycon", with no parameters.
>
> SPCR *provides* an address of UART (required by specification).

What is "it's" in your first sentence? The access method? Baud rate
can't be configured ever in the kernel w/o knowing the input clock to
the uart block. That's already been brought up, and it is inherently a
requirement to know that to recalculate the divisor. These patches are
doing early OOB binding to set the proper input clock because: 1. SPCR
doesn't have that information 2. you nak'd the generic way of
specifying the input clock on the command line. Sadly, this situation
is not unique to this hardware. There is hardware all over that does
not meet the current assumptions being made in the early uart drivers
within the kernel.
