Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473C2C08D0;
	Wed, 22 Apr 2026 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841594; cv=none; b=WSMcl29dirEiO1ZR1k37xIs3ZmRr6zOmnZqeVjQD6OQS7E3gNiAaMxu8DVEgjcPwdZekOBs7kR0vPgtFG/yG1+6cO7UpqM37xJjJXriUPRIXI5RlYGcBiQuw+Novl2wCWPTyqLwWmrrVLho8RrDUN/6JkLEUprHBTafYoI8fdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841594; c=relaxed/simple;
	bh=s/4NNvvbT5+1meXDTAtsXuKvs/oS52CCo22GJtQKNQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZbANAD3Vgsd+Oh+JwwuKAqOHe3RsWCOpwVj2KCcJov0i33doYqn4O2d6RUvdWeixR3XKisQoFz5S9qf6Xr/6eOGZfirbhgzqyuETJLKKyUKi/F4ruocKh3ex2/kMjCW3GLX0n1OaDv4o6x+u3byZVtihkeZoMLuHNpK61rClno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K64fVnx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K64fVnx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722D9C2BCB3;
	Wed, 22 Apr 2026 07:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776841593;
	bh=s/4NNvvbT5+1meXDTAtsXuKvs/oS52CCo22GJtQKNQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K64fVnx16SQRlS4Mz4UJ7/0RCDVkH/6btgMbI7FAh2FQBBjQIUc/OzDaLVpUUm+TA
	 3tw5MUA+1uUN5X4bWep7PIlDZHSL+k4pJWYituxnZAwD4827mfEMsraCHBio9sW3XS
	 dIR9KNbheVIr72lM0z5QzH08K3vwgwenV1vDxru2TT0VU2eG4fuGjlHmB3HAQKxuT7
	 tEfmTQETXL9/EZE07kNovpUQEf1Jy8VXV5YAb+pRyQ8wpqqsMQiry1C5iLTASy5szK
	 JivJ8u0khCIO2nSntYi3XdZZMQ5udZ16c3CkY8AQ5O+y+PwIv02BJm/ihKg7RBL4z3
	 7zbfFXhmzoYyQ==
Date: Wed, 22 Apr 2026 09:06:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan =?utf-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, soc@lists.linux.dev, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/8] dt-bindings: arm: Add zx297520v3 board binding
Message-ID: <20260422-majestic-rabbit-of-jest-c4df6c@quoll>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
 <20260421-send-v5-2-ace038e63515@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260421-send-v5-2-ace038e63515@gmail.com>

On Tue, Apr 21, 2026 at 11:23:10PM +0300, Stefan D=C3=B6singer wrote:
> +maintainers:
> +  - Stefan D=C3=B6singer <stefandoesinger@gmail.com>
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - dlink,dwr932m
> +              - hgsd,r310
> +              - tecno,tr118
> +              - zte,k10

Where are users of these bindings? We do not need unused ABI.

Best regards,
Krzysztof

