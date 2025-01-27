Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AF21FDA63;
	Mon, 27 Jan 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972440; cv=none; b=Xm2fU18wur8BDlmSx1yWWFJpHDiiyfZ0TR3rlqViOTInyu1LwQMDLXPgpgQi2FKvtzBykttVyxx6CTDFGXPajVdlV5j6dCzw4z2LtO6q32awJhUe8uH09dEaJbtX+eAI/HGmoc9m+n3TEKd+Upey/y20e2o9h+5jWZErID+LVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972440; c=relaxed/simple;
	bh=RfJQ8yaqXD1dnaSaIFmMEvnwU3jqVebHnUCgcclM/zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooKNSes2qzkLwXwnO/aUJu6FGa/yzoH3wF+0YXOreCLtbdvFvRnoMl3ny8a7KG2zQmk2nodb5+MLBMzz6z6eUj79EcduQ5gYL4jQUPqYIfAW36S8EO5z++zaZsXMrfcnTATCl98F2Yc7UXtY4Qx9ohCz1n4ZTqdoPy4gGlovzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoDfnHj5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoDfnHj5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2167141dfa1so72913415ad.1;
        Mon, 27 Jan 2025 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737972439; x=1738577239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oXJWMCIyeR01ooEwhI8Miy6ncM+ExWllN4yK3g2GK4=;
        b=HoDfnHj5z5MIQUcdjtXY1QkQvFqsGTY4Ftuc0Hk9EQP9nGZK/xDd96wi403m3HS+B5
         KVJ0eN2VuiaW9AEwLVYme2BO1/47WP+X1IaZJm8qXgm8eOnZxvuu51XIkMB/gulUUS8z
         N4M8e1/2/iV+d8RRZ5w//eOH6bhDxej7CNgT6DptAQThQ/7BDCD1dW+gV0HiIzfvTuDd
         EQTWtoXPcE5GwwWmKJSMvl0bgyWEwrOXCcMKdPTAlG33qQ5Tbo5nC5vdSUa9KpqZOsQ7
         m7Z+bBUgHoB4izFmrG/0MFuqyO9ovrW1BWXD0K0GzNqgMFls5sYfx3E2+dshC5dT/+PM
         clLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737972439; x=1738577239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oXJWMCIyeR01ooEwhI8Miy6ncM+ExWllN4yK3g2GK4=;
        b=QAE1gvoOsAqJHAlUQIkkJDasAupoRU8xZBLDiM+2iDQZqxhbrtBUb9PIuX047wabsp
         KIO1qHQl2YpAm17rIIjJvcbLtj7qvqWUXPRUSRPxV4IoSRzo0izgJFNuln14KKcZ9XdR
         uAZ4kO7Sj8ENg8n0e92d2Lm+B5JiGsmi9cLlOaP07kWmsgtciL3+fNY/JwEdWkrECAbI
         OgsoN1poNrr9hhh7O4Y24Pp2e7W8cN5gscPUYWkhqygoCVVP6FSy4HqcC3qtmjd1euf7
         0dMtUtn9fuyLtZ9WmHht2M7F0z+FY9jtzZ1IAc79fW61PFtoDzrSKBrtpvmafSM2IrA+
         QfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw1HO3Eb6p+mfdTPK3ECJrG/XXZb2IRqJOtvLCJz7Is8UqY2EYZ/3jZNuej+GMy+Hi6xsr0qtuGiQRhphP@vger.kernel.org, AJvYcCWbkZFRbREUYAMtau/l1E2KAqCGvj+epeI8B4sXyd+ZEamX7cDcFYGNB9QSuZlLz2KtcvMmraU4WgsSCbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweauNvVIeO0+l0ed00e7VvVQyG+XyuErlhVKvdWcFi0rqUJP4l
	QoScOjYjXgJbgBr1FE8+ExAzdLZ53akK9C2/ubgsKAeXTAGaZ21R
X-Gm-Gg: ASbGncsypVOgq2vrMRYDEKRwrtCuJG4gRmfI+Zys2LFz4Tx27G3VuLTazgWYs62rN1p
	eA9YIE8k6LtTsYHC45EswvRGT9Vu6+AQzWCIaolhtGEIZSwtK3DgU2MYJWXu0Vc60ABpu7RpJev
	NmczwD1Cqr88coUDMC1PY/mslm9fC335NCWfnpoVgTNddI7adCQmfGt1IphlYosWKAYqw7yE9UG
	LfssaXm52R2vD0BQEtbD8yNmfzJQ3b0qJVFVIZ1Ap+0We9dQCk9gXLJWUijhfMQ8HT4ESOahBaL
	kEsuFVE=
X-Google-Smtp-Source: AGHT+IFI1i36ud5c2xr9PmQ2ENq0YQ7Jn82I0tHkp+Z/GHRepPg7DKy61vizGZbbEojD7+mcwE4jgA==
X-Received: by 2002:a17:903:120d:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-21d9932f586mr242112565ad.7.1737972438766;
        Mon, 27 Jan 2025 02:07:18 -0800 (PST)
Received: from eleanor-wkdl ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea1e0bsm59106985ad.53.2025.01.27.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:07:18 -0800 (PST)
Date: Mon, 27 Jan 2025 18:07:13 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: pic32: Fix build warning when CONFIG_OF is
 disabled
Message-ID: <Z5da0aCupnXRvjr9@eleanor-wkdl>
References: <20250126163115.3200308-1-eleanor15x@gmail.com>
 <2025012604-undamaged-earring-d16c@gregkh>
 <Z5dD5Fz2vf-nnjvg@eleanor-wkdl>
 <2025012726-macaroni-unbiased-e6c3@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012726-macaroni-unbiased-e6c3@gregkh>

On Mon, Jan 27, 2025 at 10:12:47AM +0100, Greg KH wrote:
> > So I should remove of_match_ptr and add the CONFIG_OF as a dependency
> > for the configuration. Correct?
> 
> I don't know, but putting #ifdef in .c files is not the correct solution
> at all.

I fixed the build warning this way because I saw it was done the same way
in these three files:

drivers/tty/serial/samsung_tty.c 
drivers/tty/serial/mps2-uart.c
drivers/tty/serial/altera_jtaguart.c

Or maybe we can add __maybe_unused to avoid the warning?

Yu-Chun Lin
