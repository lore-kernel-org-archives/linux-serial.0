Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EC5187C1;
	Fri, 18 Sep 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752874; cv=none; b=bFiMT6N+kum38BN3ijIuNNDXmZ5r5EvCgkeL07rWrsLInwOADaFgCP+e4xWXmmR8l2yerJPZYA//n4sHeULxU6TriItEc3u7uo0taMRFsPb6NJdVR9qFQzKAQnjcgvBHZaUQISl/7vRMH4GKTZQbjzjgDuYX48dsVaNkl+cPW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752874; c=relaxed/simple;
	bh=O3eIxD3F7KpfTg/iAsT9PEu2aBWTQQaQwanECbFholY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RX+/fzpLpiztbpJExJ/KmSk3Tr0m+VBTYTQmOzM/3//y4YkeKK1IkokIJ1/EgoBqw58ExVEmgVABQQqbvBD17OXnHiYxMaxjOJfNgArp/tb2g5Qc7AIo/r3T62XRXDvIH3glE/afSSvrGpJxh9SP34+xGkLEz2Kami1uyxTY4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlvUokgh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlvUokgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AEC1F000FF;
	Fri, 18 Sep 2026 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752867;
	bh=HgHZImmOP32qR81TpXnTRwxvfbfeydaUHyswLlfbpTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QlvUokgh32WKtXpQW4tn8YVdUa8XBzelp3AXfOnwrauY23CxZUWOgmujYy2MLXDCy
	 Tgy4iiZGJNZsAOaRD56Vay4DbeEdbSiSh5CRSJjtZ9d/ruiGKQGgMhUzpY1SCo4n7Z
	 24B4VNc5OQCS6qKaN2booR3h2LmE9wz00IMRL4OwOg6PoubZMU35roVRSp535eo2Rn
	 XHc/TACfLbBYmeH16KfqaqVKOAeqUfAAE5BQpMQXbKZYAPjZAG1gefVQAMcIXt8bm9
	 ZD4ZQP6l2qCZwff+qVGWar3sNOSAfMIks2iyo7A1ywT3b1ZgnXYQG77/o6nhOJfpu3
	 YkprEVaF6P+fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v3-3-c94e51140509@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v3-3-c94e51140509@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:34:26 +0000
Message-Id: <20260918173426.D6AEC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Douglas Anderson <dianders@chromium.org>
>=20
> Add initial device trees for frankel (Pixel 10), blazer (Pixel 10
> Pro) and mustang (Pixel 10 Pro XL). These device trees are enough to
> boot to a serial prompt using an initramfs.
>=20
> Currently only Laguna B0 silicon found in mass production phones is
> officially supported. Further revisions such as A0 silicon and EVT
> devices maybe added in the future if they are useful. As of today,
> these device trees boot fine on EVT devices with A0 silicon.
>=20
> A few things can be noted about these device trees:
>=20
> 1. They purposely choose to use the full 64-bit address and size cells
>    for the root node and the `soc@0` node. Although I haven't tested
> [ ... ]
>  - Add osc 38.4Mhz fixed-clock
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Co-developed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-contrib-pg=
-pixel10-initial-dts-v3-0-c94e51140509@linaro.org?part=3D3

