Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793594773;
	b=0BVJD1pgWvrSJWP1+BvUj0+eUFnUnqTkBE2VKZmYC3khFDonzfIISPTiM1gHGBhzozDI
	 6FYgCnNOUkw2PVGh4FmzkvwhlOzpeXUn7qeC6oTBHDPfBnCAqOaI4ApnvS+vN+y6LfbDL
	 DEDL2E/AdGx74yjgtYosbCle2bsT8NMI/A7HKjlfMrQp8gbXOo5sN0aJkCV7d2EBA5uq3
	 TlMpNUR7o1AdBlObT/amQadilw6/dJK6nXNr1YVRXMfhwidK5lQ3LYvrGC/g9MXGhD5a6
	 Co1w+TL8dsghUXf5rSDPKAMaDLGZG4Sy6Xke/6m1+dbCgdWz1ceoCWljvSleGW/6TlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793594773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yB6wEIyzc0Neh33c9nuixn5SD09vP1yiHRmy677LGXo=;
	b=fG7D8uqZpTn7Aq+FyiwB9O2qhQaOpNYFU194kaNFqqTPh5wL8BaE3+HxiLh8qoQ5j4Jj
	 LQxVdm3xXjx8YjbU2ttk3Tg8OtyvdfUkfxks9Z6hd+VrGF3/bYWRIn/EP7wzopdKgZzid
	 AIjVAbrce0ItheaAceULUt5hgHi1cSAF5OjonUOgwhhBxELLh0NNAoBz1oGcIgt3jveFf
	 uG5itzncBBJM0oFdtpntiDZp0NNxvoNMgRBefE4+JsxPc9ce/9bte2HNMfCDpQIeQr4/+
	 B5ZhoZ/0ZGIo2zRWpAyD6wotyKBd8m7v61KGd+ywlaIo0bz8cPUEMDOHpkqjeDPF1yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0qXwYij;
	arc=fail smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C1606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 04:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0qXwYij
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0db268bd8so15379417b3.1
        for <linux-serial@vger.kernel.org>; Sun, 01 Nov 2026 20:46:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793594772; cv=none;
        d=google.com; s=arc-20260327;
        b=QaFmvugScO7i26C4va94fY6GHuzd4kfDnHGjw4wvShqexCvpu6400q2VbuqRTUEusU
         9QsIJ3Ijp9nycUKmvHHo3qbi20Oh6b6pa2LO+mpUkAc1wi99WXEybVQ3gu8eJPqi7rNr
         GU8aP0Rj1IcrpkRHsxRu9HTyQpzzplee44JSKHxS6oaa1qf3cAhdPNle9fmo/3BqVk6Y
         jjju/hKqRMNYkKbpvM2QG9QV0hkhZK+RY4H15wAtsc59sNcRNXFple0M+WgIM2MFLn5R
         7lghqsGMSJrU5DQUVuJySu4LOaHRLcf9rgDOQ7SjAR+DiHA+/64EQbfR0OvxIPu/N7gL
         gT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yB6wEIyzc0Neh33c9nuixn5SD09vP1yiHRmy677LGXo=;
        fh=wKSGeha/EMjEnwdXKvRj2yBDGxwD56wpzEz5yPQr/Rw=;
        b=fp1KFasglyRoGnDpLpf/Ru6t6ifo7bpv7lQwIb1NRA3TUjc2wvxgebyKsjv8kTUqxb
         tNCJ19d+9xbe3jQaUL+ne/NZkBj/bHkcUleXliGdZNEdA5AqvpgRPIylzun6/r+p/2kb
         Jh8gOSLQd2oNfyspDZS7hkrsuC4VGHsboRYnmAraVUsAVL2jUbbDp/aDFvFfnUbAhaR+
         wcqdIeR1HBKaEikzbvVSnB9QhXiP5p/ad5B5fLp3LYc8RkZtU7z7EO4LJ5dKpzWLBIGy
         7opbfHbMHxnwRJGjn/M4DwIjKgXf2buKhAgJDoCrIy2sY81OUIt1AjZyRq6JKEdgsef0
         W7eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793594772; x=1794199572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yB6wEIyzc0Neh33c9nuixn5SD09vP1yiHRmy677LGXo=;
        b=o0qXwYijoiqbPUT/iMnRKJL9Rcry0sFtNbg0F5j3Mt0+g50S+K06I7S1CklQyFLVIu
         +SUPWRQXKjPbvM2QOzn6WzwhmMCtXazaQySSfexzNppseiinIHNY3ZCYGyNWbkFyRBJY
         re0yvBy89VXMKN16ll5S4w8k0VL07fXetc1kSlDN0il4lU1r5zeHOYy3nThW0PluRkT7
         evKBoSow1sBRJ6m17g5cN4RaeJJZ1WHMmU3k2mwKik+JV+ne9fMtxjNyE9yy8zEKkJma
         flwyNSb/P1TP5pGp5E37AhGaxUwabhL60ftv8MuhRDwpbdk8hk28thhsElg4ANLxV7lb
         0akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793594772; x=1794199572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yB6wEIyzc0Neh33c9nuixn5SD09vP1yiHRmy677LGXo=;
        b=e6WpGkM78msN84sIS+gjIXTR8GlpprXHg1Xmf3wc3qxaTM37osTee3j7M2n9EX3kpk
         ip3ZK/MmmS5aLY4EydGUxso4JkDTuQCu5cixS6TFeqWXRxBGz1wT/A9VSB4bL8oYx44/
         nRDB5Qazfx+opu27wxHwkH80A7rrud7WFcJyI6MvK7cqcxf5bTZYF7Xryb2iuIT9K2hU
         msIxpMSxBs0WpQ5PzfL+aW9jQQ5+gLFVYcknbegD4TobxEea3xh2lo3Jb1Tj0TxFsWxn
         SN6HCKW3wUcinCG2IFaPPB1DvWHyCYLsj25Xf+sIr9G4LoEw/wo5oAmtv2K33Sgmefk1
         PFWg==
X-Forwarded-Encrypted: i=1; AKwUvByn87km3rxAfR7NDNO87R7e2asmea6em+i7YY611meN/UoRt9cUF2yQ38O/6a7NvZN9TxXT8C0PzEJnecs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tyo3wXrJtvT4Uuw6WAl9Ajyc4Sy6NvBDrd0DZ8SDqth5FlrLD
	IwJISG1RhbR8f6ypXh6rn/REdZ4ZduIZ13WO2rMjJklh02uRDnsYOK/z94kweRppsG/tTZNtRXt
	daHT4i0txMPwPNEEohbN2v3dIrZ4/pnw=
X-Gm-Gg: AYBFou2ZxeFeFnlJ8qEPUt/XoJhgvG+FfIvvKS0h4035BE37XcSFnmUQM16JfmusbdP
	inGx0avLe2m5iUyFDPX3JykQTVwa+xEFEnnmh/73kn4PnJ6OqiugD2Puzc75wbjW8mrrG9sA2Uv
	51REnKPzUjJ3ZCQLXC5LMoGALVnYBPS2bzfXuOhWgp5Gpq+pOWSsveFmsKpfgcZlqJHAUSXOcF6
	VDGYQuNdGpTSXc+v2i2F3oRnSSsvenclhheVtCwbivbKJQ4aQetxwwnZ3C/8SPBLZuq2jrDIAx6
	2Hi680KYhQvWMyiwbA5vronKQJwQ+ogyw4Rjw9qasgNhy3s6rPMLS2Sl0Q/3kehW4mS/WWk/Fee
	hVYOkidVMFJ4FaIPamhP7BFZmeKNaHtXW8vRs/+/mXg50z/ODy1QcdKxJV79O
X-Received: by 2002:a53:ac90:0:b0:679:a47a:d414 with SMTP id
 956f58d0204a3-67ba50520d1mr4698256d50.148.1793594772269; Sun, 01 Nov 2026
 20:46:12 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
 <20261031-tty-dont-use-autosuspend-removal-v1-5-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-5-7bdadcadc4dd@kernel.org>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 2 Nov 2026 10:16:00 +0530
X-Gm-Features: AclHuK_YfQrdtG8grRC3sDl9M88bqx3_75JwW2gTYOzUBxf8mRI61Vj_PHN10uM
Message-ID: <CAKfKVtG5xCzn3mHcR_7+Q9mdq+46eXAk0qu12KE1UsS_-zNbLQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] serial: uartlite: remove redundant
 pm_runtime_dont_use_autosuspend() calls
To: Joshua Crofts <crofts@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 10:40=E2=80=AFPM Joshua Crofts <crofts@kernel.org> =
wrote:
>
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosus=
pend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>
> Remove the redundant function call.
>
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
