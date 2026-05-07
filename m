Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931523C6A5F
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156691; cv=none; b=afom7xtimmizU+PWG5PyaNb3z0GL4Q/cvMvX2meffA4x6guEuElnHAw2U/IIqv/5DcRHEHW/yYMjf0lY4HaBSIedX8+JxgFDi5T1uvTflJY5JccCm8pPraFbLgJhcynC8wLRYqsEXZpa/G88W5DrR9xHE2YpGjh6NU2aN7K774s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156691; c=relaxed/simple;
	bh=QIql3ABFxBxfhPdKS/rwS+nEJrZPiQL67AN4+VOVMso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3DsFOpdtCLFArh+yTFBTmv8gr8zCPeeF5MRKqzN57h0r5KjXcLzokHclgHaDStZ2hGYWzguBBO5LJ6S/ZDawNJtEvw7Begp/k+lrqF8Zj99cwp8HAHM9L5gBQ3IcoFEh3J4xlF1d1H4Gx5SIH8C+Av8pa5YU0EiPII10sO6QXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKv5nDNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKv5nDNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AB4C2BCFC
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778156691;
	bh=QIql3ABFxBxfhPdKS/rwS+nEJrZPiQL67AN4+VOVMso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RKv5nDNm8HFBZ/inumudOz8bq/9D0RjWYEYvjZAonv+XeRXE/imJ8Qqy8AMlTq2/3
	 hiTSyhuBXJEe1/W4ad2WCVpo4YydHtCpkviJfrU6xwIFA0JwyxqjujRuYf9M3mFfgZ
	 7lIZdnr+Z9aOWGtutXOFLo+ub4pk0mUe+JTqNPeyDm3eQ0h0l3/SSNBuMpfIGRw2AZ
	 6y6nh+Yf/G0uWxYfAZHMB0VBhBoP2DzpehNT3YjR87Ei7luHPc5avzFuwBUeFTcsPc
	 /kJgYH0QDk4OdOX+6ZDX7xLOdrnY8yxTOwqZz+ezUcEyuj0XEXfELugJSPs4IQyjWK
	 5chGoE6TbBt+g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso735834e87.1
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2026 05:24:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+F2w6sRC1JpTAz/r2si1C8BGzX01vbLUDUMCgwiMxAZrc/oCbxrh8sCoPVYNN5BIQSBAKB4pQTxtMEVWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAT8mWcw6nhvq2moMZ/ybkx0c92A7q2SzQBX8bkJffcAl/5FgX
	qTFGN+DmHHjO9xZSoY+Y/XgKYX/vOEi38+riWfdqL2tlQPwelo0Rt1g3sBOC8anVVAmp9Zbqhqf
	+hTQSCBoEJOv3mxEFXtNQQE8iZ10u2jk=
X-Received: by 2002:a05:6512:3c81:b0:5a7:4783:a13a with SMTP id
 2adb3069b0e04-5a887adfe0cmr2797785e87.6.1778156689988; Thu, 07 May 2026
 05:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-send-v7-0-b432e00d2db8@gmail.com> <20260429-send-v7-6-b432e00d2db8@gmail.com>
 <CAD++jL=S6DSOuC-PXFn76SA7e-Lgueu9Z2wuF7icXCVX7MBpJw@mail.gmail.com> <5379905.31r3eYUQgx@strix>
In-Reply-To: <5379905.31r3eYUQgx@strix>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 7 May 2026 14:24:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLk02QnkXYwJ0b6x=qw9stR4nPrjD3sYPOvWAQz8t9OsUA@mail.gmail.com>
X-Gm-Features: AVHnY4KG1i7F86ysxgeSAop-bGeT8IWW7pLynGDyGg64qsvOgzwotjy6zksXjl4
Message-ID: <CAD++jLk02QnkXYwJ0b6x=qw9stR4nPrjD3sYPOvWAQz8t9OsUA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] ARM: zte: defconfig: Add a zx29 defconfig file
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, May 6, 2026 at 7:39=E2=80=AFPM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:

> I'll send a v8 with some of Sashiko's (very impressive)
> findings but keep the defconfig.

Maybe not send all patches to soc@kernel.org right now because they
end up in the patch tracker.

For a new platform that may be OK though...

Nominall it should be three pull requests:
1. Platform
2. DTS files
3. Defconfig

But in this case maybe it is better if we cherry-pick them to the
SoC tree.

Yours,
Linus Walleij
