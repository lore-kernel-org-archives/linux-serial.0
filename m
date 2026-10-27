Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099518;
	b=JVb5IqpMPB+ygXKrk1R1RDX46Xvv77bJqaZoU4dRqbHgZ2Q7HyPL776/K8GsAUDDVRLR
	 hfbKEiHT1Q/rE0eKAeomYzupz3oTeWafmGcJwXlVQvNcWg520rySqCJIGJTyvS+7KMkE+
	 nNec+dEgd1KvzKE6th10sojF3d/L62LhAt0PImCLgUu2X5ylBy6DPNrF6EOD6Uj9zSZq7
	 kVQ7hLnKV8jplXE858NriqtJLg7PznDrSwKCsXD6U6+jzHtETQKQi9WoVA3ttuPD/ouS2
	 MtZrYKpKQs1d77RqOQMi7UwZdHLARxg4geP4m5wlb6gbfUhtdavcm2zaMfblWCQgn0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099518;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MziFyfaCRHmzuO5Z+LBp0WgrdHZ9mJgVVfwHjCjUIrU=;
	b=QXgk0ir2mDXaMVI92lYPFvZrogZ15uBckH5/S+5u9V/j4oh15aWpEsF/rYpf+HtC/VQk
	 wKpP2eCTUJ3UoiPx8VPSXbQTVChf9Xaklsb0A1zu8/g32f2ot3nZplDaluOYnw7O9FA86
	 Wdmi7CcmiHORhGKYhz4rMrSm+jXqH6KMPhLzEetzU2o341mYrbcE62dmqlI8awZZdBagh
	 XTv2Is5VEV3mfuGSi36AgVKHBXWFGFsdiLEbqczKwWInhOo113eUv2f9BhpBipekJ9iGX
	 0YHGmXtKiQXGtM8XzSl7FBnE8Zig5FQBTRo636OWVq8Xyl/cvLMD4HaondOpPs12eVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Si8m3p9N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107D606A321
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Si8m3p9N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6029C1F01828;
	Tue, 27 Oct 2026 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099518;
	bh=MziFyfaCRHmzuO5Z+LBp0WgrdHZ9mJgVVfwHjCjUIrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Si8m3p9NgRppTRkXiDmhHkUmzfc1VyjghbQkcOBAU5ArSIYij+X4mrYybURmOGuyM
	 FnTL5eyuNBkLYG8bcSnQ1mDGSmJjQI9m4wEg4Oqh99/5ub2LPhaIgTB5x13bBII4kB
	 Wm2+soPailONNhV6pSL0/FwCXzQpKl3PxlzeEenindVK1pyVi0R+qpIsGl+S4VkvJo
	 4j/sfwAWscl0hb6WUexS1EGircUEWpfBBUm22QuUd1ccyA0zMU/Uaw9XciJf7X71SI
	 XPUBr5R/YCdRlNgNw6VenX/VBG44Jw5TAmZAISUHTViglsVLr3gmGnbsFKG1YStn9E
	 57Qf6CA/5f50w==
Message-ID: <sashiko-outbox-186416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/24] serial: fsl_lpuart: fix tty ref of wakeup event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-18-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-18-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:11:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> To report a wakeup event, lpuart_resume_noirq() gets the tty with
> tty_port_tty_get() and never puts it: each wakeup by the UART leaks a
> reference, and the tty is not freed when it is closed.
>=20
> With no_console_suspend, the function also gets there for a console
> which is not open.  Then tty_port_tty_get() returns NULL, which is
> dereferenced.
>=20
> Fixes: 18bdfccf3c30 ("tty: serial: fsl_lpuart: Add missing wakeup event r=
eporting")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
> Cc: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D18

