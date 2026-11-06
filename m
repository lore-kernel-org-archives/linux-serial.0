Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969931;
	b=h48rPLqluF/jpG7OdUieqbzbugKxTvgC3b6Fgs+414QATPGpbM1X2AdGfbQzC/FlmkQQ
	 wqJrATsgHB4U6K8YUh02jFa6+gqvrGaMLSjVuYh00WvvHgHPs4qzafU0KPaPwUDz4Nsrc
	 x3l7s7dXC8LTbTlwePJP8TF4wNwfgYG7JtjXyfQmuDGWxmC7YBluicdCcLpvUSpkEfrUb
	 xA9x4zeS/b0aHtg57rTJMqM1Eg/cy1k4QP7+LAejsBCfkFIxddtkngk+ssUVVScqhc0zO
	 s5dKfUTkQJ+bFOGkJ3u8pyKvqgN21MrK1Q5NGnswpd91Oiej5NTEAlsll9IjjykOJBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969931;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XJIrETOCNOaci1WGCReNLw2o2zCqhBZbAKF0An0JnZI=;
	b=tULhPZTJU41O83SaVicGeBGdQmtmuNwonlEuTDlQz4V85Zdhb7c9HUCX0W9gPQAeJuk9
	 4X/1ri/CL+H/1/7aTIT/UdKrPmVr/NF4OiZ2jwIF9BTixCoLOrwDOWcQfkEtk/Z898U11
	 q6a0ZLj3g3dw26pNMC+859tUrLkjC+iwLC1A7S2rJFlkbt6d17upCr3TLQbJOSyKPbhYH
	 FUkcIEiA1spX5zvj11IC8+TRtN7M65pR6dqk4opYuK180ye/GQjxCAwd2e+1T7awGEbuw
	 johZLonQnuG8EOT9/BNDFC2oC5zrLrH3XMmI5RSub+WoQY5pEqfLtpgXD2lCpyvelqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmy0PAIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645D606A329;
	Fri,  6 Nov 2026 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmy0PAIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6B91F0089F;
	Fri,  6 Nov 2026 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969931;
	bh=XJIrETOCNOaci1WGCReNLw2o2zCqhBZbAKF0An0JnZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bmy0PAIc42UjJ5Uq0ToaYg4Xu7D3Uw7JSbUk3GivPPWhS89b0+nGoHwyEMMRSnT4d
	 irCdS4E+6enAOtJ5kJilWo3sDKWIpzpNhEkWQWpB565uwb6gh8NgmAR/4qQDzQ6qNM
	 /p7AiRmrAcYprswe74orB0qYDiROcWXgGBLKDh5h2CQW5O3hx9hECnMarkA7/Y5Lqd
	 ONCmREDrI/A6y5U2jtkNN9j/ARCGWtRXRlXeR34I4/GTHBBf32leRjoc4xdtn9JFtD
	 tno7z6Fq6n8hN88T/Jxezw7Q8Kl8hB3QnLRmPs8y0+poxOE0fO0fRIrQHNK7pGBJr5
	 tHP3s43bHjDyA==
Date: Fri, 6 Nov 2026 13:58:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, luan.r@variscite.com, 
	alifer.m@variscite.com, pierluigi.p@variscite.com, 
	Stefano Radaelli <stefano.r@variscite.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Johan Hovold <johan@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
	John Ogness <john.ogness@linutronix.de>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: serial: fsl-lpuart: Allow
 wakeup-source
Message-ID: <20261106-bald-cricket-of-hurricane-5ef4a3@quoll>
References: <cover.1793719239.git.stefano.r@variscite.com>
 <51b4d26521bf708d7f74f0ccb49fbe515d673ae6.1793719239.git.stefano.r@variscite.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51b4d26521bf708d7f74f0ccb49fbe515d673ae6.1793719239.git.stefano.r@variscite.com>

On Tue, Nov 03, 2026 at 04:51:25PM +0100, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> LPUART supports waking the system on receive activity. Allow the
> wakeup-source property to describe ports intended for system wakeup.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

