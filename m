Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A139AE3;
	Thu, 27 Jun 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511248; cv=none; b=nn5ivF86IakaO+Vq+48b/53dayFbz5d8YYDMAypWJ4o7U4sWZxtkL+Ggd8BPiAqiXF5g1lyg+cWn4yWFPrBYjLuR3ry4soPXKO3FKO10Seg9x3UI7aYAziOr6DFIRb9Nv0maW9QFvu1XdadWPuU9La5tcOEjUhQLgKn6ZZ6eVIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511248; c=relaxed/simple;
	bh=NiXOcqBw//fdDC3tr5lVquyR2ocKMpTBwmlCMcbthug=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=d4GCf4+/a7tHX5fhfvMGCOQKxJZ0NzncI8BjorkE4EKxwyG/Rt+OEnMj0sTgNBCLZMaVsja6LbF0IQwLT/LV+2BVVcPy2LgIbnjXbTKM9c36QhGpDjcg0yU6Rp7f9w4Lh25+e3yviHSuTthpUZBH+sBDFVxgYIZqpy0GvxA1pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anxsqjOe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anxsqjOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6843AC2BBFC;
	Thu, 27 Jun 2024 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719511247;
	bh=NiXOcqBw//fdDC3tr5lVquyR2ocKMpTBwmlCMcbthug=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=anxsqjOexQlk/CEKSL2uuEIidvW/pO5sqKb8YCSKRi2cK4nVmlveuH+pe2+Pz5Lse
	 7N1/nHJkb96XoV9KHEmKpsAnCEC2TuXXO6TCjLwbZ97fm9Jv+OkwLttcy6m2t6MoR+
	 oPmdmtuf7rAddMfYqY88FdLUeHX2C1JTrJ2NIGctgJnkU4lVA5DChuDq6czZG5jUdL
	 9L+2k5yOokVkHGUUBVK1FUNfZnxhPCzsIWoBpamJnUYjHIXTeI170/BO5e1dps/FxV
	 Wy77arzHOQJ477ZWSg1k1n3A2TEWJqmI0aEbmCmP4jMa/kzlYNZAJEJS3aqF7zfCz/
	 jqhoieWdvk9DA==
Date: Thu, 27 Jun 2024 12:00:46 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: devicetree@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Yangyu Chen <cyy@cyyself.name>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Jiri Slaby <jirislaby@kernel.org>, 
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor+dt@kernel.org>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, Lubomir Rintel <lkundrak@v3.sk>, 
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org>
Message-Id: <171951124625.247065.2247490671669383522.robh@kernel.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: riscv: add SpacemiT K1 bindings


On Thu, 27 Jun 2024 15:31:17 +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
> 
> Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
> Pi BPi-F3 board[2] which used it.
> 
> [1] https://www.spacemit.com/en/spacemit-key-stone-2/
> [2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/riscv/spacemit.yaml        | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/spacemit.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

