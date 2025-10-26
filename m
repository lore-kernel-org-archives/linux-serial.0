Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CD1AAE28;
	Sun, 26 Oct 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761514977; cv=none; b=jAxf9Pq96rDKsyMw0X0fNA3m4NORowmtZ/TWxNsgs2S/CUr90rw4ifhiNIL3T+rDantQEZUlD/5y0BH/V41ALY8KeifWEHyS0QJ6dHfOs/KAeUxGlgqTFW3z1Y+ekymNAVKfUvBlKsPoEhHRAXabGnhOyAfYigUFjwsMGM3iDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761514977; c=relaxed/simple;
	bh=yYlZvv2N8vUzR/Uap+bbPhqk7533omyjDNKLYfAZqlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em6ojWcha4hvSD64kKT0nXAqYyy1Ak8w8bzt2lMxWVJxRBtFJ4QKs3VSwJWFWwEfSJBNqWmGIJb5FrtnF2CboHewd4LWkZnUlAZgvkyf2GG6KdoE3g5S2p1/OxC63Iv7Kqi44xzySLiHVgAb4GgZEM9xLlYUU4qU5w1pZesvhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N17r29EV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N17r29EV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92E4C4CEE7;
	Sun, 26 Oct 2025 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761514977;
	bh=yYlZvv2N8vUzR/Uap+bbPhqk7533omyjDNKLYfAZqlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N17r29EVziQUBIJC02k5cMN19nwO/L5GQynVwaysjxva8FJnqG6WMwsLquQbLlFuW
	 tk78PyHq8yGrfPqCX3q4TwFgAzQ6dNTu1Kiayy/1fEOm3+wvsdkocsjmYI5CDgnfuJ
	 SrDrgAQqc/BScvz3BHlBMcHnqviKz21L6kpMpv6C2VW/oSurV50FwQHA03SNqcXly8
	 XpKXIH/0u60nN2n50RjJlcj2Hkw1TAVuQiNDww+JWDhXe7c5kkjKdBX+WLT4K3Ndl0
	 +u9EfHnN2GZxdPwI8HpnVF02uWHou2BBLlXZe8U8xRn4z0n9Glvdoc+k7rYCCKnKsA
	 caKWNWyge1g4A==
Date: Sun, 26 Oct 2025 16:42:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Chen Wang <unicorn_wang@outlook.com>, sophgo@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Conor Dooley <conor@kernel.org>, linux-serial@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v3 06/13] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 ACLINT SSWI
Message-ID: <176151497232.2988011.13908967550515331584.robh@kernel.org>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
 <20251021-dr1v90-basic-dt-v3-6-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-dr1v90-basic-dt-v3-6-5478db4f664a@pigmoral.tech>


On Tue, 21 Oct 2025 17:41:41 +0800, Junhui Liu wrote:
> Add SSWI support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with a
> TIMER unit compliant with the ACLINT specification.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  .../bindings/interrupt-controller/thead,c900-aclint-sswi.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

