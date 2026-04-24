Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9A3AD50A
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029831; cv=none; b=oOzF3rqVg52CvmPCsq4Ai8BZsqssZPm+zIyUSDL7l5lHs2gPRQ5/QvdTHIprp5kBdIqJiMwDluXCIiurQbtT5aUQtYoUzBaBGIqOkN5yTUjKkJPNG3xQSx/8PxWdSRb7xsWxrIqo01lj5/ykIU9ZzyNCDW0uDPLZRpBjOVCfaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029831; c=relaxed/simple;
	bh=CRAdYzX9+jNsTYs4h8ctNWZTdaCBBbrpEXxcu4w9zCQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GoAPLrys1r/EM7KolvZZx96+tGQ7BKjGzEZCs4buWkdyTzVP3OvkdIArrNpwOc7VO12852ELN1AQ+oys0tq5bAlEP3tj+Cfk65dXp/5YV5ZDMDpUjn2ouYKcRbCcjceCJXvGFb9FBCw1VNa3z6g/S8P29sug94fUFZOYnKDF190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hobNOn+j; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hobNOn+j"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eada6d900so7537383f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 04:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777029828; x=1777634628; darn=vger.kernel.org;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+t+DJdjmBiSqlx1/PpjPe0tKhCBDYlA3fqYW1n4w00o=;
        b=hobNOn+jNnkILFM0B2lWuWoYhwhZrFxY9Geg77nhWKIxfnXfF8/kdCXUqF3IAH6N85
         +MnXX+X/ryx3Bsb6GDGsnU+E7gsrj0IJK8lZwR8RlhREjSRMJ/+Qt3zcDdkIFIWaTjFD
         2KBPkIHZyxjw8xEjD+3KFJm4otmxlu+Dn1hPLmAPSw7NNGBzdT7P3K0buEHgORui9RC5
         fBO+PBMgPIhhQCJ8Yay1I9UptXXghC2VGHRzgaS9ncV7xSj+i+cSKniM8nvvEqnLqnDp
         CxNPHUOaxAc63WJRXFxdlW/xuJ9/fDR33uXVXIiqCTPauSSSLmEoEGo/B+t28aL6Yc5r
         zAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777029828; x=1777634628;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t+DJdjmBiSqlx1/PpjPe0tKhCBDYlA3fqYW1n4w00o=;
        b=rhunWAvq9WBdMs+2BXCxdbZ7iSbCJqPU6Li6x0KdPYDIKniaD6bAVqGWrNMu0lhEVs
         yrQRGh0wA6DwauuvKctTwHW+wX7E/+9j5D+244wbGUe8jFFWQnsCRL9coXfOPFJpqkkw
         f9AtlBzehpGWec1dV6nlxkbMIvnwv2MM3hAy1Dx/n2F/6DEsQYCPgtb1bRJam6xeAvND
         9x0mGYhK/A8OJRudBXalVzbBDE5u9a6TtDsPRIGhhPZReFQhZ76GeB4IZdPlJDBVAiQ5
         MkXmMmCg1eMTNTY9Pnok7upWo87iAsflFsZKqFpC+VgUy7lDvwBxzoRF2KQadXshkn0x
         Rsog==
X-Forwarded-Encrypted: i=1; AFNElJ/fMMKGxop0zdZeH/75LvjnbaL1WoMKxmRg+J1confb7lv0kuNo90kGLxRUxBJ7kdpWX05Gj6BoR7v0ZQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/Kam/IQqq3egt1dK9RJJj+I2CapXzx1Pqu5F5dZROXQtkS07
	67Zx3mdjaewXfacRdWGWwwSoaxODNbmx9gLtkj7tp1hv6aHuNw+zZ0g2
X-Gm-Gg: AeBDiesUYGagm4Jgi8MqcYSDRC+aKSeQwpaBSDm3+Wy8wGhxgzzA7KOY9FKtbGvTK0v
	wGMSYVgl6VWaNc2SKu74PB5qR6xc8lcgQYCear5sDzDozEVzfcxHturN7agvWpO60vOXEhdBJ5D
	+V2zh4aZQrvtTWJYai9ucpTZ3pjwExTFbaM1iuBT96O1OAW/lixE1uH2Jk5YdZ7M89K0RtW+ScB
	r1V0+h/RiQPV36ju9vOcSzhUUgg4RxbP2iMJiewplUAvgo+neJ1GDN8DPQI5GNmtCWF2PMru4DD
	xl9DBp81vWKwzxjwRwAXGuBeOFP9i5NUelOCD7jXxDML2dM3wzqGPzMQ/qekkH6BAHU/C/qHJRD
	iNEHtop2bZhteA+SD72C1V3KtmuuotOGQvuQlfMYnqKWwzMSCw0yaDIXcY7uVUpO8Zi6rMjnrEp
	yujzI3Yf5TWt9JsVKCNFXAQdC2pTeUYUiGpJB06FO/w7Ov
X-Received: by 2002:a05:6000:240e:b0:439:ae2a:755e with SMTP id ffacd0b85a97d-43fe3e0b606mr48159269f8f.23.1777029828055;
        Fri, 24 Apr 2026 04:23:48 -0700 (PDT)
Received: from smtpclient.apple ([197.250.51.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm63645843f8f.7.2026.04.24.04.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2026 04:23:47 -0700 (PDT)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_EE2E18C8-0A52-4302-9DA1-BBDF2F1ACD26";
	protocol="application/pgp-signature";
	micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v5 1/8] ARM: zte: Add zx297520v3 platform support
From: =?utf-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
In-Reply-To: <CAD++jL=am0f+sgBSFYQCdcFOvFWgPETn_pSgVdzETJ3_yUNqgw@mail.gmail.com>
Date: Fri, 24 Apr 2026 14:23:29 +0300
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 soc@lists.linux.dev,
 linux-serial@vger.kernel.org
Message-Id: <BF5EABA2-3168-48A2-AE2D-D8EE2CF88E9F@gmail.com>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
 <20260421-send-v5-1-ace038e63515@gmail.com>
 <CAD++jL=am0f+sgBSFYQCdcFOvFWgPETn_pSgVdzETJ3_yUNqgw@mail.gmail.com>
To: Linus Walleij <linusw@kernel.org>
X-Mailer: Apple Mail (2.3864.500.181)


--Apple-Mail=_EE2E18C8-0A52-4302-9DA1-BBDF2F1ACD26
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> Am 24.04.2026 um 10:06 schrieb Linus Walleij <linusw@kernel.org>:
>=20
> On Tue, Apr 21, 2026 at 10:24=E2=80=AFPM Stefan D=C3=B6singer
> <stefandoesinger@gmail.com> wrote:
>=20
>> This SoC is used in low end LTE-to-WiFi routers, for example some =
D-Link
>> DWR 932 revisions, ZTE K10, ZLT S10 4G, but also models that are =
branded
>> and sold by ISPs themselves. They are widespread in Africa, China,
>> Russia and Eastern Europe.
>>=20
>> This SoC is a relative of the zx296702 and zx296718 that had some
>> upstream support until commit 89d4f98ae90d ("ARM: remove zte zx
>> platform"). My eventual goal is to enable OpenWRT to run on these
>> devices.
>>=20
>> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>
>=20
> Didn't I review this already? I don't remember, anyway:
> Reviewed-by: Linus Walleij <linusw@kernel.org>

Yes, you did, but the previous version, and after I sent this one.

And if I understand the b4 docs correctly, the Reviewed-by tags are sort =
of handled client side: I have to tell b4 to fetch trailers, and then it =
will add it when I send my v6 with Krzysztof's request to squash =
patches.


--Apple-Mail=_EE2E18C8-0A52-4302-9DA1-BBDF2F1ACD26
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmnrUrEACgkQPRO8yFRP
GiKRrQ//d0i3JtN4eqnwGJS0KDoAetBNQXiNUwHJGszPaUlMzi1beDOdsTFk7Who
t8GNv9VvwjuR7Agxy+B9vNltnZanU6djJKQhm1+Qd7AvlC86ueKD2tGZUxpmuipl
37Poxi+E1zUTG68RTaJz1p0utLhaZkiCjVJzmTQgJJq3mAfYp8ycFI29IgdGHJCN
612a3nSFm1l6vz8a+qSX9kQG1UnTYQjsavu1ACxQp9Kk1Xga1G+atLgfXTTY3Aav
LjzHpAl+B0szQ84Zb05ZpJ1jiZYnMrDrIlNu1hv9/PTddXHyL2ISI+0um5OCvJ6n
61iXnVpyJlrscV1Iqs23VwxKx+y3rnV1JIlf/j4n1nwkJ5LQLxRWuYUpmK71uwKt
8WtiK3AD9VxnQvfVtAn2ltUaCLeeE+pZpSwnOvI31AOrwwZQ3ckSqkYRYVwnxVZZ
hkYMk1IfqjRPdMgMjyAqKEPZ5hOqYC5eqd68uM0HAXpYnUT/FNxGw/+sV7oX3qyY
eVho0WqhoeBEAezLTQ+GeCNlLirDpHwT2Y8NHYxSTlIQuwhwClwRPjdXCyS9adcF
eCz32rEZFS75z0LG701LB+MlMhblYEkGiAm3DEsFo4778ft7kfWC5N3GJLbu31SX
1/xC0sqkBY5zF5gvLXwtw0kEniW7PzEgc3oc2N3T37x4mk/WGfo=
=+4QJ
-----END PGP SIGNATURE-----

--Apple-Mail=_EE2E18C8-0A52-4302-9DA1-BBDF2F1ACD26--
