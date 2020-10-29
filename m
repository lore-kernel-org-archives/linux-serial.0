Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B859C2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD7F20782
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 13:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ufT+6Q2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgJ2N0n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 09:26:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33442 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgJ2N0m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 09:26:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09TDQdlp073095;
        Thu, 29 Oct 2020 08:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603978000;
        bh=GkhCoHJ1/XnzOLNyI1cMIoAAwgZQEjOKh0XhF9teF0Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ufT+6Q2yK3VlnvW+xry6bxZ6U7/tk3uOAZgCyr1ONBLOXnSVJMcOEtm7FujWvT3rb
         I7sxRCvQ/xZq4SN62zIP3vOOa20qawq2AId7ZEuFWPVgVcNyNT1xmu3cdTBvIx10/c
         JeKhOs2c229U5TcplzT6Kj8fUpVX7XZIX7pMD75U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09TDQdrq119625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 08:26:39 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 08:26:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 08:26:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09TDQdxL109917;
        Thu, 29 Oct 2020 08:26:39 -0500
Date:   Thu, 29 Oct 2020 08:26:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: Re: [PATCH] dt-bindings: serial: 8250_omap: Add compatible for UART
 controller on AM64 SoC
Message-ID: <20201029132639.xx7eoy4zrj2echi3@uphold>
References: <20201029065318.2437-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201029065318.2437-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12:23-20201029, Vignesh Raghavendra wrote:
> AM64 uses a UART controller that is compatible with AM654 UART.
> Introduce a specific compatible to help handle the differences if
> necessary.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
> index dcba86b0a0d0..c2db8cabf2ab 100644
> --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
> @@ -1,6 +1,7 @@
>  OMAP UART controller
>  
>  Required properties:
> +- compatible : should be "ti,am64-uart", "ti,am654-uart" for AM64 controllers
>  - compatible : should be "ti,j721e-uart", "ti,am654-uart" for J721E controllers
>  - compatible : should be "ti,am654-uart" for AM654 controllers
>  - compatible : should be "ti,omap2-uart" for OMAP2 controllers
> -- 
> 2.29.0
> 

Thanks.

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
