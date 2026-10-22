Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685593;
	b=asfw/+D5anPGSWiG3n4MRBeRGL2TgT6F0ulLKbU83U+/c6D4KImyVkcDA6KKnXa3Go+E
	 uR4cxO4IZ0xt+dEq0LtqBRBAcvPTFp4xJE60qI2zdIm+01Sn+/Q0+qvCcvsXMOa9tL2E9
	 K1DuufNjG5+d2VPS7g0V7gfnSexnDkTUj9dmcx3Kf6e9cAaN8MWNmgE6E8rDozKMI3XIH
	 ph1SXVBa6hTHK9gkAchIsjfInkZebLi2EhvlJ8R/IvN6DLH3t0rtAFRlWQrqa1bMmzXSU
	 5ThG3j0zmlIpThiaC3BSKe309alIEtaUSmkCHKUH5/JIeXaQrNs0KqZXTFt3G2nb7UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XDz/lwya9jMSrhLocsFPNFuLuLQjmn2ktvow5ko6z6U=;
	b=eZ7BdESGTD1L+bMLJGA5manAUX/LtXbq9o03id8l0He7THuy8aIAt0i/AeE2tFyM30kz
	 cHOk5zOc9Jv9kD4FUNbgGQyVvmDoVpN5luYJBxpZeH96T8fHEfEkMKL0938tqVK/O5/xQ
	 Ss7EzBlLQicI1pu5IOGdGrP5euz5aYNi5JgHkJHeS8WrjuujMIqMfArKLoMY8Lvq0hoZJ
	 Am+FayQPDkuUwX2paGJW+1423jRJYrwzBSweYQaRImN9js0unnFHJBy7JtRJJAlSPV5CG
	 yY5AUzTJ9K6Ij1cNU2fmOoLST8pNSLUebU38haSGXP8XPnHBa3d/6SRdydPKzG3tFyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atKhmJaJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BD606A319;
	Thu, 22 Oct 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atKhmJaJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802DB1F01829;
	Thu, 22 Oct 2026 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685593;
	bh=XDz/lwya9jMSrhLocsFPNFuLuLQjmn2ktvow5ko6z6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atKhmJaJ+qyln1K9yWxChooXgOD/sgxzLCNn5O0n1f3qUkuA3tZaNa4WtNeVV3W0W
	 Xyp/QsGPxkv6SI0oBPBabOpAYfNJdIxdq4/t9gizrOmBVjJFuEBqlr3VsPIZp7aGuf
	 ZmKhvkSbtACgxqqltjjX6vb0h+6ol+kpTcZcrxC+L8TZxfKVk4UH/Sm8UiZNekba7t
	 pov9KL/nD+hGTbafBYnuF6ePMIWKTDZHzFR/PnAPRkzGYcP/EnJyvqxuQ2AmBFXLy8
	 fyvKbT6W7gC+kCMYqjJFPBqEomBfRrome7BjbkBdft1u6P20rfA68XxnZ+fzdinzFP
	 /YNjibrTG3G8A==
Message-ID: <sashiko-outbox-181778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/27] dt-bindings: net: rockchip-dwmac: Add RK3572
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-14-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-14-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: net: rockchip,rk3572-gmac missing from snps,dwmac.yaml
--

commit d49e116eebf8a880b2905b76936e70d57c74d68e
Author: Cunhao Lu <1579567540@qq.com>

dt-bindings: net: rockchip-dwmac: Add RK3572

This commit adds the rockchip,rk3572-gmac compatible string with the
snps,dwmac-4.20a fallback to the Rockchip dwmac device tree binding
schema.

> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/=
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 80c252845349c..83b0a81b4f3b7 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml

[ ... ]

> @@ -54,6 +55,7 @@ properties:
>                - rockchip,rk3506-gmac
>                - rockchip,rk3528-gmac
>                - rockchip,rk3568-gmac
> +              - rockchip,rk3572-gmac
>                - rockchip,rk3576-gmac
>                - rockchip,rk3588-gmac
>                - rockchip,rv1126-gmac

[Severity: Low]
Should rockchip,rk3572-gmac also be added to properties:compatible in
Documentation/devicetree/bindings/net/snps,dwmac.yaml?

Documentation/devicetree/bindings/net/rockchip-dwmac.yaml references
snps,dwmac.yaml# under allOf:

  allOf:
    - $ref: snps,dwmac.yaml#

In Documentation/devicetree/bindings/net/snps,dwmac.yaml,
properties:compatible lists all Rockchip gmac compatibles from
rockchip-dwmac.yaml so that schemas including it can validate properly:

  properties:

    # We need to include all the compatibles from schemas that will
    # include that schemas, otherwise compatible won't validate for
    # those.
    compatible:
      contains:
        enum:
          ...
          - rockchip,rk3506-gmac
          - rockchip,rk3528-gmac
          - rockchip,rk3568-gmac
          - rockchip,rk3576-gmac
          - rockchip,rk3588-gmac
          - rockchip,rv1108-gmac
          - rockchip,rv1126-gmac

Prior commits adding or syncing Rockchip gmac compatibles (such as commit
4a667bec74b3 for rk3506, commit 299e2aefb159 for rk3576, and commit
e774c91dca45) updated snps,dwmac.yaml alongside rockchip-dwmac.yaml,
whereas omitting rockchip,rk3572-gmac leaves the two schemas out of sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D14
