From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri, 3 Apr 2015 20:00:55 -0700
Message-ID: <CAE9FiQUfSucr20rj9dQuhbGUWudCHSDOJ_d4SOfHfGxTmre+4w@mail.gmail.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>
	<1428105875-4038-1-git-send-email-peter@hurleysoftware.com>
	<CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>
	<551F4C6C.6040108@hurleysoftware.com>
	<551F5193.3050002@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <551F5193.3050002@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 3, 2015 at 7:50 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 04/03/2015 10:29 PM, Peter Hurley wrote:
>> On 04/03/2015 10:19 PM, Yinghai Lu wrote:
>>> Another regression.
>>> when user have
>>> console=uart8250,io,0x3f8 console=uart8250,io,0x2f8
>>>
>>> before your patchset:
>>> port_0x3f8 is early console, and will be console later.
>>> and port_0x2f8 is ignored, because only ONE early console is allowed.
>>>        and old console setup, only handle ttyS0.
>>>
>>> after your patchset:
>>> port_0x3f8 is early console, and will be console later.
>>> port_0x2f8 will become default console, as new console with match method
>>>    treat all uart8250 as ttyS0.
>>>
>>> Please fix that too.
>>
>> That's a new feature, not a regression.
>
> So, in all seriousness, you actually have this setup and want me to
> fix this?

No.

Just add one count in the console match for it.

>
> IOW, to support more than 1 earlycon in the future will require
> using a totally different command line parameter. Awesome.
>

That is future, right?  Show me patch.

Thanks

Yinghai
