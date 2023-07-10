Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2AFEB64DC
	for <linux-serial@archiver.kernel.org>; Mon, 10 Jul 2023 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGJSW7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjGJSWu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jul 2023 14:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D4189;
        Mon, 10 Jul 2023 11:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5D061190;
        Mon, 10 Jul 2023 18:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3530AC433C7;
        Mon, 10 Jul 2023 18:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689013368;
        bh=zhWL6PsIuT2O5z7O3PejqMxdq/24+BCbNFiR11xE4Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brP2ygGxCH3YTqXc1g40MhZglw9deDZeYBPRckbfG4Hd+0cPHbca7/0tOINwvMTl5
         u4A8QizM7EXmsC3/AgRwBr4rczfGX3r8RxPfIEp4ARAQnxcADSZYZpla3ZTfm0gh0e
         jlnKIvHT1VNP7PoTZMuEeXd4Yq9K3baI+cgWVjz7AgKEE7ubZt2gWFnwqSrrSfsluA
         cP/xSAN1rkW393AIzgwtZewwv5MqRXYDveyEpJOl/D8je86qORrr3Xf1en3cY4VVvZ
         tREtbKzPqSS+ZxCUGaRvZqbdBJMEIyAVj9/mXAGJNAZFXQC/BzjEMjGhahvbY1wwIi
         NNFo0WaJo31ww==
Date:   Mon, 10 Jul 2023 19:22:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Remove obsolete cavium-uart.txt
Message-ID: <20230710-ambulance-pristine-2e14935c1cc0@spud>
References: <20230707221602.1063972-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vclZz3wH2Hz9WiNt"
Content-Disposition: inline
In-Reply-To: <20230707221602.1063972-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--vclZz3wH2Hz9WiNt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 04:16:02PM -0600, Rob Herring wrote:
> cavium-uart.txt binding is already covered by 8250.yaml, so remove it.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--vclZz3wH2Hz9WiNt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKxMdAAKCRB4tDGHoIJi
0uFpAPwMxi/zNALLQ/K2qG8O7oHAg+hMK8pNs36aCLo3MEqAQAD9FJPEooLjpJZM
GXp86f0rPmXKoaA1Etbv7aqlZqI11gg=
=IL5d
-----END PGP SIGNATURE-----

--vclZz3wH2Hz9WiNt--
