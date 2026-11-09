Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209494;
	b=GQWFjpXQfWxnYsvphGiMr8YZJiNAVjTznleTFOTV5z8r1OhyTbotBr+jaPHBP+sKla9A
	 VPw7sPqA3Lm5AV5ICtOOwb2i6GmEcNYJGQ+FlC7B3s+HvOrRt0usJJIGT+j/4qz9Tj9mY
	 ZRdhJA/BcQWCF+ZZQkoR+we0mC3QtcpSLnjQ87gzQrLKHSZeToQOtPxEA+pE6wBRD6gIl
	 LbuJ1uxvI7N8TJRURCXndIO7CeZ+n2Li+jjJoqylFskXTNgEGiNyeWrfnnrJUdo/6blys
	 Z+t0Fr67A6LkjCujc4jaISN6PdwtOX7OpTujFXySoT0kGS9ogH7oDcsl9BlYZD/NWSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209494;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uHpDt5Z+8RB/vw9lOlSwwBYSg4hXZcK/E1hxVO38o4M=;
	b=vjbthAKxwyuIlQZZgaXauqvpCxiK0Uqu4YhqvH1VkkH1f/J+U/+hn8TsDl/a6pq6x6Ar
	 EnUWdwen87k4R+f05A9JLqnrZrPVSv91H3UQupG+wl4h7pDGIdlntXo1aDfs+MeK1sq5f
	 4dp9LuEZ3/9Eo/kngpKHLMK2AEJ3Vs9ij/hZ1hlHex5+yuaFyK4sJhZWyNKSFscB2m+f+
	 GdkWALe9YU/X0hdvBZt/s1PwDcO4pHW5NTTPB9As+nnUbngKLDrKcrZV4oPEOA/PXK7CL
	 lGpbtOnX4RGVQMuec7SNfw+BOqP5VplzaW8n4nDvsn8HtOkn6R9f6juLr+KHO0htecQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CslatUrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186B606A331
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CslatUrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC37A1F0089F;
	Mon,  9 Nov 2026 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209494;
	bh=uHpDt5Z+8RB/vw9lOlSwwBYSg4hXZcK/E1hxVO38o4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CslatUrjnVy5ev1k3/vYFpmufIiIt7wd10E6LsEJAWfHQduGE58+FZmIQ0SX34B6e
	 GlMfL5vHY5u3Ms4raYlJnWOuJjyKVvrzzMeVPVlIKRfT89ApSuamQ9xLop6DM58p37
	 FgtSdp3Lqse7e1XAJmPgSCX3ZvC8jfQJvoE/Po1hWol+CLyqlDRK287CzaN5SJCN28
	 hnGo9j0ojliuC3pDkBbErjscLmM7+vB6MyAimdZsGo1oJiqQ/r2tWA5fG4AgDtJahE
	 GdeHu+RFD+uf9Q61vA3/38E3py0lpkKSqsj0m2glCicLM7/hodVBPD406MOmTNlP8I
	 CDlsLWfuqhnYw==
Message-ID: <sashiko-outbox-204543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: xilinx_uartps: fix runtime PM race during
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109071916.731116-1-radhey.shyam.pandey@amd.com>
References: <20261109071916.731116-1-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:31:33 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
>=20
> pm_runtime_enable() was called with usage_count=3D0, allowing the PM
> core to immediately queue a deferred suspend via pm_runtime_work.
> This raced with console write, causing cdns_runtime_suspend to
> fire before the port was fully registered.
>=20
> Hold a reference with pm_runtime_get_noresume() before enabling
> runtime PM.
>=20
> Fixes: d62100f1aac2 ("serial: xilinx_uartps: Add pm runtime support")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109071916.7311=
16-1-radhey.shyam.pandey@amd.com?part=3D1

