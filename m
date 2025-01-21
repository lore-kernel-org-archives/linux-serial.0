Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5671BCA0E;
	Tue, 21 Jan 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467066; cv=none; b=mfTVzjgZU1XNtgBDve82JyUo6pkK4HD6mgq8ZAp86jUOb0Hw+C6Zy4iT0SHCgCna1Vtm/urc8oeAABBNCDepotqkkVHAE+4h4C5131NNzhheAnC0tX3JeJ19sDDwoi/HSZJSM7GldsKvbpJC8rOVcTy6lD+UJvqtpGW5z4osqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467066; c=relaxed/simple;
	bh=ZNHKTzbc1qE2RVmc+TGDtrXgWkU8kMRka/zQs1fCEpQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jJlZQVzkVZQZyQW5LOV2wqZJ/ITOQrguguPd8pFF8lrVDl0TE1p6T8+Qp3Y4kHyY60Wf6JlvUHYnadknD5y0aTHk4mRdUaqu4RSZ5Tq60vOGQZ2+Rdq9plnWHwM9jgpil9usOjncOs0YivXnIsqWR7Ba+0PvBzjjyP+5tWNGvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcV7Yu1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcV7Yu1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F329C4CEDF;
	Tue, 21 Jan 2025 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737467065;
	bh=ZNHKTzbc1qE2RVmc+TGDtrXgWkU8kMRka/zQs1fCEpQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hcV7Yu1WK4hL71lRucisEPi1ndG+9QDxeTfjfs2vqMqItkZfQ4nQJ7NzHw8ARaeuh
	 hq/MNo5nJJ1uKDXWgtCKk/59jjaT6t8LyY+jOc34f5MknU8tXpH1CbmiooctUJB+Vj
	 nE9OIYNWRZkpEKAtA6ho2+tPtwylWi2aG9eRrGxtoEmPknHfhg9KFeaLX0G/a4Smmi
	 jGL5lLx19/LCzy2M5nxzb7F6OWdMMSB2G034mngDsPT2qWKV7hcoQWyiVrkifpemhJ
	 V4Y3fekQtX2eAcu2M8jIvwzQsGTgkeTdt8xh1xISP4urRvuwfY3W7XePeg7tiTJOgh
	 z+mBk2XvCSeqw==
Date: Tue, 21 Jan 2025 07:44:24 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cixi Geng <cixi.geng@linux.dev>, devicetree@vger.kernel.org, 
 wenhua lin <wenhua.lin1994@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
 Zhirong Qiu <Zhirong.Qiu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
 Orson Zhai <orsonzhai@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-serial@vger.kernel.org
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
In-Reply-To: <20250121115404.3612588-1-Wenhua.Lin@unisoc.com>
References: <20250121115404.3612588-1-Wenhua.Lin@unisoc.com>
Message-Id: <173746706432.2493664.199542333902610683.robh@kernel.org>
Subject: Re: [PATCH V3] dt-bindings: serial: Add a new compatible string
 for UMS9632


On Tue, 21 Jan 2025 19:54:04 +0800, Wenhua Lin wrote:
> The UART IP version of the ums9632 SoC project has been upgraded.
> UART controller registers have added valid bits to support new features.
> In order to distinguish different UART IP versions, we use sc9632-uart
> to represent upgraded IP and sc9836-uart to represent old IP.
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
> V2->V3 changes:
> * Lists are ordered by fallback.
> * Combine two const items into enum.
> * Change commit message.
> 
> V1->V2 changes:
> * Modify the compatible string of enum.
> * Change commit message.
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/serial/sprd-uart.yaml:30:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250121115404.3612588-1-Wenhua.Lin@unisoc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

