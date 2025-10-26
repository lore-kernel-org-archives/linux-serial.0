Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482813B280;
	Sun, 26 Oct 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761514844; cv=none; b=XlWJe50QO9Vs/8aVk8gyePMD+UjVGj/ELpRtINZCMeGpUSzIoPg25rijzc7aHIQt9NhCSg3XAcMaUmx9Xgw+2Gsf6QMa3VajGY+ZwAPyAq6W+fr3Mi59323bZYsfJ17YhSOtRguxb7YkiW6tAzUoa8TMEagYuLYmH04a2jhh5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761514844; c=relaxed/simple;
	bh=hrAhullTtGBpi18RJq12aBGKxmGAG7DcyxLeBCASy5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQPXJTdNrbO48TkNWj6n/lKO/mVYt6C1kOJAgKP0SGx+2uJbszG7LBpt5gP8FaQi/BvvCVZ8eqmL+aYgx1H6tDXzJsGcQlddOOgY2xDhttGu2YrdEjQcnyPU0y7ssGv7aENjFMuiWgm/OB2tBZVxAKVc5IYUUKhxAOhMK0mP8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKhKB+tm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKhKB+tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8121C4CEE7;
	Sun, 26 Oct 2025 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761514844;
	bh=hrAhullTtGBpi18RJq12aBGKxmGAG7DcyxLeBCASy5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKhKB+tmed0VAijfGV0sE1GPY3vki2cliuedET4rXwig8irwIsvwx06T94zIDy+AB
	 99Bpc+ZX1inw/DryDrXsTytAKX9pSt1NuiKMk0C85vE1Y6hMxst1qqYDUzoXku+5lT
	 C+fFwZHFBiLNiVKZ6nE/SlKsxtWcLiSkgh0F+dOwzYyajJ4oD0/0MOXes5Eku0nQ6E
	 FMsJw7QkawE1jPodpNFrNH6dK+3nuEzaoqSCEyL/+rIvlYDtL62OSng7y74RdVfAMd
	 ceKitmwv4I7jDlB4v6BobDDC2+7yBwoAcBOqRpaYTRWab21S3svt98aLYwYOzXtsVs
	 ggeZpJZJQE0Ow==
Date: Sun, 26 Oct 2025 16:40:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <pjw@kernel.org>, linux-serial@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>, devicetree@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>, sophgo@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor+dt@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 05/13] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 ACLINT MSWI
Message-ID: <176151483790.2985487.5387793525895332800.robh@kernel.org>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
 <20251021-dr1v90-basic-dt-v3-5-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-dr1v90-basic-dt-v3-5-5478db4f664a@pigmoral.tech>


On Tue, 21 Oct 2025 17:41:40 +0800, Junhui Liu wrote:
> Add MSWI support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with a
> TIMER unit compliant with the ACLINT specification.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  .../interrupt-controller/thead,c900-aclint-mswi.yaml    | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

