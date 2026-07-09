Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB41D5160
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632288; cv=none; b=bhgr/naf5vRNo4BgFY8fV75zZYoIbMrcOoruryfggKieZiwzFuRCfndSro7dHcDLEX/fOthueu2XLumCiSjqCrXrNwbXXwM9sWNGU2g4Vaxp2xrnP59RjuvnnVaG9HvAjDDpk3ZwMfmbll893ckf4aWmjPHesmnDLGjS/TCATl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632288; c=relaxed/simple;
	bh=WnQFw/EAZJgAiYw3GOe3M376DHNPD+wiJc10bZRAjo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hdcf/1FgrHhCnuDdoY40NL2D3f8kEASTeWar9NXIRqjzniX58Gte+Iwbzs4xDyGafc6IAFQiRpjZFvN3759eGZq3hv5v+hFs2ptUTixxDpcXlM5gHqfI/zVZ0ikdGUlKaD3dBnaFcIzlqSxSjGlksu3NoL8436/j/cczdRHTwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBSBjVCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBSBjVCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C83C1F00A3D
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783632287;
	bh=WnQFw/EAZJgAiYw3GOe3M376DHNPD+wiJc10bZRAjo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TBSBjVCRDqAoqTrVGlCNV7Nxo4+sr0XwJAeWOL6quH9uuvMbOHqGFf1aMyFN+8Vdf
	 IEMG5yDS4GE+vy02XApPerTlQ2Cy+Dhwv76IGZtcqYUX3Jffu+X7ElQS4HkThlQWYA
	 N3B0REpAj1TmJ0YJ0eVQ6ADS26jwTZQNSt1UHzcq/yTyh2HdZmF+AnEt5UJJy4rJ3j
	 PRJJVZsHOIb94lGpp3l3MyAGaCrKmoe+A1VRHDquazLsQeX+LPT9/3yoXGwvHCBOM8
	 AyGEwHkKGJhFI/SVXbdFegBE4cPa2jn6VVtGE1Hp1lzTBFu/JcNodhNdFNU0+SE9+d
	 KQcp6LJVrwXvA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so2310861fa.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 14:24:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrlVyggs/vzybOTWHs2wHuZwEzJboMlMAsCZPVga90zcjqkbEYoozyaBjbRu+V63Oa3xSQWzVjS9Dz1nfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJspjh88c/8zlkvCKb5F3oD0Euo5VRNefAqGV+5PKLzhlBVYKV
	8LjAIu13oS1cB2/+w4O7yaG3AYE8YNM6ZbMy0HE2f4H+2PNxM1/WHKsSnhl1k9aod1rAOadceG3
	8GTnp7vjqorH6hyWnbtVwMBdcct9GSPY=
X-Received: by 2002:a05:6512:2449:b0:5ae:bc4f:d631 with SMTP id
 2adb3069b0e04-5b0114ad53emr1945262e87.44.1783632286197; Thu, 09 Jul 2026
 14:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709-ixp4xx-serial-hackfix-v2-1-465fc8e4c54c@kernel.org> <8e8795a0-704f-46d0-bb1d-5833f642df7b@app.fastmail.com>
In-Reply-To: <8e8795a0-704f-46d0-bb1d-5833f642df7b@app.fastmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Jul 2026 23:24:33 +0200
X-Gmail-Original-Message-ID: <CAD++jL=amMmXR55PGO=z=kq9ZAMbXV+Fa4C7SCtxT-bWbMofWQ@mail.gmail.com>
X-Gm-Features: AUfX_mxexIoqeHq8spx_r1V3Brk50y265EFKzX-MWwXho8YXlS8QdzWNqEAVP3g
Message-ID: <CAD++jL=amMmXR55PGO=z=kq9ZAMbXV+Fa4C7SCtxT-bWbMofWQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250: handle ixp4xx register endianness correctly
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:33=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> Thanks a lot for the update, this looks good to me now.

Cool, hope Greg can pick this up.

> It's barely worth keeping my authorship on it, as I'm sure
> you have put more work into it than I did, but it's probably
> not worth resending it just for that unless something else
> comes up.

Who cares, the important thing is that we proceed.

Yours,
Linus Walleij
