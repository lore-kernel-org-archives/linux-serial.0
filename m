Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420B33030F
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014361; cv=none; b=Hhl7iHh1596eWNYziy2uhTM9aMYxSPWnz6SgPWnuRnwRyhI/DsDwCpT84mwJRE4ofRL3C2YvdOgoMojHT2cJVxUTlpTmvxwWL7ONZ9G+yTRInSlaKbvkAmeNsflyH3LqivbqBJ1gSQ2NA6BXvBmB9f9+qk5CVX3BwottIJC3HRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014361; c=relaxed/simple;
	bh=0/sC3xbHX91SFc6+u2OW880xg51KottdLmNCvxxcEqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRMAbt0C8VYdVF6oNZy75svYMu0hNke5TtczuPB4ol40eDLU9cKdsi+705PArRZs052MgeahLtCraGy0bAnlv2nbQqEojEPEkHG4iGXxNMbF2S9Gzw0dVcQPiqULsLAlLs16JkzSgDhMvi3tBogRamKm3Mvymllj+xZYbH307F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW5KiS9Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW5KiS9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F4C2BCB6
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 07:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777014359;
	bh=0/sC3xbHX91SFc6+u2OW880xg51KottdLmNCvxxcEqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TW5KiS9Y784yt8KM1XFWshhpxYqEmWvwSwhluCtKApdksdpwJs9m+BVMNubJk0RSq
	 B8u06aG8Ph29If4I0Y16LPNb3gUFT9wiWi6xu9KAIpLEUHpA4vam9+Ql3xA1XplEfG
	 XAYVEPSsOZYg56JMdBvhWmvPEPGxgxic+VyBbOyROzxsj1RusWMSeRyzYCX5iQLR8+
	 Mw3yPZzX7u+eitAC3lxBtisahpOM/hWQhoLzZJkStwtJhr87C6CvZdBU+eXSRj2rYg
	 9reNDcNAr/1z/PGIXT+jvvhZbtPVTGYR5XhBrXvb38Vujn+SVn2hh77oFsakG6VY2Q
	 XpUV2mG6mSyqw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a413f83226so7684812e87.1
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 00:05:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/R3t1YkwxdP6G28ZP1Vw055ieKpRUKA+D5OaOuqz9FG9srbRHx6gpv9nl7iLqMUUHxCylA7wAjCme6StI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGJBDTEQLflSQ9AgFs2oLRv60/4LhHlSbig8MvoLUCxAIo96N
	J0wICn42tsUw4d+rPckoCI9NbKMunIUxpm07MbWcS0inMkr14fJwGPIeZW+pyr1TdfsbWl4aJ07
	7Xrn/lnWzNwZLTy+ZZ11v7woARe0P6TU=
X-Received: by 2002:a05:6512:3c8c:b0:5a2:b86b:56c2 with SMTP id
 2adb3069b0e04-5a4172a2e97mr10579597e87.21.1777014358009; Fri, 24 Apr 2026
 00:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-send-v5-0-ace038e63515@gmail.com> <20260421-send-v5-6-ace038e63515@gmail.com>
In-Reply-To: <20260421-send-v5-6-ace038e63515@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 09:05:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLmbWmj+tyefBm=sFGzxQMxY+H4h5TRUD7N7x=kL_ZdqEw@mail.gmail.com>
X-Gm-Features: AQROBzD_BbBKfIuVI61TLisBat5ysC5wN22oHTVtH8oB5cdnAJpZ64NHEl1Cquo
Message-ID: <CAD++jLmbWmj+tyefBm=sFGzxQMxY+H4h5TRUD7N7x=kL_ZdqEw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] amba/serial: amba-pl011: Bring back zx29 UART support
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, soc@lists.linux.dev, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:24=E2=80=AFPM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:

> This is based on code removed in commit 89d4f98ae90d ("ARM: remove zte
> zx platform"). I did not bring back the zx29-uart .compatible as the
> arm,primecell-periphid does the job.
>
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>

I like this.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
