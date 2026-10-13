Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF455D893
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928196; cv=pass; b=X5ug4NGA8DvphREeMtc0oAX2Y3x9siPhHEssJoanY3OBGvgxXTLmL8PzfXKM67tNbX45Y6ZInW8Jy+sFgYaGl6xTdhsMzBEhJe+bnOI6pKADFa1fWN7A3Xc7MZMIzwu2F4MM5odlY07hd42nCmApEOwOPIVKESXHA1Ywd7eWbls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928196; c=relaxed/simple;
	bh=hioDiOlURo8xdbGjD/3syLKxQLmoLjjsZ6hoRskxKGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxF8HA9YDDaMdSrPhxgUrI5nROd1r5Zd2fpyeSO2OnwPfotgzeHo0Frz66QJmA/lqLQF7XpRF/jQPBwsfYFzj+YSx2bj5rzRLrbIj9+2WmLJ6yAk2yvMUgq/AalWK/EQtah6c96NUNAUA8ohuNJZrySgyMjIk5Dj4Po+XKG6mqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3/OjAZ2; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3/OjAZ2"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso444146a12.2
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 14:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791928194; cv=none;
        d=google.com; s=arc-20260327;
        b=CkYGIwymF4fEzlS23An8Au1qZ/GJXVs1ZNWSYUpM8PvrhfIpbipgEDll1VQhlckTv+
         12xLnIFZclxjk/Oo9Ak65IJbSI5e7ykzbUjLWfc22ZNwbC9AEHcfOeoLyRQ73bnqz91m
         q3Om5CVSJp78jAl0XY4gnYQAYI+TLEowKRcPHLS9lzwb1HuJL/X8eEuZJP8LNilDSzE6
         Xm/+4toReKTN0n5Bfr/ib3Dx9YzV9Hod1nmXEhTqDSEFdE0T31PV3povvvU+0dooDbOK
         vip0WdFagG4efiUmAfnwskRBzpEqwTNKdUodyefZ+VmGW3BGKsYInhX/AMHGZEgEmPHC
         ExIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        fh=yDB9m+AtKROdFsNjXHo66lzzCz7m8vWu+6u1gYFaN4g=;
        b=GMZrgC+UC66xYvrfzzRRi0MC+sK6cVaS4WZksVlVAhNFQ06Poa3JKYHjFVuu+31+9A
         XrsOwTWWAW2DJ8oBDC0I/Iy6zjzKYSxrpKxtS/pvUrZG4a2z5CWgskho4Owa5x7VPV+Z
         ll4lcf9fS1cJdhB1/ugOLW6e/TFUgQ1dSoJBA1OirbGV8JUDaDBalbwE1NgInup6aAT0
         2MtmsX5jdBi7kQMxNpIh7PQjRtuZ01dgyWvRINal1e1dSKZI3zBIaRtUrJKuXe2sNnCx
         BVUTC7eFg3rfwotI+P15Sho+XJ+BjF+Kd716WhieCpv89G6ARwPn4hOGUuxoafGTB830
         HqyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791928194; x=1792532994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        b=j3/OjAZ2nl4PNfdvBJaIEKA+mtEOUNX8P7VSxSdCJLLB3MzVMECxJlnYgjTPI/5jG6
         IZaVysbD+iWra/+q8m4MJes9UopmcyB5p8NSmEkiBGgC0r5HAJsVEYzHzPAOw160ZOox
         KuUn30o/U8bghCHneid+szoLLs3o+EVMCmSRUTCfQi5t2Ah6jAwxTYGGGq5FVu7vv74j
         j5+jiyRPRPdnC37+SzQlv+UyQYXJ1NIbebJJJeLGESeEiyqShar0gOPQMtLJBKPjH/ZP
         F/1qKkfwpU6vRLKluukHB1ljWWwdgwJWOSSqQK6+jxSZ2lm6c49kJARPROD+wRdF/FTI
         UB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791928194; x=1792532994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        b=CLFvMiLzRibg8LHzMbR+iRa8HguhM8M7Of2Tacinsync3HnbQ0eBN2HbC1aKBId5Gu
         +6rQGGyLm8v95m3ryucMppTrUSNZgSBwPW7nSD7oX2Kpmzmsq1VTm3pwD+7NA3a0M54r
         d/USudpl2F1fXUlE/XPrJvCqQMtGOt45ZzvXKzFZKHlUf5pSIk02AaJwacBqhZ77fmnf
         PY+QVqpKMMuhDigDMU5ARiJGcpDPvPzLC2zUqWHDKfctxtoG0FGcxKroFwceo0vGM3uy
         1vg9868Io+nJzLBHaJBJs8zY879z50B8I9vWhX6gD5zc3qEMoj6kWgggH4VDuWKdg18o
         C6gw==
X-Forwarded-Encrypted: i=1; AKwUvBwoNz+8EkO6xg0u2xmiIDTYVMHkSqlCBPb43DEsLmeNMrND8/TyPhqT6z55r0iNMmxIgluqxGLLvPfGqQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSCtHvHEZiT8nOTzT7a1R9Qu3DkqowzpFA1ye/S/xh2kHKoU4F
	6W9ZGLPc7wIeBOpwJJD6/DGTDlrd2mGFUnjnHblgdC2mUBCTgaAs93v4+czYkp9vqQF7L7emFcp
	nQk/5PoI4xRDIXv70D0u6ZWhkvkLvl4o=
X-Gm-Gg: AYBFou1EK3ZB7e1OQcIZN+cpehfNRNHpgsnKMIA4Ef+jAjEWPTUwEgfj48E9CGgxohS
	5OBVUYTumBFimWOefKCp5Ru6UR3iwnOS15poYnT3E+04gY8/d6hLith3qvpRWA4rkkPhJAwatQB
	41Bmwt2oegwZGXZdIuOhnDXkGOKiZfysvllnuQRLSGeIXp7C7OKD+1IaaxY/I+JnIqZ8whlZF6m
	gVzp9kpBWbRDFYK2mpYoIWFuEcEheA9zNe6w7cDQ4KZGUyeTzKTPKS8OHiS1jJ5eC/dVs6DUgW/
	CMepfVLrZOCWqe8yVZ6qPtdZUU/oxbwFzcSAcTJJQi1bzIrEkKe1x14nDt1lbwOHgWramMCFy5m
	UAfi3ChBBb/lNgnjC2TklXJ6eWG8kW1lYeGPXAjfoZg==
X-Received: by 2002:a05:6402:4006:b0:6b1:c526:afcd with SMTP id
 4fb4d7f45d1cf-6b1c526bc10mr5749588a12.11.1791928193882; Tue, 13 Oct 2026
 14:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012184826.986050-1-linmag7@gmail.com> <20261012184826.986050-9-linmag7@gmail.com>
 <2026101313-plank-outlet-d3da@gregkh>
In-Reply-To: <2026101313-plank-outlet-d3da@gregkh>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 13 Oct 2026 23:49:40 +0200
X-Gm-Features: AclHuK9ealETNMhI5yAH6CuVcBjpteVRfkO1A49G7BEeIOYibyNYpBtxXrN7t70
Message-ID: <CA+=Fv5TuSDvXc0kXkTVHSver1znah2pbMofgrfMFmiyCZgHfGA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] hvc: add an M3000 firmware console backend
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jirislaby@kernel.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, 
	oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Oct 13, 2026 at 3:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 12, 2026 at 08:48:09PM +0200, Magnus Lindholm wrote:
> > Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
> > the firmware model and console endpoints before registering it. Keep
> > firmware buffers in locked kernel mappings and serialize their use in
> > atomic console contexts through the existing SPARC p1275 interface.
> >
> > Poll input while the TTY is open and synchronize close with timer
> > rearming. Return zero on no progress so HVC retries buffered TTY output
> > but drops stalled console chunks instead of spinning indefinitely.
> > A firmware call that does not return remains unbounded.
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> > ---
> >  MAINTAINERS                 |   6 ++
> >  drivers/tty/hvc/Kconfig     |  10 ++
> >  drivers/tty/hvc/Makefile    |   1 +
> >  drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 219 insertions(+)
> >  create mode 100644 drivers/tty/hvc/hvc_m3000.c
>
> I'm guessing this will go through the sparc tree, so:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> thanks,
>
> greg k-h

Thanks for taking the time to review this patch,  I hope to
get the full series through the sparc tree. I'll pick up your
tag for a v4 which I'll send out asap.

Regards
Magnus
