Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B84493D41;
	Fri, 18 Sep 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758617; cv=none; b=T4M7oS62XqGG4E/C9GtEVrGS7LH2XMkx7zX6m/yo95Dj9BXfmge4rtiXjEaRg0/9byGwLv0DcQiyBAtk3XMmysBaJjsxDDiWKpGLmquxQ43BJ2HTCFKtib+U4Kj2wph7HdYGT0SnB4HV1nuT7nS45XTnuhuaeI2pc1sjpR3Nwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758617; c=relaxed/simple;
	bh=nYgsKJ1PbArkuEU4ObAJgBw/TpLFXAeLy+0nbYqIEqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fKO69JBW0wlE0TctcBxcAOhg+g4QJYy1gOusNIm9XVoQFB1Isgp9SRldNmS7SkqW06UWG/MB3CrmJPcJsDBx7KuWWQcElicFfHRuCSuFQB/0pFrxlD1KvxvUu+4kuUgtlikq7Ojl1xOtjkwCw1XrLwZA7Jf70PBMj/Je7cOX5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrRerwL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrRerwL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2082B1F000FF;
	Fri, 18 Sep 2026 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758610;
	bh=KTvV9o+Hdv2dYKlv/ReuyXH/XuS3gxy1FQ9aAaySgV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrRerwL6EsMLTBX8Et4lzF2E85LX1bydCUhml/oQPzUnZkgKEhnQ03oxc3VyboQDB
	 yq6YFKmVZ3heB80aQAKUeQFEBtGfjfohuWK8dxNdwqv4Q6lJ9pQhrVjXkBXs7WSbhh
	 KghcKrKD1/qN/1kjGHy+nhO5CwJ6ioje9C0gAdMnrZmU/CXwVA6DIdi+kBR1w6c9WC
	 kMZK633hkEZtZWUK02bDKh/4SPuZuI4YUS6be+5+IpYYUWGQjcFOlRSXdb9NmFUHLB
	 UnlCRhljQ++uljNfDI6Cz9QIptOWyJeBuXkmNJz+Hn52hbPbI/YqXPKBxwC4NOic2I
	 J2SPM+cEsYRGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v4-3-745eaca28b1a@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v4-3-745eaca28b1a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:10:09 +0000
Message-Id: <20260918191010.2082B1F000FF@smtp.kernel.org>
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
-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org?part=3D3

