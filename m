Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0693128DF
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513893; cv=none; b=rFPvwKETPRiQbhwR0C6FIvEWOPWwGHjP37xYYXGve3l9g9NwK4KnoDID5hhny1mocR7JlxuOWT6UG20/kdPXPX2ulRr6Nasdw6wdNhwANtiIZGCr1Cr+yLTV1ob5oXHKyuxbVbCbkh1vO9n14uxqhIjswcVocq6jc4GV/ew8i7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513893; c=relaxed/simple;
	bh=1pXRhXWdCun42Pybq9OL47SxR7nnzj86C6kap3Fx/1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7p/Jtt9DNmhdc/8soXWXxtmTF15iEmluog8DMFceWJvkTy4MXAEM/jYmfvbtoqt5UeT8/tRQAhezmKpY6PYl6dC32xFVCLWIKFYUjwTVSAy0ik9qqT6n6ukNy1hdayrle7NNpc/FeeAuLyvcc/KOYQEXFbtdd8U1xSS4LB/0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LuwnuWTf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LuwnuWTf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49553515a8bso7779745e9.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786513890; x=1787118690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yE8+3HRlFj2egTS7lSsS1PzZ8xLaY7S07tFdYgSVUuo=;
        b=LuwnuWTf6P8tD5D0jsOSpIMnP0VFtbBaOixO3oIIW3SSCZPwxRuFX+5YZHoUXzplNG
         DkhPLMUe6rGdpQvJC9o7Nz2mS0VkI1m/IR1HT4hvgza0lzgzHb6WqnQu63rtuXhY8O2W
         9u3Morzq2JqiP4kc732Syo7DdCn0Cr0pYKF+ZVtLHn7vu16e47pYSnLb3C+RAdrKSJiP
         8sx0/S3Fykkf1DzoMkAWPIwA9/Noe1Scnaqc6wxaJc6eQuMELM0lqA+dxofCZ2f3Fshy
         9LfZSgeqEJHMdrr5V9kw2+I2MtieyWHIA1YF2SuWq7y6uDF4l9nUG2qZhQpvdCooBA1i
         XRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786513890; x=1787118690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yE8+3HRlFj2egTS7lSsS1PzZ8xLaY7S07tFdYgSVUuo=;
        b=itmpl3HDmtwGaVk4w/1xsMMlq/aQQb1K8LvzdOytW1t/QBG1gzQWPcfmOCN6dpTuEW
         DFsluz2MkQdPL51+yoNsumdI8PmYdNTISjjVH/4/9paxEdS1SsEk9fwJ1SnHFTTrvTSK
         H8wLx8hIvTCZiO0W0/nNkLGj62Bowr84VcYpqv9bDfWX/ocMUnf4gDHwaV4acrA5jQwD
         EENUHS2rqEBprBM6S28yXqQTIO5pIv8W3rB7M90JU65wU00LX5Lnf+FrjJxPzLa+8MyD
         Eywr+LMVmZIND88WMxg+sKt/LOL3UzG/VRpcBlqwsvXRfXZbyMGSBmIf0Dhh6awP06+m
         ZPIA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9OqWjpJWkIVOhbI+2Jzn+uvzqQUDu49xWa9A8i7Y1OxVAG1bJrjBbRStv9zuRh/k5DCW8VERbId37U7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsOXyeUw8enLAyJHWRLGJwyAM3hVJVDtT9iNmMZHI9JDeISC4N
	TxMfDxrkmMNTygGvhqWFBnKVOpX3zF8IDwHgRQMVp89mHlfxi3ZqK+x2yWpyICfOHT5smQOXwpJ
	exfy9
X-Gm-Gg: AR+sD11/PmmKRZfb7eTgzboG9HgOoJivf42Lv20Dl7xOGBOTvVHPx5A4MYIIXk1p+oy
	6EXSHh9ODdYGkZaO2EA5gp3+YaARSgwhNPiHMR/5kxcD9jSiepPgbMTUS0Sq1GX2JaB4ng5D27o
	63u/wR8j/RlVhedALSccqETU85ZFDC4XgwA2umD8L7qMuFXF3fS638cSHSBDuGQ5BkN8y73cyx1
	uvOMLblK2qDhbV4HwT2yQe552GbRkt2597MvYJoBEzmSirkJO/ygmln3i/WWOP1gAZO1t4CIjr8
	3FSl7yiXdi+ur+PgfKXRw4DRStgmmyhtkViqZhXdRszyYzFxmWtcRTMIChuXl9w4lBStIIFAIdt
	8uUndmT/WB498tJmuJplGkghkapWcDe6vAnDQ7wPVXpKxLbYdZ+bwkBkyZU2xjdRiN/ZAWgtA6F
	vNSx1N1Jcc7XpwGsEu8+v1prY/8dY0YKoLrxKSh0daRrjPWUf20RpCLdz4gHDxNy2yOTVc5tBoB
	nO3
X-Received: by 2002:a05:600c:8b14:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4997c139b2bmr28448735e9.10.1786513889531;
        Tue, 11 Aug 2026 22:51:29 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48150c057f0sm4197408f8f.9.2026.08.11.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:51:28 -0700 (PDT)
Date: Wed, 12 Aug 2026 07:51:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Abinash Singh <abinashsinghlalotra@gmail.com>, Rahul Bukte <rahul.bukte@sony.com>, Kees Cook <kees@kernel.org>, 
	Russell King <rmk@dyn-67.arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 7/8] serial: 8250: hub6: Add cleanup code
Message-ID: <anwJi_9iQcem6Ir3@monoceros>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
 <a258f2dcbf9eb7a5ea07209734201ad873addf22.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7vcwpp6vhhxsybo6"
Content-Disposition: inline
In-Reply-To: <a258f2dcbf9eb7a5ea07209734201ad873addf22.1785832297.git.u.kleine-koenig@baylibre.com>


--7vcwpp6vhhxsybo6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/8] serial: 8250: hub6: Add cleanup code
MIME-Version: 1.0

Hello,

On Tue, Aug 04, 2026 at 10:57:59AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> +void serial8250_hub6_exit(void);
> [...]
> +
> +int __init_or_module serial8250_hub6_exit(void)
> +{
> +	return platform_device_unregister(&hub6_device);
> +}

I just found that this patch suffered from compile test coverage on my
end. Please don't apply, I'll respin the series.

Best regards
Uwe

--7vcwpp6vhhxsybo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp8CdsACgkQj4D7WH0S
/k4i0wf+LpsJo2nQuoX2HiGgOWqIPUdjWqBurahfCj9RTrHZLUJQU7sMMNnt0LOl
GdyJi68zl+5W2WMvifdOxAV06FVzpLjMbaL7Wy6/x0Q16rNwywigbjXl9tDOfzvu
dEv9b3ViL7hjW0PSS6mq4Qwvs1d+gUfHcDVdT4iF7YpwjRyHtXGpFEXGUYaYkUUV
mE7/XExO0+ViFoi01d7xu4XScCz+BGI10kAr/4rMWZAc7ABj8eZ6TX/v8jFJ7hZZ
4luvLFZcqboMP7i9OFpQ84iB7u8SBlCanLwXJza0IOlsElx/nXQ8XaIPv01EpXhh
CiJA6EEr8hJ+hXF5aSAMMr+tj3ic9A==
=rDhb
-----END PGP SIGNATURE-----

--7vcwpp6vhhxsybo6--
