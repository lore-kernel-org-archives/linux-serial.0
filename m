From: Stuart Longland <stuartl@longlandclan.id.au>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 08:44:04 +1000
Message-ID: <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8402129529887202307=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Andi Kleen <andi@firstfloor.org>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8402129529887202307==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0TU6FcPtkpOtdWdBXuhpiUSNIIK4QvfNP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0TU6FcPtkpOtdWdBXuhpiUSNIIK4QvfNP
Content-Type: multipart/mixed; boundary="MUKc1aeTC4ARPT6TKBtjORIMwqb1DN5Jb"
From: Stuart Longland <stuartl@longlandclan.id.au>
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Andi Kleen <andi@firstfloor.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
In-Reply-To: <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>

--MUKc1aeTC4ARPT6TKBtjORIMwqb1DN5Jb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/17 07:41, Nicolas Pitre wrote:
>> No PTYs seems like a big limitation. This means no sshd?
> Again, my ultimate system target is in the sub-megabyte of RAM.  I=20
> really doubt you'll be able to fit an SSH server in there even if PTYs =

> were supported, unless sshd (or dropbear) can be made really tiny.=20
> Otherwise you most probably have sufficient resources to run the regula=
r=20
> TTY code.

Are we talking small microcontrollers here?  The smallest machine in
terms of RAM I ever recall running Linux on was a 386SX/25 MHz with 4MB
RAM, and that had a MMU.

I recall Slackware requiring that you booted with a mounted floppy (no
ramdisk) and possibly even required that you had a second floppy drive
formatted as swap so you'd be able to get through the install without
oomkiller knocking on your door.

The same machine could also "run" Windows 95.  When I say "run", it was
more like a slow crawl.  Bull sharks washed onto land by flood waters
run faster.

Sub-megabyte system support is a noble goal, but I'm wondering how
practical such systems would be, and whether an embedded real-time
kernel might be a better choice than Linux on such systems.
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--MUKc1aeTC4ARPT6TKBtjORIMwqb1DN5Jb--

--0TU6FcPtkpOtdWdBXuhpiUSNIIK4QvfNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY4X7RAAoJEPlUu7t5SNVGC+AP/i8lmiFZIcwb3VT9WfndUpki
eAfbGPcYMJXhuB6aXKb6BM2h5Q1HkVXyf+u1CwkWC/b30UI37ALnzx69VzqFH4ny
yMMTAhd3Y+0CdMjcAB8vOSUQ67qxIO9INkqxyiDf2Lx6CaLbVCB9jBAvw7brmgTT
J225ZwoonvmLkSqmryzvVjBNXqSZAUzXyRUah29fMogCu5+6djiupvcND0ZtzTXP
Zpv9uoCKN46QZYD38GRp8SXyQEPWOHYPYFWRImnwi8FBTxneFI3dtvEsIYRDOOIo
mun2MWkl/KCSxKJ/P7ehMrJ+0p5pAfpUFvynaAdy1ky7JJnTJhtjwx/fu/1ASmj7
1rChxIRlACJoAPdqn217EEGLwxdhfff/PCOnkagHlj2ZWfPjRO22nNwPYIRPj/1d
rSM+Bjz0/pvST+gdCcFUbfjTvIjJEwQmqexx6KK5Um05grDRQL2xSZVkmDNP3R9Y
pJg47PbLrhlayrWyAgdkaTsGXmCmxf4M3nNcKZ/jWuq4hof/0VbJIwnxykfGdexS
wmShzbWErRF+zD4Etgcu4Oc3Jj9RHGewVAzRpKQVkVNqD91ZNS+NpgsawELEWArY
7p7y3IDYPm+rOvAiOlUffquR743ASFLXK07XlYnxhop2lNtuwC2nN4ILE8bvIL6p
T6mhQB94dmvZbjikRrSM
=k6jK
-----END PGP SIGNATURE-----

--0TU6FcPtkpOtdWdBXuhpiUSNIIK4QvfNP--


--===============8402129529887202307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8402129529887202307==--
