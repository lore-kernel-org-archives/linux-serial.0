Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F5C7EE29
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 15:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbjEYPPM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 11:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbjEYPPL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 11:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD3FA3;
        Thu, 25 May 2023 08:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F07BD61BBA;
        Thu, 25 May 2023 15:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB3DC4339B;
        Thu, 25 May 2023 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685027709;
        bh=37eNBLZ1YbsqlLGGXbdA21QfOPaYWspY1FN2V3p/B18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UT9oLGCSn30ytDnmVTII/SVnCYpcAVNAaSECDk1zbKnYjB7555Eu0AcN30O06+tQC
         OVqnlU3MP5bx75hYWLmc2akKS4NW+ozPCmmDN7F/fWYH2Ga/mR56VuW/fqrEDRMAG7
         WiPly+C9I5m08nuJXBYI8Z7vnCdbveNgfzjRDTf1t4jnYpPMJ7O8gK6PqKZ7Y4c+lp
         o3Ymt1dNv6Lg9xVhG70V5ioOpiwBSNZq8MHL2sNaCwlI1Rr24S1jDOVFBmnTDjI1C2
         bkSQ9wwTwEui4YHD7oOdCUrQUHKma7FFr7CR0/7vgDGQWSA4iDzyW/nbSOx/Y7ZNbp
         8vIajuWjY8R9g==
Date:   Thu, 25 May 2023 16:15:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 07/11] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Message-ID: <20230525-bling-entree-1446ae1c56bc@spud>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-8-hugo@hugovil.com>
 <ZG9CWhiTbLBKjPC9@surfacebook>
 <20230525103443.d3d31e80221aed1ebceef30e@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vvVfhAnb5U6ok/6J"
Content-Disposition: inline
In-Reply-To: <20230525103443.d3d31e80221aed1ebceef30e@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--vvVfhAnb5U6ok/6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 10:34:43AM -0400, Hugo Villeneuve wrote:
> On Thu, 25 May 2023 14:11:22 +0300
> andy.shevchenko@gmail.com wrote:

> > I'm wondering if we can convert this to YAML first and then add a new property.

> I think it would be best to do it after this patch series.
> Keep in mind that the original intent of this patch series,
> and this new property, was to fix a regression related to the
> GPIOs, and I think that converting to YAML would simply delay
> and add much noise to the discussion at this point.

I think that that is reasonable.

--vvVfhAnb5U6ok/6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG97dAAKCRB4tDGHoIJi
0vmLAQCO7y7stkqQr4pMNeYhLjjyhxwHDBTLgxPmlHBODmY/PQD+JSDbLAa5JGrK
0bMwzm7hygPdo/5VJXve5BO3OMbY6QM=
=vRUN
-----END PGP SIGNATURE-----

--vvVfhAnb5U6ok/6J--
