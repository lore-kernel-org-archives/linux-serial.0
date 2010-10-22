From: Darius Augulis <augulis.darius@gmail.com>
Subject: Re: [RESEND PATCH] serial: samsung: fix device name
Date: Fri, 22 Oct 2010 10:02:35 +0300
Message-ID: <AANLkTikDyz5Jho+5T1vmZ9PL=ZxcXf8phQqrZaVxjgQJ@mail.gmail.com>
References: <20100923190212.18863.25678.stgit@darius-desktop>
	<4C9BE577.4050504@fluff.org>
	<AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com>
	<4C9CD3E0.6060000@gmail.com>
	<4C9FE2C4.8070302@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63436 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab0JVHCg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Oct 2010 03:02:36 -0400
In-Reply-To: <4C9FE2C4.8070302@fluff.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>, kgene.kim@samsung.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Ben, Kukjin,

please don't forget to add this change to your tree for this merge wind=
ow.

Thanks,
Darius

On Mon, Sep 27, 2010 at 3:18 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On 24/09/10 17:37, Paulius Zaleckas wrote:
>> On 09/24/2010 09:57 AM, Darius Augulis wrote:
>>> Hi,
>>>
>>> On Fri, Sep 24, 2010 at 2:40 AM, Ben Dooks<ben-linux@fluff.org> =A0=
wrote:
>>>> On 23/09/10 20:15, Darius Augulis wrote:
>>>>> Swap device and driver names in serial/samsung.c
>>>>
>>>> This is far too short, please see the notes below on trying
>>>> to make this more informative.
>>>>
>>>>> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
>>>>> ---
>>>>>
>>>>> This patch was submitted about 3 months ago, but still not merged=
=2E
>>>>> There was another similar patch from Joonyoung Shim
>>>>> <jy0922.shim@samsung.com> =A0and was discussed here:
>>>>> http://marc.info/?l=3Dlinux-serial&m=3D127416101222281&w=3D2.
>>>>> Joonyoung Shim acked my patch and other people on ARM mailing lis=
t
>>>>> acked it. The maintainer, Ben Dooks, still not responding for
>>>>> a long time. Another maintainer, Kukjin Kim, refused to merge
>>>>> it without Ben's review.
>>>>> I would like to ask somebody pick up this bugfix.
>>>>
>>>> I belive last time this was brought up I asked about the affect
>>>> this has on the userspace. The following issues would be helpful
>>>> or essential to have noted in the header about the effect of this.
>>>>
>>>> - Does it change the /dev name of the device? if so I would thinl
>>>> =A0 carefully about applying it, as it would be a change in the wa=
y
>>>> =A0 that userspace sees the kernel.
>>>
>>> It does - now devices are named /dev/s3c2410_serial, and patch chan=
ges
>>> its name to /dev/ttySAC
>>>
>>>>
>>>> - Does it change the kernel output itself? A note on what diffeenc=
es
>>>> =A0 can be seen in things like dmesg would be helpful.
>>>
>>> It does. Serial driver reports device names when probing, so there
>>> will appear ttySACx instead of
>>> s3c2410_serialx.
>>>
>>>>
>>>> - Are there any other side effects
>>>>
>>>> - Why is this a bug? Maybe the previous points will explain what i=
s
>>>> =A0 going on, but if not, then a reasonably concise description of
>>>> =A0 what is going on here.
>>>
>>> This is bug, because of several points:
>>>
>>> 1. Because it contradicts kernel documentation. Please read
>>> Documentation/arm/Samsung-S3C24XX/Overview.txt line 196.
>>> This should be enough to apply this patch.
>>>
>>> 2. Because s3c2410_serial isn't correct name for serial device node=
=2E
>>> It's name of Samsung serial driver.
>>>
>>> 3. Because now almost all userspace systems workaround it by creati=
ng
>>> symlink
>>> /dev/ttySACx> =A0/dev/s3c2410_serialx and only then put some getty =
on
>>> created symlink, not on original device.
>>> Systems which don't create this symlink, fail to boot at all, becau=
se
>>> of wrong console name. Good example is Buildroot.
>>
>> I had similar issue with buildroot too, because in /etc/securetty it=
 is
>> defained as ttySAC0
>>
>> 4. For console in kernel boot command line you must enter console=3D=
ttySACx.
>> Why it sould be different in userspace?
>>
>> For me it seems taht this bug was not noticed earlier, because most
>> embedded
>> systems were using static device nodes and ttySACx was used in these=
 cases.
>
> As long as these are explained, then I'm reasonably happy for this to=
 be
> applied, as long as there are no other complaints.
>
> However, this is a big change, and I think it should await the next
> merge window.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
