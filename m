Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742533750BC;
	Mon, 20 Apr 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690043; cv=none; b=tNO1A3I24VOzm40af2Z9MSolUh8CWe0H4FRQWheGr399fzN4J2AZLw8Yo4MygK0IxtiJmAfw9RfqHIjs6n1QjEYQQ5Yr9FMbMT+Q5i5ygzvzuS2uTMK1gDSy4AOpM3vbnGaxha7mipZXLCunFkeicruNU8edPiKCigJvn1X1Aho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690043; c=relaxed/simple;
	bh=tUC2t9kCbTutWnz6IuPE32rjpeccnNIrpMgaz4pD0xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBcDMRebU4+/48oQlWZ6W0sECtKC5wdFqV443NiHc0RsOOKmI5Uf26AO2KhhH66PAoSBL6uplOno6KWfgrKkMt6/rk9cBny6EecpJ1qHO3wPXsTrFUtptBJY53eELRjvwsLz+6VkPM13M+gJHXWTLrErVBIuqb4WXRxiZqRWGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlVcalFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlVcalFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBE1C2BCB4;
	Mon, 20 Apr 2026 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690043;
	bh=tUC2t9kCbTutWnz6IuPE32rjpeccnNIrpMgaz4pD0xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlVcalFzn0PvL+6InUzgqSW+//qTjGG/EfiW0TS8x0zIGJ4uAz3KtlCEIdTY72YTy
	 SATZbU4nIdedKAryE4IKUikbt2UpAV670DGv37zi22wOPDSq32Z0Zdb/vPQOAHhV7L
	 R35f+tkpc9jcihD1qrfP0TKz+3uJDOYMmGiwmrFTnnSqiFNSetkcePBGG/xKu5LGnu
	 asbzNN9TTZLZUbSEsaJ20Fz2H0Z2/jWZQogamuUR9uXs321B0epvjSiYn6Dvex523d
	 fVOWm2enR6PxWJfmlCw2CuN/R6tbyJzFVc94nrBqhpt1kLO+3wVyNbmb/1ps8rY0Q1
	 wlb+04KJisEeQ==
Date: Mon, 20 Apr 2026 15:00:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan =?utf-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Drew Fustini <fustini@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, soc@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-serial@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: arm: Add zx297520v3 board binding
Message-ID: <20260420-blue-parrot-of-spirit-2b5f6a@quoll>
References: <20260416-send-v4-0-e19d02b944ec@gmail.com>
 <20260416-send-v4-2-e19d02b944ec@gmail.com>
 <177646012448.2165534.5760108355183774935.robh@kernel.org>
 <6264667.lOV4Wx5bFT@strix>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6264667.lOV4Wx5bFT@strix>

On Sun, Apr 19, 2026 at 11:30:04AM +0300, Stefan D=C3=B6singer wrote:
> Hi Rob,
>=20
> Am Samstag, 18. April 2026, 00:08:44 Ostafrikanische Zeit schrieben Sie:
>=20
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
>=20
> Here is a new PEBKAC issue for your mail template: I ran dt_binding_check=
, it=20
> wrote the warning you pointed out, but I only checked the return value - =
which=20
> indicated success. Which I guess makes sense for a warning, since there s=
eem=20
> to be a few preexisting ones. The warning itself was somewhere in the=20
> scrollback because I let dt_binding_check check all the files.
>=20
> So I learned I have to actually look at the output to see if there are an=
y=20
> warnings.

Same with every other tool warnings, like compiler warnings...

Best regards,
Krzysztof

