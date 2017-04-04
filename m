From: Stuart Longland <stuartl@longlandclan.id.au>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 4 Apr 2017 10:39:53 +1000
Message-ID: <821bef75-3c16-a7f2-ea15-de711d1d9eb8@longlandclan.id.au>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
 <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
 <alpine.LFD.2.20.1704022040380.1847@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0691759688022243486=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.20.1704022040380.1847@knanqh.ubzr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0691759688022243486==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oWNojkaOe1c9c3pmGAB10GXQPJVqblwpX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oWNojkaOe1c9c3pmGAB10GXQPJVqblwpX
Content-Type: multipart/mixed; boundary="QE0fHnkwqEFDcB2PqxKIt1p8Hn9nXhsd6"
From: Stuart Longland <stuartl@longlandclan.id.au>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <andi@firstfloor.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <821bef75-3c16-a7f2-ea15-de711d1d9eb8@longlandclan.id.au>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
 <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
 <alpine.LFD.2.20.1704022040380.1847@knanqh.ubzr>
In-Reply-To: <alpine.LFD.2.20.1704022040380.1847@knanqh.ubzr>

--QE0fHnkwqEFDcB2PqxKIt1p8Hn9nXhsd6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/17 11:01, Nicolas Pitre wrote:
> On Mon, 3 Apr 2017, Stuart Longland wrote:
>> On 03/04/17 07:41, Nicolas Pitre wrote:
>>>> No PTYs seems like a big limitation. This means no sshd?
>>> Again, my ultimate system target is in the sub-megabyte of RAM.  I=20
>>> really doubt you'll be able to fit an SSH server in there even if PTY=
s=20
>>> were supported, unless sshd (or dropbear) can be made really tiny.=20
>>> Otherwise you most probably have sufficient resources to run the regu=
lar=20
>>> TTY code.
>>
>> Are we talking small microcontrollers here?  The smallest machine in
>> terms of RAM I ever recall running Linux on was a 386SX/25 MHz with 4M=
B
>> RAM, and that had a MMU.
>=20
> Not to repeat what I've said already, I invite you to have a look at=20
> https://lkml.org/lkml/2017/3/24/634
>=20
>> I recall Slackware requiring that you booted with a mounted floppy (no=

>> ramdisk) and possibly even required that you had a second floppy drive=

>> formatted as swap so you'd be able to get through the install without
>> oomkiller knocking on your door.
>=20
> Did the oom killer even exist in those days? I don't remember.
> All I remember is the stack of 73 flopies or so to install Slackware...=
=20
> and of course floppy #68 would have developed a bad sector preventing=20
> you from completing the installation.

It probably didn't, my memory is a bit hazy, even though the machine in
question was long obsolete by the time I did this experiment.  The
version of Slackware was pretty old by that time too.

Luckily for me, I had a network, I could mount the CD disk sets over NFS
that way, and so the only floppies I had to worry about were the boot
and root floppies.

But I digress=E2=80=A6 :-)

>> Sub-megabyte system support is a noble goal, but I'm wondering how
>> practical such systems would be, and whether an embedded real-time
>> kernel might be a better choice than Linux on such systems.
>=20
> Obviously, you need to leave the idea of a _distribution_ behind. If yo=
u=20
> think of a single user app, and a kernel that only provides those=20
> syscalls used by that app, and the minimal subset of kernel services=20
> that such an app require, then nothing prevents such and app/kernel fro=
m=20
> using the actual Linux API. And that's where you get a big advantage=20
> over other RTOSes. See the link above for the full rationale.

Fair enough=E2=80=A6 so basically using the Linux kernel in place of an e=
mbedded
kernel like FreeRTOS or eCos.  Still, as I say a noble goal, I wish the
project well.  I guess it can be our answer to RetroBSD. :-)
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--QE0fHnkwqEFDcB2PqxKIt1p8Hn9nXhsd6--

--oWNojkaOe1c9c3pmGAB10GXQPJVqblwpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY4utZAAoJEPlUu7t5SNVGuvwQAJ6EI+FFNCAn2dfscelm7h8T
2V7ikqMgVJyFqFvVvyFL8jkw8RyMg8+OlWb5h9MJfhs8Z2oWvjBBTmRIgq07r+FP
jDqVpMQjP28pe+uXuL6uym6qAV8hfVjVje6oDaXhBhu8HPLD5usrtjfOnyDjo8xz
Y5F5vpIA3NaGUbfWhLrr6w4HpLe9skyulUYTZkzUKO4SLSv/v3q+5kH5UZSZLn45
m6xygq6iqKEIfGs/p7D2DSVkjP+muwCk5i+i5iIZ6Vg53CZYXeGhIfXxn+ar9V0i
NjPHjVEhu/PrTiz9U+G0wwqUtiSAdYCqK7QTpKYRJ33MJ0f2BLNQzwcZz8tAEob/
mHF/f0mU1zeQN09PfoYaKtsH+ns69bLwLwbx112N+A+P1n4MqPypcsnPaFe7wuWQ
w/NdBLUvGsXYEQcFExUnhjBHDlZ4CNetpyEk3zLl6klDb8QmisW14WOtfZj9sCmq
z8RSvzNNsWycWjTYjn0SWTeCdsqUz1FxxUqeMx15Lxfo0YiFQRAHzEdjapqE18lp
FouOQFcOxL984/elRQwXiT7guhyS89od4jetzET8ScKhbtaisaRicQh617nTonI9
ogmJW8TsIhrIeL1aHheotVw+E8/LyCIuRHu5FLRKoul9zYht6gMIlKJKMy+LMpz3
WH7gWV5+oZyvMSh+YuZp
=8q1C
-----END PGP SIGNATURE-----

--oWNojkaOe1c9c3pmGAB10GXQPJVqblwpX--


--===============0691759688022243486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0691759688022243486==--
