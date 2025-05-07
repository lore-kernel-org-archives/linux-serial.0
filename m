Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DB2AE84;
	Wed,  7 May 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578599; cv=none; b=nazGXT2AKR6QKgRZOab7oa+DxsYQ69HGsAkMpvl7uF+teVYCkaTdYmwHPzZKHi+jdZLW34IlDXsvIQnRa3DGo0qzgpPlulb1nTE721Oe1tR2WH8PVpX/EJ1DEjsqAEVvKMgtXq5MF2JEeyjXC6Pxkx12tFhcT7Pa63NXPg71cWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578599; c=relaxed/simple;
	bh=1Mqy/kljIpeIqD8Jbhrs2lkLPGlh44MkqaVQ/428QIg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=INMG3J3tuHFms8GIMtn3ihKK4qdLJKKP1KgmBYZy5q2i4WeYXiVSvkVmWnlHk7SLHJzRM7p3jEAB1KBqO59ttvvF5vGsLHlqGs4m1V9LRVz3jJ9SoVbQeEExx3avYsv2eGzmlmMuqPXJJ3TbJZ3WT6RASWJOeeb0wm+a8RXxPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4INu7m7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4INu7m7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2487BC4CEE4;
	Wed,  7 May 2025 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746578599;
	bh=1Mqy/kljIpeIqD8Jbhrs2lkLPGlh44MkqaVQ/428QIg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=T4INu7m7SCfthuUP6iuS+ww1iqGb9i6pgwYQPXM4k4IPYv7JCIxea05M5hN57VsvI
	 26sraN5olF/vBv3d52sa6tR3nPh+QWasFs+tPq43vYIEYMrGwnU2yQuo5sv9j41YIr
	 BoYSYtlPlY400LIgo/pBxnYVJeyFlrHP65uVRwyXvC6aCAyh6xqcXPEcwUQ2Kd6Hbs
	 pzaWgBs4v6iJP7Qm9t8hVxxoMo8RdScnKZovUerXcz4aFKlRR61e1RV8kr81ON2+Sa
	 FITCZVs6yOeVkO+7iIGMfTp5pa4odshsHEG8kyBLsE++P9ASiTFPhbKuRAaVZuGJRy
	 uTuo5FxVGomwA==
Date: Tue, 06 May 2025 19:43:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
 Chandra Mandal <purna.mandal@microchip.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-serial@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrei Pistirica <andrei.pistirica@microchip.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20250506220034.2546370-1-robh@kernel.org>
References: <20250506220034.2546370-1-robh@kernel.org>
Message-Id: <174657859727.3211905.5051377478699644321.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: Convert microchip,pic32mzda-uart
 to DT schema


On Tue, 06 May 2025 17:00:33 -0500, Rob Herring (Arm) wrote:
> Convert the Microchip PIC32 UART binding to DT schema. The binding was
> unclear there are 3 interrupts. The functions were determined from the
> driver. The 'cts-gpios' property is covered by serial.yaml schema.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/serial/microchip,pic32-uart.txt  | 29 ----------
>  .../serial/microchip,pic32mzda-uart.yaml      | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.example.dtb: serial@1f822000 (microchip,pic32mzda-uart): Unevaluated properties are not allowed ('cts-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/microchip,pic32mzda-uart.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250506220034.2546370-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

