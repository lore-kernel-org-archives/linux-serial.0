From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 06/10] devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC family
Date: Wed, 03 Feb 2016 09:02:44 +0100
Message-ID: <87fuxa5ihn.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<1454436468-4241-7-git-send-email-gregory.clement@free-electrons.com>
	<20160202212454.GA21678@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160202212454.GA21678@rob-hp-laptop> (Rob Herring's message of
	"Tue, 2 Feb 2016 15:24:54 -0600")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,
=20
 On mar., f=C3=A9vr. 02 2016, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Tue, Feb 02, 2016 at 07:07:44PM +0100, Gregory CLEMENT wrote:
>> The Marvell Armada 3700 is a family of ARMv8 CA53 SoCs. This commit
>> introduces the Device Tree binding that documents the top-level
>> compatible strings for Armada 3700 based platforms.
>>=20
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt     | 17 ++++++=
+++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/ar=
mada-37xx.txt
>>=20
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37=
xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> new file mode 100644
>> index 000000000000..5db9f1a90da2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> @@ -0,0 +1,17 @@
>> +Marvell Armada 37xx Platforms Device Tree Bindings
>> +--------------------------------------------------
>> +
>> +Boards using a SoC of the Marvell Armada 37xx family must carry the
>> +following root node property:
>> +
>> + - compatible: must contain "marvell,armada3700"
>
> Is 3700 an actual chip? If not, please drop this.

As for I know, it is not an actual chip, so I will remove it.

Thanks,

Gregory

>
>> +
>> +In addition, depending on whether the Armada 3710 or Armada 3720 So=
Cs
>> +are being used, the following root node property must be added:
>> +
>> + - compatible: must contain either "marvell,armada3710" or
>> +   "marvell,armada3720"
>> +
>> +Example:
>> +
>> +compatible =3D "marvell,armada-3720-db", "marvell,armada3720", "mar=
vell,armada3700";
>> --=20
>> 2.5.0
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree=
" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
