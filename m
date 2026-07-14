Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0330675C
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011007; cv=pass; b=UPiKfK3VQUkbhO0293CqRDbvA3IJ/Cf0AR3oNCiLPNDYo7smaWzkbXkI27DLxyu8v8s+junsX6nxYpxJVq9ok0pLe5aVK0OImTRi8cuwucrbpddGBmycSiXFxPwQlgWD6e2wVf9Cu4wqQkJpUSc4WAT3H4qjjMTPgIpJn5SLbQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011007; c=relaxed/simple;
	bh=nNtgHm6gS76O+B9Srd0Wr2aCF/mjym9uwgYYwgdjclg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu+mvvc7/2dIiotHlVlz6SsAZ6eioCIkb6zvX/X53WbEzlTRCulHN6xFOeA7zuulgnGn20Uk6HZ217sf3kdWVsLAma08s71HwzB1A28cQwmFzEoZGC1sH7aYJ+IAr+yj/KWz7iY7RuF4/KHGgmXhmJd8P9lcGk9lYf1dyoXZMFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=MwK60GA2; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="MwK60GA2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so302605f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2026 23:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784011004; cv=none;
        d=google.com; s=arc-20260327;
        b=Y/h5fY0lkoYOuGMduKP9xlmoxAJKNB55w+TfOqr7NGzxNdPVODYyuYIlwmtoaLOfB/
         ah+NIT9VOPHcBhUSyHDTxwZUWo5gXNWyJMuYn1NVIlhZ0GGlyJQAPNbe2YknS1X7zzWP
         7pXUDcI8jO4/liKLrb/myrLCNk9ajSRGN0ksCZR5I/P4LLjVbfynGwJ23Hd98sqemTae
         T5EHM+RFMS5a7aOMGdLGcXjxZaJFuUbTlx65teZg0Jy02Jz+1wSj+VylmB1L/I6gmJoq
         R+N8sSh9DfMQvnohW3Cvxl94LfO+NMlv4pUeOnAXXdldAWV51uerTQ+UrVzhYElGT1JO
         IMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCojHCJqKCZD1pOeyWJ1gcjn0kakXpXScxWlytGoI3E=;
        fh=Z0QYM6r2dSCIrPZ1DH/QhU5/ePWXG5MZchNiUtDVPdU=;
        b=h81DPmQ3gtInGcFwzXKHmcZ8Kw1kWhrviZy1zJYBi7NoUp1HXWZJQojoPITNmfNzs0
         AjmMe2QITx6qW6eAgjvy+7bMe0elZp/ugQ/AyDo89cin/mXeEh5pDScEDFT2PFkLAym/
         8SjY3NUVKhw9G9ygHn6nugnRHL6WdjrwMRKUYc44F4VNELw2EL5DvcXbHHRF9XQhqOMV
         9Cdf0rsLrQNhlbBnUhCDGmURYmm/TBQ3tK0xZox6vQcF97v9aR140EQN5dEAtYiYqKSJ
         rEZlzFp27z3/vkteTUD8dHuv3YOVWe0Q9XmB0zdRULEm0jeXl9wHZXHNK74iZs56hZaA
         6pHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784011004; x=1784615804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCojHCJqKCZD1pOeyWJ1gcjn0kakXpXScxWlytGoI3E=;
        b=MwK60GA2D3IoTC7mIeTz0k8tEOVY5a6nkYzGdHkJZ6mOSwzuUSltzGDvMPq8Vz4l4y
         1bOz4HzmkpD1ddxxmFBHsqVbNjgC6LqyGJwAxfEgvNOlX4iP5jiPWhVopQ03HEdO/4HN
         fdTDv70pVG1rvHQZDh/NAdni+E1CJlbArr9IqcysnTh1wVAICCAdMEjhB+UpWw86KaJT
         pL1ARO/oPgKpyrwGl/67iUKPbi17QX/a30lFRWoKE0beswyLk9FqK4l6hPC33YPi1gc0
         L3uZn6Tz7hNSmvrJ6/Znve16YzcG4HDDn1nkLU9edkei9rwihtJ81J2PGyTxtY2nCW32
         s6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011004; x=1784615804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCojHCJqKCZD1pOeyWJ1gcjn0kakXpXScxWlytGoI3E=;
        b=VuGrbeqn9oPpip/deYV0zYcHb1fvziL5XDUVUm8G6naLM3e673uVPOtHk2X7nuTtuE
         OYi+eazuGX593pWasKLR45hHnpEZ2PUCfrUWB+RJbRSvl6o9ImoFwOrvmoefmKhxpyUx
         78U6fDTCCGLkYJL01Dq8wbMXoGbf4RR2N3wmHC8mxjFma5o2aa01LaxNwSu9/Zw+dBzq
         cjFlUo5FIxzqlLV+qn51VOQDBQf0+KERITH/RBrNLxtfS6EhSsVz5Xbr5weUKBiXmigG
         hIacNnY5bW6rhkNdpZf0beS7XZjnKfdcwF0ee56xxa1Bzay59fRglPvou2o3XdPW6418
         9YoA==
X-Forwarded-Encrypted: i=1; AHgh+Rp26dAzITkZ5am7DvjuZWjg8YmYCsTwGtYkPIn18YAzCDBMmrAx/EnOg1LDvILRyT1EtouHd+53RQQ8/iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnmavl5nG+errzhi1v3xRIjw6NvUFizwYUMTfoLL2jVka5P1nz
	NQ/5zkvpvpxr07K5ExmS15aBrzWjJfpUEyWQRRnJD9npVm8ZArtZErm/ZIpMY9OpcELAoH7wPFh
	ZWyfFc+xu4Ie7TgWX5WFop1pTtMYuSKKEp3PzS3utZw==
X-Gm-Gg: AfdE7ckhCY3JRkV2y03WmWCXz7tWAXGWRE1auDyMMqvTA0R4iF51hoIB2IeYlHXeyfS
	vV8wlIDHDX2c7DKJCEBe9wLBtcXPGeKl72+V6KGqU23YzxumoQYvbm723dyKTusim1znwQYbc6T
	goG3MVBo4bYo/gWxfjcJ8N4hzLQ8jKELQU8Ee7R7XRIqI/yMibq6UarhNEYJOi8xnB8z0SXLuc9
	lxBaVl+xrZL2CD2d/vBxpeFsid8SD1eWm935Yk5KrPvXTm7+kLUjLovMk4Pa2sWtIas0g68QjaO
	ZWXF5y8V0oXbZgJQGfhxv4K63XsovHRO/4Q8kdu3DNN6MQwJQHSBu8m21w==
X-Received: by 2002:a05:6000:250d:b0:473:fc10:f675 with SMTP id
 ffacd0b85a97d-47f2dcc0fe2mr11861531f8f.18.1784011003684; Mon, 13 Jul 2026
 23:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
 <694c7c37-fb42-4994-93eb-04ed4ae299cf@lunn.ch> <f391981a-29f8-4ed3-b582-744aa47cbe1d@kernel.org>
In-Reply-To: <f391981a-29f8-4ed3-b582-744aa47cbe1d@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 08:36:32 +0200
X-Gm-Features: AUfX_mw96YChou-o26GCAe3iXMgSxSuxMxN9BrrwvkqSMEY9o4uLAQRa2eH9JvU
Message-ID: <CAFi2wKboRtGWsDWvJjuWXpBQdKD+W4MjZdOdqerWEyWLZDvaaw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, joel@jms.id.au, andrew@codeconstruct.com.au, 
	lkundrak@v3.sk, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jul 2026 at 07:19, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 08. 07. 26, 18:46, Andrew Lunn wrote:
> >> +    if (silicon_revision_id =3D=3D AST2600A3_REVISION_ID)
> >> +            rc =3D regmap_update_bits(scu, ASPEED_SCUC24,
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_HO=
ST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_HO=
ST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> >> +    else
> >> +            rc =3D regmap_update_bits(scu, ASPEED_SCUC24,
> >> +                                    /**
> >> +                                     * The bit 14 is reserved in the =
Datasheet.
> >> +                                     */
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_SC=
U560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_SC=
U560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> >
> > checkpatch should be warning about these long lines. Traditionally,
> > the limit is 80 character lines, but recently 100 has been accepted by
> > some subsystems. The exception is when wrapping the lines will make
> > them less readable, but i don't think that applies here.
>
> FWIW 100 is fine by me. 80 is too ancient limit.

Modified to fit 100 characters-per-line limit.
No checkpatch warning.

Regards,
Gr=C3=A9goire
