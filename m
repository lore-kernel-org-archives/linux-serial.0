From: Matthias Schiffer <mschiffer@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Tue, 22 Mar 2016 01:52:42 +0100
Message-ID: <56F0975A.7050609@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
 <20160321230821.GA17910@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NoArXBUAd1SwsurQ1PtLBiVIG3tK0nR83"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160321230821.GA17910@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NoArXBUAd1SwsurQ1PtLBiVIG3tK0nR83
Content-Type: multipart/mixed; boundary="putPgl5wFOaQ4PMcrCQn7cM3T3oPxiIRX"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, jslaby@suse.com,
 linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <56F0975A.7050609@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
References: <56F07DA1.8080404@universe-factory.net>
 <20160321230821.GA17910@kroah.com>
In-Reply-To: <20160321230821.GA17910@kroah.com>

--putPgl5wFOaQ4PMcrCQn7cM3T3oPxiIRX
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/22/2016 12:08 AM, Greg KH wrote:
> On Tue, Mar 22, 2016 at 12:02:57AM +0100, Matthias Schiffer wrote:
>> Hi,
>> we're experiencing weird nondeterministic hangs during bootconsole/con=
sole
>> handover on some ath79 systems on OpenWrt. I've seen this issue myself=
 on
>> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to othe=
r
>> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs li=
ke
>> QCA953x likewise.
>=20
> Can you try 4.4 or ideally, 4.5?  There's been a lot of console/tty
> fixes/changes since the obsolete 3.18 kernel you are using...
>=20
> thanks,
>=20
> greg k-h
>=20

With 4.4, I was not able to reproduce this hang, but I have no idea if th=
is
is caused by an actual bugfix, or just random timing changes hiding the
bug. I suspect the latter might be the case (as I wrote in my first mail,=

even minor differences in kernel images of the same version and the same
config make the hang more or less probable.) I was not yet able to test
4.5, as OpenWrt is a hell of kernel patches...

On 3.18, I also tried other things like disabling the early console
altogether, which also made the hang go away, but as even much smaller
changes hid the bug, this doesn't really say much.

The basic code path during the console handover seems to be the same in
3.18 and 4.4, even though a few functions have been moved; the relevant
part of the log looks the same:

> [    0.756298] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled=

> [    0.766754] console [ttyS0] disabled
> [    0.790293] serial8250.0: ttyS0 at MMIO 0x18020000 (irq =3D 11, base=
_baud =3D 12500000) is a 16550A
> [    0.798909] console [ttyS0] enabled
> [    0.798909] console [ttyS0] enabled
> [    0.805854] bootconsole [early0] disabled
> [    0.805854] bootconsole [early0] disabled

So, in propect of an actual bugfix or backport, this boils down to two
questions, which I hope the serial or MIPS maintainers can answer me:

* Is it sane to have two console drivers using the same serial port? In
particular, is it sane for the early console to use the serial port after=

serial8250_config_port has reset/configured it, but before the rest of th=
e
setup of uart_configure_port has run? (this would be the case for the
message "serial8250.0: ttyS0 at MMIO...")
* Is it possible to get the serial controller into a state in which
early_printk might wait for THRE forever?

Thanks,
Matthias


--putPgl5wFOaQ4PMcrCQn7cM3T3oPxiIRX--

--NoArXBUAd1SwsurQ1PtLBiVIG3tK0nR83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW8JdbAAoJEBbvP2TLIB2c9kgP/2MLOdQOvaHpjwg3TFhDi0ev
UWdSZmqV+w5hmT09pYL/6iIbv9nkyhaoIv1zdgWnYZfk/+Na9ecT6JZrIp6tAIkf
zsEH8WXtXZo5acA7M4qDaSnep/rwZfyK/t5rrZCsj5A/Z3EPZQLkWVMfoW1PfMja
RPxuQ3I48t6u6BuquPG7cvTM/S5lqer2vZulczHoNOhfw3MWaKNzAAYp5hAdldpn
CjQ+wNFMcICMPqOr2ytL4EfE9hRU8GDf6A+T/ouOVPH3ljPZZnqWN2C7AeRiEwrH
VgtKW4lRG4C3h+HeAsILKUGDMUzzP0RXy3zTpy4mpQAfQYj7IQb6jm765A6h90cn
hMU4MvH20C/jwOTenSk8UFKywxjYqFxsEgPVGktCs1rsIdl8LBBTnogcZi9hfdfi
0XuzmFQ/5LDJLz29QeI5ubZlJpKrF4D8XIWlV7i+N7fghGF0SOxtYer7AelRuX48
Yvp2lWRoLRsqNuBEfInaTtslzTjZfDk/c8MeclJo96eoSg8bPcGe0Am9PlLZHwn9
sv+TSORAgT2rai/5xg6eCHoL5O6fnzVdcDLJlE4g0F/BfCxwf2dP7fuioLR2qPCb
/vtGL643TllVAQACrjhKcLnRLKONfVV2B6vVlGPysYhE2ts3uTUq9F8PCOfuj1qG
NLZDy4ba2MY4sUgESs3y
=Imgn
-----END PGP SIGNATURE-----

--NoArXBUAd1SwsurQ1PtLBiVIG3tK0nR83--
