Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDFE388E46
	for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788081473; cv=pass; b=cw3WGaD2f/7nfkaMQ1TrdPtwNoVvsLaXVs24TnlVgWW/ax/9n3c09i03hXtFXWuDQjKIEyvra+IaBCcbood1rmuTiJEzvrNuKcts5OJP7Yrl8COwEuRk9VodQi/urO5i5bYkqaddl53iBMOjCkUHKn9XRw9lEF+YsGIWHN6QxUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788081473; c=relaxed/simple;
	bh=+nDvf1vITnsfEPkVB3AAZRrnHIkG4rMS6TLWYJdxGJc=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISAUZ5LMSryk0UQgOMSwDRV0BYoNkKFpvuYlnYsBIEhgFLFo8EZfRiz51eJMmsHL5Th4xxCozhfNO5JXU0URuy8Wfp0YYELEVYGcHrzHC1qi7miVsGByAquDpvNsKJuJxicf9lD0JqESZ6tGSRgMclhgbe3nX+Wkk7XVzHm/JMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN8pNzoY; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN8pNzoY"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c255206b4dfso314788366b.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 02:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788081470; cv=none;
        d=google.com; s=arc-20260327;
        b=P42X4SwupASly43qilWJ3sgCx++Qt5j5ZULXABUMhh4aGjCFufQFWOgWGWenIsXgwN
         /UvB00Rjj8G1SttMQt/wDRLXOwuSicmoRLirmrGNud2vSeu8uxSBrBdlGMDV7gD1vBve
         QoWe4R7ngPATS/DwgRMocqO95VP4l9Jg0r4QlYZefzEfDL/Ce+G9D5HQPvWHQ4oCkWZl
         hWpamBdZA2LjSvRe+7VHlG924f1rFfipLvVqKxjU9i/6KeOOroWTSOiQH/Qok8iSFlhd
         o6+Qlw8ybnqOleQuPDr4R4ZxSs3woCaw+qrR4b9M+9ucUqsCAtQahfJEBtx/mz2Qmqas
         agKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=+nDvf1vITnsfEPkVB3AAZRrnHIkG4rMS6TLWYJdxGJc=;
        fh=/QP+n2O4Hyc4wPS4zFFRlhIZQ4uvqm/l12+HjjpmfsY=;
        b=EJZfbZFtUDfVe5YUVPRn2iei46bydBuVHO3GxNEsdwUyCjpdRVKQMnrqe/pp07kQgT
         ZduQBHQcbDSjQJjuH8F8brveq4KVDHlru7/AvA2YTOCzBL9yfhjzY047eS6oLSyzNQTX
         HvJw/5F6tn7G+TgpK9CZjLf9yXcB7c/1DKokh/1oGuGti5Hk1IvfFHZzQh3Dch+q8g7C
         bNEoAm9mAA6TD56pgtTtWmGhlCHox5LJDLSRGM2nNWDVnRCHG7fuJ+HFnPBGaRA31TRk
         pUg9psNgumluuMQJyqmu5Xcrt3zWlW77Mg57FVVdVq65leJNl9JTj9j5YKWhvHBVrcvX
         IEMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788081470; x=1788686270; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+nDvf1vITnsfEPkVB3AAZRrnHIkG4rMS6TLWYJdxGJc=;
        b=GN8pNzoYNpTf7KzZFU783m3YwdOAGfwUR8N34bl0/XEkm18/NOiysVxV08slrKC76f
         SM1edsgkLeO9BXEL1B/4YbPqWUIvHqgjrtLbFsjae7spkP2DvhuLGY5eLXeasE3fQaFX
         JmB1ZdRw4VHeVfSH2PGs5St6pPeKQrZnjiIcGC/8Xzy/lum8aWH3xh1VcvUxiMJjqsaZ
         D77FX4eQ3p+Z2G0kPzgIHTi/z+vI7T7FJEk6oqsAcactRJqvVqcBQqFJxCOQGm3eWRhc
         KLTmbEPqhWZqBWGSgEnmYci4uG8KjxRPb2bzTaVe6xItC01wkUt90/HnjLD1OFGjMsWs
         aBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788081470; x=1788686270;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+nDvf1vITnsfEPkVB3AAZRrnHIkG4rMS6TLWYJdxGJc=;
        b=ZjQ63Rr7QjhwAQYuSi14I27l+WqpOzskdqhriQnfpgOQsWfnqJDTR/zV5jeA9la99D
         vcuq0ekzXzLKDYlXdOsbtB8n6GjUBfioAYMUHqH/Cm8fIurN0kW7WjaI6NrODfkigRtc
         B0JwcUKmQ8YUFdxTG4R9J83ESmiUiRTcJIkp/5o+PE/7sZqtddbusg0xZf2+caMdAqEv
         NdZsy9IKZceeJ/LgRnefw9MX1KhzOEOT3sf44KuZa9+23Lx1OwXov7XYPkgxqakczQw9
         KjwwczxTMbUvurQZULvDCSWCf6Ib8hI/uChisvwpHdWVS6zUCDuc5ipDk0C5hC1FltNf
         Q7zA==
X-Gm-Message-State: AFuF++n9tuoxk3AMwBrSW31jbbwyMi7bC1ykSorwPO/S1kw/Ymos0M/Y
	kIVxavmzcRz4fwvd7zC8+TLni2VdV/gqPKUmFE0DEnr0mk73+8IHrSqR7xQZ2cknomJCBxF/cph
	WVhoQOtXSwjSWzUOfzlDluRdneQ8pJRHw/onY
X-Gm-Gg: AR+sD10dvZKnIYD+Tp0SlXmn+e2jEL1hXg/maOmOOmI4goMcCceoWIbF6sPwbl5KcNJ
	UZUvk9nyhLoKH3jHExFmb+/gHvE9zbXvw/tvF9khieZHYgQ/stD86O1a2PHLn9FpuSSImp+PSSb
	eFaZqT0cxCXUqMLQYkWUAAkIvhKp/UaNN0pl991GSvFaVz02VdjbTh3slTAWZpAAi82UMwf8NX6
	K1WjxaI2X5MmPGMkBqovwJMYOh/gYKpkJ0vN+4pevO5ilhiQDwvRz6kACyky88ntsTYFP375SoW
	aqyw+J1UwVVR4rZTAMONnvol0zlo2mXgyD7+jlBOMWBs+V0=
X-Received: by 2002:a05:6938:a086:20b0:c25:8c05:902f with SMTP id
 a640c23a62f3a-c258c05937amr113786766b.13.1788081469563; Sun, 30 Aug 2026
 02:17:49 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 30 Aug 2026 02:17:49 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 30 Aug 2026 02:17:49 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sinyavin@gmail.com
In-Reply-To: <20260830090550.79EC31F000E9@smtp.kernel.org>
References: <20260830085340.2542624-1-sinyavin@gmail.com> <20260830090550.79EC31F000E9@smtp.kernel.org>
Date: Sun, 30 Aug 2026 02:17:49 -0700
X-Gm-Features: AcwNN1UELGVc8MQoksPCsuRRMHkX3Io-3x0bQrzBAvuDzU8QRYO3N2DGuVIc2xQ
Message-ID: <CADE4BHKCsqRZ6L1OCf7nvy+hh39mZMFtgaB1aysUfAfgAAoTKg@mail.gmail.com>
Subject: Re: [PATCH] serial: msm: select PM_OPP
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review.

Both findings concern pre-existing code and are unrelated to this
Kconfig-only change, so they are outside the scope of this patch.
