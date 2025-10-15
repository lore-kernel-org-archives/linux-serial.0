Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C5239E7D
	for <linux-serial@vger.kernel.org>; Wed, 15 Oct 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521167; cv=none; b=PyH+P5OlgyE+h261pPGOfWrfRjyuHRPU0pb+2GWk4lBrBEgAMbeRY53FoNuJBrrHUq6xq1BDeiEvPzXCoEVqpb6GsonCbyZwIN4Ixv/DPt5B/5UcBLSOLPRxiLd5OGwMX0KpNE7kDo/+FUpGqAdHpatidXAn9JF6f2d2xna0cTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521167; c=relaxed/simple;
	bh=u1eJKOWwZghNRxJv0zHXChCsSqbn7vM9VucZ50DOiNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AogwfCXmGIZxMrJ1bj4OOzI/+b51ZnN1iahqTwwi7t742Oxrc1L1MB2NPcKBryroolL/beeFpIpO8uardTWMxrZK1ZQqXuszTHa2wfs49rEmIu3zg9KF704es6sfYMv/9dmkuSPDFwQjzGKiW4mV3Ik/zduvUaXgXm0BV003qzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq3Eic35; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq3Eic35"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7930132f59aso8466064b3a.0
        for <linux-serial@vger.kernel.org>; Wed, 15 Oct 2025 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760521163; x=1761125963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1eJKOWwZghNRxJv0zHXChCsSqbn7vM9VucZ50DOiNI=;
        b=Vq3Eic35swbvt2ENzbXRVyv1LJm3HT1Q6CIPfG6OhGknsJqgFtyB/Nm0AJjW9+2ol7
         1yg9WGpzjeNIyl0VnFs/Qs9eg+GOB5UCWGQeXshJgu5GHrPg/79lO2hdqRC+QOczPtc4
         SMxxBq2KroDP+DEBeaLJDMwcbv1WaGz0HvptQrQz6jF7WyHO1xOf6hpa6EVzIwo8VPca
         8CfJpfM0QtgLAh1cKAaH6HefVDzW/SqZw68Vcc8bBtmD64BIOMmwDMRv9MPZHIhOomhQ
         s1mkc3v0qUiVLcN4H4PuxkCpN9xDw1VsyattjVd1FjG40LR68Ln6nFua6dXuyx2gz4rL
         nVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521163; x=1761125963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1eJKOWwZghNRxJv0zHXChCsSqbn7vM9VucZ50DOiNI=;
        b=GHDFqtOZp760d58m+my6CUxwtyVrRbfKySDoh0gmheCZbJsB1JW+u7eEhlpDS9Gi2b
         iqawwTVDy+Oz6TsmS3oyt9dz55H8m5lP63nNUK2LcVppYqYm5JwfIXNxTqH0Q8u7ltsJ
         H2DND48sxc/GxVT5ddbeEVw4LrYcPPHvxIrWkIJKecg/YvbOBnvYhFt7tu+WnfLqH8/c
         Tmlu2zfXDDERB5S02+AnR0QCJw1SYiuPOQLvqcFzdbNaFV0wiZpI4VXlg9up5YhHJVSJ
         /3YGwOm4lRdppdtSOg190R0u5Q1M6pF979KDnvBwqes8x7ud6AdgkUSoVKbg+uBB7jS6
         n6fA==
X-Forwarded-Encrypted: i=1; AJvYcCUBt9a9aY8wMzF1OafPUrcd+x38cvRVVWZwHM5Q/Ma/YliOCiTs+2knBc9lbDnaS5+M2sCREDXSbc6WlLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIl6M3wBntUiGvdzkA68yM0eNSCsgim7ZYh5puYtXrKST3ocQ7
	/Xdh1PACnbibLM/C0wancgj2C8VNko0imAxyd9PPHSFWrwQ3Q/L1pdcv
X-Gm-Gg: ASbGncsEkNTDfZcMn8ti/IyXTkjU+7vqbMAYkquEND1sXccK+P85CSiEg9+3jWXGNer
	8IMsqVGw17+gDRHwI/XC9R3+0QlPg6w//ocV3LjxHcSZ0CYWFMW/Xu8svKd7YK45xwtEAaQ4xdB
	f28/im6Bz4qsKHYp+B3liK2ajrxLPIbVYDIeTDsP6jRe09bEGxZO0SDJbjg8zBZq6ouHxVSvQkS
	ldJAwHlrcwXcOpS9Il4ItfGxTB+zylMZofo0EheNLlblhP6QKGesHuG3nQgy7kZzvrELWMWp6Ks
	FBOFsrLpCGOWKkrrrTL1oZ2USXdy+1ax6TZzj12OVuUDJmSCPlraHeJgrK2tclKAGBLTwBre24l
	+pYDEnJ1jO9qda/+LYMzQLuhiSuoGfYuWer0MWWXkwZ8dUHdLyK9G+bA=
X-Google-Smtp-Source: AGHT+IElgVwNPxXRA/tImitB//ntptdYiVe7d9RWZ80dKHs5si0bLCs+yLDawiIS/352iKLuIDMl8A==
X-Received: by 2002:a05:6a00:4fd4:b0:78a:f784:e8cf with SMTP id d2e1a72fcca58-79387829619mr30080478b3a.27.1760521163332;
        Wed, 15 Oct 2025 02:39:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060962sm18269938b3a.1.2025.10.15.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:39:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6907D452891F; Wed, 15 Oct 2025 16:39:20 +0700 (WIB)
Date: Wed, 15 Oct 2025 16:39:20 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>
Cc: Cengiz Can <cengiz@kernel.wtf>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
Message-ID: <aO9ryPohDdkoFykR@archie.me>
References: <20251008112409.33622-1-bagasdotme@gmail.com>
 <87wm4xbkim.fsf@trenco.lwn.net>
 <d6cd375c-dad6-4047-9574-bac7dfc24315@infradead.org>
 <aO7mnXCajeIdUYON@archie.me>
 <0cc09ea7-d4f7-4e1c-9cd0-bf310faba217@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fSCHwCyZlDgbl+8D"
Content-Disposition: inline
In-Reply-To: <0cc09ea7-d4f7-4e1c-9cd0-bf310faba217@kernel.org>


--fSCHwCyZlDgbl+8D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 08:18:44AM +0200, Jiri Slaby wrote:
> On 15. 10. 25, 2:11, Bagas Sanjaya wrote:
> > I guess the whole "On all" description can be rewritten like:
> >=20
> > Write a single character to /proc/sysrq-trigger, e.g.::
> >=20
> > <snipped>...
> >=20
> > If a string (multiple characters) is written instead, only the first ch=
aracter
> > is processed unless the string is prepended by an underscore, like::
> >=20
> > <snipped>...
>=20
> Some kind of, yes. So Either:
> * you write no underscore and a character -- the rest is ignored and you
> should not write more than one.
> * you prepend underscore and write more of them -- all are processed.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--fSCHwCyZlDgbl+8D
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaO9ryAAKCRD2uYlJVVFO
o9OUAP9UtfDuga5xwT18A5agR7OavUEpIPgMB3t54ZaS3LQLdAD9FOa3EizTUaQP
UG9Pgb7JUNguv5lAowSSyRLyW2sECQk=
=+4Vu
-----END PGP SIGNATURE-----

--fSCHwCyZlDgbl+8D--
