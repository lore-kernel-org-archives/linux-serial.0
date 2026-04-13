Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E137C912
	for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052721; cv=none; b=R5oCW/XlxMeIilfKwDXO29j61jUX10MXSZ06iwCITANwombrG6Gn++1GuTy77UMRflA7mzZSLBE7zAZ1tYbAP79kCAeSVt7RDpWp99u+fA6E66EUQm5yK8uDHa9vg1UjRbrVKC7BMkE8zfZeSos2zUvx+zQGlEEPPEjZvns26Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052721; c=relaxed/simple;
	bh=q6Fg8aFIwSBBkrdIbWDYN2Qg/+XFIv/XYOlevHI46mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbpEAK2oWjfGbDsIosHBVEa9FSDH3/6XGcNhSkFF7dAaK16hTmFPhwKKVkkG3aIau7Cpco77vEHn+INVtOscvZr4PgL2QQGYAHxUVw5J16zehbnOYqHjUfr7k+gXEvn1cZv7Z2ad5SGoWW9iSq01vUiFuICaMiutSQ9BLup0VFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qpD7HXCZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpD7HXCZ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c648bc907ebso2804530a12.3
        for <linux-serial@vger.kernel.org>; Sun, 12 Apr 2026 20:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776052719; x=1776657519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr/lzenYvIspGVOBd9qA8LexXmTvhf6tDNuKiRhUvmY=;
        b=qpD7HXCZabEdEVQtDv9KZ2oJkD4LVewRKP3m7QvDjjfl1TSwMhZCohUpxbvqR8A4oi
         cvaV7ha9deZOhF6Bnqdf4RSqNyDpSjdvJSpGO7S65+7kdsdWj//FwObPhtq5cf1UvlKX
         hF/QrLH9kpegVv3MRLrMg2nN++L7hdLrtPOVr3RzIbw1YoZ+EE4zO9ruWgmOLPYKyKrE
         DQgQMR2/HRYcgm+WTXlyKr2yZvsX/6rPZugPCGXjroxQt8fSYQE5YCA9nun1sGJmKeNA
         tSQ4umKF69LKttH+2/USadnxDRne2JWN52R/9xiD+seOXVBYfMCtebf0RGZWeZYhHvv8
         BFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052719; x=1776657519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fr/lzenYvIspGVOBd9qA8LexXmTvhf6tDNuKiRhUvmY=;
        b=QWYGlzGT8DSwTbFDVjuuvjfNiIoxb0+IrUUBB46vQj1N+BH/MM3u9tvkXap0uvRBzZ
         Gs79tZSs+HBffVA607asKaafdkOfzb2WBHtwxdZrQgj/v7WZ/M0n66m9vdIdyZtIV7hl
         22XwYqAqi9IC428wldxgLAqfbXpSMaLomacudc/+cK1H0rIN9dtFTYBR5hjNhSYKFuIo
         LIgp1utHhPjn08LnlfqH27noqNbgn+ohfdx5RXYzTBXqfuNnJ1gMZd7MJoh9Q5MwC/6X
         v5N/usGVRHcJFYjDoe9gaK7kNdTztv6suK46koxY6T+FvXkTaAYoiV3cPKa7XLpvsR6U
         mCBA==
X-Forwarded-Encrypted: i=1; AFNElJ9JA+Lfv1jJ1/XrIgjgEkdXrzSYPWOcR99syqrEg21wk7Qe36ASCENVdv9cYFFjWFW6vPCPVug60w8IwVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7O738c9nEO9FhsHHXPg6qitdeXldDXvbavctKR0fL16Wq5Zu
	6pqr6fNpTnVB9NMlZfALvNwfAt7e8rr2CBPPi0NyWXxJGiV7TDjVIN8jCuCAy6qmNas=
X-Gm-Gg: AeBDiesACwwE/UMdbrjZLmdSM0tQgr2wma5ksQGxTL/e9PdMFAi8P8i7CrsrIqhGlqv
	TQBsZTi7QCQTIjJP80YfjKmv2dSx6HyaFxOP9i9cdHYqa8dDQ0geL9tpAd10b4UZYPBi1HvShnB
	fGpiADNt322CFWhK1R5MosKoTcsHc11P1+G/kFj6O9+TjO99CQcBpHT7DZjH1+dctF2qQYJJqy8
	5M0JeLleqnzENWtywEhvKOgTtkEC+OIdZGXme1Ldt+3ilMUdoO6TzFVjhpYubwMsXaCbNvh5s2H
	XyXOByPyfj+FjGnzlcfiOdIBOs6iDtFzBJZ6TgVmJqT33rCimWWZkTUuNmuVZqFR8bJDFu3sCDi
	qfXrUjujqh6aOzhgHXUCOtPF3OvIdlYQr6t7KYt/hkISbg/2F5v50CZpttrmYNpCuWUEPLO4y3D
	nczcieZcqtt+ZoIg3LU/x5IuZQ
X-Received: by 2002:a05:6a20:3ca2:b0:39b:e138:e230 with SMTP id adf61e73a8af0-39fe3cf7579mr12869459637.13.1776052718668;
        Sun, 12 Apr 2026 20:58:38 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0f8a7501sm9627799b3a.50.2026.04.12.20.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:58:37 -0700 (PDT)
Date: Mon, 13 Apr 2026 09:28:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: markus.probst@posteo.de
Cc: Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Kari Argillander <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/4] rust: devres: return reference in
 `devres::register`
Message-ID: <gm76z4ngcpgbi4f7xym25n423wmvdac3meou4lefd26hgqqp2p@aziculojtqan>
References: <20260411-rust_serdev-v4-0-845e960c6627@posteo.de>
 <20260411-rust_serdev-v4-1-845e960c6627@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411-rust_serdev-v4-1-845e960c6627@posteo.de>

On 11-04-26, 17:10, Markus Probst via B4 Relay wrote:
> From: Markus Probst <markus.probst@posteo.de>
> 
> Return the reference to the initialized data in the `devres::register`
> function.
> 
> This is needed in a following commit (rust: add basic serial device bus
> abstractions).
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/kernel/cpufreq.rs    |  3 ++-
>  rust/kernel/devres.rs     | 15 +++++++++++++--
>  rust/kernel/drm/driver.rs |  3 ++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f5adee48d40c..31bf7e685097 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1052,7 +1052,8 @@ pub fn new_foreign_owned(dev: &Device<Bound>) -> Result
>      where
>          T: 'static,
>      {
> -        devres::register(dev, Self::new()?, GFP_KERNEL)
> +        devres::register(dev, Self::new()?, GFP_KERNEL)?;
> +        Ok(())
>      }
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
