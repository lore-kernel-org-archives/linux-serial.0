Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDD44BCAA
	for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749722; cv=none; b=EYK48WUU1M7rGqXqwvLOwFzSQiXAIVdfWQSpzjK+Dxjg9gWi3g4FDUiRR6FOIsavV1avpwKy8qDR+Li2rkGKhokYAkKgf4SYIZb1lTk+xgLPijJ4fpu8bj8/YsQyGhBSRTgEOvRJ62/Cs+Gu0b4tMMxnm8WpM047trVmtSObQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749722; c=relaxed/simple;
	bh=w6ZVnKbd/yP5ciQEeAt3KGcP1DU9DnB81w3BTQgoGHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mufv4gB8hOJG7AJIsB4yJymprueY9w87PYxDmeTz8wCGh24tCCLlpXqLwPitLTIUAZw+ieDrGujVRK0uKlcUahME9StVnBORI064sTIqXJVATr6uzk0ZAs6gYTKUt3Y0XYU3N01CIOpvO0CXk0VthZQ2F2dKBuTk9Hy0/RODPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJoazlts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJoazlts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A0B1F00A3A
	for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782749721;
	bh=2echV2TuUCorDUo3P+lP4EOwfZ6UxnA7Vrhb9+2po14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TJoazltsXCrMCTgucF9n2rj55ynbhFXimvamVNgnZhCjgNyjgNqGE+fB84F2BOlK1
	 Lhep4YdXesYdd4f+yP36ezAZZrT5O1TXql4Eq7vImX0an2xO5P3S37240UffBz51JH
	 F3OhdkIPez8rlNHeQchlruofSmheg8cfSA7hNy5fv1OwhBJmiJSLX8P2+qE0X45xRL
	 okDyyj6H7k7wo4fFTcbK9a7Sh+rJsQe9YgiHuH0jnIwIhNoP2+bk4RCNC0CnkEPhhr
	 lyayZgs64iOAznZH9uHM9q2Wokb0AxK7AQaTYq/Mwb3dFzVDr66xXJ8cp17sX3KN9q
	 710v1sBBZcBEQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1269e4721aso166301266b.0
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 09:15:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++H3BBtMx5re6RkRotZCKqMofBMRr1At3G5hYvzCiT+Ugzh5AklJ/PT7wZmQjxap5xsjwKtLSXstvLJd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmS0OMLL3nlmePzDL08u/GLBD31oVPlKeeLMw7LX00uWftaGRq
	Ot1z1UNY0AN/Lt4dLaENnF6iTGLmM6Voq3pUmBQtAyVWSYFhXDQjnRVL5M9lpq7hWMPCGjYZnEp
	dipAVRCRCdqpx5UVk5s5sSIDXH13msw==
X-Received: by 2002:a17:907:1c91:b0:c12:58ac:9869 with SMTP id
 a640c23a62f3a-c1258aca1b9mr349323966b.9.1782749719747; Mon, 29 Jun 2026
 09:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de> <20260603-rust_serdev-v12-3-3400ffb88b12@posteo.de>
In-Reply-To: <20260603-rust_serdev-v12-3-3400ffb88b12@posteo.de>
From: Rob Herring <robh@kernel.org>
Date: Mon, 29 Jun 2026 11:15:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJEqUbA8t_01E+QBbsfdV6JWKGJPhEQMD7YKPKYk3vYuA@mail.gmail.com>
X-Gm-Features: AVVi8CfhB--Db5QbuVKNGlVOJyT9ymFkRQjZNe17XqY3kKJM0r_8jlarJXXYsZQ
Message-ID: <CAL_JsqJEqUbA8t_01E+QBbsfdV6JWKGJPhEQMD7YKPKYk3vYuA@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] MAINTAINERS: serdev: Add self for serdev
To: markus.probst@posteo.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Kari Argillander <kari.argillander@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 10:56=E2=80=AFAM Markus Probst via B4 Relay
<devnull+markus.probst.posteo.de@kernel.org> wrote:
>
> From: Markus Probst <markus.probst@posteo.de>
>
> Rob mentioned he needs to find someone else to maintain serdev.
>
> Link: https://lore.kernel.org/rust-for-linux/20260430195858.GA1650658-rob=
h@kernel.org/
> Link: https://lore.kernel.org/rust-for-linux/da85ceb81f51079d4a8248a1ffde=
6a27d2ef24ad.camel@posteo.de/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
