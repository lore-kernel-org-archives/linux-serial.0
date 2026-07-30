Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1C42FCDB;
	Thu, 30 Jul 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415368; cv=none; b=tOJZJW8DZUMJJ7XGBoSxkxk/D0FLgjkvdmzgOEMShp3DJxJ26RfJcl16AMLE7MCj1N8DY+ys3REoQhNG/+wRI54R6WfubRfBt8mYup9TP9mX7tAEmSH4LaP3cmpKS3zA/3ZbZbZPM10xv6dYcisrf7EbusvNvDeqwpkKV7p4BTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415368; c=relaxed/simple;
	bh=LvcFbw8oGouvM+jfTzOUofHdTDiFUki9e2xOIqaczCc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hcPOtZjQklAVLGV5MU5/UsJyYXJvJ3AJ/Ijzpw1HOYagZMResUbq1ETZbMsWvOpurktBfIqm4CErb7yYPIhcE9Nf2aMNr7GYIxT2+o9X2effirhvnWMyALMlsCeGRlLiwg1258aqd8uys90JTwCW8K1K2QBdQb/oYtaS8rbD2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k55iXxW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k55iXxW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD35F1F000E9;
	Thu, 30 Jul 2026 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785415366;
	bh=w0qIs3ynZHgkXTYTbvPP3qUgG0ysx0KqrNSlrPX/EX8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=k55iXxW/57vq4N7SQpzmf7TxlWiDqiu6jL+I4xd5BgkznDjH5YKXqPabxXI86qHbU
	 3l0qGAPwnGS3ynu24kjqGaj3WRAKGkCVujl23HrcAh3cufaV0drXP7j65LGeeIbDQx
	 SkqIir1IzMQF0cgHaZgbgm2riM/d3Cidi5UC2dNfOdQDV6ZPhUeR4Hcg8DuVFmwHdc
	 KoaAHJAOeAbEMvHTAumgQDANvEFfcycUxNWMFdI3Cqt3/PeFuozDET6dbY2dLHBSWV
	 hsK2/tm4vNz7XQ0zAaoPPWxi8IGFXU5o5jDsABEUAQ5kuo+MhggSqE6Tm8iTQOZ/We
	 UvaIEpAQP+N0g==
Date: Thu, 30 Jul 2026 07:42:46 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Michael Turquette <mturquette@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, 
 devicetree@vger.kernel.org, soc@lists.linux.dev, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, 
 Catalin Marinas <catalin.marinas@arm.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-serial@vger.kernel.org
To: Long Zhao <longzhao@ambarella.com>
In-Reply-To: <20260730104330.81367-4-longzhao@ambarella.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
 <20260730104330.81367-4-longzhao@ambarella.com>
Message-Id: <178541536479.2601751.14563666222918731032.robh@kernel.org>
Subject: Re: [PATCH 03/10] dt-bindings: clock: add Ambarella CV75 RCT clock
 controller


On Thu, 30 Jul 2026 18:43:23 +0800, Long Zhao wrote:
> Add the CV75 RCT clock controller binding and clock ID header.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/clock/ambarella,cv75-rct.yaml    | 94 +++++++++++++++++++
>  .../dt-bindings/clock/ambarella,cv75-clock.h  | 17 ++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
>  create mode 100644 include/dt-bindings/clock/ambarella,cv75-clock.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/ambarella,cv75-rct.example.dtb: / (ambarella,cv75-evk): 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260730104330.81367-4-longzhao@ambarella.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

