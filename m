Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8111448C0
	for <linux-serial@vger.kernel.org>; Tue, 14 May 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692894; cv=none; b=bpotT/ivkpU7nXulo+BsbUU706yzJg1uh3ZRx8DvX47GNMdmd3iCPKq/6SA8UOktIZu8rYr+9B3Trlxg+54ANZ2waZz3lMKxKZY+WGuQccRdIzvTIsXFmWYSt6Df3QGVi4bSJprpBfOWNMHClg62jRvx1BYxP92jtk9temTScIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692894; c=relaxed/simple;
	bh=hZtaa+gXLYdDiofDQR4Fm4ng3aii+qH+CB9OYIf7MZo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=du10jwE0PHphrW2Hg2delTkHsgmVu5ckUuzRBD9wYcypgSXy5BpA8aNnuem03vwhE58fsofmQRoc8SPmRLTVt3F5H2U1xhm0LGiryAR6BbEtH2riJ+zTAVeq/cTTCz9/LZYnXD0sdkAnnZklQ6vT5nU2vDkhm5H+2kFZSmfPFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tG9nHuQa; arc=none smtp.client-ip=74.6.131.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tG9nHuQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715692885; bh=hZtaa+gXLYdDiofDQR4Fm4ng3aii+qH+CB9OYIf7MZo=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=tG9nHuQakGf2Q8AG3wahA9jaKjLDB1LpHLBrzN89CjkgVG/RIUWPqvDklnWhE2EZh3Xmwu03HRvGXC1S+0R2fDfFHfyArgjpEhfmMC+bdrPjuGm5M3/Dn6FZ7zit6aWX2Mtsr7FwrUnwvDKSfNIVfNlUfT6CGb4rrrvi8VaYaDBG8AuCbavzkgy+SkRdB++emExJgbtiaLKco7GBw094bfymqAGVrfW8/tC8c7qHQXVOljO+xQOdSvdS/ormuluQ9MvRyv4py7SuSkzr5vY3j12hPJYh8kpTNagW6TETG8kMJbXc4Rh63T7GIvJ7JvbifdG2XK0jMuZJcGicS4bLPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715692885; bh=7PngqoAxqPKK6rji8ZXq+PM5bGW2MtZgRGUZKxTTZ88=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=CD0rdbJG7lGKqmvfMwkmSCqHfJPgVmN9K6wjkvzHBSlBTtqrlgzDfTL6fIwRTwbyj8A0RxRcaYyYrpSk/VQqoU6uwIbn/YDaKAhDqI3hda4WvUwTrMEnSySlGMXPS82qT4vPahWRhdKnD8cfnk3sZUPNpQYPLhhFbboJDS6KWUxOEyXMPd/NzAlySzYPyrS9vKp2GpAvmsG3JyThlC3fsAhfuzhZjeuYQf0E4QP8tdOZwPyqwh8vcKjAd2TjASuPJDuj3fFog404BJs6+Mx42P7LXBSAUfUVg/6FZtb90EeO0kPQXkfAuZBapLXd+uHZyf0/QY/G5jUJ+P8m7k0QyQ==
X-YMail-OSG: EJfSh3IVM1mV2u_Ym0XQC5AGUHjfIL_6xJFIjTr43wbINzQJA5ByyViZ7OtdfVS
 d_lwqbIpGGfaC5BJJekV6vQA6Z0s2Nd.BIuYFc2N61PCImwXjvu7RgsJZqZgSFu3gdhm20INHwSv
 IbFyd.xY9sI87ZqgpqbCYUc_t7wonILPTA4gKPkEu6LTmWBDCeFCoI8s5AVSYQBiXUwQ7qRC4WDU
 sn4g_IGuJtQ79yERFigGGJaAiinT4XVLkvLYIEBOXiZFfn8mHxRmmQoMURQoWTvkFAVWVg7oJvL7
 gt6uX2gUpJSt8TaXWj6zEHpVzb_g9wYGC4vC0Um7EI8Rlnrr.F1RBurSlAgnnNl1D4kp_YKgauO9
 eGGo4aN4C1lDauvSp_QFhq8Mc4PkrWuME7Gr8ScRvYlHf2XtiewZCNKHzMrvTLhx_TQjiDIaBBIo
 fJ9I0Xu_YXpxdNX2zwPriYB3H3WFbDAzBuvUNAHScGOcf0cu2AIBPgsElOyv4fQlfJJ.Ebacmdaf
 mqyQtf3648NcJgSxppKyIqIyKFD0eDkzqOH4bjpAmIAO4m9XUgJLOiT3ICbCbNt_CN9KV.eL3IeE
 auuIsbmnUYK3YgiUwzhhqJdquwgyB2bAZt3.omTYFTPS5efqa0tJeY7Mwth9c0K_02sr76k7p9bj
 291Lk7R9BRihR.8wrcfSFDijqsmp8x5oQcMGC58gQzYaifZpHjcQndWAtS8hJszLsINvc8hCSKnF
 _ApwBd1_hnC6xz7QwimHPCgR152ojMzULV31bsu4VPLfA.TWFjDu8Wzf9f3trjBP8favQLaH4iwH
 mwThQh2Qji48_paWjS_UaYOPxXKzrMxZmJhNXeWeudP69wOexna2kzBUMIQ1Arozh6IQMAqs7bYi
 TA4eryYe61TBfI4XjTu1pl_kP1Hrtm7Bbo5zKpI0cpWyYWErH_lvZyx2xXvw8kkdbd8eburbREBT
 Zb3pZ.8sR4pU2CLXzcgGpSZBHXmmUrt36QpEd6ies4DDeCGuxQpn1CC0E64hadf6wnKFpBIi3.Jo
 rakCsSeqZu1dLJa8VLr4GRq0iLyoYNUKk4wI0tQgn95o6AzGGhZv9Igyuc7Kaq2XkHLRFBr74xmQ
 3sRvZEHZpXtGAyZAvr28JQkFlTQhAncv2QTyq_7cTXURWDN8cjb.5Mk7VSCuOIcPixt.WKaYe8dz
 z6xOOd336B1gwHA96YHiTSCwvsNPV5_c3y5zRIpJEqBOuex0kEvxn6ceR0UTZVtqDwQR7h205yYa
 KFUs2Ziq3baqw5LiUWAdcA8_oG9GmxJZASBn8d.T8palzIrOMqaOTIDlzqb7UPAVDaxdz7gGf3vl
 N3BNp0EJy_B2Xzmg5AT7U1hmax1HeyaOypo0dnqeQGsWIPzVwfwCSaIdapSiiBGN.4SAF_yFBfFK
 Zz.8PWHH5LegNh0UmMkncLHln0jnWEJWCgUzgliPjnD5WzRvM9YFIdqNQKsVxfwBTq2CRiwXr5Fs
 _y7U6Q9wDGSIHoLRJNtlUW26x4sX1WdBE54o.WpJzqytIY39RMrIQ1c6ABhZgwfRH7b5CNUFW2_o
 _uzTBLqqdfbnO8xDbuMaRCH3O7dfA4lEuKP9dn5e2nsPdpTh39JEFyadw1CS7POGzoSFMRV14nal
 pshgXtoNiVRrJ5dojdgzjlduPZJUzFDVMUNEv0vpWOHDx0E0i8mTUHryLhKMz8Ros_pvB.40PiiN
 7J8pgzrSgdQ0J_Br94oCe2TxtlkhaCzC6mwT7Cf69Og3noUSFV6FeD3hzSzouhUJiQFJeJn4tTTO
 Q8DCtddvnZ1wq_0jWjMmAuSfQ8HcvAgx.isOhHZgHgpL6oQL6E0TLIty3fho0cK6k8b9AjlUHE1y
 GbQQJFeBv3hgnLZKmZZE4QYo8_FZJAXhTMhC78Q95k7SvROz_iB7j_L1uYcQm2rR9nL9MhKQbmhG
 bQxqmV6rCvPNpD2HCbcb02Pvq14bg.gz3h0GcQdnTQ5QC9EgYZ782.FD7WhS1HsCAqKUCJrA6Piq
 z_USTX3U2OyDM8hHb1BwyH0fxwG3KMsglDsadfKrMGBQL2NMyEPQYp8RyzrPoRWAuM7L4EQ712..
 NKy.X1BIhfuJg1lUMuIYZWnbhG62fRPgIgsrqlJ_ndVwS5ghEs8t_nKkJr.PjnYruDKeTowzw9mk
 UfTGYjEErCgeAuRArUo4veQALnQxln8cAnin8yYtgAJL7JOPfB3ONNwTZwuDaSqJ14GjeNsBwM1d
 yDP.mDjutRQh9sh6t7aZtsaBr33rrS8tw_fC1TA--
X-Sonic-MF: <vkrevs@yahoo.com>
X-Sonic-ID: 8705d1b8-d904-44ac-a0a6-bd8618fbaf99
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Tue, 14 May 2024 13:21:25 +0000
Date: Tue, 14 May 2024 13:21:20 +0000 (UTC)
From: Vadym Krevs <vkrevs@yahoo.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, 
	Linux Serial <linux-serial@vger.kernel.org>, 
	Gilles Buloz <gilles.buloz@kontron.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>
Message-ID: <645803059.1237606.1715692880298@mail.yahoo.com>
In-Reply-To: <6bfafddc-cf5b-4829-e09b-2622aaf83093@linux.intel.com>
References: <ZkLv3wn62jqMVpSF@archie.me> <CAHp75VcjeJ5oZy2JjbyrKn+GVvixJKmfh3Yj1p-HxcJHrm0Wzg@mail.gmail.com> <606328522.1205749.1715678929830@mail.yahoo.com> <CAHp75VefMFJMAHrKmDf1joSkKOcaRMJWse8yM63Nt5v2W7w3Fw@mail.gmail.com> <6bfafddc-cf5b-4829-e09b-2622aaf83093@linux.intel.com>
Subject: Re: [regression] [bisected] commit
 6bb6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0 corrupts data sent via
 pseudoterminal device
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22321 YMailNorrin

On Tuesday, 14 May 2024 at 12:03:25 BST, Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com> wrote:
=C2=A0
> On Tue, 14 May 2024, Andy Shevchenko wrote:
>=C2=A0
> > On Tue, May 14, 2024 at 12:28=E2=80=AFPM Vadym Krevs <vkrevs@yahoo.com>=
 wrote:
> > >
> > > It's a standard setup for an out-of-the box default install of openSU=
SE 15.5 with KDE. All tests done in Konsole with bash as shell.
> > >
> > > stty -a -F /dev/pts/1
> > > speed 38400 baud; rows 57; columns 217; line =3D 0;
> > > intr =3D ^C; quit =3D ^; erase =3D ^?; kill =3D ^U; eof =3D ^D; eol =
=3D <undef>; eol2 =3D <undef>; swtch =3D <undef>; start =3D ^Q; stop =3D ^S=
; susp =3D ^Z; rprnt =3D ^R; werase =3D ^W; lnext =3D ^V; discard =3D ^O; m=
in =3D 1; time =3D 0;
> > > -parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts
> > > -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ix=
on ixoff -iuclc -ixany -imaxbel iutf8
> > > opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 b=
s0 vt0 ff0
> > > isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -e=
choprt echoctl echoke -flusho -extproc
> >
> > Thank you!
> >
> > Yeah. SW flow control is enabled, but I don't see which character is
> > being used for that. Anyway, let's give Ilpo a chance to look into
> > this.
>=C2=A0
> Thanks a lot for pinpointing the commit with bisect. It turns out this
> is a quite bad corruption bug and I'm quite surprised I didn't see (or
> notice) it while testing the patch.
>=C2=A0
> Could you please test and confirm the patch below fixes the issue?
> --
> [PATCH] tty: n_tty: Fix buffer offsets when looked ahead is used
>=C2=A0
> When lookahead has "consumed" some characters (la_count > 0),
> n_tty_receive_buf_standard() and n_tty_receive_buf_closing() for
> characters beyond the la_count are given wrong cp/fp offsets which
> leads to duplicating and losing some characters.
>=C2=A0
> If la_count > 0, correct buffer pointers and make count consistency too
> (the latter is not strictly necessary to fix the issue but seems more
> logical to adjust all variables immediately to keep state consistent).
>=C2=A0
> Reported-by: Vadym Krevs <vkrevs@yahoo.com>
> Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely=
")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218834
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> drivers/tty/n_tty.c | 22 ++++++++++++++++------
> 1 file changed, 16 insertions(+), 6 deletions(-)
>=C2=A0
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index f252d0b5a434..5e9ca4376d68 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1619,15 +1619,25 @@ static void __receive_buf(struct tty_struct *tty,=
 const u8 *cp, const u8 *fp,
> else if (ldata->raw || (L_EXTPROC(tty) && !preops))
> n_tty_receive_buf_raw(tty, cp, fp, count);
> else if (tty->closing && !L_EXTPROC(tty)) {
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0) {
> n_tty_receive_buf_closing(tty, cp, fp, la_count, true);
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > la_count)
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_closing(tty,=
 cp, fp, count - la_count, false);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp +=3D la_count;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp +=3D la_count=
;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count -=3D la_count;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > 0)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_closing(tty,=
 cp, fp, count, false);
> } else {
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0) {
> n_tty_receive_buf_standard(tty, cp, fp, la_count, true);
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > la_count)
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_standard(tty=
, cp, fp, count - la_count, false);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp +=3D la_count;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp +=3D la_count=
;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count -=3D la_count;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > 0)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_standard(tty=
, cp, fp, count, false);
>=C2=A0
> flush_echoes(tty);
> if (tty->ops->flush_chars)
> --
> 2.39.2

Yes, I've tested the patch against the 6.9.0-rc7-local-00012-gdccb07f2914c =
kernel (last commit=C2=A045db3ab70092637967967bfd8e6144017638563c from May =
8th)=C2=A0and it works just fine.=C2=A0

Thank you very much for fixing the problem so quicky.

Kind regards,
Vadym

P.S.: Hopefully, Yahoo mail has actually sent this reply as plain text.
