Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE522154E;
	Thu,  8 May 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688197; cv=none; b=U988oSBNyfSaDs4Q2oN69IzHUaWXMGt/SoZhyWQd6Z3+J3mwXV1PvBns2gYzzCHDYVDy0adp1IZCSSGbtnBXRc6CN/1pB8Tl1yywfBLrlvomSZUYqqSVAk+uFy/v6nT5i7fHzU4W76BJCFOiYjKJlqi0A43bL1Lsl2JGDdk845w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688197; c=relaxed/simple;
	bh=Yr2J78SHWoOtKQSemvYmYF7NMQk3vdDKnwJFh78hPRU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SqnNu0tQkma+S1J2nL7yFxZFWTv/BcIY3FWhlUC4kVQKrX2wMeVSozLtsTaL2z6u75+3kOfweorYycDCKr0XRoa/aJQftciQkCgMat6NN7CkThaA5HdvJVgqU0iPUthkLVna9UfPXR42vXWYpUzsxEXxVWgn800hz+MpolaFnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI83Seu2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI83Seu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D463FC4CEEB;
	Thu,  8 May 2025 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746688197;
	bh=Yr2J78SHWoOtKQSemvYmYF7NMQk3vdDKnwJFh78hPRU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FI83Seu2KbzvpHecpTY3G01Iz4PgSGjhZ3fU6bLjrCRPko3zjL0ofM8MabPLKdl9w
	 tA5VmxBV7dWog8cBUK0Fbs+z+18q5y8DEphda8FiVEtyl1dtdcMDFhZM5RtFAjzAa8
	 pRgvgx2t1B83Yx6qtJGheF+OHXTfB/wtI+6LgzvswZnW/G9K9WxOjC72go0tOVjlcB
	 SXtccGNK3/tuzEIxskr66PRmLKg0sA73vqVXJ4Ck62tYy6yYf/o3UAki7nEqnmDRPS
	 iNHoh67/y6nqOh3torH/NwhsT0YrpUWbgAEBvUsx8BDp2rtY/ZaciFrTromuQSCfu6
	 r6+JlSGcwfxlA==
Date: Thu, 08 May 2025 02:09:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 linux-mediatek@lists.infradead.org, xavier.chang@mediatek.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Sirius Wang <sirius.wang@mediatek.com>
In-Reply-To: <20250508063546.289115-2-sirius.wang@mediatek.com>
References: <20250508063546.289115-1-sirius.wang@mediatek.com>
 <20250508063546.289115-2-sirius.wang@mediatek.com>
Message-Id: <174668818902.3553912.2627807939857046416.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: Add compatible for MediaTek
 MT8189


On Thu, 08 May 2025 14:35:40 +0800, Sirius Wang wrote:
> This commit adds dt-binding documentation for the MediaTek MT8189
> reference board.
> 
> Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250508063546.289115-2-sirius.wang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

