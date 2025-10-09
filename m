Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2F2D8388
	for <linux-serial@vger.kernel.org>; Thu,  9 Oct 2025 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004262; cv=none; b=DEAZP2nEsaaT30avXG5JRra9M2mYW3umQLw85dUMyFjLqu5uHqjoBHXsmvT2QTjmY6Ct7+LUkfVU/iawLCEq8g3BifzRj2MGCW/uM7Tk1CcyNMLq9QWBBAOSjeXl1RP/M1Oy63lLzuZ439Ab61J3WZHdHZ/+yTro/KBtz/ItQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004262; c=relaxed/simple;
	bh=2Fr6H8jwjZt37ecVDsUPRitEOHwjUpewoETJ3zTtOe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeMtvncOpiFyWpERn1GzifImDukm9pUHEez/4GTLxMODRnOrbwKcbXk5/uUtBYd5eCoCeng+uAjSDBcnhHigGAZ3mkcfa79GhlUqc28YheCfo5KrAy3XH6hIRcS7M+0FFbyOZ4cyQK9NCxtk/8tYc/EMr2MGkMp09pb/fRlNme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngP6bWa/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngP6bWa/"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee130237a8so758826f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Oct 2025 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760004258; x=1760609058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fr6H8jwjZt37ecVDsUPRitEOHwjUpewoETJ3zTtOe8=;
        b=ngP6bWa/VrNUAG6A4uN7bswrQLHOV+Mhbh2XCBzOZwtL/lNMnCOjAXtTZSXtVg4fPd
         yvemfrQ+/8QoZ2AILZuT0z4tNaC+Kq8lE1v3oiv9yMcO6uEYeLyyu0E6iSFz3wJuA1DP
         BqVek8Hmx4ccvieODvMkgYh7VzE6df6faystLetPtoKVRpOWS1tCJo8emK8uP4Cqy12/
         8HSQih1/fKn0ZRs7CkZvH1U/Q6enicF/rjVGep/AqAQ/SmwVo5TibW0+UX/qLOgrzVQ1
         Ycv/QRqWImse7EEMoblxHlMA+DCS7waU36JSpFFEnizqGtypAFp0zG++L3gmLobYA0aL
         C7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004258; x=1760609058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fr6H8jwjZt37ecVDsUPRitEOHwjUpewoETJ3zTtOe8=;
        b=Im0j9GCz+tTPytu3coI9bh2RkMWB9fzEI2t3xAPj7quZ0tCv8qIXbapDZ7rpsVOVMq
         BZrflEV7KXbFxdxTfzpLKFRZE0AOSVx5muiVR3DXsUyHdS2oj2J5ibH1VRwFdYwC8l8r
         rtzAv2woIz06wC/Cy10m56K32pybAt7NSKFmd2ae+284xRklfTEtWlW38aWFoxOgmZGI
         RLbEbLqCW9zSJxRYN1nt4drE9CZELBoJwaLJS0J9tbUHrrHfTNq95EAwA60SNVNsbChD
         z7J9lr03Jp/eOkBIunLZ/MH7nuw/qntgQAblo3irOeX4XTRqU6CKC7x0UoDPuqSFjkm5
         lOwA==
X-Forwarded-Encrypted: i=1; AJvYcCUKaAXrsINIWdgRC8yruzjboiw8w7+QCRSY3wOIoOsVQQpfYQptRNvlXJFCvH8MOtcnWhnkGYVFfnyCKyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuzn+8PUweuileGLx+43L9Jd5rirYPJkted0HIV1QRynmFGbQD
	VzyUkmsYQj/OlIuXUTkdic3D3D8UVXP9iQvEN/JQoxCkEFZQyUXuvoPk
X-Gm-Gg: ASbGncuZC1IHByfCP9TqtCDQYowtZStBf6ZZyOeGGwD23ZAt8nrCrhEAVh36aUnAfa/
	Ze9t4T3QM4mHmZ3PmShr3cc7YSucDB75YzwMd8alqduH0+xiC3imiEZLFjV1M/ekA5gDZ7zAh7B
	aSdD3MbM4A7hz03KBYo67OWA1uPt+ff/e7IJcQBZHuZTsGnZrmSQWfx4Xf52ALZrJtf0sLWnlag
	ax7/2LIA3NcFUnugDCWuhWGoicRfGXp9+0mgoiXwcguMItwUP+oCY1d0YeqaGZ5P0yJYYHpe16A
	OSWzSL9R8tyOZSGvsBxOMCwOesE7LYK/NXdaSnNubvi65Ge72WdrI3U4C/MaAOuOoYw0DKtHle1
	fZjLnscjNxmHMpJ8LsLwnKexUHA10tCGd2U4ZhbOROlqfK+kzCg2sLJKdIOc9vGYw2ZU=
X-Google-Smtp-Source: AGHT+IENUn+DD4Ua3s6T/uHxbEnL+FrU0mnWzB8i83U5aqUj4loYbKQ9PU9Rmt2KT7tAjVWYfBS9eQ==
X-Received: by 2002:a05:6000:178c:b0:3e7:5f26:f1e8 with SMTP id ffacd0b85a97d-42666ab3390mr5094297f8f.5.1760004256437;
        Thu, 09 Oct 2025 03:04:16 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c54sm34323679f8f.11.2025.10.09.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:04:15 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:04:13 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jon Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <treding@nvidia.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
Message-ID: <csyu222cbxrze5yv3qnwj3gl67x2pwkd6ichpotrwxoj7jru5h@cywpyiqycfre>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84a521pets.fsf@jogness.linutronix.de>
 <92b787f4-1f51-4974-9e58-231dddd4b8f2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esqfwnuvvjehlikh"
Content-Disposition: inline
In-Reply-To: <92b787f4-1f51-4974-9e58-231dddd4b8f2@nvidia.com>


--esqfwnuvvjehlikh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
MIME-Version: 1.0

On Wed, Oct 08, 2025 at 08:21:49PM +0100, Jon Hunter wrote:
> Hi John,
>=20
> On 08/10/2025 16:56, John Ogness wrote:
> > Hi Jon,
> >=20
> > On 2025-01-15, Jon Hunter <jonathanh@nvidia.com> wrote:
> > > I have noticed a suspend regression on -next for some of our 32-bit
> > > Tegra (ARM) devices (Tegra20, Tegra30 and Tegra124). Bisect is pointi=
ng
> > > to this commit and reverting this on top of -next (along with reverti=
ng
> > > "serial: 8250: Revert "drop lockdep annotation from
> > > serial8250_clear_IER()") fixes the issue. So far I have not dug in any
> > > further. Unfortunately, I don't have any logs to see if there is some
> > > crash or something happening but I will see if there is any more info=
 I
> > > can get.
> >=20
> > I have been looking into reproducing this using other 8250/ARM boards
> > (BeagleBone Black and Phytec WEGA). Unfortunately it is just showing me
> > all kinds of other brokenness (in mainline) and essentially making it
> > impossible to confirm that I am seeing what you are seeing, since
> > suspend/resume is randomly dying without my 8250-nbcon patch.
> >=20
> > Before I start spending weeks investigating/fixing most likely totally
> > unrelated PM or BSP issues, is it possible that I could receive one of
> > the boards you mentioned so that I can reproduce and debug the actual
> > problem you are reporting? If this is possible, feel free to take this
> > conversation offline so that we can discuss delivery details. Thanks!
>=20
> These boards are really old now and so I don't really have any that we can
> ship. It would be great to get this change merged as I see that it is nee=
ded
> for RT support. I could see if I can resurrect a Tegra124 Jetson TK1 and
> test again on that to see if we can get some logs.
>=20
> Thierry, do you have a Tegra124 Jetson TK1 handy to test this change on?

Yes, I do. I reapplied patches 5 and 6 from the series (resolved a tiny
conflict for patch 5) and reran the tests. Same results as back in
January, though. Basically the first suspend doesn't work (it exits back
to userspace after a few seconds) and the second attempt then hangs. No
idea why that would be happpening.

I looked a bit at the code, but nothing jumped out that would explain
this. Not that I'm very familiar with any of this code, or the specifics
needed by nbcon. no_console_suspend doesn't have any noticeable effect,
other than providing a few more messages during suspend, but nothing
that would indicate what's going wrong.

John, I'm happy to test any other patches if you've got any ideas on
what could be wrong.

Thierry

--esqfwnuvvjehlikh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjniJ0ACgkQ3SOs138+
s6EYQRAAhDp85SpD9mNp783h4fKFIuqv6SEe5ZGbrY/DGNoO2Bmt77hoHRCHmH4i
kZxKTVWdoLfjjPbzQU2T+5w2jn/7WVM1R36yYLgCmDs4WJwYQyGLBEgj5MRQG6O7
bjpbKx0pPmImzP1hKNCD1rWuH6xLe0g73uHTlcEfRe/0J7+wkCtNECSgN/GsJK83
GAI9NJK8sMCgYRvGqme7yFOHnuRqfEhLva0NFVgmSK3Lwfk46IPQEfVIbB+F/m/P
2ah523ivHLGQw+DS460RAaE78NtANwkALBYdKPX/uLk/Sq1r3Sa9BQRUCX59/0/8
xONtv4ik+zCh6HiDTgbbQ07hUH0EK0+UpiCueNYFcPu7fMg+kO2kKmDSSF6yvMfm
IhnxgYtmZBdYEfa3dHqoma6g4vFyx0VgmWXMFOyWJgabekgEZCI4UVBlSQPa+F9T
ZZIiW36HF/4C2CA4vOfmrWBHQqQMCz/9wqAL/V2+FVbRR5sfx4mr0YnqL8pPreqX
afu8fRV+xyArHdrpnWLKFa6Vwnv1Gv8utq1vrIxVpwqOt05mgA7BECoPHdwxAYtu
BObONENl4eztqLYOoBRIh3EZaAZsPNgwHBnAIOHnarZvN2Tr6OoQakjg/sFhQoiw
Mt0Va9NYPadhrB5MUGwA6NCWwsBoVcZEk0ZPlWArlZryPa7tn40=
=8N2+
-----END PGP SIGNATURE-----

--esqfwnuvvjehlikh--
