Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73654903;
	Tue, 14 May 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684597; cv=none; b=d/rf8LT1wv3KBkNwBpCsFPY4d1lVxPVouvuP9SvjTGbMZgEIO55ZAlzsLj2U33RALhgXP/5hzjJlJKiD9Jr1ZyprY6+/pEGE+Vaqdb/tuqGvHpu3EahCic29ekztTwlve0w3kuleYMHQ+jr8/Pb9CE5gLs/KkIZHNnxWM8uj9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684597; c=relaxed/simple;
	bh=OywhrLKKbt4A6Kqnheggw+3eARBvAOlcXRI/HHo5cOM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jrf7a+4bHr+opBmWfs1wlJyISeAWv3zbw/RODmtxe3R9r4FAWLJBm76/bzQc+8ZSyGfG3TgSWZmMjaxNoKrryA7/wl3Eht1kgeqOBtKv1ISEU4ZHC6pTBLh4vivN+gJO0uZVtXA95AHxgR/8z+6xlPZvIQNkvCwbIy4DwFHhx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ld2aBmxS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ld2aBmxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715684596; x=1747220596;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=OywhrLKKbt4A6Kqnheggw+3eARBvAOlcXRI/HHo5cOM=;
  b=ld2aBmxSs/pcTm8niDhkptd+6JppT1KxxoYqMTVI27VpPKw4msOAiZBp
   DvwMOYuUEmXDI2K2nlGrvecWd7ZGRpdkxIboC4LTJBIJ6ZLbnhVeVgPKy
   O9P40PNl2jP+97Hd0BZKilOSo1Hwy5+H0kg87xH3IfRAVAR/cgOPNTPxJ
   TZWmqbuabdY9Y4EgcQtVMbi3TF7QrhYOq3cJ2xo67oX+7nmSo1DSE3S3d
   84jxI2pIH+WQqY/X1VsK+NAtCWyYPwGR3bQ2xAu9G1+o7faeRZcmT7MAB
   z0m/Pk+tks5Id2K0NosJzkFUD6E1TjiaiMGiF7qmQt4G3m6aAbw3g/GFL
   w==;
X-CSE-ConnectionGUID: 0YYnIOmsQoK0hSNZ5fLt8w==
X-CSE-MsgGUID: JfPfVhlxRcqBBzOaxP7ujw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="15480891"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="15480891"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:03:15 -0700
X-CSE-ConnectionGUID: v8GfHghzRg6zFCFOXcMzdw==
X-CSE-MsgGUID: WVdmOsTXSlOqgfDU6iUY0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35407856"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:03:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 May 2024 14:03:05 +0300 (EEST)
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Vadym Krevs <vkrevs@yahoo.com>
cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Regressions <regressions@lists.linux.dev>, 
    Linux Serial <linux-serial@vger.kernel.org>, 
    Gilles Buloz <gilles.buloz@kontron.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [regression] [bisected] commit 6bb6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0
 corrupts data sent via pseudoterminal device
In-Reply-To: <CAHp75VefMFJMAHrKmDf1joSkKOcaRMJWse8yM63Nt5v2W7w3Fw@mail.gmail.com>
Message-ID: <6bfafddc-cf5b-4829-e09b-2622aaf83093@linux.intel.com>
References: <ZkLv3wn62jqMVpSF@archie.me> <CAHp75VcjeJ5oZy2JjbyrKn+GVvixJKmfh3Yj1p-HxcJHrm0Wzg@mail.gmail.com> <606328522.1205749.1715678929830@mail.yahoo.com> <CAHp75VefMFJMAHrKmDf1joSkKOcaRMJWse8yM63Nt5v2W7w3Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1185213448-1715683287=:1106"
Content-ID: <62931513-71c6-d018-32cb-150e9a7156c3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1185213448-1715683287=:1106
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <51f2e973-9ce1-a42f-8b7a-37cd5beb78bd@linux.intel.com>

On Tue, 14 May 2024, Andy Shevchenko wrote:

> On Tue, May 14, 2024 at 12:28=E2=80=AFPM Vadym Krevs <vkrevs@yahoo.com> w=
rote:
> >
> > It's a standard setup for an out-of-the box default install of openSUSE=
 15.5 with KDE. All tests done in Konsole with bash as shell.
> >
> > stty -a -F /dev/pts/1
> > speed 38400 baud; rows 57; columns 217; line =3D 0;
> > intr =3D ^C; quit =3D ^\; erase =3D ^?; kill =3D ^U; eof =3D ^D; eol =
=3D <undef>; eol2 =3D <undef>; swtch =3D <undef>; start =3D ^Q; stop =3D ^S=
; susp =3D ^Z; rprnt =3D ^R; werase =3D ^W; lnext =3D ^V; discard =3D ^O; m=
in =3D 1; time =3D 0;
> > -parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts
> > -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon=
 ixoff -iuclc -ixany -imaxbel iutf8
> > opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0=
 vt0 ff0
> > isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -ech=
oprt echoctl echoke -flusho -extproc
>=20
> Thank you!
>=20
> Yeah. SW flow control is enabled, but I don't see which character is
> being used for that. Anyway, let's give Ilpo a chance to look into
> this.

Thanks a lot for pinpointing the commit with bisect. It turns out this=20
is a quite bad corruption bug and I'm quite surprised I didn't see (or=20
notice) it while testing the patch.

Could you please test and confirm the patch below fixes the issue?

--
[PATCH] tty: n_tty: Fix buffer offsets when looked ahead is used

When lookahead has "consumed" some characters (la_count > 0),
n_tty_receive_buf_standard() and n_tty_receive_buf_closing() for
characters beyond the la_count are given wrong cp/fp offsets which
leads to duplicating and losing some characters.

If la_count > 0, correct buffer pointers and make count consistency too
(the latter is not strictly necessary to fix the issue but seems more
logical to adjust all variables immediately to keep state consistent).

Reported-by: Vadym Krevs <vkrevs@yahoo.com>
Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218834
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f252d0b5a434..5e9ca4376d68 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1619,15 +1619,25 @@ static void __receive_buf(struct tty_struct *tty, c=
onst u8 *cp, const u8 *fp,
 =09else if (ldata->raw || (L_EXTPROC(tty) && !preops))
 =09=09n_tty_receive_buf_raw(tty, cp, fp, count);
 =09else if (tty->closing && !L_EXTPROC(tty)) {
-=09=09if (la_count > 0)
+=09=09if (la_count > 0) {
 =09=09=09n_tty_receive_buf_closing(tty, cp, fp, la_count, true);
-=09=09if (count > la_count)
-=09=09=09n_tty_receive_buf_closing(tty, cp, fp, count - la_count, false);
+=09=09=09cp +=3D la_count;
+=09=09=09if (fp)
+=09=09=09=09fp +=3D la_count;
+=09=09=09count -=3D la_count;
+=09=09}
+=09=09if (count > 0)
+=09=09=09n_tty_receive_buf_closing(tty, cp, fp, count, false);
 =09} else {
-=09=09if (la_count > 0)
+=09=09if (la_count > 0) {
 =09=09=09n_tty_receive_buf_standard(tty, cp, fp, la_count, true);
-=09=09if (count > la_count)
-=09=09=09n_tty_receive_buf_standard(tty, cp, fp, count - la_count, false);
+=09=09=09cp +=3D la_count;
+=09=09=09if (fp)
+=09=09=09=09fp +=3D la_count;
+=09=09=09count -=3D la_count;
+=09=09}
+=09=09if (count > 0)
+=09=09=09n_tty_receive_buf_standard(tty, cp, fp, count, false);
=20
 =09=09flush_echoes(tty);
 =09=09if (tty->ops->flush_chars)
--=20
2.39.2
--8323328-1185213448-1715683287=:1106--
