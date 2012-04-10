From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 1/3] tegra, serial8250: add ->handle_break() uart_port op
Date: Tue, 10 Apr 2012 10:36:19 -0700
Message-ID: <CABE8wwsDM=4Lp5Fa79V29tG2RypfA-MxN7zfhtze7sOLCVdL7A@mail.gmail.com>
References: <20120409194514.8004.53204.stgit@dwillia2-linux.jf.intel.com>
	<20120409194857.8004.86352.stgit@dwillia2-linux.jf.intel.com>
	<4F84575F.7090909@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F84575F.7090909@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: gregkh@linuxfoundation.org, Sudhakar Mamillapalli <sudhakar@fb.com>, linux-kernel@vger.kernel.org, ArndBergmannarnd@arndb.de, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Nhan H Mai <nhan.h.mai@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 10, 2012 at 8:53 AM, Stephen Warren <swarren@wwwdotorg.org>=
 wrote:
> On 04/09/2012 01:48 PM, Dan Williams wrote:
>> The "KT" serial port has another use case for a "received break" qui=
rk,
>> so before adding another special case to the 8250 core take this
>> opportunity to push such quirks out of the core and into a uart_port=
 op.
>
>> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/teg=
ra_defconfig
> ...
>> +CONFIG_SERIAL_TEGRA=3Dy
>
> Instead of that,
>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> ...
>> +# FIXME remove this option when Tegra completes conversion to open =
firmware
>> +config SERIAL_TEGRA
>> + =A0 =A0 bool "Tegra serial port support"
>> + =A0 =A0 depends on SERIAL_OF_PLATFORM=3Dy
>> + =A0 =A0 help
>> + =A0 =A0 =A0 If you have a machine based on NVIDIA Tegra you can en=
able its
>> + =A0 =A0 =A0 onboard serial ports by enabling this option.
>> +
>
> Can we just make that default y if ARCH_TEGRA?
>
> defconfig changes are apparently a little touchy.
>
> Actually, why even introduce a new config variable; why not replace t=
he
> ifdefs in of_serial.[ch] with CONFIG_ARCH_TEGRA?

Nice, yes, that makes things a bit cleaner.

>> --- a/arch/arm/mach-tegra/devices.h
>> +++ b/arch/arm/mach-tegra/devices.h
>> @@ -53,5 +53,4 @@ extern struct platform_device tegra_i2s_device1;
>> =A0extern struct platform_device tegra_i2s_device2;
>> =A0extern struct platform_device tegra_das_device;
>> =A0extern struct platform_device tegra_pcm_device;
>> -
>> =A0#endif
>
> That's left over from a previous patch version.

yep.

>> @@ -84,6 +106,9 @@ static int __devinit of_platform_serial_setup(str=
uct platform_device *ofdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 | UPF_FIXED_PORT | UPF_FIXED_TYPE;
>> =A0 =A0 =A0 port->dev =3D &ofdev->dev;
>>
>> + =A0 =A0 if (type =3D=3D PORT_TEGRA)
>> + =A0 =A0 =A0 =A0 =A0 =A0 port->handle_break =3D tegra_serial_handle=
_break;
>
> This is going to mean that everything in 8250.c:uart_config[] will mo=
ve
> into the exact same data structure in of_serial.c eventually, so I st=
ill
> don't see the point of this exercise. But, I guess I won't argue agai=
nst
> it any more.

To me serial8250_config is about serial port geometries, uart_port ops
are about quirks.  Once open firmware needs to deal with a serial port
with a standard geometry but with a runtime quirk this approach of
just looking at the type will need to be revisited.  The fact that
'PORT_TEGRA' is enough to identify the geometry and the quirk is
serendipitous.

>> diff --git a/include/linux/of_serial.h b/include/linux/of_serial.h
> ...
>> + * FIXME remove this file when tegra finishes conversion to open fi=
rmware,
>
> remove this *prototype* not *file*?

The entire file should go away since it is only there to export
tegra_serial_handle_break to the deprecated board files.  Once this is
open firmware only tegra_serial_handle_break can be marked static,
right?

--
Dan
