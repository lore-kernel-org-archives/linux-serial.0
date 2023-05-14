Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52843C77B7F
	for <linux-serial@archiver.kernel.org>; Sun, 14 May 2023 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjENSjh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 14 May 2023 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjENSjg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 May 2023 14:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE53AA0;
        Sun, 14 May 2023 11:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CBA860DF5;
        Sun, 14 May 2023 18:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423EFC433EF;
        Sun, 14 May 2023 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684089574;
        bh=0qXKkwNgm6r8LyU3fLXnR/zhU9ezOkHvW6g+/vQsORQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZN0yKtHCAVyLMwWTyWR2il5idn3KVri9Dkfgi3FgoqH4LUvPSKfFS3njmzMdJv7bi
         8GxNaqYWiDext2jk8UEk8IxirT0OfC+aDvAGODzjkSgEZHzoTFVCm3rKw95dG7PLKU
         07g3QH7ah/bGxGAcrZk0a60PHmHueegY2myFlwP11ze1n6YqqNNQG5t8ozSYZUqfCx
         LjGtP+5UnDd6Wymf1/Ui7Jc3XcFdIwwPPUr+A/kin8rPf31XRLWkiX+brZbu2TkUio
         0oWlJoxCH+86JhRe1knEU4z0y0ulqdZoSTpc/J9BVNvbvD6zSE8DTMTfC4p5iCqbNE
         ZJhcn07dyo2mg==
Date:   Sun, 14 May 2023 19:39:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Message-ID: <20230514-kinetic-backlog-b9573ae06507@spud>
References: <20230514165651.2199-1-jszhang@kernel.org>
 <20230514165651.2199-7-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jd7+Ni3EpcRTOoVW"
Content-Disposition: inline
In-Reply-To: <20230514165651.2199-7-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--jd7+Ni3EpcRTOoVW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 12:56:47AM +0800, Jisheng Zhang wrote:

> +title: Bouffalo Lab Technology SoC-based boards

I know you're only propagating an existing pattern, but the "SoC-based"
looks rather odd!

> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Carrier boards for the Sipeed M1s SoM
> +        items:
> +          - enum:
> +              - sipeed,m1s-dock

BTW, do you know of any other m1s compatible docks?
I couldn't find any other ones via Google, so maybe it is just worth
swapping the enum here for another const.
Either is fine by me though.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--jd7+Ni3EpcRTOoVW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGEq4AAKCRB4tDGHoIJi
0gALAP9Ok3alh7NIJMaSq8fKkKGEXm45QwG/nxQVUVvv5NFqIQD+NT/UaDdpRQ9b
AtE7/sESaeGevB6XmhBXdSnfDb6n3Ak=
=aXIX
-----END PGP SIGNATURE-----

--jd7+Ni3EpcRTOoVW--
