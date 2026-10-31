Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467030;
	b=KD/0IvjLTrWUKIk/bxxp8c8nAb9R2K36CFnQtZ3jJRJqIL+brsLqz47t9hJ2fzfmJV8W
	 lzrgqa3PgM9jx+lTj2El96D/wA3eeEb/5IC9aUoz75FOymYVajpcxWFeq64nCceB+zK6M
	 v0LJEKzSO7TadmkitK4Rf5vrmNquvjV1U7hO8fptZSwwBQH/NTtLZuB35nni50YyDsMDg
	 fW0xi9jKrfsqHLTGAtESZQq1mZI7PGggkmifris7GUDyri/QGFAGQK9b+wdWoMzHRFZbn
	 4RdNSdql2ygT3U66QgKrgQXVFU1guYGzWxy93znLYfwhGSiUmfgJxRRUCtTcHcOX+WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467030;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sCvXUk6IskCoBvJiWfQUCLVHBwzemWJvYKmXQXlC9eE=;
	b=o0pTsREGExku9QFxcyf7A2OJWQtDj1+GbGUuiTdGNdhORXlxTqk1+5lCVcGsm8U6oNYX
	 GZGY9SGfJbllUkA2pHtf0cz0kOuTOJZ84bGFbEYRqJMVIjT5ZDhpd2RsoZF/wIj+aLm1d
	 ybmBIziMAtCSDQZICnE4+CRHD/hyrEgz01tKdkKHkPNuKG6NT4cZH9CGm41Lvr1/V1vxT
	 8n11MzMA6CxDIExcwG0+opNTxZF+tMB8Xd+h7BxkZrGj6yG1jMje927JOFhA4XLt/BGLO
	 Il0sGPCh1PLWvDr5yRVQbvIdUtZu7JqeV2ES15GrqhfOTpj20hh38vutBknfjztBgZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDAdo15B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D3606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDAdo15B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DAF1F000C1;
	Sat, 31 Oct 2026 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793467029;
	bh=sCvXUk6IskCoBvJiWfQUCLVHBwzemWJvYKmXQXlC9eE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LDAdo15BEO4zMyVUF6BJhYgx1P6HyduVQnXno7qA6rRxk7+3D6hu1Nx3LUOK2dSXX
	 GcmCGg9Py0wt2JKX0QEpBCkGuIplyUMVMiq1lHeZUifPUUv7GTE3+wonSrEI30ojZk
	 zXcCEzd+Evs+Pfn7wAZqCXfVd1Kkxfu86VRumE9Rhq/5mKwuaeGEZRXjRqcuI9RD1s
	 Z+yBTDx09go18/Y3IPDJ+Lo2zOEUMk1AQzwzoS+xhEyNkhSfxHBHxZmVyRnCGodUiP
	 y3LAdqZs7MlQKNIdXIcc/bWyVCR/fbuQQISgYK8c8F1S8PFv9UaBpev+txAt3/eLMH
	 eXM+L9Z2tiVuQ==
Message-ID: <sashiko-outbox-192059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] serial: fsl_lpuart: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Crofts" <crofts@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-2-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
 <20261031-tty-dont-use-autosuspend-removal-v1-2-7bdadcadc4dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:17:09 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosus=
pend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>=20
> Remove the redundant function calls.
>=20
> Signed-off-by: Joshua Crofts <crofts@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-tty-dont-u=
se-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org?part=3D2

