Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9C2E7165;
	Mon, 12 Oct 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788388; cv=none; b=mWBmmPIYa6fWSaURAurON88R1AnbpayQ3UkqudzyXzcOsMm1brNw88hBiAem0MN+myL6u+SnYIoYgajpzso8+81wwQZtnZCRrzPD83jmHDq4xxu+mTQTfEafzsO4tfh0FkSRb6BOzNfuXcnpX/JWYra+07oUp2U1goSQJgKSY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788388; c=relaxed/simple;
	bh=VzyvvPNRfhDYx7bnHqYlO7KX57d0lpUSL7huv+AzdTM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ldm3yqXFfxRlPtZsEwKqmD4TDfwoFhwTLJc3EPH+j8Pfg2htQn8fnuVobfX9XtOd7qu5r/fCWI5dZrb1QNlpTznIEiurr/sz9PwcQKrDxei4BF7FKQN5niLDA9x1sVBC3owf92EJ8haHrwPyk0+dfZCRTndXrnLmx5ojW9Swsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OORtglse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OORtglse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B301F0089B;
	Mon, 12 Oct 2026 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788385;
	bh=VzyvvPNRfhDYx7bnHqYlO7KX57d0lpUSL7huv+AzdTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OORtglsexLK2kaL4ZcXur9Js+rfFrYDdrNQfZMQwJJHOqoBoT9eaaJTeNxlGW8yde
	 p6frVPT1uF9L8CMofPaXdm0/j6fBrk/7dHIMBpg9y5FqRiQj+s2Lkkud+jNoeX2/Hf
	 SpB9E5jiqHwNEQ84asIgmX2RDijZIeCMLEDhjZajsCfS8ZGbCNRTNWSlkcFv/Z4YVn
	 /GrDEYCXyDTd1xKpfBLY6hXZW7L1FL8Vn98gZzHlBHg4VhzAupxATziD2HRzm+SAor
	 WPCwSC0MnrTJ4DkGtydJXzEd5Iaaf7t9JTv6Hj5l2+1khmRMsbOgMs5suPafH0YAkH
	 fvfZaHLaiGZ1g==
Message-ID: <sashiko-outbox-167760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 01/10] dt-bindings: vendor-prefixes: Add Securifi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-1-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-1-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 06:59:45 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
> Add a vendor prefix for it.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v3-0-0e0d17a098cf@gmail.com?part=3D1

