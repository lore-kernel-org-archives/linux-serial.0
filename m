Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26A3F8EB3
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762407; cv=none; b=Ae6cADAe0LDJt8aR45iCkH48zGRvtoNo+KmHGqwbR6cAY6lFNLb6Hi4SZKTu4Wrl15EULEOEYhvyhMZDsVkQzF8F1+IzpQF57Nh4u8RWO0w/KOD/I2GWSRAW3KW29cCk+Rjt5fo8sVJwz+ld9PfEI0a4hG/nBeTOr4e1458zvrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762407; c=relaxed/simple;
	bh=EfaOqUAKpuFYnsIVHOrJ/0TiRDwiEAdiDk5roFX7nBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jS65gYuiJYCPZ/gGX2WkLp1DM4736Aag/Rto7LWRTd6CdyAuwcxUMHRuaEYViAjBSEuszUkOtnrFy/uFyT+yJ5ddJAuDktmVcBbEN7GyroWVpWJchiTdMsYO5L/P3rReqEfjB/BCiv9NaJOQH1oup0/T6YuljGIsvjBoziIYek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muIFYUAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muIFYUAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A941F00899
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762404;
	bh=EfaOqUAKpuFYnsIVHOrJ/0TiRDwiEAdiDk5roFX7nBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=muIFYUABjvVKsuiM3VBK55HhCAl+mC0Uikqx4GPkxeWHxqibglMVZjsEthv2ZS+3e
	 AUhs7Dsb5LGjbHoWTADLFwi6PS2TUpgK3/78Xe8eMbUdKN539B2sJYH9aPU5Iz4Qy7
	 dOy8ABR4lDoPUjf2w4lq29/TV+Jabnsvm4baPAWqFCZHtGs1oSdU9ApeiXO6wwIKiq
	 d/eiE3Q0EFMLgqKhfEzFze6+2VxEFdqGVAVx8bPa+CdzAv+j59rjCpEUcp9T+ExYO2
	 K3mbINZW+Is+H0dic4Yv0CZbYYeAlCZEAkEOeWBD8H6PaVXghSyTHFPuf/eGSy4H+W
	 FvGcKLHCaVphA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a779b23f05so3047211fa.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 03:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByoCNF5ZPWYDy9d2Jj43LzinwN8JG0Cgh89mEMKCNhotgnIa+gRB2O6Mr5N78DW3kNTk+1nHAhf7rvzCW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGMDsmA2+1cZFQbQeqOYWmLivJ6ltmSfXiHD9d2cZr+ntILMda
	q/QwrS2jU+0IYKiE+YK9+8A/8NRqjEgCVoPXr1shea2HkAOkSHiTRyKxuzPgu3xe90/LQsO3QZ1
	uWGzGY5QCrCL6jsl0CVUmBFX0xFoo9dk=
X-Received: by 2002:a2e:bc1c:0:b0:3a6:6831:6e28 with SMTP id
 38308e7fff4ca-3a77919076dmr3451661fa.6.1790762403440; Wed, 30 Sep 2026
 03:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com> <20260930-b4-cs75xx-v1-3-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-3-4617c4463529@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 11:59:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLmqvjJUgFBtERvtkO_+=m60ag1UC-ZOAdo8_7X3cERKYA@mail.gmail.com>
X-Gm-Features: AclHuK_48zLXL0KDLF2JWFOLuk9UnViCs077-v6ZyB7fHZb2R7O5ZT3ShI4k8r8
Message-ID: <CAD++jLmqvjJUgFBtERvtkO_+=m60ag1UC-ZOAdo8_7X3cERKYA@mail.gmail.com>
Subject: Re: [PATCH RFC 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
To: filipp.dunsky@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:00=E2=80=AFAM Fil Dunsky via B4 Relay
<devnull+filipp.dunsky.gmail.com@kernel.org> wrote:

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>
> On the CS7542 the bootloader parks the secondary Cortex-A9 core in a loop
> that waits for an event and then jumps to the address found in a global
> software register. Add the "cortina,cs7542-smp" enable method for it and,
> as with the other release-address based methods, require cpu-release-addr
> to point at that register.
>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
