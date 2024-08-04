Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4514F98;
	Sun,  4 Aug 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722756223; cv=none; b=kENEF56iCOjytVqlEUMhrIxsfEwa4bhgmuZp+oJkpe9vduo591QX/Z492v8JMM0ufA0gqQYQiiCxp773N3Pswg+NK3/mWrCxpug85zKL3MLKprQLiIAF1BGqaTd0zlwVfWJLVN4IRJP/mJ7WQp8LGAj3jxFgRiRFLFAeVjxMjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722756223; c=relaxed/simple;
	bh=jQiJOpRAAEffBgCAE+wAqMVZconq0jXGk3ZQfZAVTR4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=JNDcZ9fkFNyj52+OqEhQYM9SUIz2GqsJliaWkWyq17XCbmWpAj546SZmudh/rYO5iN9Z4chOYnGP0rxwaxyAtNKUWuDpt2uw/7/6MM74Jl8T5PIVtTtG8r8RYrbIqpuGJxvn83tAX1DlFfR+4qcEg9WOvBkpKlsRULNu8E6JdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXYCpmm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXYCpmm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A243C32786;
	Sun,  4 Aug 2024 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722756222;
	bh=jQiJOpRAAEffBgCAE+wAqMVZconq0jXGk3ZQfZAVTR4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qXYCpmm6WRM/h5S9iJLmxp8x5LOwr8+0FYoaw8AyydJzVPotwdderP7s7G9oEyyky
	 QCq8CF/HDqiN9izjuYLkxxLPl2oyh98Mzd+cyEnxl08JINMWju+Un/axwz3tlG+hPE
	 fonG9U28asGmkcYcPLsL0HIRgYwTLhg6OUD7aVn+O91eR76qX2Vgxo06YDJJxZ63m7
	 wZzAy5DOMATw4Qz3xUpjlxD0EJEbWFr0xhNIKORLDyY32yhyRHtbrnvZrUPdskxUL+
	 mU4/Yd0I2S9xFdDF1Rkpco9tQ7emop0G5xajvA3YlGDtleyA+0W1O6blB+cVAt3enj
	 NoQwM5KUlMgzQ==
Date: Sun, 04 Aug 2024 01:23:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: zhenghaowei@loongson.cn
Cc: kernel@xen0n.name, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, 
 devicetree@vger.kernel.org, p.zabel@pengutronix.de, 
 loongarch@lists.linux.dev, conor+dt@kernel.org, chenhuacai@kernel.org, 
 jirislaby@kernel.org
In-Reply-To: <20240804063834.70022-1-zhenghaowei@loongson.cn>
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
Message-Id: <172275622121.3211162.12520346466286897443.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: Add Loongson UART
 controller


On Sun, 04 Aug 2024 14:38:32 +0800, zhenghaowei@loongson.cn wrote:
> From: Haowei Zheng <zhenghaowei@loongson.cn>
> 
> Add Loongson UART controller binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> ---
>  .../bindings/serial/loongson,ls7a-uart.yaml   | 74 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml: fractional-division: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml: rts-invert: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml: dtr-invert: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml: cts-invert: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml: dsr-invert: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.example.dtb: serial@1fe001e0: reg: [[0, 534774240], [0, 16]] is too long
	from schema $id: http://devicetree.org/schemas/loongson,ls7a-uart.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.example.dtb: serial@1fe001e0: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/loongson,ls7a-uart.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/loongson,ls7a-uart.example.dtb: serial@1fe001e0: Unevaluated properties are not allowed ('clock-frequency', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/loongson,ls7a-uart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240804063834.70022-1-zhenghaowei@loongson.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

