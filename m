From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 00/12] Add support for the Armada 3700 SoC an mvebu ARM64 based
Date: Wed, 17 Feb 2016 17:03:15 +0100
Message-ID: <87a8mzs4sc.fsf@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
	<2699923.cugyhCaCQy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <2699923.cugyhCaCQy@wuerfel> (Arnd Bergmann's message of "Tue, 16
	Feb 2016 22:22:11 +0100")
Sender: linux-ide-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,
=20
 On mar., f=C3=A9vr. 16 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 16 February 2016 19:14:50 Gregory CLEMENT wrote:
>> This series introduce the support of the Armada 3700 family: it is t=
he
>> first ARM64 SoC of the mvebu family submitted to the mainline!
>>=20
>> Currently there are two members of the Armada 3700 family, the only
>> difference is the number of core: the Armada 3710 comes with one
>> Cortex-A53 whereas the Armada 3720 comes with 2 Cortex-A53. In this
>> series we enabled only the minimum to boot, pinctrl and clock tree
>> will come soon.
>>=20
>
> Whole series
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Great!

I am going to do a first pull requests for the mvebu arm64. Let me know
if I do it correctly.

Thanks,

Gregory

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
