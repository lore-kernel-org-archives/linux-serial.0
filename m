Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140829;
	b=c10QoMykjAutul1Qwdl6o0D6p+laoULhRtztbhIYr+gobQDdvRilnxXdppzJkXxrkhen
	 fkahAGxapewdpKcXQ1GbOCgQdFigY6csB9+nij1JmBmLACcb3m3eSSOoDlqzjv0OL8gLF
	 f68F2MZIy+zrS7pnoNOAJVKXeopz+fAuvcReZFO+qdlMss8QI6yTBewiFSNbFlkwZmIt7
	 2k/tootilRlsP5l3cLdBgpWcciQsWdRF+e/YvPiTGTQ6EqFgRa0BPvumEUO0wFLzW6fiM
	 n1muhF+q7DWeKp2d12bzxIA6IctRVsPn94gRldC92KYKZ/yfsNbpJUwJdBjaLzH0cag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=80YuNoiLYzeYuqTx7CbDOCsOUCcJq50vLqiJKxIoxX4=;
	b=qlrViAt5liUSmLxTcxfYl6Hrd6IKbR80zcgejYkEVjZhLoV1et/ZEi9iJL99/NRiqrBC
	 hxdmdBL0tChXAc7GMJeefO5mN2rZndEVm9aYQEFUlKGk8QJEe8VsHxGkzTPdyvcRlDMMW
	 EJfzvrz8IiQ1I8NRZQBV1b0TtKA8jkl7jkYSLIafzS15mQzscIqc8vtCTchmwxRtYXGrW
	 oQz23/HyM8llnsGpjFK7N8HKrY82y5X+FAw8wIhIDq0ZFDtX91eSirg4X6ips91ONWs+0
	 gYsH7arnrrZYq5c5lGhSNpP00Ccy23a5YPLpjD7qfLQnPjTu4SGNYzBdoGbcbXjmi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnPYStJ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D5606A31C
	for <linux-serial@vger.kernel.org>; Sun,  8 Nov 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnPYStJ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CDF1F0089F;
	Sun,  8 Nov 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140829;
	bh=80YuNoiLYzeYuqTx7CbDOCsOUCcJq50vLqiJKxIoxX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WnPYStJ7r+ktJf2usevrGusRIdzpAozjjYp2dvG43+VCPL1cyDXG1tZAqBPg7qaeh
	 49MfmvhRO++/f+67CoZ5Olak9I4vlugElkKhnMHpctuICb/lOpc5gCskFNkbZ+zfPS
	 mCeqCcNZeOkPqO/fTvvUVCsWLUS/4ht0YmN84P/fseqv4CETIeZUKutJwopDMWk7Vt
	 SWddgOwVnJAjoy0G1KTiNWW2DEf+iWcPyvRNYf9E/cCAJdlbRLGkOmNtRzouJ/QtfZ
	 qKwOzkI0AO3LKazonFb4XsDiCNW8sbTgwtr9XrK1e4LZd1rTuEGYiwDjnaOn/ce4Kd
	 5rpxrksxzHMrA==
Message-ID: <sashiko-outbox-203729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: vt8500: Use devm_clk_get_enabled()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <1794138380.2883200.vulab@iscas.ac.cn>
References: <20260917155834.2161361-1-vulab@iscas.ac.cn>
 <CABjd4Yy-9A0xWCDfZemHOTZDrDdtdO05nUjmN=w=sLwYjzZn8Q@mail.gmail.com>
 <1794138380.2883200.vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 12:27:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] serial: vt8500: malformed commit message and missing
  Signed-off-by
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] serial: vt8500: port index leak in vt8500_serial_probe() [1]
--

commit 8b3881e4e3251512b27bf8982412d7a23856190f
Author: Wentao Liang <vulab@iscas.ac.cn>

> serial: vt8500: Use devm_clk_get_enabled()
>
> Hi Alexey,
>
> Sorry for the very late reply. Working through the review comments I got
> in September has taken me far longer than it should have.
>
> Your suggestion was right, but the leak fix went in before I could act on
> it: it is commit 9d8955281d92 ("serial: vt8500: Fix clock reference leak
> in vt8500_serial_probe()") in mainline, and it kept the clk_put() you
> asked me to replace. It has been backported to the stable trees by now as
> well. So the patch below is not a v2 of that one, which would only resend
> something that is already applied, but a follow-up that does the
> conversion on top of it.
>
> devm_clk_get_enabled() gets the clock and enables it in one call and
> registers the disable and put with devm, so both the manual error handling
> and the clk_put() go away. Probe now returns the error code from the clock
> lookup instead of a hard-coded -EINVAL, and the clock is released
> automatically through devres. The success path is unchanged and nothing
> else in the driver is touched.
>
> For the record on where this came from: the candidate came from our static
> analysis tooling, and DeepSeek and GPT-6.1 Sol were used to audit it and =
to
> help write the change. I reviewed the result and I am responsible for it.
> The patch is build-tested only: it compiles cleanly with W=3D1 for arm
> (vt8500_v6_v7_defconfig, CONFIG_SERIAL_VT8500=3Dy) and passes
> checkpatch.pl --strict; I have no VT8500 hardware to test it on.
>
> Thanks for the review,
> Wentao
>
> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Wentao Liang <vulab@iscas.ac.cn>
> Date: Sun, 8 Nov 2026 11:41:30 +0000
> Subject: [PATCH] serial: vt8500: Use devm_clk_get_enabled()
>
> vt8500_serial_probe() gets the clock with of_clk_get() and enables it
> with clk_prepare_enable(), so the reference has to be dropped by hand on
> the error path, and the clock is never disabled or released afterwards,
> even though the rest of the probe is devm-managed.
>
> Use devm_clk_get_enabled() instead, which gets and enables the clock in
> one call and registers the teardown with devm. The manual error handling
> and the clk_put() can then go, and probe returns the actual error code
> from the clock lookup rather than a hard-coded -EINVAL.
>
> The clock still stays enabled as long as the port is in use, so the
> success path is unchanged.

[Severity: Low]
The commit message contains an unstripped email reply and embedded git
format-patch headers, and is missing a Signed-off-by: trailer. Personal
commentary and build-testing notes belong below the --- separator (or
above a scissors line) so they do not end up in the permanent git log.

> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt85=
00_serial.c
> index fc6fdc751b167..73922523dff64 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
[ ... ]
> @@ -647,17 +646,10 @@ static int vt8500_serial_probe(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(vt8500_port->uart.membase))
>  		return PTR_ERR(vt8500_port->uart.membase);
> =20
> -	vt8500_port->clk =3D of_clk_get(pdev->dev.of_node, 0);
> +	vt8500_port->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(vt8500_port->clk)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
> -		return  -EINVAL;
> -	}
> -
> -	ret =3D clk_prepare_enable(vt8500_port->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable clock\n");
> -		clk_put(vt8500_port->clk);
> -		return ret;
> +		return PTR_ERR(vt8500_port->clk);
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but does returning on error
here (or from the earlier devm_kzalloc() and
devm_platform_get_and_ioremap_resource() checks) leak the port index in
vt8500_ports_in_use [1]?

drivers/tty/serial/vt8500_serial.c:vt8500_serial_probe() {
	...
	/* reserve the port id */
	if (test_and_set_bit(port, vt8500_ports_in_use)) {
		/* port already in use - shouldn't really happen */
		return -EBUSY;
	}
	...
}

If devm_clk_get_enabled() fails (for example with -EPROBE_DEFER), the bit
in vt8500_ports_in_use is never cleared, so a later retry or re-bind will
find the port still marked in use and fail with -EBUSY (or exhaust
VT8500_MAX_PORTS for dynamically assigned ports).

[1] https://sashiko.dev/#/bug/linux-ca000721-4a5b-4d88-bdb8-7f1e438dc81e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1794138380.2883200.=
vulab@iscas.ac.cn?part=3D1
