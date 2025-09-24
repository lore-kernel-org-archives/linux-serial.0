Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B021765B;
	Wed, 24 Sep 2025 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741554; cv=none; b=D/0IOKtlMsucdiL/8Lt2r/zeNpU9fFgqKA2zIwacH5j6XHQ9O/ZaNTCRfBY1MDXgPZSdYZiY4CwQjztC+E5IVyDiiflwdWm8BI6hJmZ7mRcuGqiRqyshZyV5Ue1kxvqg31fEfTrbc17OFXVhAv0CldMaJQWzeSmMtJEN+gWGI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741554; c=relaxed/simple;
	bh=mdCv3RD3cqfZ0s/HDZ28RMQmcKAk9mNqnr5oGlONhDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBySYC7mrVYuE08n2pw+6NwNkobk4M9z3aNAUiStHAIhCPcDkvZPXBe+5VEDorRsDSXj7Bqfwf3ShntfBB+m4qa79Gv9xCVhC3sQltLoD02dFTO3wuhbtUfgpw4+pbNd39NuPzza+KDmphVffPiTFJhM1UINTaLG62o2RHlBx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUguPH5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUguPH5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A1DC4CEE7;
	Wed, 24 Sep 2025 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758741552;
	bh=mdCv3RD3cqfZ0s/HDZ28RMQmcKAk9mNqnr5oGlONhDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUguPH5Q4wqiy4rY5r4C5TxUAecFtgkdEWdBxuFAGkqMFLfsFNd60mOu0VfXgW4my
	 PbGIgECqxOBUJYHrAV9PRHJHM5HP7l3gA4ME8cS9wi3xvzomCBiLus738dBD0lBsIi
	 OKpgHXiGvjuupgabqQPB5/Hn7kxfHmKnPgU9PBq1h8vekKzwzClGX3kM5MPjKP94ky
	 fgtAbRTNallIf5AEwOURJoEO0f2ualY933y17WscGMT6nG/yDuho4J0cwgPni6Y0GI
	 RBnYzCsk+Pi/HIkqJywfLY+/nkH/MfYxejkClJjkUbYg7jSCIsvptZ0oxsatmbWC/+
	 wv8DCldfAFhQg==
Date: Wed, 24 Sep 2025 20:19:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: serial: 8250: Add Loongson uart
 compatible
Message-ID: <20250924-reappoint-routing-d5f2bac03d17@spud>
References: <cover.1758676290.git.zhoubinbin@loongson.cn>
 <ade57dcdd021de6824a15d4aa11aa9cbeebce169.1758676290.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GxWE5Bo9wF1mObcJ"
Content-Disposition: inline
In-Reply-To: <ade57dcdd021de6824a15d4aa11aa9cbeebce169.1758676290.git.zhoubinbin@loongson.cn>


--GxWE5Bo9wF1mObcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GxWE5Bo9wF1mObcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNREKwAKCRB4tDGHoIJi
0htfAQCNlzeTu9RvA3UDJqaCK1bBmzghgSoSEejoGtCvm55t4AEA+90IInlq2gT6
CN1a6/aOTpDf3UldWxeywTdcW2ToAws=
=nFLt
-----END PGP SIGNATURE-----

--GxWE5Bo9wF1mObcJ--
