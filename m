From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] serial: samsung: fix device name
Date: Wed, 01 Sep 2010 11:46:34 +0900
Message-ID: <4C7DBE8A.5050709@samsung.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
 <AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
 <4C5BAFF6.10606@gmail.com> <4C5BB462.6010409@samsung.com>
 <008701cb3538$54a12a00$fde37e00$%kim@samsung.com> <4C7B5838.7060605@gmail.com>
 <012b01cb4977$72adf4d0$5809de70$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21394 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0IACqg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Aug 2010 22:46:36 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L8100H7KRPMXB10@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Wed, 01 Sep 2010 11:46:34 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L81004RQRPM4Z@mmp2.samsung.com> for
 linux-serial@vger.kernel.org; Wed, 01 Sep 2010 11:46:34 +0900 (KST)
In-reply-to: <012b01cb4977$72adf4d0$5809de70$%kim@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Darius Augulis' <augulis.darius@gmail.com>, 'Kyungmin Park' <kmpark@infradead.org>, 'Paulius Zaleckas' <paulius.zaleckas@gmail.com>, ben-linux@fluff.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2010-09-01 =EC=98=A4=EC=A0=84 10:46, Kukjin Kim wrote:
> Darius Augulis wrote:
>>
>> Hi Kukjin,
>>
> Hi ;-)
>
>> please pick up this one to your tree too.
>>
>
> As I still thinking, this should be handled by Ben Dooks.
>
> And please refer to below Ben's comments about this.
>

I am really wondering your opinion about this fix. Why should handle=20
only by Ben? This is obvious bug fix if you think so, you can handle it=
 too.

>> Thanks,
>>
>> Darius.
>>
>> On 08/06/2010 10:23 AM, Kukjin Kim wrote:
>>> Joonyoung Shim wrote:
>>>>
>>>> On 8/6/2010 3:47 PM, Paulius Zaleckas wrote:
>>>>> On 08/06/2010 03:04 AM, Kyungmin Park wrote:
>>>>>> Hi,
>>>>>>
>>>>>> It's already posted by Mr. Shim
>>>>>> http://marc.info/?l=3Dlinux-arm-kernel&m=3D127410047306149&w=3D2
>>>>>
>>>>> Darius patch is a little bit cleaner.
>>>>>
>>>>
>>>> OK, it's better.
>>>>
>>>> Acked-by: Joonyoung Shim<jy0922.shim@samsung.com>
>>>>
>>>
>>> Hi all,
>>>
>>> I think, this should be handled by Ben Dooks....
>>> As Kyungmin Park said, there was his comment about this.
>>>
>>> This is just for your information....
>>>
>>> =3D=3D=3D
>>>
>>> On Tue, May 18, 2010 at 12:52:13PM +0900, Joonyoung Shim wrote:
>>>> On 5/18/2010 11:48 AM, Ben Dooks wrote:
>>>>> On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
>>>>>> Thd dev_name and driver_name should be switched each other.
>>>>>
>>>>> Hmm, this doesn't seem to have appeard on the linux-arm-kernel li=
st
> yet.
>>>>>
>>>>> Please provide some information about what problem that this is f=
ixing
>>>>> and the impact on any existing systems.
>>>>>
>>>>
>>>> The serial device nodes are created to s3c2410_serial* on android
>>>> platform instead of ttySAC*.
>>>
>>> This has been how they've been for ages, surely the android device =
node
>>> creation sytstem supports symlinking /dev/SACx ->   /dev/s3c2410_se=
rialx,
>>> like many other operating sysyerms that can already do this.
>>>
>>> Changing this just because android (something as-yet unmerged into
> mainline)
>>> does not like it. I'm not even happy with an #ifdef around this.
>>>
>>> If you really feel this is a problem that you absolutely must fix i=
n
> kernel
>>> then please provide a kernel commandline option to change the seria=
l
> driver
>>> name and use that on any platform that needs it. Another way would =
be to
>>> update the serial platform data to have a field for which name to
> choose.
>>>
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim<kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
