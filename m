Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5935961
	for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019906; cv=none; b=GE95y0yO3uU3gPQj1DhWMZrmYAbl93CDSBE7KfUl1m2TQdfMvy9fFs+mvA6gs5tshPKECYIRnEEY/lUUvcM9s9Ef65xJfp8SVJKHhj4fqQQou6jtb5+fi/eJl89hQKnYqHzhNBHaqIobkG07uGmaKMQoOoNQoEcrYzYkLaJ+Npw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019906; c=relaxed/simple;
	bh=p98MxICZ2hRwZcgshomPAWNE3MrQP1Pftu+P1/2Tcfc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GV3jv/+WH6Nu13HVKKI/RP+VjRJIx3yvg3ImDh0a/IQZgsjcORaIWzwP2R5shWZa/m/6Xs6vAeZsekdLZ39nTvBV0Ov8jhy38YMBDGkDoIYuKMTC1jEg2G+U+R3A5eizd0xtVd5Ae/XfOuJrtcATmXegy2jZFQOWYhcZcfA06V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GiEbLLJ4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GiEbLLJ4"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47ae894e9b7so3050871cf.3
        for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746019902; x=1746624702; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J27zH1j+2DGLSZuiVQYcAZeTzSnyKb84uUwM/rDsIQM=;
        b=GiEbLLJ4SwvqnZ+rWGD9lr4E8UOYbZ75S/gGWPb9DlwI427Pcstq246UpNKnV/H3tO
         KFcIuBLq9gpekY9hnyahirBZycknhkoyCVSLwUWC9lSR+t9ztzbff+0JrZvo35aClXfq
         FdKjfOS7yUEQuZX0Gx2TBxMPMG9mFoZQcMNAYP3dOt5njkfdmpC9Kp50+ODVXcTJpsQE
         GovqPlYGe/RiJ5e+p0Guhfibn2aNaHMALn80zzUv6x6YtHpArXGy0FTAgEyrEcRDvATl
         ATEih+/adwQRbEl69X9l+mIPq+t1+HDl1pj/Vyp8w5EETqxi/LYkK3Zd7/gvNIBTcfjx
         MYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746019902; x=1746624702;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J27zH1j+2DGLSZuiVQYcAZeTzSnyKb84uUwM/rDsIQM=;
        b=roNB7ZvpaHRdhdwKX81F+u6fCsWPdTiA15RryddUpR+RZ7Qa8Vgi8HyEHsd4rlr7rj
         uYEbEz0PDH4bRp2lkyhTCJ6Pjtkz2j6ULuvqdE85N8pz5pyK0hNB9qXa+p/Ir3jXr9VY
         ZoFBuhqTvHWoR1A6rmIjS8tHmyklvic87FhWdn4wE9tSBLLgoq2sFQ0HbaSsJ9eY3uGi
         aGwQXtxzpxuyexh8LCGiqfb7JwONEYJtsSiMJI5p3yFWPho08Xvv2dQ+qZnsJZFXU0Sp
         yuNscESO4HswfeEBxbE4Ufd7wUZ2Z8TxLUy0Nj1l5t278eBPO4psx+u3XH7kQ/C2pzEl
         pgxw==
X-Forwarded-Encrypted: i=1; AJvYcCW7XbRNawb8DmsW2j+Py5WxRG5CNv5j4PzO+acyuaeGODk6DAfHfiOoh90qXT8kuCLJmwN5JCd6LAHxYnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz91bEOM0vDL+MEhnMwo808RJkMdvZoByJZq8W2B8MJeJegDse
	mhQRfXtw0ReEtinE+PxY1h0YvAuvvfayMZ/p5zQH8tltszBFNOQs4o/gMLXp8eg=
X-Gm-Gg: ASbGncs9sRBkK2BP8B1xsObbJ7vMvf+ckkh0nFsqm1EuYuaE1xDMfTRqKBEc4wqrMuC
	kh70rDizY1tj9Bkmt8dEnActn5EQZ2I2gnnJIoihR10Dju2mK0N62ywnxxJEf8r5TkK3DY70L3E
	tZJylxu7CW9GWQGsYlea4UB3o2Emii2HbPkEIj4jDn00V9KqoJ7O5HDgDV4/laP0SgGtRZmXWT/
	3OFLEwheIWzLFjvF4R11mpOVel+U/0DGKCGXcEDCisN3tCgXM6tNpHcwIy0TdfIg78S/keLXkzX
	hxfg3SsvPGetD0eXiT/qM8EQXRFrptGwgUjzhUShwArwhU+/JAApz133BD+/9H6TEFPnTQUlXPr
	BIFQ=
X-Google-Smtp-Source: AGHT+IFHOhrysBR+6DovsVdXIpuhTVp8HJr3/OBh9t/W0q0+yunbstdhdagS7/7fV+TcxTFn88rdTw==
X-Received: by 2002:a05:622a:2514:b0:476:add4:d2c0 with SMTP id d75a77b69052e-489e63d73bcmr43950311cf.35.1746019901714;
        Wed, 30 Apr 2025 06:31:41 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1ba29c2sm92032681cf.76.2025.04.30.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 06:31:41 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:31:40 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: add new dynamically generated files to .gitignore
In-Reply-To: <20250430122917.72105-1-brgl@bgdev.pl>
Message-ID: <sq7527p1-9218-r845-605n-2p419s2650s5@onlyvoer.pbz>
References: <20250430122917.72105-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Apr 2025, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add new dynamically generated headers to the local .gitignore.
> 
> Fixes: b11a041179e7 ("vt: introduce gen_ucs_width_table.py to create ucs_width_table.h")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
>  drivers/tty/vt/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/vt/.gitignore b/drivers/tty/vt/.gitignore
> index 0221709b177d..49ce44edad65 100644
> --- a/drivers/tty/vt/.gitignore
> +++ b/drivers/tty/vt/.gitignore
> @@ -2,3 +2,5 @@
>  /conmakehash
>  /consolemap_deftbl.c
>  /defkeymap.c
> +/ucs_recompose_table.h
> +/ucs_width_table.h
> -- 
> 2.45.2
> 
> 
