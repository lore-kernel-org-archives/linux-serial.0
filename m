Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF51B4F2B;
	Mon, 14 Oct 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921376; cv=none; b=sGD60R8M+Hlt+/XY3UCWTr2uDZTz/scGNszCOQwNEzM0IXG3DI1C3BAqEH2p3cLEAf6Wb6FiJnDTrbji4jzVBM80LuHWiDYL3SPgwS8YR0ToFploJSv/0Zl2YqbcGZOtFi6e0CtZNhCfrNYLDg6Yt8TUCrFgatKcGNy9ZYGX3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921376; c=relaxed/simple;
	bh=RdNdTs4gWFa8xA+1hi9htDSIKKlwmLFj74jVWogayEM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ow+jHmD3k1vxnTud02WghWL6PUiFIcBf2KqgwNmlB5xK17vGbZBuCI2JflXyKorwbrOMhrh6KBDKvNCH8NRjKRPCUPoGrLWKPL9eKqscrbJQPFoviw3yY9Odh/U1g+im00BFsZUJCOvlvw5CUolpfbyM7n4Ril5aBj3NZs5ZsFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeSb95v6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeSb95v6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212EC4CEC3;
	Mon, 14 Oct 2024 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728921376;
	bh=RdNdTs4gWFa8xA+1hi9htDSIKKlwmLFj74jVWogayEM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FeSb95v6y18mAB5rVvY4u9Kmh5FFSPyKzcrMh8uVcSFGaG+hkbODTKIULH1uZ63/U
	 YqreHb9YRvpjDrmFVdWoIUzoYRhuoEnl3B6UFyjAs1nBoeFq/5OgiJpgV5JUW8X5er
	 s8vKdWhJmu4zwgEpbWUFYhjAtlxVr9yH2SB/TIQblFQcY3kFu+uxhb1LSTmsSP4QVA
	 O7F0bkRzYKvYPs6L7mtJt2uTRnjzakIq//zjtX2ClKnWoCgV8F/rsqW/+bkyBcWIcB
	 oY+fHrE3k1nr0ONLS61IqOdNQ8bP0FBWvjyTUDm8oVdZhJI7sPmV5gwdT8HOl7iE39
	 JSs4BGsSwmrCg==
Date: Mon, 14 Oct 2024 10:56:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Christophe Lizzi <clizzi@redhat.com>, 
 Alberto Ruiz <aruizrui@redhat.com>, Chester Lin <chester62515@gmail.com>, 
 linux-serial@vger.kernel.org, Enric Balletbo <eballetb@redhat.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>
In-Reply-To: <20241014144501.388050-2-ciprianmarian.costea@oss.nxp.com>
References: <20241014144501.388050-1-ciprianmarian.costea@oss.nxp.com>
 <20241014144501.388050-2-ciprianmarian.costea@oss.nxp.com>
Message-Id: <172892137480.1497237.16573929497529624657.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: linflexuart: add clock definitions


On Mon, 14 Oct 2024 17:45:00 +0300, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add clock definitions for NXP LINFlexD UART bindings
> and update the binding examples with S32G2 node.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.example.dtb: serial@40053000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/serial/fsl,s32-linflexuart.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.example.dtb: serial@40053000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/serial/fsl,s32-linflexuart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241014144501.388050-2-ciprianmarian.costea@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

