Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCB3EFFBA
	for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821651; cv=none; b=ZNQJ2ahRjII9nJ56xYCqpD532zkvJuxSJKzR2H3JSjBchWmnOcnErd+GfheFrJ78hlCtPeoeTNKl7M8E7diKtjdYbDJHXyGHgqA825+xzBESWh4yU+pm1Ztw10E6vVl7Q/GCgORCgNDadzRHTqQtu3rZGJyQg6nrqL6DlTr/uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821651; c=relaxed/simple;
	bh=QW5hfsDRd1FivVmd2ugPokfYmZGbqzRuvms7qEgsMwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKofiRAzVrlIXj0EbHRmCWlOLjgZYazo9htrxSH76bAcdirzlmmn9IX7HuJWZa1Rh7vbbwDSCsT9RVbih14W3LRflFbbeJ92AdnIJhT9Ip57TqKXhg3mMLswTSb7f+Xlw/CPPTXpi+R0sQlvKAHaMw53qHZYacn4PtrZHlr7t1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md3pGbPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md3pGbPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E41F00AC4
	for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782821648;
	bh=QW5hfsDRd1FivVmd2ugPokfYmZGbqzRuvms7qEgsMwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Md3pGbPRwNwsScKMp1sgak9oDRrk20dEpQizuVWSQSz05lFcb9o5XXUsV7YHWTZmF
	 4P2V755bmrNNJaOQOGbulpbgkcsWr7O8XXKz/DOfFQLJv4b1edqHUKxgPH658NG3tj
	 2hNA3IS9360PKlELSAFDsqq6EEnsVHAVjMbdVhhdbebrKux78XJQUEuxoqfYB5dWoP
	 +6eg5NjUI0E9Ua3fAzTAFvJLr9RbRFpgRCOnjeGED2wr07AZhpPilH9FjB6TaKtKPE
	 yth/lnLuYfBFK9LSxbmJtxqI5ZDi9P0f1mtXz+dY6tmRl2bZhRzwasTgL1sPBRKtP5
	 wf50tmaTJ1lAQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b14a7e53aso16529021fa.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 05:14:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrCr/O3/SyRNFB+XAAt+FWm6FzUzODRxY/FWLmnObv3v6UPbZeNRpgfa1UGPsQKo1UrVrupy9K0WNecVj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4ju5HUCe5qzQsNNwFZcq4xpbM0WR3CUn14KHKbGpYX9UHSf6
	zccfp9vXbEE6fjxvBjfCNxZdx0C+lV4Vaho1AaQ3tEDLEpTSJYDjKCBjeUp9DrP39k9Ai0iNfKQ
	I4VLN/BpeMhYjb2rpUCIHoYqXpkBvNHs=
X-Received: by 2002:ac2:4576:0:b0:5ae:b9e6:afac with SMTP id
 2adb3069b0e04-5aec10aa4aamr99161e87.23.1782821647638; Tue, 30 Jun 2026
 05:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-b4-serial-max310x-gpio-get-direction-v2-1-4704ba2b181a@vaisala.com>
In-Reply-To: <20260615-b4-serial-max310x-gpio-get-direction-v2-1-4704ba2b181a@vaisala.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 13:13:55 +0100
X-Gmail-Original-Message-ID: <CAD++jL=g6jVJS=MeWxv+1J5m-nKjqNasb82xv0z3=wU47rxUtA@mail.gmail.com>
X-Gm-Features: AVVi8CdUwZsxJGd-1jkbwJC3cpMuesQpbhYucYXzc8Y282bGiYiAvtZpAnJjlJ4
Message-ID: <CAD++jL=g6jVJS=MeWxv+1J5m-nKjqNasb82xv0z3=wU47rxUtA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: max310x: implement gpio_chip::get_direction()
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 7:38=E2=80=AFAM Tapio Reijonen
<tapio.reijonen@vaisala.com> wrote:

> It's strongly recommended for GPIO drivers to always implement the
> .get_direction() callback - even when the direction is tracked in
> software. The GPIO core emits a warning when the callback is missing
> and a user reads the direction of a line, e.g. via
> /sys/kernel/debug/gpio.
>
> The MAX310X keeps the GPIO direction in the GPIOCFG register (a set bit
> selects output), which the existing direction_input/output callbacks
> already program, so the current direction can be read back directly.
>
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
