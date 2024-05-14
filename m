Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB5125AC;
	Tue, 14 May 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662825; cv=none; b=W31FuuNheolr2EZlZy+BcWXuC3Uw/NPBdIg19VTwFEEXPs+dDNoZDO3NQrcfVIgwAxv+iVO92TDlYIQVPA2PNp6qHn3d7das4kVcrU8LrsmtaNrXETTGxtZTKpRQ6JQpAoYtydP/7Vu/7nDFUc0mSvy2GoD0Y9n1ReMa0pyeY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662825; c=relaxed/simple;
	bh=WX7VG3BVk9XSoR5DqCAUrIPNR1eRdJyWanKtGcOcsYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kF2ejwUwehstoouJLb/IFeXl7hwjKQsDJG6GDtHabJ7UTRnpQwpruTtP4KScJeYnK0bDEq9n/iK2YVd90SILlrE6+BoouBbIRC3PpK/zXcnF+Qk5JJSNMsSE8FwNdu7cnjLqxm34lQOh/GgIUvHmpQAd8/7GlAX7h+2z0zBUqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4WQrP8C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4WQrP8C"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso1856271b3a.1;
        Mon, 13 May 2024 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715662822; x=1716267622; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXNx2Z+E3SWT+ukr47s2ttlE9TfM7OSzxxKe700bUPs=;
        b=D4WQrP8CF8uDsoaDGTtGAfN8FYdUcLIFr+W+tf8QW2kiu1HSDNUTS3pmMLIg4ExnEi
         987MMv22VjORBtQetLHf+pS/vnMV4pZlLPcQkRN3ykEctz77jRo9/GZTfrJaUxxKSOEy
         GmM9zRVxZIbdT7T5vtJ4QHC/ngDumqt+vXsFQp0onSLdECKf29UU6FJn7ojnxKYtMeNx
         hVcwUARZUEVUPyeSuWuMT+lCC60Qz5da96o/860Oi1vl7krWD+Er5NmWMkX1cKa/2Hws
         8miyP6KbLAMM0h/X379fF3TrKvvR10qht5R02R04x5962y3YctFIYPnmBq9yO/DvqMPj
         et/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715662822; x=1716267622;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXNx2Z+E3SWT+ukr47s2ttlE9TfM7OSzxxKe700bUPs=;
        b=npdTVZPUQ84w3xENo8jla6M9VLwA5w4lj+gcZueP5GV5A9SdNuThNLzM4BmPisM1Ti
         dcFNBRb6NUkTlYl/ELDEJ5WXekxCbca8zT/a9hM8yvbMGWD6GY+oGjtupVtOEw/mIWgV
         3oJXu2S53Cox6ndUsMtr9sYbVvUfxO+DzlGm0QfKYRKmvI29hGv+oE5DAqArbmiFuEl+
         xmtFG53PCA835QORY0GcSth7hc2Vr7OeTetmrPXjslYgP93U2JOAu1FK72D0GVLIjzp4
         UmtbE586FtF2p8XhB8/Iq7oRrsOo53faBs53X8B6kCbpE+gWLbJpnTD18Tr9VEqwWh0W
         Nm3w==
X-Forwarded-Encrypted: i=1; AJvYcCXboz9e7Brs5GsTHh6c4D9tr04/PtNgnnKteVSMifwPcNShcI9RTP8mbkhDyfaSXrA28xfueBNPLG92aksLygxedWh7Bxxl3YpnI2jE
X-Gm-Message-State: AOJu0YzibcRyiGfsP36qw/RYlBERfRPKHiN/1u+DlE0qMxQjysky8tmb
	KIfEz6eN1FeSuSLSJqvYwuo7T3FRu48Einq9bbcuRw+0kvLaxsDh2B8uQw==
X-Google-Smtp-Source: AGHT+IED/FDIqZjd+pjzL6M2mZKkK4nwgYtSITAYtDSf47BelW+pgQGsieNiCMEsJeuVPNlVRnJq6Q==
X-Received: by 2002:a05:6a00:2d9c:b0:6f4:54f1:ccae with SMTP id d2e1a72fcca58-6f4c90b608amr20178902b3a.6.1715662820941;
        Mon, 13 May 2024 22:00:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2bccsm8904470b3a.170.2024.05.13.22.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 22:00:20 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 80098181C8F95; Tue, 14 May 2024 12:00:16 +0700 (WIB)
Date: Tue, 14 May 2024 12:00:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Serial <linux-serial@vger.kernel.org>
Cc: Gilles Buloz <gilles.buloz@kontron.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>, vkrevs@yahoo.com
Subject: Fwd: [regression] [bisected] commit
 6bb6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0 corrupts data sent via
 pseudoterminal device
Message-ID: <ZkLv3wn62jqMVpSF@archie.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FhXQwPKZX4lMLcx3"
Content-Disposition: inline


--FhXQwPKZX4lMLcx3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

<vkrevs@yahoo.com> reported on Bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=3D218834) pseudoterminal data
corruption regression. He wrote:

> Hello. There appears to be a regression in pseudoterminal support introdu=
ced by commit 6bb6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0.
>=20
> We have a wrapper program that uses a pseudoterminal to transform data fe=
d into input/read from output of a child process. Transformed data is writt=
en to the master device, the child process, whose stdin/stdout are mapped t=
o the slave device, reads data from parent by reading from its stdin, proce=
sses that data and sends it back to parent by writing the response to its s=
tdout, and then data from the child process is read by the wrapper from pse=
udoterminal master descriptor.
>=20
> This used to work fine on various Linux distros such as Amazon Linux2, SL=
ES 12/15, openSUSE 15, RHEL 8/9 with pre 6.0 kernels. However, running our =
regression suite on Amazon Linux 2023 which uses a 6.x kernel revealed regr=
ession. Sometimes, when a lot of data is written by the parent process into=
 the master device's descriptor, some data is lost or corrupted when the ch=
ild process is reading it from the slave device's descriptor. We've verifie=
d that this is a kernel regression introduced via commit 6bb6fa6908ebd3cb4e=
14cd4f0ce272ec885d2eb0 by performing kernel bisection as described in https=
://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html#intr=
oguide-bissbs. Bisection was performed using openSUSE 15.5 in VirtualBox (s=
o the kernels had the tainted flag set) but the issue can also be reproduce=
d outside of VirtualBox.
>=20
> Bisection logs and a repro test case used to perform bisection are in the=
 repro+bisect.zip attachment.
>=20
> -------------------------------------------------------------------------=
----------
> The test script, ptybug.sh, pipes a large plain text file containing 1027=
800 plain text records separated by newlines into the wrapper program. Each=
 record is a 0-padded record number padded with spaces to 80 bytes.
>=20
> The wrapper program sends the unmodified data read from its stdin to the =
child program via a pseudoterminal, reads the output from the child and pri=
nts it on its stdout. Wrapper's stdout is redirected to a file which is the=
n compared with expected output.
>=20
> The child process reads exactly 1000000 records from its stdin, strips of=
f trailing whitespace, and prints the record on its stdout.
>=20
> Both the wrapper and the child process mirror the data written into the p=
seudoterminal master descriptor/read from the pseudoterminal slave descript=
or into separate files - which are identical on kernels prior to commit 6bb=
6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0 and which differ on kernels that incl=
ude that commit.
>=20
> -------------------------------------------------------------------------=
----------
> How to reproduce:
>=20
> tar xvf repro+bisect.tar.zstd
> cd repro
> ./ptybug.sh
>=20
> Expected output (on 5.19.0-rc1* kernels prior to commit 6bb6fa6908ebd3cb4=
e14cd4f0ce272ec885d2eb0)
> rm -f ptybug ptybug_child gen  *.o
> cc     ptybug.c   -o ptybug
> cc     ptybug_child.c   -o ptybug_child
> cc     gen.c   -o gen
> Test run 1 ...
> Test run 2 ...
> Test run 3 ...
> Test run 4 ...
> Test run 5 ...
> PASS
>=20
> Actual/bad output (on 5.19.0-rc1* starting from commit 6bb6fa6908ebd3cb4e=
14cd4f0ce272ec885d2eb0 and later kernels, including latest)
> rm -f ptybug ptybug_child gen  *.o
> cc     ptybug.c   -o ptybug
> cc     ptybug_child.c   -o ptybug_child
> cc     gen.c   -o gen
> Test run 1 ...
> FAIL Actual and expected output does not match (gen1027800)
> FAIL
>=20
>=20
> To see the difference between data written by the master into the pseudot=
erminal master descriptor and data read by the child from the pseudotermina=
l slace descriptor (stripping off trailing spaces) run:
> diff -u gen1027800_sysin.txt.nospace gen1027800_a_out.txt.copy |more
>=20
> One possible output is below (every time you run this on a kernel startin=
g from commit 6bb6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0 the results are slig=
tly different). As you can see lines corresponding to records 17861-17862 h=
ave been erroneourly replaced with lines 17858-17859, and so on.
>=20
> --- gen1027800_expected.txt     2024-04-26 14:39:22.287121535 +0100
> +++ gen1027800_a_out.txt.copy   2024-05-13 15:52:48.915952662 +0100
> @@ -17858,8 +17858,8 @@
>  000000000000017858
>  000000000000017859
>  000000000000017860
> -000000000000017861
> -000000000000017862
> +000000000000017858
> +000000000000017859
>  000000000000017863
>  000000000000017864
>  000000000000017865
> @@ -51261,7 +51261,7 @@
>  000000000000051261
>  000000000000051262
>  000000000000051263
> -000000000000051264
> +0000000000000512651264
>  000000000000051265
>  000000000000051266
>  000000000000051267
> @@ -104576,9 +104576,9 @@
>  000000000000104576
>  000000000000104577
>  000000000000104578
> -000000000000104579
> -000000000000104580
> -000000000000104581
> +000000000000104576
> +000000000000104577
> +000000000000104578
>  000000000000104582
>  000000000000104583
>  000000000000104584
> @@ -110897,8 +110897,8 @@
>  000000000000110897
>  000000000000110898
>  000000000000110899
> -000000000000110900
> -000000000000110901
> +000000000000110898
> +000000000000110899
>  000000000000110902
>  000000000000110903
>  000000000000110904
> @@ -279673,9 +279673,9 @@
>  000000000000279673
>  000000000000279674
>  000000000000279675
> -000000000000279676
> -000000000000279677
> -000000000000279678

See Bugzilla link for the reproducer mentioned.

IMO, this is quite different from the case fixed by 56c14fb4086b2d ("tty: F=
ix
lookahead_buf crash with serdev").

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FhXQwPKZX4lMLcx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkLv2gAKCRD2uYlJVVFO
o18gAQCN9uc+cZ4uY13FfkF0y4a9fH5vuQL1tKXciJwjsC8lAQD9H/5fOYmkf3V8
p7cTZrOxl9rYUWA35/QaSWAO2w5S8gQ=
=8tYJ
-----END PGP SIGNATURE-----

--FhXQwPKZX4lMLcx3--
