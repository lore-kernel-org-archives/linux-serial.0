Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CE218EB1;
	Tue, 17 Jun 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163362; cv=none; b=MbszdA+Tipo0uouLtdfu6WD8z0XO3jVuzwinhQisoJtCQZmO6niQpW1ys5ubat2gvLKLHEl4c/fj3WI8gtnp0QwdYzIP2rz8Z22M+Mb2EQ6GmroCbEn7IZ0Qdw0GcAmbgZJv2/E92+F9Vb2OscOPjjllE9CTPaKThjCda3B3rFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163362; c=relaxed/simple;
	bh=1rabJWHs/troXwkLRRhetm/8+lxBBJBnQJuQDDtiXSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9Fr5QTZM72gbKjPD085gZ5KJg1tnjTduNI0Ya9UYyYGXclFVIfMISMJoiELQFL3lo0L7NCp7JOC2ZXUHE4697ByNEJVqNRC3yT/WDDW/fWF/IdVS235vLQ0p44y1H5wbPKwWBG/hUmI5epcPJnpTrPjjt9DQuDppJEhirjo2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so822883137.2;
        Tue, 17 Jun 2025 05:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163356; x=1750768156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uly5rMibStMdldgH/XC+DdGvc/SzsbEOlkLd11yOicU=;
        b=dfr7NktUk0k0y9GJZLEoYi8lpXckQZAhFgitxPyBmmtLMwn20pprnBLu7XyvG8xWxA
         XjqR2ta0KUmXaO+vy0AjECHVE/u9LUCX1gKCV8ePpw90pSyDtuysaMMWPAdLxsuPyKGH
         YK7y6uA+JWfwv3BkC7/BU5bjwBcCWNORpbQssziRxuNzE49rqB0NJnnidCi76qeyCXlp
         AxQeOEKuoFAMuskSxh8jqAT8jDOjIJTcKU9cAGA4e+FyKPPO8VlbTXVVksJFjfg1gxOK
         zcPQSC5AyrIv/g/CJqPQLXIA2qfJ3yqfmCVOumTNuC+A06bLeAYwmSm98cAPK/al55xn
         jBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDkLlZSnxbE9Ah1uAgWfqH2Z8CIbGs5CbDPGgW4b3+RLUNMRLebjfKR1FM65Uj2Xr/YI5/ohDmC7uqOKk=@vger.kernel.org, AJvYcCWJJZEt/k3Qa6uim9GELNXXsrD68LVJYiHDH29qoQxWfkZbiGiWRynnb6yjkyPfnpTUWA7zO/oXwlTTxdCI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Y5sr8gIg48hslLHgc0q0p19/iEkVKIZVh87aDQ1ZI0eYwC0u
	jfp5uVpZ28NjrjBWwQVRaW+ixg8exoEkr0FcYHnNmKXuavPhihu1NvgbzogVsDuo
X-Gm-Gg: ASbGncvEaWTePzBbDonNv1JrwX8J1WCUbXcn3SAbboqY/VculdqmsV8lq8YC5GKYplv
	ZJBfLNJm+SC/MW54qmTwrZzp48MSKaPvhtqgc2+SJB8BUVkEVbiv3ki26dW3ErkilGtAoEz7V0e
	UHXgOdP+5ZUzQnfrB8no1v/nRykTSaow8oGEFuOPN39MlT5Y0h8MaJqrWJLgXP8w3xqp0mJpJQK
	FzcjyfXleg1Dc2cvgZ0tvV4FowHP/QbNEcRBTfin7upcql0lTh6AJwiq06t0rwTk3cQi97KnReN
	A0pSFiY8n0hnPWSzKEOLRaT3HxcquDhPoepHCehdxrMvYz7YO4PBIQPcWvBBaEoaEWDS64WGfhE
	9f3tuoWpSsxrAO9yzdNiphLnF
X-Google-Smtp-Source: AGHT+IFmZEcii9qLnDX7tPSnNnbt3GSrEazD1Fz6FNjMWw1e+qqMvLFx9hM0qGG2n+gRO5AXuD8iyg==
X-Received: by 2002:a05:6102:26d3:b0:4de:d08f:6727 with SMTP id ada2fe7eead31-4e7f63a1f01mr8365900137.13.1750163356430;
        Tue, 17 Jun 2025 05:29:16 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7f2fbf5b9sm1450960137.29.2025.06.17.05.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 05:29:16 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e2b5ffb932so1513186137.0;
        Tue, 17 Jun 2025 05:29:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBty6xD7iZkyQ9bzBix6HCaQac8MxtYydnw7g0ExdNCxXXKWXSR+CEePRH8MHjdITJp0a56QlzEKcsD7UM@vger.kernel.org, AJvYcCVSuDTlhxdtnqBv4aKue8XlPBBRUrV6ntktVxWd7JsCWnmPoWKmEQVOI2vfRdpEgXw8QIXlglcq4L2U3Bo=@vger.kernel.org
X-Received: by 2002:a05:6102:6c9:b0:4e5:9867:14fb with SMTP id
 ada2fe7eead31-4e7f63f3d52mr8675512137.24.1750163355790; Tue, 17 Jun 2025
 05:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-5-jirislaby@kernel.org>
In-Reply-To: <20250611100319.186924-5-jirislaby@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Jun 2025 14:29:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDFjBwu-3+bx=MqNW_m5EdUHcfn-gROY1ZfHFahzkUgw@mail.gmail.com>
X-Gm-Features: Ac12FXy71I420HG6FoY8xytnP_y8sbWA9TF3YO8Rg8lKJ2-nqSvV06O0TmPz6vM
Message-ID: <CAMuHMdUDFjBwu-3+bx=MqNW_m5EdUHcfn-gROY1ZfHFahzkUgw@mail.gmail.com>
Subject: Re: [PATCH 04/33] m68k: remove unneeded tty includes
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 12:03, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> All these includes must have been cut & pasted. The code does not use
> any tty or vt functionality at all.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Since GregKH seems to be eager to pick up this series:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
