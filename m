Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC952D7812;
	Tue, 23 Sep 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654243; cv=none; b=NhiF0oRkcxNifuzydp4d7R8XiKGVxmGYBA64FY/f97h67WHmdTU8VBI661OLpmSdg6P7F7E73GLMGWczs3mWSB6eh3crn3c7GmGErgQZ+SOsTPCHBjX0Nq0T7QlT+yCvWlBZNcXf+l/gixhMqSYhhEJnIVUdvbP8HHBONAIKqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654243; c=relaxed/simple;
	bh=rObBVnG62ZJ7ZCcfJqDzxOXdIfr3WgqAb0OSmCfkgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZTC+nWvjBcaiXKoyboX4qTeQdUWpRFhbWP+Pmwy7O0XjaLqKdaACQHmco6nWAJXvQafK3QjuuJDEFxgcvFUlghnqxtqyhCwbxROus46+UCZIVhFiwxUFcnrNWDmIE5+oHUwiAzXt3Moew3BZhUBENyT5w4ESz+gwkyRNIJyN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abRMG2Al; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abRMG2Al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5831EC4CEF5;
	Tue, 23 Sep 2025 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654242;
	bh=rObBVnG62ZJ7ZCcfJqDzxOXdIfr3WgqAb0OSmCfkgWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abRMG2AlbbsDYgfeunO3H3ZWQqTgpqWoKeIKc13cYmTn/jceSJ4VF5d7wUD0Kf/lk
	 PizfsETSN/oS3z2ZxTyiL4qRVXLkR2uCuHo/NC4LBXr8CFx8MiAl48NjSv+OQgsLQN
	 t9sT9Einp0qDnjooqexa4Nt99QaVjDYajKI2kkj5QRZfVu6pcQDB3WdVaCnOOvNjBh
	 zR3V9hZlh1Wj/BBFIok7N2obgy2/zgd9N6cpCPrG2xemoptGzp9LfgFj6OZY1Xeu0v
	 YjLsf3fObMvlpvGGoWWSGslb70eWXipEHD5I9TRGBhcLMk0boDI6jgDuLfBHpoWWoO
	 AKhq4mSbvBCvg==
Date: Tue, 23 Sep 2025 20:03:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 02/11] dt-bindings: riscv: Add Nuclei UX900 compatibles
Message-ID: <20250923-patchy-planner-112bd8448ef8@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-2-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CAd0kSoi90+pR06L"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-2-64d28500cb37@pigmoral.tech>


--CAd0kSoi90+pR06L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--CAd0kSoi90+pR06L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLvHQAKCRB4tDGHoIJi
0mm0AQCNWP5i3bqaHYB02yTtRtUwZXq/nVW3Pa5v9mJmyekDigEArtrKBVf3mnsU
AqMaRyV5PaznMNOPCQAKIpIxRWNaTgc=
=qZfh
-----END PGP SIGNATURE-----

--CAd0kSoi90+pR06L--
