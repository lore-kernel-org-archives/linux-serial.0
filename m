From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 07/10] arm64: dts: add the Marvell Armada 3700 family and a development board
Date: Wed, 03 Feb 2016 11:44:38 +0100
Message-ID: <877fim5azt.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<1454436468-4241-8-git-send-email-gregory.clement@free-electrons.com>
	<20160202183436.GE29778@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20160202183436.GE29778@leverpostej> (Mark Rutland's message of
	"Tue, 2 Feb 2016 18:34:36 +0000")
Sender: linux-ide-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Mark,
=20
 On mar., f=C3=A9vr. 02 2016, Mark Rutland <mark.rutland@arm.com> wrote=
:

>> +	memory {
>> +		device_type =3D "memory";
>> +		/* use only 256 MB on the 512 MB available */
>> +		reg =3D <0x00000000 0x00000000 0x00000000 0x10000000>;
>> +	};
>
> It would be good to comment as to why we can't use 256M of the memory=
=2E

Actually the comment is wrong and the size too, we do use the 512MB.

I will fix it

Thanks,

Gregory

>
> Otherwise this looks fine.
>
> Mark.

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
