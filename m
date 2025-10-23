Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929747F4A
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179752; cv=none; b=OIcdBFBWnUmoS+Tsb+pvyJCKAvsstCDG6YXtvxalv6usJGaZU2vBpIcvKw2iKK8JjS029QdMqfh3i+iH3SJPlXCpdIkYgubpBisyGQWbh7maeVukSroTR9m0jRkg00jAE3Ua77SNfcuV3rQgvZTyVIOdGabOO5uoLgN59ItuvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179752; c=relaxed/simple;
	bh=6MK6l7c29SeWtwE8hQa/CW6Q741RQa2P5rFfmChI2GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikN8sIdaaXCXU1HIB6KJ0sIq/1KW4FXSDOilhsethpnvFiYwlbvVMcxo8yJI5cCLFcHeuZbALybKFBC35d2mI2QOPq6KPMd/o4OyJc7D+vZTax5gtN82Iv7N2dE7oQSBDflu+5hNG0bm+zfXnofRKQ51LCK+5UeV77XnYEDtrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpXTJHoA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpXTJHoA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67684e2904so125858a12.2
        for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761179750; x=1761784550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MK6l7c29SeWtwE8hQa/CW6Q741RQa2P5rFfmChI2GA=;
        b=kpXTJHoA/Ev6O2dCk7GcDLTMWwwCOSgSKOK4fUiHKRsUlczkNUdPHHNnS8PXY/Ndqh
         Tr7CFFa0rO9r6Boc7RWRZvQULD7e9ASERwjiuuhntdN0vn/nbLGWOgqKmpcbsW9gRsfP
         7Kr5ELjhLHI03f9eDe/mYCA27PJa1ZzgLtzm9eWW+fXmsnuw2UhGTJj8x8ie4hzF7ZC2
         40Tr5HwBc7UbL2Kz1jv7qMpcPhyM0xEPitChSDYibV6HRWtDNgd/q2fnqs0Ti89uHJbF
         QbzhnlkuprE0P9PmAl+kXIV87pYV874hm0UJxi8Adblb7mQ21o4d414b6P53yxJWZcsc
         +VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761179750; x=1761784550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MK6l7c29SeWtwE8hQa/CW6Q741RQa2P5rFfmChI2GA=;
        b=SMKFCqswHPd0DVhRAtJbZ0tGaW+WDkPPHEQH0l+D4BSbCe45n5Ywt3gqbdhOaQ0GMi
         B5Qc/zYFmtFraIbaB7o4pqgBGRWlFVK32yxZTzjMKotOq6Emts9pj/fKY8kw5+CRpK6F
         KrgXt0W48xsJaJWSVEBt0OArjFP8MB0q+qkjpM9stjrLD5+tw1p80k9piOrFV+fqXbrw
         1ewXixse4v8gXaXN7qMkTbl9x3LuvDebvtThoyhVe1KhnPt3UWPFZ5kHIaCXHflv7cvh
         4P5a7hFGipao5U2vtpCzpZ/5o7fYV9pzb/EjB+SwweaJx4joIO7tHdfV5sIKXW3CDXDO
         bahg==
X-Forwarded-Encrypted: i=1; AJvYcCXGOQ9LVo8i652iGm3Qq1OXlB03/hk27KBeu0CUXQZcCAnvs47D6HvYFqP58Ow0JjJDbq2n6mlry6NNzUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ60qeTWyzUr+IXUEYY0EDLpxnva4HxN0i03aHp4AB3Boob9gD
	riaJ3wRxRN97pHHuYKvQYgL+uO/zezKnY75dI5I2dtAJN97BevfjqmYt
X-Gm-Gg: ASbGncs5OpInV2XOBBi+LmkLDBK3Z2cRTjANHNWW+SvEXNMegoU2JiExlpNUKAevBsY
	tIBeq9hL7peqHi6oNZ1o/tnZ5AJ6ZUznwPR+lxf+2qDQsjhlJsy6Bwhzrod+9frJ8JjJyQOrcpw
	uLRg6EXeWNv4pL62u/Fdnq+8oXIaGbzWBi14EbrhjXTW/4olYVmn/WySO9xgUjj1lJO1+UPjqmy
	6mubL5yFO9Zi0tKDUDcx2CVDTkmqYSbtMwmf10x/ybgnUSNcoMLRHIoEWfhZ9NMlJ62SDL00Y5/
	pHyZYhQM0/0BBLenbOyX8xp8meghW9R6sNljNT4+TO0rw5c2bgqst2M9+z63UBt987+QCZ0ra6t
	o4i31URwrhVpXkpYdtQiZBDSTUCAAhWDrGJXFn2PGOSC+bsn8RCOTtFQvcKoEgPKxJLmhhqil0Q
	elzYl9XGcaj3Asqx2faT/O0ZBF
X-Google-Smtp-Source: AGHT+IETXuhhNf78OP3gfzvgezxHrsc4/DYMrC/Ibv4NjwGQFJehIewmkz5tGsD+C3+MBSgJyP9Lfw==
X-Received: by 2002:a17:902:eccb:b0:290:b53b:745b with SMTP id d9443c01a7336-290cb07cfe3mr354371855ad.39.1761179750274;
        Wed, 22 Oct 2025 17:35:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223cb0a5sm3785593a91.1.2025.10.22.17.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:35:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A98C44241819; Thu, 23 Oct 2025 07:35:46 +0700 (WIB)
Date: Thu, 23 Oct 2025 07:35:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	=?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Re: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger
 usage
Message-ID: <aPl4YsW6lkYLqx4K@archie.me>
References: <20251016103609.33897-2-bagasdotme@gmail.com>
 <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
 <CAH2-hc+XQR7v9Z28yH_CTWZ4ieaF5eQFKBVut1idULP=4w03fQ@mail.gmail.com>
 <6b8e7935-6b80-4f00-9a44-7003071d1a21@infradead.org>
 <CAH2-hc+M-CyXL1HtHkD9o_Q_8PP_OkYLvjqhdBiCnHVBQspedQ@mail.gmail.com>
 <1b0acbf2-8ce4-4c8d-a088-1f271233e60a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DIlPZY+9ThdZQOFt"
Content-Disposition: inline
In-Reply-To: <1b0acbf2-8ce4-4c8d-a088-1f271233e60a@infradead.org>


--DIlPZY+9ThdZQOFt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:04:59AM -0700, Randy Dunlap wrote:
>=20
>=20
> On 10/21/25 1:37 AM, Tom=C3=A1=C5=A1 Mudru=C5=88ka wrote:
> > In that case, can we use some short form? Something like
> > "extra characters are ignored for now, which might change in future".
> >=20
> > Thing is that i wanted to add handling of extra characters, but
> > maintainer said it cannot be done because people might currently rely
> > on characters being ignored as written in documentation.
>=20
> Sure, OK with me.

No problem on my side.

--=20
An old man doll... just what I always wanted! - Clara

--DIlPZY+9ThdZQOFt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPl4XQAKCRD2uYlJVVFO
o6X1AP9SHBdxr9JAbDQZWyWjpwMWjnGkRkufU73llPjh6pmZ0QEAhyM4k5DgR5wv
0ePjw3LgJ28FOCa88k6MG9QQRpPGgwQ=
=UsfV
-----END PGP SIGNATURE-----

--DIlPZY+9ThdZQOFt--
