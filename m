Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82A33CE8C
	for <linux-serial@vger.kernel.org>; Wed, 24 Dec 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766588056; cv=none; b=ZpSJae7qk1jJMqjaFCwbLaJ3h5OIDHIw7u4zJvKJAGx/REo7ExNEk6cYuaowgohzo83bvIY6QrHA0SYJ71ZxTxzEjP20pisMC05XFd73qVl7qLMdwPLHKrfDQv+kYt8+B1ZmACB2nt8dQkeKXdfBYdj3j7Enx63rZ28OXDZ5SbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766588056; c=relaxed/simple;
	bh=yaMU99YCkVipghDp1MoZNPaCqasMZCJJuDxNH/aob4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EV7V54oDZYGt0FCRcFCswuapYIcurGaUg2/aNs5qOBNdoWktq8LpYh0lGyB9qS9XDId61/MyNNlCZqYrGUpCooe5Mpi0imdmyWsMpiQwIctvcYRo8lNCIasyOrvZcORDBgGbVe4/es3cr+fQqYEDFRyn2XFcgL+0SYj5P8iKVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SBK6tvV7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SBK6tvV7"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5959105629bso5955201e87.2
        for <linux-serial@vger.kernel.org>; Wed, 24 Dec 2025 06:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766588053; x=1767192853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhDqDV4s7qdrjj9f2mFsE6YTEhmlOrrwQwpDUlAObV0=;
        b=SBK6tvV7HCjfIlPgFcmswKmau+iW0VEmgX9LOPfFb66FSOhnVV+1CWH2mBToI5ni+j
         LnmuYBZjgZ+mdV8dYU8PS0jiDXM616T6yvqqKRAfddH20M3aTE+Top1DzLUBH3IWYb7N
         1SWexQDR+9KrlnC9OnkBLr2AUIPlAOxPdyDeLdsOMURGXq5GTntQZjnI6Z5Q+K7gdxrn
         gBCUh7LTsByFUAX+Fdl9JFbdKeScl7e7IM6UG0SkikL7v6t+m/coQaKHLN4/s4qjpSKr
         21FTAHX5BEQpWBUbrTEdVE0D7J4AE5SSw4z1QMBrsLVacVij47wThatwhCMPWESuSxPg
         OMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766588053; x=1767192853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhDqDV4s7qdrjj9f2mFsE6YTEhmlOrrwQwpDUlAObV0=;
        b=u5yadn24bACegAJ8pYpecmQz8EVEQlQea73fVTE2BgooPTrY3dFtgvFtOrwux+NCXN
         W7AnHwUP817sAmPh06Itzl15cdMq11WVWSjyzTgn3xyek2/ugWsD4EUnaS85YnEtgO2d
         uPQmYGhs34M6nQcYBW/iJ26qF6/b4FCw7xMDtp1ezPehGg2xHlx9yoof1liNTM+3h6+0
         fRbQ9OV/L1zb0SAVHfCYTyuNA3Lgn/6q50og4S14v1/oBfhzivrgy7N7UaFnvcjTOCwF
         aQUUyFDZvB7yn/Q+mrI751PxOxQ0UkywE14/AuYnjwINLSqwT4l++MyWvj2WIK+fqaN2
         Cfbw==
X-Forwarded-Encrypted: i=1; AJvYcCWqmP8vSHYotHmklC2eI0irQfS+yntHvhrwlvVgauMCj6xoWjh3wmdWGLIWgdz6TGZ1IKbSzjvA47sjEOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiU2EKmsIn96EgbGeVnCXfRKtTymHpCz9ms5ZRrJgi4VNZpsfq
	sWtCcbQxtaPbD3o3N+3OZtwitS+oXlqsuEBNmKmAxc+pNs+8rVMc5tDmpP2B2/knTBdlMqaJ2fj
	Pa+MDDD6CA9Al1UEs0TgWiSGCTvfTzIdaai3iWHv3fg==
X-Gm-Gg: AY/fxX7TvMYudbQviKXo3cAWfZOzwE1VF5FSsZoIkf/D8JyUuwJDMwMuy4wVkhUv9oQ
	D4VHF27qPkte3UIIHSqUqVnkjKucr2d/MPChbOXpJbgnZj2IXzUyx2VhdR9iRvCRd9to6y8TbSx
	yGYdxkK84mSodaC6fDHJ+DHSt3QmR5D19i4QL9VLSjg0/qOn031HyRTkiocyRjArdidRHrb1UHl
	KoYq3GZStx/nru+NPhlrw3eJiRL1FRaWAfUPljHZVozbZr6VaLNG0HsiwRgeRDCE7qzukXE6VQY
	idcUho46qkg4HvlH979fi7coVGOQffNjZ35xpO4=
X-Google-Smtp-Source: AGHT+IFb5l8Qi3x1iiYF2FxcQm9ToAJYtqYDLEYVODSKq73qOS4XIMj94cKKijEct6IXowX/8P0tpzjYcs1SN5b6LXo=
X-Received: by 2002:a05:6512:124f:b0:598:ef25:c2f with SMTP id
 2adb3069b0e04-59a17d4c7c4mr6265150e87.35.1766588052857; Wed, 24 Dec 2025
 06:54:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104105446.110884-1-marco.crivellari@suse.com>
In-Reply-To: <20251104105446.110884-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Dec 2025 15:54:01 +0100
X-Gm-Features: AQt7F2qtc-N2XlSqG_t4BzlMqOZG8upusNcv4H9vXAMzn8BrYR8yJ3-W-19yOEw
Message-ID: <CAAofZF6DCmHnpT8mNGiYRJdeQc9yBooRf=N+WVEw371-ZP06Zw@mail.gmail.com>
Subject: Re: [PATCH] tty: replace use of system_unbound_wq with system_dfl_wq
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:54=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>  drivers/tty/serial/8250/8250_dw.c | 4 ++--
>  drivers/tty/tty_buffer.c          | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
