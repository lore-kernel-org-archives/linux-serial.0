Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6142F1FC9
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191743; cv=none; b=hGxPzZ8xxQj8CsN/UZdGkP8L7bM2/pFcqZyQaesllfTgcGe7rFuRrnQlVb04OQmColxAxRY3t4h1I4oL/U0QPxGS0KY7BMyukBt1cudAODUJ276V9ZZ0sIk9NBB+/2m1VmbgZeL5aa0lthiq/J3azGkzKXvCDnjoDxRT3n/Jr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191743; c=relaxed/simple;
	bh=trZCIv4VUbmZsT+tqtZK8MjDiIjWO57JQfjXqAJtZwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOiXSDIwmbW66H5KW4kyXbk3cD+uxXCGrOY+0YUZ9NUPugr4v3N2Mn1RKc4zCxGESLHXBbP+qw4rqMgWeAlKawGFphJyFMyrR4pRxThsDlzpKpScuPHLsSvP0CzKOw3qcLnnmOvVdqntD82d3KBFdeWSMddjAcCivJLlFF4Dtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS8RMX/r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS8RMX/r"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ba840146so12172775e9.1
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2026 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778191740; x=1778796540; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=trZCIv4VUbmZsT+tqtZK8MjDiIjWO57JQfjXqAJtZwc=;
        b=TS8RMX/r6PH+MkBNNRfyXf5BvgXb5OkjCBwOOajaDb4vSQLyFCmZviVLdgHj7Fhq7n
         f86xDcMvdrqvB3fdXWI30Giz8t8XSFpbcSZsEqhyOXxESkjEtorlY5IC7j+IYEiZXDkJ
         Fhaxhntecj14ga0ZbccIAB3qYDm61ygrZ7N5dGYw7Tgvrv/FkBix/G5b3USGwZjNNnKv
         I+w2H1MOSfAvO6bfi9YwwdwKqa0yCDQEkSOZg8pD5R/P97/FUFPEwhF4ChUcaw+B4BN3
         RgVvz4NqxSGvB33yNOzrxbA1VJfzyGXd+v+3Ac8RsQ7DBBoHz9/pq4hzHAmTi4JDGnWq
         VWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778191740; x=1778796540;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trZCIv4VUbmZsT+tqtZK8MjDiIjWO57JQfjXqAJtZwc=;
        b=pStgMoC5NbIp1NaVRv0gnCifSqRi2okrm7e2Mxn0tnWURc/fit8P3MURycevJqPnl2
         82+rYVK6bdOZYRfg4GhhwqDa1Kq8F57P1CsZ8AAxTV0RDRyA2u6OjnVswpK0UQlSg5MR
         zDCV2JJzxUX8aKkYS2hCBd/Bq+s/tVNgs/4t5zasaSjD/OZD4dcjX18C3KEwnhv14h0r
         s60mY0Z5VkQvcPJXqMO+J/SVSHNW6Cvm2Lc9ob+59APsw1XQ04Gb2/ExU5cf7xpS99PX
         h+EFWpBXntZU1Wp3T7e1j+Uuke+w5xaYDOtnwBcdUkx3LkpxfmQROwre8duNOKc9ZMUL
         0iPw==
X-Forwarded-Encrypted: i=1; AFNElJ/uFZHj2NiLpd1iQ9HOf1oByMrE0CKG0L9rw4YtMYAiC3Imlm0D3zqP9vp+6NMbnZe8plQ2ZE7z0KX+6mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCPDnDu1iGgAliHzZGGEeMdjKjMXZjLtjzcHbnZlGga6YN5yN
	21nDnMynxoNz/SlFW5/39RBJ3c6reqkC6QZIwCBrSQ90UO34M5dVSxPI
X-Gm-Gg: AeBDiesk4zq3A9aerfc98lo529EGQ64LkFx3uEz9rFbTzTQTjo4841Z23ef3jgmHO+k
	wu96Ch1SpOoKiJ9JeCHkSmr6MYUax5EENZf5RsyZgadcFCB1a3jubmiw38W8gqliVNB5BKF6GRB
	gYfaeY9uY6xhhmytRZIfLiFOA59LKhmThrYbK1xyyIuUCQnexmsjd/Bx10sDJ75Bbkff39iV0Xn
	132dnCsFlL69wFd7pcPwr75FqtS9T1h/2Q2Ty7YahGGY0RV+UtjUG2sbTFFvAjqMazksqrxhoHB
	No5jHd5A3oTO4SipLjDFzzMKtMRLCj4BbhMAzKALhcjQRwztXP2DfUYmUe659hFXQGnaMvv8ZEK
	LU/bvin0P9fVhicAFBKjOtEAG+jd44c8pGfynHYvLqqJdCE4emWXjlo3b1N8DijyrKc9+JRBSZ1
	UcR8JtNNrygYRfxQAfba0liNir1b3ISC9qXALYZmFsLXfCkmbz
X-Received: by 2002:a05:600c:3548:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-48e51e0a60fmr153507315e9.2.1778191740007;
        Thu, 07 May 2026 15:09:00 -0700 (PDT)
Received: from silicon.doe.home ([197.250.51.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412de445csm1834705f8f.14.2026.05.07.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:08:59 -0700 (PDT)
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 6/6] ARM: zte: defconfig: Add a zx29 defconfig file
Date: Fri, 08 May 2026 01:08:49 +0300
Message-ID: <23095518.EfDdHjke4D@silicon.doe.home>
In-Reply-To:
 <CAD++jLk02QnkXYwJ0b6x=qw9stR4nPrjD3sYPOvWAQz8t9OsUA@mail.gmail.com>
References:
 <20260429-send-v7-0-b432e00d2db8@gmail.com> <5379905.31r3eYUQgx@strix>
 <CAD++jLk02QnkXYwJ0b6x=qw9stR4nPrjD3sYPOvWAQz8t9OsUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7940474.EvYhyI6sBW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart7940474.EvYhyI6sBW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Date: Fri, 08 May 2026 01:08:49 +0300
Message-ID: <23095518.EfDdHjke4D@silicon.doe.home>
MIME-Version: 1.0

Hi Linus,

Am Donnerstag, 7. Mai 2026, 15:24:38 Ostafrikanische Zeit schrieb Linus=20
Walleij:
> Hi Stefan,
>=20
> On Wed, May 6, 2026 at 7:39=E2=80=AFPM Stefan D=C3=B6singer
>=20
> <stefandoesinger@gmail.com> wrote:
> > I'll send a v8 with some of Sashiko's (very impressive)
> > findings but keep the defconfig.
>=20
> Maybe not send all patches to soc@kernel.org right now because they
> end up in the patch tracker.

I meant send them to linux-arm-kernel@, not soc@ just yet.

I propose to hold off on adding the new SoC upstream until the clk and pinc=
trl=20
drivers had at least an initial review. They are more complicated than this=
=20
current patchset and they will be necessary to do anything useful with this=
=20
SoC. I expect to send a first version of the clock driver over the weekend.

The important thing with the submission to this mailing list was to get=20
feedback, so I avoid building a long set of patches on a shaky foundation.

> For a new platform that may be OK though...
>=20
> Nominall it should be three pull requests:
> 1. Platform
> 2. DTS files
> 3. Defconfig

So I read https://docs.kernel.org/process/maintainer-soc.html a few times. =
If=20
I understand it correctly at this point "pull request" still means emails s=
ent=20
with p4, correct? Or does someone create a git repository on git.kernel.org=
=20
for me that I can use to send actual pull requests?

As I understand it, my 6 patches then go to the 4 corners of the kernel:

Patch 1 (dt binding) to devicetree@vger.kernel.org
Patches 2 (platform), 5 (DTS) and 6 (defconfig) to soc@kernel.org, but not =
in=20
one series but 3 independent ones
Patches 3 and 4 (UART) to linux-serial@vger.kernel.org. I think this can an=
d=20
should be a series of both patches belonging together

It might make sense to send the DT binding on its way so it is in place whe=
n=20
the SoC maintainers look at the patch that adds the new platform.

Do I understand the mechanics correctly?

Thanks,
Stefan
--nextPart7940474.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmn9DXEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMywyAAoJED0TvMhUTxoixokQAJhmmO8EPvppOjAKiU0j
VdiM0KDUx5XdfQy6Y3qibMHrfltre+BU1sXBALudR/Cu6eVqbRG7LnTS/SnW1HJV
nikfjKT1fNHMgbObi7u6cg/h7vAN8nH5GLgB+cXLO6WO+227c1rusLbDW7ofc3NW
5B6vIjy7FcGfNv2vLHucbdANPdwqrJWN/Ls5qHMUPmOo6Dqyp4t6KUUdlIHte5QZ
TwKse0rRM0gc3qkeiL1tAWyDGAsx3l0nkWY8Dbrv38rhF/GbnSo58wv8QGUKEwoj
7JEmr/4EKArvnpz2Hw3Kstgj2E9e2OUqV0Ba6LCKGhq5oV/+YQ0PPIrepFFznmCf
dOs0Ek838VCedQ7tTNr689DQiQqcfc9xaU9BZWOBx8c6neW6dqlLXb+Z+PzmcAMc
qwIMk7D+ryNHp8zKF5zc2P4GXwpeH5W87wU8y/pAscTqkBHe0lJqmqAemRqR5GQ1
JrpbZ9+q19rh43uWQJDc/gpBm+CqzfFRIpPHpZvgqC+C6tc+IfERZPVzp/qjG6Ee
QKks/Sw6Ppz24RhR696N1fOadSZpEBM2982UXlpTmBE6SbdMpIwycjtlakyx+qmY
31Vt8syR+uK7HDGzKaGdXU/IouS4tJ43mfi1uIPAy7OUWlFq+3foENXKECN+E9kQ
caBl+NzhrviDrlkehVYTcNkx
=U1tW
-----END PGP SIGNATURE-----

--nextPart7940474.EvYhyI6sBW--



