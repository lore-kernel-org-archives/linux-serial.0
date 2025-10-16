Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B36343217
	for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611632; cv=none; b=lsc6wsv2RtJUM3NvXzlnjCRIuC2x+uOmK2OHfojWVc5T3NLykNaWG7XpT5nM52bkC/inv6lEBwkTMdWD7C7KyZIhmMXXFM3/OM3ni7xVQGhrbkaCpmuRXZbPnkzAivegP8HUQvnq3sdoNJEyBrkGz+WQc5j9XGHlptkJtAfzmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611632; c=relaxed/simple;
	bh=U4Vw9TFefxHy667IjfemK0KK0KGVnSeJFdgB3++3kP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbWLEWXpDe6kyRzSneNWcjzEy2vGXdbIZQkb6kG4VUGjFmvAwXRP5joI3lQVgkFy9vYs4onHIuy4mirgGYbqntVc1Xtq50/NZV7YgNJl04qY42GdlhD32ID4igsrWL/b6ivHJDt5RBGD0vQwXQnIaRB99JuoIeZfDzJSh+LAjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL9GascR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL9GascR"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b60971c17acso458126a12.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760611630; x=1761216430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4Vw9TFefxHy667IjfemK0KK0KGVnSeJFdgB3++3kP8=;
        b=gL9GascRemtrbu/pBAvJ9Hy8Tm0TW1APBuRhTUv3keyrzLCsdkavLp8x5FTg4rgYpZ
         ohaDmNHJNLmWs7gI3HQBJ8UinogKM/qCxMt6kQ6bmEslqhdje+2W94qWZ26AUBvPV7sA
         qsO7M7o1sQz8k3NcQLXivIYC+3wyrIZoU/2B4UnBQge214J6QioT+lmgNjvnhdd9o3rB
         nKbv9TrnfkJxUJtm/oO/aH70YIq0mIfAYSmegnVMFTwyQ+9d18DAotLvIfp0vEOEkxn/
         fITZdLa+taQs8vLutThX2arM6FPOQ+zF3f3RtQR3Tsio7kY6dhWct6YcrqA0BKlE+XSw
         +/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760611630; x=1761216430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4Vw9TFefxHy667IjfemK0KK0KGVnSeJFdgB3++3kP8=;
        b=lT/v2mNN8NSMA1DHeVG6iMCfdknJRbzM9pGejkNxeBFhFZu4jtqGby+0SDu0JVSy00
         TDlfLT7TpDQppZSzEyfDTvQCnZKw2KXLIPriS9lHbVkL1uLsO0n1neYd04jJKmWA0oyF
         Y7qCd7jBP4HttGVSTh/E2h5/4i+pr//UjcgMVLaZir1fugxTZvwiCd4OCDDLgnf6s3Ek
         CPSMdQOYyJzCaRctdbhEiJ47S2JE1YC47J04ESjySOGA2cgy+WRKvcc0ZLuctxYXDdid
         yxpFA+t1ltK+ueZ+1UE/kqmrwUNcTW6B+cm6LRHbcfrATJ7OY3GOkUcRUVwTJnj0CEkg
         5UKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuUqByDcp1STT+m79tBabVCJ+fzATWsVjBjv8/BnwBL80XK3bstr3gK/gNcEMpfP7pHa2/A1s1GKFNzTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC4I9yhvE+nSvbnob87ObZSdHxV0vCTaxtJr1l2HTPvQu3KGZi
	3NIzlAy9TEfywaMdVRlNfp1T4BSWFd9s3Vd+J2frrh73LQ3G6effo+Rn
X-Gm-Gg: ASbGncta4ncDopmlUgtr1BAsZkZjins8GbOAb0zYyezcRVGdzAjFsaqTj0YgEopqqiL
	kOixDURYLNDthOpxxdAHHl/LjUd3KbRnrWpNsJzB73TZo7b4SizhNz1v+9MZSwC2WT35fOhKF/a
	VNVnp9YhcdDAKwnKJ6pdZTxodS2YCPvSjgzsk8oXYEPBVC0Ny4hhHGG7BWBWWjFMtzsO+4oYM2h
	yTmUM/bwqkJWLmE803unbRM2+r9e0ZyeIwT8M0XR0t3/BuHA+7I1E7HUNRa83sQycjbUbtDRHvh
	Cfr/EZB4pmuYeytM2S050W26yL0yGQmhMqm9vkZpi5AFIiTxRVM/1xJYrlhwU+lha7EX4yfAXGS
	iachkHc1u/agRSHO4fviqy/m/ZpyAftV+7v5W1ZZKjgKYplmCoA3N6inE5GfUDdMgNTyiSo0VgX
	MP+MU=
X-Google-Smtp-Source: AGHT+IHTuRp5je6WAU5xPxz34jRwwCQlRmcYtd63dQHcWlBJO1BdF4M1kQCtuddlLGvoLVhgrUMy2g==
X-Received: by 2002:a17:903:ac3:b0:272:dee1:c133 with SMTP id d9443c01a7336-2902723facfmr344914025ad.22.1760611629900;
        Thu, 16 Oct 2025 03:47:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934fde5sm26007355ad.41.2025.10.16.03.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:47:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9286F40995B9; Thu, 16 Oct 2025 17:47:04 +0700 (WIB)
Date: Thu, 16 Oct 2025 17:47:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tomas Mudrunka <tomas.mudrunka@gmail.com>, corbet@lwn.net
Cc: cengiz@kernel.wtf, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, mail@anselmschueler.com
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
Message-ID: <aPDNJ3f1H_65infk@archie.me>
References: <87wm4xbkim.fsf@trenco.lwn.net>
 <20251016101758.1441349-1-tomas.mudrunka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fYTqeHXCD8CdoU8f"
Content-Disposition: inline
In-Reply-To: <20251016101758.1441349-1-tomas.mudrunka@gmail.com>


--fYTqeHXCD8CdoU8f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:17:58PM +0200, Tomas Mudrunka wrote:
> Hi. I am author of that sentence and this is NACK from me.

Oops, I didn't see your review when I send v2 [1].

[1]: https://lore.kernel.org/linux-doc/20251016103609.33897-2-bagasdotme@gm=
ail.com/

>=20
> > I'm not sure this is right - there is a warning here that additional
> > characters may acquire a meaning in the future, so one should not
> > develop the habit of writing them now.
>=20
> As you've said... I don't see anything confusing about that.
> The warning was added for a reason, because there was discussion
> about some people writing extra characters in there, which might
> cause issues down the line if we refactor the code in future.

Any pointers to these discussions? Or do you have any idea on better
description on /proc/sysrq-trigger itself?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--fYTqeHXCD8CdoU8f
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPDNJwAKCRD2uYlJVVFO
o9KxAPkBTuPUaUuBs6BBHv8+0HhycpaDuHMgX2T2NaHa+3O3OQEAzy5RJ2R7rtkg
k3VhSpHck6n708zue7aH+EZxpD2w0gw=
=Kjn2
-----END PGP SIGNATURE-----

--fYTqeHXCD8CdoU8f--
