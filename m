Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769E400996
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931010; cv=none; b=tg/9nGVbyX+dz4wP8PKcsVN0tNhYaKElOoBqQBj6Lx8ynbKXCdA1pUN3q7Jv6JhyudZmYbh9X5BTRtjD5quWVI+7gp8hmmMMSFyY70k7PtIzYqNN/u5Hwl3eq6HhWpGdhjM+/ZjeRRwaVmQGFHkaiv5VkqZWGTq1v0xtRt5qRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931010; c=relaxed/simple;
	bh=XlqJBdTQwt/OCV4IqVEN9S9dyn7uAAKXPCBm7yxu/yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ooo4AECsRZvefBbNYS2suYILWrZ7iTKwyG1Bw+oUxrJixLe1akivLeU4uDcS7/DLHD0ngXZw8+90CfaIR4X63634DB9QwiqThdyhjP57C+QrGaISw6VzMmco/D+zRjlss49V6x0S/7imJVsJm3tfqTzo4dxZw5gHfE88NAdZV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPZxZXW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPZxZXW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29DA1F000E9
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931006;
	bh=XlqJBdTQwt/OCV4IqVEN9S9dyn7uAAKXPCBm7yxu/yE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QPZxZXW1hCl0WLU0pV1Kkl4mf2U77UEpUDfLz+BDedPJAX9yrmJhHsAssf0OVvEcO
	 VOy/FU9IhlQFXce0xpkOYkR83vuDPlsjvoJRaD+HcC/2tnIR8v93xNd1G1l9CC4Goj
	 pWpNnoht/1yrkrTpu1SVGovxgOlNMx+lDJi/kIjIXU5gTtCITdgtO5sWRsxrJaUN8T
	 2/cMQ83QCKQmDBYiJ4wX8Wyqfh/x/XHgdGFHKzAbFpQkzKSZKVRbMo0I5WPc/iGRqk
	 DEq/qoEROy1HWLfiSrr46kuFLArLOh8A2BMISiqJ8bCN3t+rtTW2qNNZd4Y/CFLxvO
	 qjGOlozN4bTDQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so1111446e87.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 15:10:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RocHaH7ZD3EA7ueGmrzjhlxU64Q4r3gCEVv3kFAscOGj/v6jFatyY+WTQtjAblDr6hMBdZDIBMkxHPulIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5ffMrSQCEP/OoRTKDOuHybRzwZJGgAKJ0iwqOwIfvkvEbzuh
	Y5cJUKd8oZl6E8q1f5KL62vJqZIIkrXIxHNMFbI4iS+/B3y0yRMX0b7QAok95L6tJv00+r45tjX
	ANcu7bLLVv0fZhLS9PYZAXdlm+n/Ht+Y=
X-Received: by 2002:ac2:454d:0:b0:5ae:a9eb:c5c2 with SMTP id
 2adb3069b0e04-5b2b2f7f6d0mr1389667e87.60.1784931005641; Fri, 24 Jul 2026
 15:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716210813.2582826-1-hugo@hugovil.com>
In-Reply-To: <20260716210813.2582826-1-hugo@hugovil.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 25 Jul 2026 00:09:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLnzMEL5vauna86RgLWs1edcvE4YEddoBEZN9Gkc8XQzzw@mail.gmail.com>
X-Gm-Features: AUfX_mwJ19yURrtca8IRMTyQlGSAs9NA0_jacepCm48O-hgMI14ToQP2uAfi4_c
Message-ID: <CAD++jLnzMEL5vauna86RgLWs1edcvE4YEddoBEZN9Gkc8XQzzw@mail.gmail.com>
Subject: Re: [PATCH] serial: sc16is7xx: implement gpio get_direction() callback
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jon Ringle <jringle@gridpoint.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:08=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> It's strongly recommended for GPIO drivers to always implement the
> .get_direction() callback - even when the direction is tracked in
> software. The GPIO core emits a warning when the callback is missing
> and a user reads the direction of a line, e.g. via
> /sys/kernel/debug/gpio.
>
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc: stable@kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
