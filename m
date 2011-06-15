From: Andrew McGregor <andrewmcgr@gmail.com>
Subject: Fwd: "irq 42: nobody cared" and I/O errors on serial ports
Date: Wed, 15 Jun 2011 14:25:04 +1200
Message-ID: <84E97454-6F1A-4417-9CFB-D0704522C8CB@gmail.com>
References: <72B32DA6-6FD7-4FDE-B708-BB25DA121E93@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/mixed; boundary=Apple-Mail-585--914977617
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49655 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab1FOCZK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Jun 2011 22:25:10 -0400
Received: by gxk21 with SMTP id 21so3852234gxk.19
        for <linux-serial@vger.kernel.org>; Tue, 14 Jun 2011 19:25:10 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--Apple-Mail-585--914977617
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Resending again... this is getting silly.

Begin forwarded message:

> From: Andrew McGregor <andrewmcgr@gmail.com>
> Date: 15 June 2011 2:14:19 PM NZST
> To: "Greg KH" <greg@kroah.com>, Alan Cox <alan@linux.intel.com>, Joe =
Peterson <joe@skyrush.com>, linux-serial@vger.kernel.org
> Cc: andrew.mcgregor@alliedtelesis.co.nz
> Subject: Fwd: "irq 42: nobody cared" and I/O errors on serial ports
>=20
> Resending from another address due to broken mail system.
>=20
> Sorry for the spam everyone, I'll just do it this way next time.
>=20
> Andrew
>=20
>>>> On 6/15/2011 at 12:31 PM, in message
> <4DF8AF57.0494.0036.0@alliedtelesis.co.nz>, andrew mcgregor
> <andrew.mcgregor@alliedtelesis.co.nz> wrote:=20
>> Resending due to catastrophically broken mail system...
>>=20
>> Oops, sorry.
>> Sorry about the Signed-off, I misunderstood what Alan was asking me =
to do. =20
>> It should be signed-off by me.=20
>>=20
>> Edited patch attached.=20
>>=20
>>>>> On 6/14/2011 at 03:48 AM, in message =
<20110613154818.GB32372@kroah.com>, Greg=20
>> KH <greg@kroah.com> wrote: =20
>>> On Mon, Jun 13, 2011 at 11:55:14AM +1200, andrew mcgregor wrote:=20
>>>> Ok, patch attached.=20
>>>>=20
>>>=20
>>>>> =46rom 9c14cbc96253c90533a4dbd12fd8cc23955d7133 Mon Sep 17 =
00:00:00 2001=20
>>>> From: Andrew McGregor <andrew.mcgregor@alliedtelesis.co.nz>=20
>>>> Date: Mon, 13 Jun 2011 11:31:31 +1200=20
>>>> Subject: [PATCH]  fix "IRQ45: nobody cared"=20
>>>>=20
>>>> Unthrottling the TTY during close ends up enabling interrupts=20
>>>> on a device not on the active list, which will never have the=20
>>>> interrupts cleared.  Doctor, it hurts when I do this.=20
>>>>=20
>>>> On Wed, 01 Jun 2011 10:34:07 +1200=20
>>>> "andrew mcgregor" <andrew.mcgregor@alliedtelesis.co.nz> wrote:=20
>>>>=20
>>>>> The LKML message=20
>>>>> http://kerneltrap.org/mailarchive/linux-kernel/2010/2/25/4541847 =
from=20
>>>>> February doesn't seem to have been resolved since.  We struck the=20=

>>>>> issue, and the patch below (against 2.6.32) fixes it.  Should I=20
>>>>> supply a patch against 3.0.0rc?=20
>>>>=20
>>>> I think that would be sensible. I don't actually see how you hit it =
as=20
>>>> the IRQ ought to be masked by then but it's certainly wrong for =
n_tty=20
>>>> to be calling into check_unthrottle at that point.=20
>>>>=20
>>>> So yes please send a patch with a suitable Signed-off-by: line to=20=

>>>> linux-serial and cc GregKH <greg@kroah.com> as well.=20
>>>>=20
>>>> Alan=20
>>>>=20
>>>> Signed-off-by: Alan Cox <alan@linux.intel.com>=20
>>>=20
>>> Wait, Alan wrote this?  Or you did?  You can't add someone elses=20
>>> Signed-off-by: to a patch they didn't create.  Please read=20
>>> Documentation/SubmittingPatches for what this line means.=20
>>>=20
>>> thanks,=20
>>>=20
>>> greg k-h=20
>>>=20
>>=20

--Apple-Mail-585--914977617
Content-Disposition: attachment;
	filename=0001-fix-IRQ45-nobody-cared.patch
Content-Type: text/plain;
	name="0001-fix-IRQ45-nobody-cared.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 9c14cbc96253c90533a4dbd12fd8cc23955d7133 Mon Sep 17 00:00:00 2001
From: Andrew McGregor <andrew.mcgregor@alliedtelesis.co.nz>
Date: Mon, 13 Jun 2011 11:31:31 +1200
Subject: [PATCH]  fix "IRQ45: nobody cared"

Unthrottling the TTY during close ends up enabling interrupts
on a device not on the active list, which will never have the
interrupts cleared.  Doctor, it hurts when I do this.

>>> On 6/2/2011 at 01:56 AM, in message =
<20110601145608.3e586e16@bob.linux.org.uk>, Alan Cox =
<alan@linux.intel.com> wrote:=20
> On Wed, 01 Jun 2011 10:34:07 +1200=20
> "andrew mcgregor" <andrew.mcgregor@alliedtelesis.co.nz> wrote:=20
> > The LKML message=20
> > http://kerneltrap.org/mailarchive/linux-kernel/2010/2/25/4541847 =
from=20
> > February doesn't seem to have been resolved since.  We struck the=20
> > issue, and the patch below (against 2.6.32) fixes it.  Should I=20
> > supply a patch against 3.0.0rc?=20
> =20
> I think that would be sensible. I don't actually see how you hit it as=20=

> the IRQ ought to be masked by then but it's certainly wrong for n_tty=20=

> to be calling into check_unthrottle at that point.=20
> =20
> So yes please send a patch with a suitable Signed-off-by: line to=20
> linux-serial and cc GregKH <greg@kroah.com> as well.=20
> =20
> Alan=20

Signed-off-by: Andrew McGregor <andrew.mcgregor@alliedtelesis.co.nz>

---
 drivers/tty/n_tty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0ad3288..1ddc5d7 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -185,7 +185,6 @@ static void reset_buffer_flags(struct tty_struct =
*tty)
 	tty->canon_head =3D tty->canon_data =3D tty->erasing =3D 0;
 	memset(&tty->read_flags, 0, sizeof tty->read_flags);
 	n_tty_set_room(tty);
-	check_unthrottle(tty);
 }
=20
 /**
@@ -1587,6 +1586,7 @@ static int n_tty_open(struct tty_struct *tty)
 			return -ENOMEM;
 	}
 	reset_buffer_flags(tty);
+	tty_unthrottle(tty);
 	tty->column =3D 0;
 	n_tty_set_termios(tty, NULL);
 	tty->minimum_to_wake =3D 1;
--=20
1.7.0.4


--Apple-Mail-585--914977617
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> 
> 


--Apple-Mail-585--914977617--
