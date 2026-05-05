Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84016324B2C
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974882; cv=none; b=oOZ9aIaI98icmQf8ue/49CKbRqO+okIlHFnfryzdiYsAN4Bf69ys42jBXOEJOw9/tDwLHGqEar/ICvDM4aOC3YAWWiqJ3vKw59GLvyciIke//guM1LT8R9bUkYbVtdjYsuD18I/IEWygeddRYjAdgtfAwLfHfKMW1sRNiymlP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974882; c=relaxed/simple;
	bh=PxaH7JEkFGR4j8g8WfN53Ub/nYRVGDBMMmwqa0ku9Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wkoc3vh+SxkL/dIcQUy8dFROim7JkOt0h+++cQKOb2s/rU6b0Q585claxZcBJc4C+iOA8Xtqifhv81BA6mXHJdUbngQEW4AyQh1J97zwJBCbcT8VciLpigXyt18eBmaejsKPi1vHAp02Pvu0+cunHLIOi7JLmV+adx7sbNvvrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyjhw2Ld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyjhw2Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A43C2BCC9
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974882;
	bh=PxaH7JEkFGR4j8g8WfN53Ub/nYRVGDBMMmwqa0ku9Ro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iyjhw2LdsncUd1w1Gr8k+i+Ps+3e6h+F5hs6sCYhAgbXsbEr+/plWEpJaqyz/FbBs
	 1HCmosWthE/mVgageM08fXD2GUvFqOdVDMjvAHAQ2QOhIP9RBHchcXjDrXgj8dy3PH
	 br2eS8SqFwFJe0hpo+HJ3WTxVxWVCeiEbR0FuLoj0IkwMvKyr2rMo6EDrhN9ZovemP
	 poWZMvVlY+UFVCx8UzuWQfve7XFMLdU79kAHcZ90xTa970ioeO7GozL0H1W43oNGY1
	 HtYKuD/hhX5Ka8QA9bnLnAK+zytKsb575CazAjxo6VdrC4HwZLoQnKLoI1S7cV272O
	 PkH4A1kq5vsVA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2b636b944so5160892e87.1
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 02:54:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ATWURZMnpYLZYKM8wPg3aps3C5F2761QuWaALPJxwLZEINS7XaID/SLtoySRKOh5/sU7rVr7CDqyCLFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaxj6CdbNWB0MebouApYeeGSFJdGP7TAdToRv+r895H4QNrEUM
	l9IvDF+rREmgYkdDs3DB6zGmkLrr6O8iCDiG/xFi1Q3dR2A75DB/TA3GLWmgGVGcX60aJ+5l5O9
	XtdKq1kMLsA8LG5nTPpURDIdeOI3z5nU=
X-Received: by 2002:a05:6512:31cf:b0:5a2:bf50:763d with SMTP id
 2adb3069b0e04-5a8631c8222mr5342230e87.38.1777974881162; Tue, 05 May 2026
 02:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-send-v7-0-b432e00d2db8@gmail.com> <20260429-send-v7-6-b432e00d2db8@gmail.com>
In-Reply-To: <20260429-send-v7-6-b432e00d2db8@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 11:54:29 +0200
X-Gmail-Original-Message-ID: <CAD++jL=S6DSOuC-PXFn76SA7e-Lgueu9Z2wuF7icXCVX7MBpJw@mail.gmail.com>
X-Gm-Features: AVHnY4LKgP4azk8C0fxvoRTN_Zgf5-T84OtwL-usSAdLEb83x0Y0BnN24IkSneU
Message-ID: <CAD++jL=S6DSOuC-PXFn76SA7e-Lgueu9Z2wuF7icXCVX7MBpJw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] ARM: zte: defconfig: Add a zx29 defconfig file
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

On Wed, Apr 29, 2026 at 9:14=E2=80=AFPM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:

> This enables existing drivers for hardware that is present on this board
> even if it is not present in the DT yet.
>
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>

I'm in favor of this, mainly because multi_v7 is pretty useless
for this board, it is absolutely too big to boot on the machine,
the board is odd and need some ARM64 stuff.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
