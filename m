Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F2379989
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283932; cv=none; b=CwklUcYajlcYjxwr9dGsAHkmSwPikFEVfmRNNAIk4oHzSaCbpUuL2q9hEt3e4HFEGwAcHdKyIyOo1NDPXGALgwCdr5yeaJVQQZjB6zIDT6xMjioeNC0lnlfaL6XAIjpluwQSNHmasESfvba8NxjIZY6w43IPdoVUTsAWwRB/zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283932; c=relaxed/simple;
	bh=IENLG4lALsSd6SFIaejv91iD8F+jicBiO8yAGOtezqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnVQ7vrqa2GSJq7SN+cC6N66zzRsTHLnKr/idAp4vnBchrNDbN/Fp4dn+rBrJDKRRAPQmhL94436a4sOmLBh4ncU4f+a05Sjf0QKR+MuWJcx9CbM5kuGxJrQ8Rbnb+0kdm+gIZCidpXrnqmmTMG3+m5kOGFHzAh0e0TamWtz8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzHFglYV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzHFglYV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-476d8e647e9so7012873f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784283929; x=1784888729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8xj/Zq3eXlyeFQ5HcLTwcCtnwxHoymRmkUZEXvgL74=;
        b=fzHFglYVHusk61twdF73aE5z3VIIPmETHWIy0H2a459ag7DvGcSvKG9xk94Ix7nqyn
         t4Jl1WjP8WBbsfvLfoD0tKYU1nNdcjBx2aGmWC0LKR8SNCUKRtwrpdcpNOtUF799O42u
         JbGYA05p26NJ3qoldpsp/wcyt9crL5u2LJ6Ak43JNiyKkMIuWSF222inz0uB4YnJS8qJ
         FxGeJI6UvIqLrt4X7g0jezMgHAWsgIeBiPDc/T1NULCMetxlr1tj+rY+qSXxwBiMyZ3t
         SKNpyTYBA5/7ZHxsVGFiJwNIW5f0OV6rIKiNLtrOQ8FHbHyt99EpFKEqbB/4ri3nKrzO
         XH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784283929; x=1784888729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8xj/Zq3eXlyeFQ5HcLTwcCtnwxHoymRmkUZEXvgL74=;
        b=iRxz38eiqrqD1BgluVdGmB0oAPM40ieUxPgIxXb0gNz7TJLB15F4ARrmMCQa+HnNHI
         PPFxPw6g+Bs8vOKwstYrBuHiJvjW4AekwQBCBi+Y1lYFe6XH9vdkkbmGN+bNorKOxrA2
         M1rJJd5bLvIVltiQgqhSXw4IWwmuZLsLkUTm9ApNYq/IQevIsd9Gsf5n947CLs9SyH3K
         D4VhNbxvPUm4rfchOiRmZhu7naBBNQBJnAGgievUJGZtleENfVPE88rGF2i3rYXewF+9
         eb+jenNNZn2eU6z1bXdfvQp2YD4DVqOv6AGZHbalLbNipQ224daHgXh2+vlk/jzJVXqo
         VEHg==
X-Forwarded-Encrypted: i=1; AHgh+RoWXVDyNZ7XC73onHghzrtAN6o5OMIGnMvN5jLF4Xr0Bv3jhMumZT06RxXqfPcSAgDUpAJuzxhxllqk3Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmiSefgXMtOHrtx2eKR0sP6VJvF0KskuJh4caQW0EtPO3JTM7
	He8ZQaams+TS0jN9pq3rBrP+5O4F5V68X3IWJQoff4yiAGEZdiAOS9iH5KznLqZz
X-Gm-Gg: AfdE7ckjAwqmzWcY9LBQ423sAJJIMvWeYCnKwVz4lwYIHj8lR/lXQeVNnN14i72zWmv
	rnMLbI3HqbSfEIh1aPMNWdmEXt6MvkHuq4rZEY+0G6nxce0O9q5dB+A1I5uT0D/yNvoURHnVKo7
	81wwxUVmm2h19lvEHWu4IZeWTj9az3ga+TMOldLEENXHvNWF/rDeyz0nQ7xG/Zb7B77yz1ywm+a
	uWYHaFMBvbxGn+yf8I00F4Py5Tu1PgjKbhKANaRUrT+TDkSNESxbdZ4mIZuz9Joj7Qyqp/0rLM8
	l+w3hqf3ZHgnj1uvCV5jrna3mn6ORKjMei20NSqGUogDOTTme45FfL2hHvA6lmJBLe4GVxt0SYb
	hbWSqEymRHnQAAeEZPPCNmEFW2nj1X+qftXnPnSBILNqEl0ovIRh9gz8nzHWrmRxrphwEVPRphT
	Vd3N9cDERlOcxX/4xj/O2UbmJIH++WqfF63pL+xLG8LjCpBes0eZvi0CIKh6tXtYZwjSVGCZn+S
	xXCdLoOTYYMHKEA6r8X6GzatQEkM2uIPwknappRfZyJcM5sJdADeuBGh88aLKB21I0SVbachDDw
	8/QWDl2vC1rc
X-Received: by 2002:a05:600c:3107:b0:493:d305:b8f3 with SMTP id 5b1f17b1804b1-4954a3d6462mr25201465e9.3.1784283928841;
        Fri, 17 Jul 2026 03:25:28 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a56c-5c01-55c4-777b-77ab-69e3.310.pool.telefonica.de. [2a02:3100:a56c:5c01:55c4:777b:77ab:69e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2511sm30880395e9.1.2026.07.17.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:25:28 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:25:26 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <nico@fluxnic.net>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
Message-ID: <aloCa9hBXW_7I-QQ@unknown748F3CBA5068>
References: <20260717071616.91423-1-kmehltretter@gmail.com>
 <2026071743-number-headfirst-bcca@gregkh>
 <8a4b1bb8-57ec-4746-8c98-3bcc13e9ffd9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4b1bb8-57ec-4746-8c98-3bcc13e9ffd9@app.fastmail.com>

On Fri, Jul 17, 2026 at 10:04:17AM +0100, Arnd Bergmann wrote:
> On Fri, Jul 17, 2026, at 09:22, Greg Kroah-Hartman wrote:
> >
> > What about testing builds?
> 
> The driver only builds on arm32 or arm64, and there is little
> value of build-testing it on armv4/v5.
> 
Oh I already sent a v2 with COMPILE_TEST before reading this.
I'm happy with either version.

thanks,
Karl
