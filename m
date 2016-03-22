From: Matthias Schiffer <mschiffer@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Tue, 22 Mar 2016 10:50:20 +0100
Message-ID: <56F1155C.7080506@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
 <20160322084046.7196890a7c157503cd0ea0d5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PeX5h5CuJHvVMVEJJIDOSGthFIQ8VUUW1"
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20160322084046.7196890a7c157503cd0ea0d5@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Mamonov <pmamonov@gmail.com>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PeX5h5CuJHvVMVEJJIDOSGthFIQ8VUUW1
Content-Type: multipart/mixed; boundary="9d17nTEchecUAE9Pmh2cPXG2R6TpWmOP8"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
 jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Peter Mamonov <pmamonov@gmail.com>
Message-ID: <56F1155C.7080506@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
References: <56F07DA1.8080404@universe-factory.net>
 <20160322084046.7196890a7c157503cd0ea0d5@gmail.com>
In-Reply-To: <20160322084046.7196890a7c157503cd0ea0d5@gmail.com>

--9d17nTEchecUAE9Pmh2cPXG2R6TpWmOP8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/22/2016 06:40 AM, Antony Pavlov wrote:
> On Tue, 22 Mar 2016 00:02:57 +0100
> Matthias Schiffer <mschiffer@universe-factory.net> wrote:
>=20
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
>>
>> See the log below for the exact place it hangs; the log was taken in d=
uring
>> a good boot; a bad boot will just hang forever at the marked location.=
 The
>> issue is extremely hard to debug, as changing the timing in any way (l=
ike
>> adding additional printk) will usually make it work without problems. =
(Even
>> recompiling the kernel with the same config, but different uname times=
tamp
>> will make the occurence more or less likely)
>>
>> My theory is the following:
>>
>> As soon as ttyS0 is detected and installed as the console, there are t=
wo
>> console drivers active on the serial port at the same time: early0 and=

>> ttyS0. I suspect that the hang occurs when the primitive early0
>> implementation prom_putchar_ar71xx waits indefinitely on THRE,
>=20
> Can you use EJTAG to prove your theory?
>=20
> --=20
> Best regards,
>   Antony Pavlov
>=20

Unfortunately, the board I can reproduce this at the moment does not have=

an accessible JTAG port. I hope I can reproduce it on other hardware whic=
h
is more developer-friendly, but no luck so far.

Matthias


--9d17nTEchecUAE9Pmh2cPXG2R6TpWmOP8--

--PeX5h5CuJHvVMVEJJIDOSGthFIQ8VUUW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW8RVcAAoJEBbvP2TLIB2cgEQQAIQfVgeXprFvdsAq/8gUa1Ra
oQUXPOp6KSMiBIEOqyOYH648TZcrdH7id8oZh16/x/uCLQG/TnwHe6Ks4udseUiJ
3M319vuuSJwZ0/fR2TpVd3jMP2vhFzmxhOZEBYgJr2KPb/OMTtiVqcOEJmqOzRC3
LbxxRgo8UvakTG3v3/brQJ1VCHNnvpu5jyKVSY7w8TsGFEkRY71aw9tv//0NQ3/T
t4nxJ/FTm9Ku6zRCDT7uzB/Gd43fQVMKzfRaIUqoGPxzxeL1JW54itLBaVtqimhS
3bxP/zOF787xHpa0nH57j6EYZM4jSqyT3zW+JaqEMz/SQi9f/SP2ZJavhAruOWtb
F5bY5Nmuk+gJi5slEe1IqEnP7uOhj3WH0ygf5qkxGq7tKDQ8p2LqNoBOAzbvd+xV
drC/o/4pUCK0wpyQqZsTbmtJjG6w9PR1NkcPf43maegQHUtA/DW9Ny7DTJhNzBLG
OGtjo6Sa0E7q6dCBC0QdUnwS+azPQfCtKZFpUIIjKTH/IxMPLp9bw/DRJ8l8dbvl
r/CK6CNsF/pw74QXK4aY081VjVvsMytjK2XjbPj2opUlxNqp/VTLlsxxZhTQZEc5
14to3GpceXGEeC74+Af6KFA9ys8Km3EE916ZLpkwX4MmKADIxgfxRIbF208YWHUb
XyMeYFOUne+Q+DT/OEGV
=+Ilz
-----END PGP SIGNATURE-----

--PeX5h5CuJHvVMVEJJIDOSGthFIQ8VUUW1--
