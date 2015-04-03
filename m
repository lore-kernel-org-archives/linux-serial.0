From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Fri, 03 Apr 2015 13:38:25 -0400
Message-ID: <551ED011.1030004@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>	<1425932842-21812-12-git-send-email-peter@hurleysoftware.com>	<CAE9FiQVWhfVt8kmj5QumAH2hyp+DRYGeQcBtFrynojXTCOdnQw@mail.gmail.com>	<551CB5DF.1010108@hurleysoftware.com>	<CAE9FiQVKY9KLeBOB0shqTPZZipsmAiU=3_8gzfFhsCW9kxo_uA@mail.gmail.com>	<551D6EEA.6050704@hurleysoftware.com>	<CAE9FiQUGeGuf9z0tQyjOujfRW_RtrWe8ELeKe=W6GNFmRVdpfg@mail.gmail.com>	<CAE9FiQVBxGt_jX-juzf4vvc_6MgiiSixW6RtVTz1aUTw0h3Rmg@mail.gmail.com>	<CAE9FiQVaM650O139RgLcHRv7NGUVVMqSETq0YJ+7OAWVg=0Y0A@mail.gmail.com>	<CAE9FiQUJq0zi2gx0jM1AQp60FhyaytKEMV_mpY+fNc3OATnCBA@mail.gmail.com>	<CAE9FiQV0rfOfo3-=yQOYLDD-x+48_OuWfkHVNy-+oTzWvgr9Ew@mail.gmail.com>	<CAE9FiQX2gQQcD5OrFkDCN5Ew746H1kd5+VgpAcSNvEqg-gFx7Q@mail.gmail.com>	<551E6D61.7000501@hurleysoftware.com>
  <CAE9FiQXaOZOf4hj72iUpDoYgGTuO+jwF34qOeiLw=3rrWK+ucA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQXaOZOf4hj72iUpDoYgGTuO+jwF34qOeiLw=3rrWK+ucA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/03/2015 12:57 PM, Yinghai Lu wrote:
> On Fri, Apr 3, 2015 at 3:37 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 04/02/2015 10:38 PM, Yinghai Lu wrote:
>>> On Thu, Apr 2, 2015 at 5:22 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>
>>>>>>> still have another problem.
>>>>>>> when using console=uart8250,io,0x3f8
>>>>>>> it works as earlycon at first.
>>>>>>> but after handover to normal console
>>>>>>> it will revert back to 9600 again.
>>>>>>
>>>>>> this regression should be caused by:
>>>>>>
>>>>>> commit c7cef0a84912cab3c9df8949b034e4aa62982ec9
>>>>>> Author: Peter Hurley <peter@hurleysoftware.com>
>>>>>> Date:   Mon Mar 9 16:27:12 2015 -0400
>>>>>>
>>>>>>     console: Add extensible console matching
>>>>>
>>>> So your whole patchset will need the first patch ?
>>>>
>>>> or can you just drop the first one patch ?
>>>
>>> Please check attached patch that fix regresion by. commit c7cef0a849
>>> ("console: Add extensible console matching")
>>>
>>> or you have better way?
>>
>> Please re-read my first response to this problem.
>>
> 
>> Also, this expectation is an impediment when adding support for other
>> 8250-like designs that don't have the same 8250 divisor registers
>> (ie., _every_ new design). To properly support this requirement for
>> just the existing 8250 hardware will require special probe_baud()
>> functions for: dw_8250, intel byt, intel mid, omap_8250, exar 17v35 series,
>> omap 1510.
> 
> But you can not break old setup!
> 
> old behavior: console=uart8250,io,0x3f8
> 
> when bootloader or firmware has 115200 used already,
> earlycon, and console all keep 115200.
> 
> Now with your change, earlycon will use 115200 still,
> but console will switch to 9600.
> 
>>
>> Is specifying the line speed on the command line really a burden?
>>
> 
> Yes.  We have two setups, and two BIOS versions.
> product version is using 9600 and devel/debug is using 115200.

Wait -- you have earlycon in a product??

> This is a regression, and must be addressed.
> 
> Greg,
> 
> Please don't send merge request for tty-next to Linus before
> this regression get resolved.
