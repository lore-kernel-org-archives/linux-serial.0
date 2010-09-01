From: Darius Augulis <augulis.darius@gmail.com>
Subject: Re: [PATCH] serial: samsung: fix device name
Date: Wed, 1 Sep 2010 09:27:04 +0300
Message-ID: <AANLkTikDi6R7rY2CUM0C4f07up00bN+_YGgJhK-aT1Qh@mail.gmail.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
	<AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
	<4C5BAFF6.10606@gmail.com>
	<4C5BB462.6010409@samsung.com>
	<008701cb3538$54a12a00$fde37e00$%kim@samsung.com>
	<4C7B5838.7060605@gmail.com>
	<012b01cb4977$72adf4d0$5809de70$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59578 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0IAG1G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Sep 2010 02:27:06 -0400
Received: by wyb35 with SMTP id 35so8834674wyb.19
        for <linux-serial@vger.kernel.org>; Tue, 31 Aug 2010 23:27:04 -0700 (PDT)
In-Reply-To: <012b01cb4977$72adf4d0$5809de70$%kim@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Kyungmin Park <kmpark@infradead.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Wed, Sep 1, 2010 at 4:46 AM, Kukjin Kim <kgene.kim@samsung.com> wrot=
e:
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

there isn't anything to handle. it's few lines patch, we type more
lines to discuss it.
this patch hangs there for almost half year. we waste time.

>
>> Thanks,
>>
>> Darius.
>>
>> On 08/06/2010 10:23 AM, Kukjin Kim wrote:
>> > Joonyoung Shim wrote:
>> >>
>> >> On 8/6/2010 3:47 PM, Paulius Zaleckas wrote:
>> >>> On 08/06/2010 03:04 AM, Kyungmin Park wrote:
>> >>>> Hi,
>> >>>>
>> >>>> It's already posted by Mr. Shim
>> >>>> http://marc.info/?l=3Dlinux-arm-kernel&m=3D127410047306149&w=3D=
2
>> >>>
>> >>> Darius patch is a little bit cleaner.
>> >>>
>> >>
>> >> OK, it's better.
>> >>
>> >> Acked-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> >>
>> >
>> > Hi all,
>> >
>> > I think, this should be handled by Ben Dooks....
>> > As Kyungmin Park said, there was his comment about this.
>> >
>> > This is just for your information....
>> >
>> > =3D=3D=3D
>> >
>> > On Tue, May 18, 2010 at 12:52:13PM +0900, Joonyoung Shim wrote:
>> >> On 5/18/2010 11:48 AM, Ben Dooks wrote:
>> >>> On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
>> >>>> Thd dev_name and driver_name should be switched each other.
>> >>>
>> >>> Hmm, this doesn't seem to have appeard on the linux-arm-kernel l=
ist
> yet.
>> >>>
>> >>> Please provide some information about what problem that this is =
fixing
>> >>> and the impact on any existing systems.
>> >>>
>> >>
>> >> The serial device nodes are created to s3c2410_serial* on android
>> >> platform instead of ttySAC*.
>> >
>> > This has been how they've been for ages, surely the android device=
 node
>> > creation sytstem supports symlinking /dev/SACx -> =A0/dev/s3c2410_=
serialx,
>> > like many other operating sysyerms that can already do this.
>> >
>> > Changing this just because android (something as-yet unmerged into
> mainline)
>> > does not like it. I'm not even happy with an #ifdef around this.
>> >
>> > If you really feel this is a problem that you absolutely must fix =
in
> kernel
>> > then please provide a kernel commandline option to change the seri=
al
> driver
>> > name and use that on any platform that needs it. Another way would=
 be to
>> > update the serial platform data to have a field for which name to
> choose.
>> >
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
