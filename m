From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [RESEND PATCH] serial: samsung: fix device name
Date: Mon, 27 Sep 2010 01:18:12 +0100
Message-ID: <4C9FE2C4.8070302@fluff.org>
References: <20100923190212.18863.25678.stgit@darius-desktop>	<4C9BE577.4050504@fluff.org>	<AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com> <4C9CD3E0.6060000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dsl78-143-211-26.in-addr.fast.co.uk ([78.143.211.26]:37798 "EHLO
	ben-laptop" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757257Ab0I0ASU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 Sep 2010 20:18:20 -0400
In-Reply-To: <4C9CD3E0.6060000@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Darius Augulis <augulis.darius@gmail.com>, kgene.kim@samsung.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org

On 24/09/10 17:37, Paulius Zaleckas wrote:
> On 09/24/2010 09:57 AM, Darius Augulis wrote:
>> Hi,
>>
>> On Fri, Sep 24, 2010 at 2:40 AM, Ben Dooks<ben-linux@fluff.org>  wrote:
>>> On 23/09/10 20:15, Darius Augulis wrote:
>>>> Swap device and driver names in serial/samsung.c
>>>
>>> This is far too short, please see the notes below on trying
>>> to make this more informative.
>>>
>>>> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
>>>> ---
>>>>
>>>> This patch was submitted about 3 months ago, but still not merged.
>>>> There was another similar patch from Joonyoung Shim
>>>> <jy0922.shim@samsung.com>  and was discussed here:
>>>> http://marc.info/?l=linux-serial&m=127416101222281&w=2.
>>>> Joonyoung Shim acked my patch and other people on ARM mailing list
>>>> acked it. The maintainer, Ben Dooks, still not responding for
>>>> a long time. Another maintainer, Kukjin Kim, refused to merge
>>>> it without Ben's review.
>>>> I would like to ask somebody pick up this bugfix.
>>>
>>> I belive last time this was brought up I asked about the affect
>>> this has on the userspace. The following issues would be helpful
>>> or essential to have noted in the header about the effect of this.
>>>
>>> - Does it change the /dev name of the device? if so I would thinl
>>>   carefully about applying it, as it would be a change in the way
>>>   that userspace sees the kernel.
>>
>> It does - now devices are named /dev/s3c2410_serial, and patch changes
>> its name to /dev/ttySAC
>>
>>>
>>> - Does it change the kernel output itself? A note on what diffeences
>>>   can be seen in things like dmesg would be helpful.
>>
>> It does. Serial driver reports device names when probing, so there
>> will appear ttySACx instead of
>> s3c2410_serialx.
>>
>>>
>>> - Are there any other side effects
>>>
>>> - Why is this a bug? Maybe the previous points will explain what is
>>>   going on, but if not, then a reasonably concise description of
>>>   what is going on here.
>>
>> This is bug, because of several points:
>>
>> 1. Because it contradicts kernel documentation. Please read
>> Documentation/arm/Samsung-S3C24XX/Overview.txt line 196.
>> This should be enough to apply this patch.
>>
>> 2. Because s3c2410_serial isn't correct name for serial device node.
>> It's name of Samsung serial driver.
>>
>> 3. Because now almost all userspace systems workaround it by creating
>> symlink
>> /dev/ttySACx>  /dev/s3c2410_serialx and only then put some getty on
>> created symlink, not on original device.
>> Systems which don't create this symlink, fail to boot at all, because
>> of wrong console name. Good example is Buildroot.
> 
> I had similar issue with buildroot too, because in /etc/securetty it is
> defained as ttySAC0
> 
> 4. For console in kernel boot command line you must enter console=ttySACx.
> Why it sould be different in userspace?
> 
> For me it seems taht this bug was not noticed earlier, because most
> embedded
> systems were using static device nodes and ttySACx was used in these cases.

As long as these are explained, then I'm reasonably happy for this to be
applied, as long as there are no other complaints.

However, this is a big change, and I think it should await the next
merge window.
