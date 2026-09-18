Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912023E5EC6;
	Fri, 18 Sep 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758481; cv=none; b=IjhmM2S3KmX4Z3y4Ay3rf37RWPpz5GGjZ/m/EngUcdO84t0QbFhOivNu9bNwIzhS4c3VEaFI43psALeRLHHikPJFOXiH173rMCXxHEbj5JbeDNEIVQM7TQynXjw34RTi8ix6Y3djOFSH5VoQF85VgYfqMYjxK/ARTdpuatci9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758481; c=relaxed/simple;
	bh=oY6q5xBOHltfzSGbD9wqSaMIlT9XZENqC498JeeuZc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8SgFZoduyEeLaWaMYwdzcKnx5T3VTeY6HvrZ2rYgsm1DbhRIE2S7Ue5M1J1fK6WFKXz/SfhnCkwU1xB32S9gXWNep//+4Hn9QZzvTRBaGVuOz/zPmoPTlo40WEEvXpCePO+1aTD1LrPj8GIslfx9ApGUcNsGnr5T20/lTQXW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQPeUj44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQPeUj44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813311F00898;
	Fri, 18 Sep 2026 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758472;
	bh=oY6q5xBOHltfzSGbD9wqSaMIlT9XZENqC498JeeuZc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQPeUj44+yFrpKg5FvJPv17dMgg0gLiZarRm76tR6Alq0SkxZKpNZblmCvPy4nmDN
	 uzBDcgcT0A1wqDQjOUHwEhV99BhF1OQGiTAFPgIijxgoCFu8vz3ez4/OIZrMHiJ4Oj
	 0o5DzV/caalTFDSriFCOs8itKMCRwVGmOKLjdKi58JwIoiLs7c+XblMAJ5mZ/Ac/fF
	 q3MF5X7B4ldlpRgzj/Bod73u41J7HyQViDo0jT4dG5u7YvnyxJDRVfa/2I4GH0gSjI
	 bJRjekCPh6TNLTRRCDXJGlc0JBgWf/5pLlldY0i14ADBqG35k9VKf75g/K9xHQMA5r
	 SNZ2u9ZbU+02g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] arm64: defconfig: enable Tensor G5 SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v4-4-745eaca28b1a@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v4-4-745eaca28b1a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:07:52 +0000
Message-Id: <20260918190752.813311F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Enable the Google Tensor G5 (Laguna) SoC family in the arm64
> defconfig. This SoC family is found in Pixel 10 and later phones.
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-contrib-pg=
-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org?part=3D4

