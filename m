From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 0/4 V2] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Thu, 01 Mar 2012 11:29:28 -0800
Message-ID: <4F4FCE18.4050400@linux.intel.com>
References: <cover.1330539597.git.dvhart@linux.intel.com> <CANKRQnhFVJAUHAg0qTPFJ8L0L_+-_q4ZtfOnV0wSR1Xa6Mn8UQ@mail.gmail.com> <4F4EC73E.40209@linux.intel.com> <CANKRQnjQ4WB-ExmM5G5diw1LyA_HwySzkNyhKmf4fDLn0ZO7wg@mail.gmail.com> <4F4ECCE8.90207@linux.intel.com> <20120301024028.GA6612@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120301024028.GA6612@feng-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Alan Cox <alan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 02/29/2012 06:40 PM, Feng Tang wrote:
> On Wed, Feb 29, 2012 at 05:12:08PM -0800, Darren Hart wrote:
>>
>>
>> On 02/29/2012 05:06 PM, Tomoya MORINAGA wrote:
>>> 2012=E5=B9=B43=E6=9C=881=E6=97=A59:47 Darren Hart <dvhart@linux.int=
el.com>:
>>>> how do we force the
>>>> 192MHz clock setting BEFORE the pch_phub code runs?
>>>
>>> To realize your requirement,
>>> I think that set by BIOS is only way.
>>
>> Perhaps a pch_phub.bios_uartclk parameter could be used for setting =
up
>> the initial console and once the phub driver is loaded, it can make =
the
>> necessary changes and fix things up in the uart port? This would add=
 a
>> binding between the pch_uart and pch_phub code.
>>
>> Thoughts?
>=20
> To satisfy the early console, one way may be add a x86_init_ops for a=
ll
> Tunnel Creek compatible platform like what Moorestown/Medfield have d=
one,
> and insert the uart clk setting work into one of the early init funct=
ion.=20
>=20

I believe this is inline with what Alan was recommending in his respons=
e
to the V1 patch series, and it sounds like a reasonable next step.

--=20
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
