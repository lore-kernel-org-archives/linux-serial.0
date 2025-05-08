Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB3221DA8;
	Thu,  8 May 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688199; cv=none; b=Aye7KyMSL7GanitfildYY39l5SYwPgKdDcH2cY8wLqYWZN2Gka8JNUKMhL+rYsZaSl/+QqhlfKJDWw0Uclh6jUuA/2sR1S13xi1qxWmQIMuNKvwwA1ASaYlfkHofpimFniX8Ooi06sayQpyoPYuAawG8JrewH0gF+6PVTl4Wqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688199; c=relaxed/simple;
	bh=RrwRtaujjlqJpIgcXtqqvO+THEkQ26LzURxmJEZVRD8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=onDRzZaU/0hFkK9T6OHz0y4QylG/SYmeOuOgIMhsDDaJcKobTvUNp+v+OUS3dTGcQX2fIngfH8Zi5+EJPvgswsijB2HlLlvggb6eWQxcLfJGnnclEW01XbdQQq9ggpkxfct+YLUgTxL7ivDaB/P7B3aDca3SUMlQqU+5ma7Gd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHUON7AE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHUON7AE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D888C4CEEB;
	Thu,  8 May 2025 07:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746688198;
	bh=RrwRtaujjlqJpIgcXtqqvO+THEkQ26LzURxmJEZVRD8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PHUON7AE9iEwY4EReMGouzh8o4Xx3NEVh1B3niBALfu93L0I1ZeEBBxRkmVQCo71P
	 yYHulapgtsDqfZAEoi6oXb3FV35XThgJhiI4G4xEt37OPJYaoUB1PexJZr/5LwScE9
	 XJseyi7K7OLnNmO+GoGG2onANkWJCoDjkp5ZBq5hWrm9yjaAmcHPtmpi5XsZrjNjOh
	 w0nbRR+nv/EZq9AdfrsAR47j51d5g6dGLnqr5vVIdfmXZ9cEGPcdy7NfErMeilz2of
	 T+KcaV2SPlNGcoQ1z3JK3W7Pg572JpINQ9JrtRc3M1rgKE7ZafmuyCBlVpVkJuIgOX
	 d9DTGaPjoGgng==
Date: Thu, 08 May 2025 02:09:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-serial@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 xavier.chang@mediatek.com, wenst@chromium.org, linux-kernel@vger.kernel.org
To: Sirius Wang <sirius.wang@mediatek.com>
In-Reply-To: <20250508063546.289115-3-sirius.wang@mediatek.com>
References: <20250508063546.289115-1-sirius.wang@mediatek.com>
 <20250508063546.289115-3-sirius.wang@mediatek.com>
Message-Id: <174668818993.3553950.2026638570584322328.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: serial: mediatek,uart: Add
 compatible for MT8189


On Thu, 08 May 2025 14:35:41 +0800, Sirius Wang wrote:
> Add compatible string for serial on MT8189 SoC.
> 
> Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250508063546.289115-3-sirius.wang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

