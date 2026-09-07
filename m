Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5943B6CB
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769219; cv=none; b=NAnHXy/Q20He7EpKqd3sknC9x+i9fO/ag71qpBdOYM9LbDgnX3CtBWNDir76mL8+to2SGuRbA4cDFbDCb49jthFh26kP/FrlKt5sTj3zEmy89u1ZwvbvRnalEBOQwXK5qoSNMetZbtepHyhoyQ7pPADKqGX/5sklMi8N2Rigu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769219; c=relaxed/simple;
	bh=+rKOQJFFm5bYnGcGZ6XGvUk+Etwa8kXtuvtSPF9Nyzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB+5IK2lvpdK/goSLoVrjfwRraxtV/NifGglhlL53wdki57q2xUL04f3ruFawuJFlkfanc4dIG0MMv7doHlPe3nRePiYxhkcFnsbDgCa0L3D91AW85HR/5ZKYCSGVf0++r90G4C0OBGce/cpDhQH1U6oe5kWQiZYKy+aG7gT6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PYz5b3+X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PYz5b3+X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956869750eso27990455e9.2
        for <linux-serial@vger.kernel.org>; Mon, 07 Sep 2026 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788769215; x=1789374015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+rKOQJFFm5bYnGcGZ6XGvUk+Etwa8kXtuvtSPF9Nyzs=;
        b=PYz5b3+XLrSHetXQeEcJBtGmPDmPtcKkRkHvBQNZR4Yyolb/GOBpPsimvRPTVAJe80
         h/bzeQTg7G9yoECPCCSGlL6EinfzFSHoKy7N5dzdPCoPHIbvjn9wtbqfeEYwPrq0+RaT
         YufpVWj9dj1+J/zSmR6pBxUNSKahi5t08gvi/+oCjSD9VoT5h45MwzecTcZ9SIURFzHO
         xYVrI/PcGzkHtQt6fNXfHcxNFqF5m1xeeanUUV1sM1S0ivSkialpMKf6SJ5XttRJilLP
         NGbJSG5h3HfjbYrqonfjN7FAHRkvWupRZEeNhwcAorcuIJXw60LGEHuUiBOAqXzgMNhQ
         MkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769215; x=1789374015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+rKOQJFFm5bYnGcGZ6XGvUk+Etwa8kXtuvtSPF9Nyzs=;
        b=iHU4swY7vU0lI1zh4b7ErndAfJNVp1/Qsh9EpDe4Vk3ujX1E1hdgQd2bFS7kGA7mFZ
         c/vkiEQ7TVMaTOgpk+HG/u6+dRgLAFtG4RFKVDhEZwl4opUOcaKbqoNsxvdAorpaGKpa
         kJX6kQ9w25OtaEXWnKEsJddZITUX43Em8V4u1+OWdGfnIC1smYuV14fLgzI1TrNNHExQ
         uoEFPUxdYWeGbLBO0sNc61lvVByH6wk+vK8/OnfZPHzscOF699dl7p5geGD8/TGw2A8J
         p9psaGkxQfOiQKJF1UE68dAvubpF7y0iTz8rMOfLwYu/C27Q3Oa7MotPhxW85A8Ul8UK
         +uEg==
X-Forwarded-Encrypted: i=1; AKwUvBxVnFaYOL/CfVxfEAkKn6waQML56Zr1tPaCEm//M1C1MGXu6kGkckRWsw9l/UzPPCez4abPpwQ9cVhH8W8=@vger.kernel.org
X-Gm-Message-State: AFuF++lgN9LeDZEB96w3zdEIWFNiDg0V2rF3yc0FP7Ot46aFjsofjapd
	QXNsRbnL1sSZQ2GW5iSMNrUId5DYKOkmEGdRL6cD+E7Dkt8iGswDzcVmDhXxUEe3vNE=
X-Gm-Gg: AYBFou18I516ZzCphOdjxsESGYNpMDOrBK/J8dxEtctzaNKR+64smDgX4lYUqmGEjby
	tBJuCXuRXZNoPEPsW4A10r/6sCZegVRmhjoFEgfakQCFMnrIJfufmmcwJV8K9I/C1J3I4VUxNK5
	lcSPRbejvY0Qcm5Pt/DiNrIawa6owvp46y0yqt17nuimnShmjVSNEABaA9cBt35lo7zhzr+IBgr
	QLBQ7EbQl7JNI6ZfRzTcbOLSNyzJ6Ylx3jMggxIuCyPFovJqsuigFd7Pp6iVX2iIoooAr/xvTOO
	uJLVH3swu3jE3JFKBqv+zIG2FTxi0dYOedmRo5jOvEQCJcLVKHeCLOk7UQQtsQ8MJkOWYGwjZHl
	1yZHMFbihwlCjVc//Gm9hjwjbhiQswZyxc0ljLwqCe9oQiUfBlUN0/NQbhbOm3+jYyTzFy6/5Ls
	kV06S26W9ISDZtaUX96hsQguBuX3VyfN0il/f2cASOKc2hCFrDJwWJogWzGinhVhJyzZ3DWWSkz
	GhFaAiccbuZ+tf2VudyEqAs2KrHQGmHydSEJWY54/DonIVhiSPizZqoukIe5w==
X-Received: by 2002:a05:600c:524b:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49cfa20cd2cmr189791795e9.31.1788769214222;
        Mon, 07 Sep 2026 01:20:14 -0700 (PDT)
Received: from localhost (p200300f65f19a9047ae53bb37ada872a.dip0.t-ipconnect.de. [2003:f6:5f19:a904:7ae5:3bb3:7ada:872a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49ce58da3acsm802919035e9.0.2026.09.07.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:20:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:20:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: zjzhao <zjzhao@edatec.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: wk2xxx: Add WK2xxx SPI UART driver
Message-ID: <ap5zKvMdXmTzN__c@monoceros>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904072027.67473-2-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jcsnrjlgqtppepvx"
Content-Disposition: inline
In-Reply-To: <20260904072027.67473-2-zjzhao@edatec.cn>


--jcsnrjlgqtppepvx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] serial: wk2xxx: Add WK2xxx SPI UART driver
MIME-Version: 1.0

On Fri, Sep 04, 2026 at 03:20:26PM +0800, zjzhao wrote:
> +#include <linux/mod_devicetable.h>
> ...
> +#include <linux/spi/spi.h>

Please rely on <linux/spi/spi.h> to provide spi_device_id and
of_device_id and don't include <linux/mod_devicetable.h>. (Or include
<linux/device-id/of.h> and <linux/device-id/spi.h> if you prefer.)

<linux/mod_devicetable.h> shouldn't be used as it pulls in too many
things and thus introduces many unneeded build dependencies.

Best regards
Uwe

--jcsnrjlgqtppepvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqec7kACgkQj4D7WH0S
/k6lwggAtl11TJBXSFbUtG1oE2b5lhT1yEeiEK6ibargxChJaR+TK7r7SrBtfe81
Xy9gJRVsa6vWh5N5auS7Sb2+k4rbYiFghuSnO7v4q6pMi5zAnh+iCYi9hzlB2yuU
a5TCmhNg1vlEL6eLSK/Zs2IEXsrzfndIjjHUS06+6ypgxHgGJ2+EAUw+lgDb4MUN
LGTsyEUrOsF4q/0GmLqRXld/VciDVAWNkDvubKROM3aTgo/WULivvvZSibfQqjLD
KtG+CMmviDvLI3NyCCv7wjML2jLeOFhGQS+3gdxfoUP5LK9Prr4IFWoVJjzbR4pX
J9QIFiOyMIec8yjX8Z6TUwbPPs4zgA==
=VgUt
-----END PGP SIGNATURE-----

--jcsnrjlgqtppepvx--
