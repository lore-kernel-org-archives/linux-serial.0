Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E41DED6C
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117784; cv=none; b=QGX0VfZfXXYVY5WJBOJm5Rj1SJcmQddbdBEgqqeUBVwXXSYRYu0IogLGpHYHPtk3jAgy9eMd4cV32QEjk49ND3HuGuI+HP2KN1VoinSbACT91FDDKqW2njMmOKlddnvvPgfvruiSiG9fKKBxQ0qtpIfv3sdIr5Q0o4yd87k9eVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117784; c=relaxed/simple;
	bh=Bki+efw7o+OJmQttS7uN1v4hC2NHRP2+KSFCIgTTpLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7uzVkmsZaQwA2pBB21CYZusuG2RoGp6nUwjVmRVZO/Iw2SUP6R8hXXyMFO9Km+log8yFOLeNhLHxDCdxwZ1J5UqHEF5omVxEHrjp0hBjC+yKRe5tws52R8mW0NSq/saJNSjJl9q8cUaZ0R0AX4LFkV6nSqm1rGixHYYsGe5Zcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkjv6lmu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkjv6lmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F03C4CEE7
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744117784;
	bh=Bki+efw7o+OJmQttS7uN1v4hC2NHRP2+KSFCIgTTpLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tkjv6lmuWPZIi45Q+VrEztPd3yW9GKSbwlr+o+isedwKkwcKUMz1B4fCyNV/ojh0J
	 9DJauuyrxafLu7N/zUlXet2A8A8CVtuajdCivQvsNXY3Ie2jbfKUr7iYPll1RRw2q3
	 PVgVfDaoXWFbJfkB5BzjX8oOk88Y59Z/If34f0Ic0j3yN85GTcO5YkMw5uHe89FDrK
	 LcUzJ6RXsSXZSPC8ei/zrOFbctQfvL7YvABDog9NrIwbn74+gPBflzkYzISQP2rgXl
	 mcb9g/Cr1livF5Ir7yasbkdfBrk3Ec0kaxK7t0RrEEu3YDu/lmXtIWaowyYePKxYEr
	 m1ZY8snCKJxGA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so9196865a12.2
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2025 06:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkHQX+etVPDs5kE+24ca7vQRGcHh0ZnxHfPR/IK/5Em+qjp8BgzV7IwixXO6GfwNCsOneIPEV5MA+mRDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPr0ttN4Wqeq7tCH9AIwrnMxxrZMnUH3VwLfbVIFwOmnmyxGgV
	p5L7muhOxZyzZ+wzrF+fXIvGUpgWn1uQBRgj0kWrd5RbDp5EtAm9aPj77hMgeR4iGYLftEwGFvI
	DSPXQEszIxtyIRAc3/Y7RHDRwAw==
X-Google-Smtp-Source: AGHT+IFRR5xtpSdPE+zcNnNBbdPGiHBWHs0r0C+NXUhFlB7+WmTr+8S76Ku54cA31lz4/HqE4cu6VGoJevyLLNF9TLw=
X-Received: by 2002:a05:6402:3548:b0:5e7:b081:e0d1 with SMTP id
 4fb4d7f45d1cf-5f0b5d82c83mr15704600a12.3.1744117782479; Tue, 08 Apr 2025
 06:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213143430.3893651-1-loic.poulain@linaro.org>
In-Reply-To: <20250213143430.3893651-1-loic.poulain@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Apr 2025 08:09:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK+qpy0oUWiLHvQOetv4h-FQyUjim0xD8mN124pU_zk+Q@mail.gmail.com>
X-Gm-Features: ATxdqUGi4JAR1Dig7Yoob8Sp4WaeyyZgiGjLOjcnObUOJTWdQW3IztczfCV9h68
Message-ID: <CAL_JsqK+qpy0oUWiLHvQOetv4h-FQyUjim0xD8mN124pU_zk+Q@mail.gmail.com>
Subject: Re: [PATCH] serdev: Add support for wakeup-source
To: Loic Poulain <loic.poulain@linaro.org>
Cc: jirislaby@kernel.org, gregkh@linuxfoundation.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:34=E2=80=AFAM Loic Poulain <loic.poulain@linaro.o=
rg> wrote:
>
> This brings support for dedicated interrupt as wakeup source into the
> serdev core, similarly to the I2C bus, and aligned with the documentation=
:
> Documentation/devicetree/bindings/power/wakeup-source.txt

Don't add new references to old documentation.

The difference I think is I2C has some defined mechanisms for wakeup.
We don't have anything in platform devices, SPI, etc., so why serdev?
A "wakeup" IRQ is also a suggestion more than a hard requirement of
how wakeup is implemented.

Rob
