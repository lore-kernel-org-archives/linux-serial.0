From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri, 03 Apr 2015 23:09:16 -0400
Message-ID: <551F55DC.1000706@hurleysoftware.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>	<1428105875-4038-1-git-send-email-peter@hurleysoftware.com>	<CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>	<551F4C6C.6040108@hurleysoftware.com> <CAE9FiQW=TvocnF=xWh3V2ARAUaR8pSPnv0Y3ixMWfE+KZH138A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQW=TvocnF=xWh3V2ARAUaR8pSPnv0Y3ixMWfE+KZH138A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/03/2015 10:56 PM, Yinghai Lu wrote:
> On Fri, Apr 3, 2015 at 7:29 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 04/03/2015 10:19 PM, Yinghai Lu wrote:
>>> On Fri, Apr 3, 2015 at 5:04 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> Restore undocumented behavior of kernel command line parameters of
>>>> the forms:
>>>>     console=uart[8250],io|mmio|mmio32,<addr>[,options]
>>>>     console=uart[8250],<addr>[,options]
>>>> where 'options' have not been specified; in this case, the hardware
>>>> is assumed to be initialized.
>>>
>>>
>>> Please separated bug fix and other documentation change to different patches.
>>
>> No. The documentation reflects exactly what the bug fix is for.
> 
> what is
> 
> +               uart[<n>],mmio,<addr>[,options]
> +               uart[<n>],mmio32,<addr>[,options]

Wrong patch version; that's v1.


>>> also fix the patch title to make it clear and you need to mention which commit
>>> cause the regression.
>>
>> Please bisect and send bisect log so I know which commit broke
>> your setup.
> 
> I already gave your the patch "title". Here it is again:
> 
> commit c7cef0a84912cab3c9df8949b034e4aa62982ec9
> Author: Peter Hurley <peter@hurleysoftware.com>
> Date:   Mon Mar 9 16:27:12 2015 -0400
> 
>     console: Add extensible console matching

Ok.

>>> This patch fix regression for the hand over.  Thanks.
>>>
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
> ok, think that more.
> 
> with this patch:
> 
> [PATCH] earlycon: 8250: Fix command line regression
> 
> When you have console=uart8250,io,0x3f8 console=uart,io,0x2f8
> 
> you will skip the setup to 0x2f8, as the options is null.
> then if the bios or bootloader only setup baud rate for 0x3f8.
> the user could get nothing from 0x2f8.
> 
> Do you need to call univ8250_console_setup(co, options)
> to set the default baud rate ?

No. The user specified that the console had already been initialized
by leaving out the option string. Isn't that what this whole
email thread has been about?

All this automatic behavior and aliases for the same things just
adds unnecessary complexity and maintenance burden, without measurable
gain.

The real tragedy is that all this was totally unnecessary; what was
wrong with "earlycon=uart,io,0x3f8 console=ttyS0"?

Regards,
Peter Hurley
