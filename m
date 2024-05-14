Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580031448FA;
	Tue, 14 May 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693455; cv=none; b=l0zDWYa7JakuDpjpD9k9/hQTzbJBvUxHubWvh6Q0DuZU17LFWwDtMarueXk9irGkm8wrG2gGdeDXinzGWliVoOEFfGWcbW0wynKdHH9ysnzHBZadpd3/RocwNI5lEWm4BlVVpcWoqA2cIyRd1FpVVxuCFiRZM/b+f9rxoLI3g+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693455; c=relaxed/simple;
	bh=nV9cCdyWa6uNoKVhoHvsrtVk11wlmfVkj3k9QaXbYy8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cidFAO7b8erAkPhvhqSTwyBmUTRU/2wsNp+JDsKFWvG3NugceD8PktkL+8pdS3ljPuy8CvTOeUqCtz1BecZUS6UCLh/B3Ec3gjUf+6HbCHHBbWvvKSjReRMcH0kkq9/NyDWZchZSxNthG2l62emEJoAFyZNAGqYC+nTqRBbSRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWX2K2SC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWX2K2SC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715693453; x=1747229453;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nV9cCdyWa6uNoKVhoHvsrtVk11wlmfVkj3k9QaXbYy8=;
  b=fWX2K2SCx9RqFByrqCHjCTJYkTSeAecl0RpmidKnVXD1cC50jAL/zdDD
   E2dojVx/LXrTjyut51butn/xH9+Fr1ukAT29vV/cVkgr8YlFOPPLjZXak
   N+rDCTG9yEhZGP5c4qbWEFYfkf9z9oEY21GiB+5QeRJgo6jhBXHRDt2Dh
   cDxhINqz7FCUkd1nyFh+WPKKHdkm/Hk1oTe6sdECaKiE9/O102VT3b9EO
   Vn69dUsDiXHx/2XONZfhwT+4rnd9mYyOiU8bDvQ5dgI01OcDUyeDcTcIY
   QzHHAs4UYuK2qrj4318FBojBOUQjLUdPCAYgn8b7H9E5Dwef7n3ANUPtP
   Q==;
X-CSE-ConnectionGUID: f8KNrwTyQ/O0p9Z4uZhWlA==
X-CSE-MsgGUID: Z5CdlS0WTtS0SW4DNYCQbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11507725"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11507725"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:30:52 -0700
X-CSE-ConnectionGUID: E8HEEfvkQ8y2UtObp/BVIQ==
X-CSE-MsgGUID: hOQLxRn9QuK8XMwaYAWxlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30701483"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:30:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 May 2024 16:30:41 +0300 (EEST)
To: Vadym Krevs <vkrevs@yahoo.com>
cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Bagas Sanjaya <bagasdotme@gmail.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Regressions <regressions@lists.linux.dev>, 
    Linux Serial <linux-serial@vger.kernel.org>, 
    Gilles Buloz <gilles.buloz@kontron.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [regression] [bisected] commit 6bb6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0
 corrupts data sent via pseudoterminal device
In-Reply-To: <645803059.1237606.1715692880298@mail.yahoo.com>
Message-ID: <386fae3e-5286-e13d-4171-3a6e87cb1567@linux.intel.com>
References: <ZkLv3wn62jqMVpSF@archie.me> <CAHp75VcjeJ5oZy2JjbyrKn+GVvixJKmfh3Yj1p-HxcJHrm0Wzg@mail.gmail.com> <606328522.1205749.1715678929830@mail.yahoo.com> <CAHp75VefMFJMAHrKmDf1joSkKOcaRMJWse8yM63Nt5v2W7w3Fw@mail.gmail.com> <6bfafddc-cf5b-4829-e09b-2622aaf83093@linux.intel.com>
 <645803059.1237606.1715692880298@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-191811837-1715693441=:6875"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-191811837-1715693441=:6875
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 May 2024, Vadym Krevs wrote:

> On Tuesday, 14 May 2024 at 12:03:25 BST, Ilpo J=C3=A4rvinen <ilpo.jarvine=
n@linux.intel.com> wrote:
> =C2=A0
> > On Tue, 14 May 2024, Andy Shevchenko wrote:
> >=C2=A0
> > > On Tue, May 14, 2024 at 12:28=E2=80=AFPM Vadym Krevs <vkrevs@yahoo.co=
m> wrote:
> > > >
> > > > It's a standard setup for an out-of-the box default install of open=
SUSE 15.5 with KDE. All tests done in Konsole with bash as shell.
> > > >
> > > > stty -a -F /dev/pts/1
> > > > speed 38400 baud; rows 57; columns 217; line =3D 0;
> > > > intr =3D ^C; quit =3D ^; erase =3D ^?; kill =3D ^U; eof =3D ^D; eol=
 =3D <undef>; eol2 =3D <undef>; swtch =3D <undef>; start =3D ^Q; stop =3D ^=
S; susp =3D ^Z; rprnt =3D ^R; werase =3D ^W; lnext =3D ^V; discard =3D ^O; =
min =3D 1; time =3D 0;
> > > > -parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts
> > > > -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl =
ixon ixoff -iuclc -ixany -imaxbel iutf8
> > > > opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0=
 bs0 vt0 ff0
> > > > isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop =
-echoprt echoctl echoke -flusho -extproc
> > >
> > > Thank you!
> > >
> > > Yeah. SW flow control is enabled, but I don't see which character is
> > > being used for that. Anyway, let's give Ilpo a chance to look into
> > > this.
> >=C2=A0
> > Thanks a lot for pinpointing the commit with bisect. It turns out this
> > is a quite bad corruption bug and I'm quite surprised I didn't see (or
> > notice) it while testing the patch.
> >=C2=A0
> > Could you please test and confirm the patch below fixes the issue?
> > --
> > [PATCH] tty: n_tty: Fix buffer offsets when looked ahead is used
> >=C2=A0
> > When lookahead has "consumed" some characters (la_count > 0),
> > n_tty_receive_buf_standard() and n_tty_receive_buf_closing() for
> > characters beyond the la_count are given wrong cp/fp offsets which
> > leads to duplicating and losing some characters.
> >=C2=A0
> > If la_count > 0, correct buffer pointers and make count consistency too
> > (the latter is not strictly necessary to fix the issue but seems more
> > logical to adjust all variables immediately to keep state consistent).
> >=C2=A0
> > Reported-by: Vadym Krevs <vkrevs@yahoo.com>
> > Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF time=
ly")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218834
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > drivers/tty/n_tty.c | 22 ++++++++++++++++------
> > 1 file changed, 16 insertions(+), 6 deletions(-)
> >=C2=A0
> > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > index f252d0b5a434..5e9ca4376d68 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> > @@ -1619,15 +1619,25 @@ static void __receive_buf(struct tty_struct *tt=
y, const u8 *cp, const u8 *fp,
> > else if (ldata->raw || (L_EXTPROC(tty) && !preops))
> > n_tty_receive_buf_raw(tty, cp, fp, count);
> > else if (tty->closing && !L_EXTPROC(tty)) {
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0) {
> > n_tty_receive_buf_closing(tty, cp, fp, la_count, true);
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > la_count)
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_closing(tt=
y, cp, fp, count - la_count, false);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp +=3D la_count;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp +=3D la_cou=
nt;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count -=3D la_count;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > 0)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_closing(tt=
y, cp, fp, count, false);
> > } else {
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0) {
> > n_tty_receive_buf_standard(tty, cp, fp, la_count, true);
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > la_count)
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_standard(t=
ty, cp, fp, count - la_count, false);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp +=3D la_count;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp +=3D la_cou=
nt;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count -=3D la_count;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > 0)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_standard(t=
ty, cp, fp, count, false);
> >=C2=A0
> > flush_echoes(tty);
> > if (tty->ops->flush_chars)
> > --
> > 2.39.2
>=20
> Yes, I've tested the patch against the 6.9.0-rc7-local-00012-gdccb07f2914=
c kernel (last commit=C2=A045db3ab70092637967967bfd8e6144017638563c from Ma=
y 8th)=C2=A0and it works just fine.=C2=A0
>=20
> Thank you very much for fixing the problem so quicky.
>=20
> Kind regards,
> Vadym
>=20
> P.S.: Hopefully, Yahoo mail has actually sent this reply as plain text.

Thanks for testing.

Can I put your Tested-by tag into the fix?

--=20
 i.

--8323328-191811837-1715693441=:6875--
