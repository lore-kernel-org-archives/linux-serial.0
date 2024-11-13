Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F761F9A8E
	for <linux-serial@vger.kernel.org>; Wed, 13 Nov 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492389; cv=none; b=o7p0XI6k/gkifjBgv5y5J3LyaoVDIITb7OZYSKzKa0mBA76H0Jw1F7JlPDnfhxOrVSdCORs9W89RujF2rairntTEpEj0O8UaETzsD4maPehFb6zmQ14tsULz9YQXGd0gfMz/Ej9KnLi5arLMSDYz7vdxlvuVzl1WJiLwS6juDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492389; c=relaxed/simple;
	bh=xgef7oBfeDTGTKeZLWgpvN3wmKB5KjDdGGTI4IyvG00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGDIJEXJbx0wsWrz63wAgZy9MpySxwoqbRICruHw8xEigYPxWpDmgBMeoW4/iGXOluapAVoJ5BZfzRD9Hg967sPdtJFnDHvNwOWW1hdxBe2UopS+hnCF40w9GPmDLMRl6hV1y17FXOHS9TAMGVOY2WS0jCStArQC1Ootq7zeoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m2c7RvkJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2c7RvkJ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so7493941fa.0
        for <linux-serial@vger.kernel.org>; Wed, 13 Nov 2024 02:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731492386; x=1732097186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgef7oBfeDTGTKeZLWgpvN3wmKB5KjDdGGTI4IyvG00=;
        b=m2c7RvkJuVY3gAXHSg9Zi7Fe/BQGhCfNogGPZv+wByen6/lEj8eHyGoWHRfuMGLEu/
         xGgbSxcOM7i/e/MAatKXPzg7Ilo9ZIpON2hoCZ1ewGBUj+6Q1s3SNiHVcsVB92RC04A+
         gUXdvf8i8CiiGg25tE370W9fHwaa1TLCyYpGH0gzKT4Om0mC+HSLmjtwqyi4tCZatwmv
         4gkyi5Ob8LZ87BpJRdFmwRce5ggqJerszX0m1IBlFzvfdtqjKySxC/Tt9QLuRIN7ogDN
         yB1pM4ztA97TfKrAcBoRUok8s+iFLcP8XA4zowKJmB9WRl6mBrgnG7yk413q7XtBXyXn
         LARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492386; x=1732097186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgef7oBfeDTGTKeZLWgpvN3wmKB5KjDdGGTI4IyvG00=;
        b=uxoUuveaaUwsqPT6yfHdM+hrkmC9qsFj4eqxrsqDs49MPUt5T/e3JCnkE/6WbejUdS
         lzFXiJV4EpPU2kCuRWLWhR9ysKn0ldR0aSbU781x1Jd9JsyDDw4liuF80rzXEf3Mhclx
         qQ2jMeARD0rQjmpETLzFFUnJWezkSo/2XJz8NNiNRadohPHVMGnwABUhXHX3IrD6sCnw
         jarZ4enIPaPIrkJi58sPoQ9bOlqcGAuNqmHOtmmMc9Vyj564Dx7EHivTaHDL2mJx9rV1
         shpsuVWHMSatFnkOuuhZQ+hs11IgkwJLJo6s4FyagnAepQEfJVleLW6xTpK7ARCCnfcr
         K4sw==
X-Forwarded-Encrypted: i=1; AJvYcCUsxDBDNi/QoGjvpj9zCPzb08FiYlmu42oHEq855wbAOl3qEOeoYZ2B65vpC4W8rEJiX8he5ez9TjXrk0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBxyPNGHJIFKZXqYkjUV4+WfoP6kjGYziMP+dFPVrKgQ8X+Sn
	8P6PnxgaZF6DNmEKCb5UbJcOxvexjAM0vhloftYnwdS5AyR7aYn/aaP+2zeAcIebip7j0I7F2so
	1fMkh7yeaC3DXXkwbVB2Tb0UCRG4KBCGXjSc/NbKMdZ48uLYc8lk=
X-Google-Smtp-Source: AGHT+IGoJc8OMYBqsZ+GfZM/vW3RDRxKJPA/vHAMUaHglZtpD3Q52srAbi+H15LRDy9o9ztoSf0lCixShpHMFgjJCsE=
X-Received: by 2002:a05:651c:b2a:b0:2f3:b71a:1e91 with SMTP id
 38308e7fff4ca-2ff426ba42bmr28366151fa.17.1731492385903; Wed, 13 Nov 2024
 02:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113092629.60226-1-kkartik@nvidia.com>
In-Reply-To: <20241113092629.60226-1-kkartik@nvidia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 11:06:14 +0100
Message-ID: <CACRpkdbhy7onqWwW90qU3UE_+nMrqvmX_Kjvdw+jqn=TjX2FkA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: amba-pl011: Fix RX stall when DMA is used
To: Kartik Rajput <kkartik@nvidia.com>
Cc: linux@armlinux.org.uk, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	theo.lebrun@bootlin.com, ilpo.jarvinen@linux.intel.com, 
	l.sanfilippo@kunbus.com, konradybcio@kernel.org, 
	christophe.jaillet@wanadoo.fr, bigeasy@linutronix.de, arnd@arndb.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:26=E2=80=AFAM Kartik Rajput <kkartik@nvidia.com>=
 wrote:

> Function pl011_throttle_rx() calls pl011_stop_rx() to disable RX, which
> also disables the RX DMA by clearing the RXDMAE bit of the DMACR
> register. However, to properly unthrottle RX when DMA is used, the
> function pl011_unthrottle_rx() is expected to set the RXDMAE bit of
> the DMACR register, which it currently lacks. This causes RX to stall
> after the throttle API is called.
>
> Set RXDMAE bit in the DMACR register while unthrottling RX if RX DMA is
> used.
>
> Fixes: 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/un=
throttle")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>

Looks right to me, thanks Kartik!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
