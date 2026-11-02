Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793594645;
	b=jy7Y3BSqU8L1NzGhz/5zoD9SI03WZkvezXQp58I9PVSnMQEKoMUKKKLgv8aUYAhCEzeS
	 1YnZwZs4rU5HwL1fJQH1vR8q+Z4OdT8i+iDVN4zKfMNpFgzTFZgyolZKlfu8Te7wwav6S
	 SvfYRSH87Pazo6IS07j9v2Jz4j73waAH2OzzlU7zo5+aQmmArQn5nWpv5s1Z1FoTnMGWK
	 B3XaekbnFaNpEdqkHUcvzqjrIBR9t2/JswUR0GhCenRKEDeJPHdrDBX95aspzdrO4hdmY
	 YLCVLdETmiVmqkBrWK1YyShi66zcigWLVfA/95lnyT6PrPlY1bveXba4rEA5DGsFwlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793594645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=O6Cwq/TYI20Xap5XXma+Ak7imjQ/5PuMjwKwFGT+f70=;
	b=RI+gjacDGrAGQYBw/0/ooJFgur1LJluB1aq9yJFD35tHQS2+myh7eZQGcaHTmWPa+6aZ
	 egg31qs/t2788pUbuVLokJcCdR5WwakfzfZGxk3hyRxm5GRZ3Cerpd/1b0q0k6iVamewI
	 aDlcQGQDYYCC8t92cSLE6PkqS2OfWWCFtB4QER10A9qCVJmts95PNydtMhkfWdhYnTmNg
	 OszQfiu5Wtby/bkWgdURuyTPhDXA/MWjvBLpmqplgxdtGEnSf8gpu93KJcitwhznwGwbn
	 FxF6tQzy+//zcbf2/TIYxcfGMj1La7pLWUZFbioKZJUm8bISsPt/M/AQcGrEW3gsJpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ywOVfQ/8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F714606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 04:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F714606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywOVfQ/8
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-675676afc3cso2456906d50.3
        for <linux-serial@vger.kernel.org>; Sun, 01 Nov 2026 20:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793594644; cv=none;
        d=google.com; s=arc-20260327;
        b=k3kZdba1riryJEtSz+8qbv6iMt9TJSunQA5irYNi8lOq8DERngjYplzYAeN3gG20B4
         5GPtUdHQEUdMvT7+Lg0MRGykWQ5wIK6m6fkugby/SDoPmnZvq0+WRUy+1gN4K1PsQDc6
         NhSszoFW7z0vLPBd/yvV3zUk0S6KNfdlYBfqJMk5hUUC+p71M5m673Ssiu5xdg13Sf8w
         X1kY7dFck7ZX/hMDyWorDv7Yps5C4b8aMUpSX0AIMmwa8DLXe41OdYgkj08aOnF3Jf+K
         +idT4N6+WppD3LGUBjplOL13+MtrIiHVU/RqAo6cAoamN/KpyDiI8Dd38SFNyylDOR7Q
         F2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O6Cwq/TYI20Xap5XXma+Ak7imjQ/5PuMjwKwFGT+f70=;
        fh=gxPr9VcVvV4k8Ey1c3MFOUQ+P87eXyRWNHQ3n96hGew=;
        b=ir+mA35SjHRJePGxtVUAVMB3ARlMDisiw1cPNGjjOmFlFiA6K8DXT7ZWa3ANPa9T7G
         3ZMTIktLVccFObCmduD/quZsrO6wx6sURJ32lJRv2LhhF4f8RVlf+qpXK2FLgK6saZMf
         TiezukgMXKoQMbmQPiLSWXGiewuYhVB+3CiZZ0s6+x31l/yF20rAlCRuVT6XAUdbnuch
         e+fcalHiAMRyqshmK+99vSd6IDJV10VBgPYlZui1nLqMiVxdEcpHR3MiHXp2y7zY7YPz
         d6KOBI2GwFBHAPwm0teTfrBjRP8op8709B2ADWfG5J4io24RW5H4yd86nXnw1DCR3GTO
         aHlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793594644; x=1794199444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O6Cwq/TYI20Xap5XXma+Ak7imjQ/5PuMjwKwFGT+f70=;
        b=ywOVfQ/8CpQwC6A2QrKzyJosYRmO1nomFHzMJv31aIs7fCgdDQqdasj6EXUcd4uLYD
         xEQaTON66QGacskLoEV1x/V5qpsAO3hxANBXnPSI745VxoMVIqlFF7Lq5wxwxd2BDGLo
         vsD8I6sPqFogDEZJbaY7oxSOnc0kihoYzLM8TlCWyvTHLxC0pXVeUeslpY281Im5aWz2
         keeglxV50Ad2dT1rK59bwtLhlnCvLsMJa3lbXg98qw3eRqdvVppqynp0Y+wgmyKhNmxz
         zr1c8p9uzQ7Sc6UypSwLrerLFgE21RNdIMx3aaZOW1YrDdfmxcwIqMl2rmB2ysmU6wK4
         HaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793594644; x=1794199444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6Cwq/TYI20Xap5XXma+Ak7imjQ/5PuMjwKwFGT+f70=;
        b=PMXxRAhXWdT30VWQtnkV8A952jTsRSFa+0kinKjDr4xo+n5v2M7PAZeekTqo5OTWu+
         GPfcpJYgghJvy1mqyQ3sHnfTzzmFX1GWV+4n7+lDY2q89HnIz9lf0BAa1pv/JmpxFg+7
         8mslThKPwuDOe5oInjQgzQCjDD4YACxeqxLtwvv+qg+s5IUbAqkbqhZJwB02os5SQCCx
         GSiu0rD2djvTBWgJnyMXHkdCChZb9NrFZUs4A1n8WJqIvlcXlWB8je4SJbMIKwVtiDV2
         wUiaa0MnacgtJq+oa8DVT8yJLg3W5MIWJYg5bL1ZIb+PnBOdi5GGsVxCVz4V5JKnvIzE
         XLcA==
X-Forwarded-Encrypted: i=1; AKwUvBwtlquTpllg5xrFiURzKq357iwCaRIjDDJeOyhY0vrKkxzIg84IwmB3TTsiKpIVRqtYIyldnz/W4zktWQ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HXyMzpSz07nHKzy2Ng/mzAUJlPMhGIYOHL9gyGau3QSzxyKHX
	qz7UZI5y5Owblx21GrRm4ylv8B//2a2E7EKSxIF4Q8WipCBHklqTCMEFBd8bU13AKP3m73KT9iq
	S2Mc1mLogd68OmdFuFp3W2oLVL59SrOTeWThm
X-Gm-Gg: AYBFou0z2Oy8J3XFAREJTr34jQNPwC/l5V4aAdpFj3ymAkbjPJHLiGAblM5+fV4c+uW
	K9C14F01mm4B0jnHtB020vg/HyDzRh8BEGZDHxq8yCOnbZndrTyRDzwE1r4OzCmkOwHntQbt6Bx
	25jrE/2lxugHRALA7FE1ksptUMqeLQTExyS1rqNvnb34P/JzbelP/wEY1yEwT5isafbB+Z6VIIF
	3xmGAgHvl5frWohj1zOKCkQeuKYAySNj1tGLCst/cJhwjQbWjQhxv2TO4flt0SAvU26g+leWGUU
	vc2Hmu9x+U+xB99TzazsyY03ra/66DxiKLiB2Dh5E6XzOtCzi94oyph/2HLXQFunBT8IG9j8rdh
	V5jmoU1c0rQqt9JKAv8QvlCbJUCjjCcUeQTRSWxYkT/4XbaUSngNukRydQF0B
X-Received: by 2002:a53:e1a1:0:b0:679:9e0b:dc4a with SMTP id
 956f58d0204a3-67ba502f05fmr4965690d50.49.1793594644085; Sun, 01 Nov 2026
 20:44:04 -0800 (PST)
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
 <20261031-tty-dont-use-autosuspend-removal-v1-3-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-3-7bdadcadc4dd@kernel.org>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 2 Nov 2026 10:13:53 +0530
X-Gm-Features: AclHuK9vZb9AMAN_Qfd5MGPYCq7hcmIITeMPXc1WAqkUrzre3J9_8OXCQvnjwD4
Message-ID: <CAKfKVtGHZ5-yQacfzqs_cK7LTb6C6GXCHNrJBk_7ecyNtJkqaQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] serial: xilinx_uartps: remove redundant
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
> Remove the redundant function calls.
>
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
