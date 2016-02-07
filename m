From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 03/12] serial: mvebu-uart: initial support for Armada-3700 serial port
Date: Sun, 07 Feb 2016 12:16:55 +0100
Message-ID: <87a8nc3h3s.fsf@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
	<1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
	<20160207071747.GA14010@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160207071747.GA14010@kroah.com> (Greg Kroah-Hartman's message
	of "Sat, 6 Feb 2016 23:17:47 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Wilson Ding <dingwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,
=20
 On dim., f=C3=A9vr. 07 2016, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org> wrote:

> On Wed, Feb 03, 2016 at 07:41:20PM +0100, Gregory CLEMENT wrote:
>> +static struct console mvebu_uart_console =3D {
>> +	.name	=3D "ttyS",
>
> You aren't ttyS, that's a reserved name for a different chip, please =
use
> a new name and major/minor numbers.

Oh sorry, I changed the ttyS to ttyMV in the uart_driver struct but I
forgot the console. I will fix it in next version.

Thanks,

Gregory

>
> thanks,
>
> greg k-h

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
