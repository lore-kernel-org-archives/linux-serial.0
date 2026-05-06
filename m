Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124484A3402
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089163; cv=none; b=ciSkVuB3e3TAQd7CNvativI7eneBmu8ikXZMpbuspxZMmeRNKpD3sNiqEOGFGA2pPf4sfywvFkelbKYyMDpb1GrurSPvukxiThPNNnuNgCv4GCycLtkxLxRRPHCwuzxlwsvlbqD4Go7WaYPbyWrLtp0l2jlSP9DH0GQh3JBN7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089163; c=relaxed/simple;
	bh=6i1w8FUVeMItLfoBEsQ1m6McI0ZsDh5XdVy3i6eNKsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGA4zYTcIa4C/ewSv7/mTCIBF92s1VYwM1HGBysjW+qDLxeH9GQmBrv4ud4OyjuiBQLByPKyGRVrJ4MO3bupr10cCn3FAsNdBPWqPXsdlaJG5lLfkkcRSchb6bcZlULUzeNwrS0TmOvBdPCdcc78QwpWq+6jCQtjWOxDxordMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdLIiDEy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdLIiDEy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so55261695e9.0
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778089160; x=1778693960; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6i1w8FUVeMItLfoBEsQ1m6McI0ZsDh5XdVy3i6eNKsY=;
        b=TdLIiDEyzUKjsIHEs2BOaoMIdNi99JiO5V2RkIC8kF1lztgZwpfgLw8B+36GgXMlnU
         svoeqXeo1rq1akTs04DPVx3ZkHHf7C+q/6cl3N8SsaSkqbC3wl0n7ft1+CQMjDCIahJV
         qNbKnvbPFT3YjvAqpXXMHio7M+pM4+SI7ROHefCEAPH8KNyPwxVU4ZiTgHGqSDyedsHA
         t+lXcoKqMIQHrgq2MSAzhfFuG3QEXWHlc3EHFwuDlFepfdZGitvoBw5t7GSjxIDVVXlD
         VkR+8vUpPMJb+VR2qLwt/n3SjhxDlfyhRQ8ynuvQPDTbbiOv44pFiMj6k/yyyINxBQhU
         CUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089160; x=1778693960;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i1w8FUVeMItLfoBEsQ1m6McI0ZsDh5XdVy3i6eNKsY=;
        b=nnv2S8GMCKYgJK6eusjxNediDnTdouzIcpFLkG/KoHInMGlIyc7OBTCrhZvpbScm7+
         sd10ukLAL4IQejrp4730+GZPZulbHMg52wXtLEF1sWkKEeUqfI+KvxnIPwgdy/12Zukt
         XEeJi+DlzHEtnoL47pgbEyDzyvJldnHtAoGcU0fgYsmquJkhQz10OwAdwGPtBt1JBkES
         pC7VfosIOktfH61vFsVWcNMdj9/GppCV/AJ5uVDNcHbYX2Ar9yfuapbLKmfMPfePlAY4
         /iHYLfyJIRV39X8DSKiM2SDNA6vwLbi4xn34/n3CFfoaw8/9asSC/fUm09P67YZzNxXe
         kuyw==
X-Forwarded-Encrypted: i=1; AFNElJ/LYkWX/KF+WQonK51rYJBXDwj/zderDAX+evLfmxp3FUe1iNHA1pvGydmemVHbE+FnR+gQkcVvue/8ovQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TiejZNjdlN0TMz+GsUeXRcE1fJVI7P100/JjSOop6geAV3NP
	e3K0KjQovpMBb9U9Quw6/SCld6nhtGak0640X0cSPRy7sF4QvZxpWXqO
X-Gm-Gg: AeBDies9VRmDsDYRBC6kWlE8/Vk1prxhiPEZObLDYfACRBqYzdheX63wIZ8sfR7L/0d
	7K149wiccoRhvjoN1X//8uye/L+ge/XYnKGX8lQZpg/Py8+S+wqBQlqako1eIbiQK5gBB58iaqe
	f714YmeYKfgpzTj6TdRB+BTt4yZji2yaow/njLpy2b1Q+jyk33GAEEsj2r9gVyyDtgGlY97DZJn
	1ODplD2K1zJWxz9GOxmTrvLDjAvRukRRMZF8KyhqtvMUIdDz/IP8o4BiDMg+rFj3TqaSvYXPJMZ
	Wez5PeG3eYdjnEDtVc1o3NxU9KQHrURpAVZdzQ7OXJdlfQ/vxeEbnXjqa4aQB+5itNBKFUVPquC
	JuYAQi5xQ3e5FzBvRbp/v1C8PjU8ceACsgIuhSt7jIF8j6uWWCegz+BsDp+WfuuH1D7K/D82moT
	pLQCE6MOvhXuP4WdI/PqcCPOY2+i2Dgalm0LA7G4EVUNVI7PqRb/KR
X-Received: by 2002:a05:600c:2e0c:b0:48e:526e:1011 with SMTP id 5b1f17b1804b1-48e526e106bmr38312325e9.25.1778089160201;
        Wed, 06 May 2026 10:39:20 -0700 (PDT)
Received: from strix.localnet ([197.250.51.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53116a9fsm31957135e9.8.2026.05.06.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:39:19 -0700 (PDT)
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
 devicetree@vger.kernel.org, soc@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 6/6] ARM: zte: defconfig: Add a zx29 defconfig file
Date: Wed, 06 May 2026 20:39:02 +0300
Message-ID: <5379905.31r3eYUQgx@strix>
In-Reply-To:
 <CAD++jL=S6DSOuC-PXFn76SA7e-Lgueu9Z2wuF7icXCVX7MBpJw@mail.gmail.com>
References:
 <20260429-send-v7-0-b432e00d2db8@gmail.com>
 <20260429-send-v7-6-b432e00d2db8@gmail.com>
 <CAD++jL=S6DSOuC-PXFn76SA7e-Lgueu9Z2wuF7icXCVX7MBpJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5014054.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5014054.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Date: Wed, 06 May 2026 20:39:02 +0300
Message-ID: <5379905.31r3eYUQgx@strix>
MIME-Version: 1.0

Hi,

Am Dienstag, 5. Mai 2026, 12:54:29 Ostafrikanische Zeit schrieb Linus Walle=
ij:
> On Wed, Apr 29, 2026 at 9:14=E2=80=AFPM Stefan D=C3=B6singer
> I'm in favor of this, mainly because multi_v7 is pretty useless
> for this board, it is absolutely too big to boot on the machine,
> the board is odd and need some ARM64 stuff.

I added it more out of cluenessness, thought that every board should have a=
=20
defconfig and Sashiko let me know that multi_v7 is the preferred. But I lik=
e=20
your reasoning. I'll send a v8 with some of Sashiko's (very impressive)=20
findings but keep the defconfig.

> Reviewed-by: Linus Walleij <linusw@kernel.org>

Thanks for the reviews as always, and thanks to Krzysztof for the yeoman's=
=20
work of guiding noobs over and over again!

--nextPart5014054.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmn7fLYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJED0TvMhUTxoiGRcP/ihTsoTIIoe31SesPPm7
q97WA2l0QuRdt6uaaVSwsjuCxhCKwuVvPOYPsy5+/F0BG9UxylI20cKySsfndZyc
kMG7hIOD2GgP2oFpXvD9Rm6mABU/01SRMgYxJ8BERldruK2XBi/tTl5z9mLCU9Gv
6hHKRVkiS28GG08oKXywoEXba+Dt5a4HLk6oVy1UgP9OlImj1Bm+KPD3wvWmlRsL
fYr2suEdrJ76ox0Mx0kHIrwqhGpDEOAwm3g5pjmNOEcXS1eVXW1QLSg83wN2KOty
3NWXcwr0KxZjxMc6zkq2jqMZmx/4d7Mdijbs/TInuprU1G9mUcyVvi6BHFYS5Hpz
2ezEEESl6nIbaMpA9zFZWHkhouqr2bOVH12W0Exkml/rhwIQBRv3S53wAeYeR3Mv
H1LNEaKdJgZWKKL5f9WC9q4QFQ7CKJQZc+jnArsKp9GkdC1uRLWzLP3eriuRsgbf
zAOrJSziqrze8Dq2VNH9OpqyNk0W92TO4mmUMNrsqpTMh3dDMM8MiM4VJcLIhb/J
xUUZ4kRf2lHfx/KAJnn9munL1lsJa/k1zBVxarYe1ASh9ivRxqyojTcy0AIPklbQ
eaQp/Vj1+rGq43J9RuCxFzqT22DpbK9xsmEcxNaCzW+ECpBXRqhclbKHHYESo/aF
+r9T9FDiyUEQwbmVCzN6OIBc
=eicH
-----END PGP SIGNATURE-----

--nextPart5014054.LvFx2qVVIh--



