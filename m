Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42CC35DF5
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6690C20637
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 09:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gkTk2rb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMiDvNMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgBYJLB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:11:01 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53333 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgBYJLB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 04:11:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0BAF57BFE;
        Tue, 25 Feb 2020 04:11:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Feb 2020 04:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=2vqTwRAj8rKUQI5FEi3ykYXRB1k
        4zegHIlQuKg4fomE=; b=gkTk2rb6Z/D8ORisKTkhB1y+SH06kgCf5Pq2c476/O9
        IyltflJ/+Dq1fp8678f7e0wjFdNroQdoEQfkWrZ7jkhee54vE0VgFRSGgVwZNWK/
        hYA8P/IBn2LNbe/E/VjX+XE1jz62u6aNeki0I314o2eF08T3uzJXuFZ1ZzPnrkB1
        NlxT0bqCry1qAf1Sn39Na0uag9CHe2raGK8OSdHZeRuYpC6yjm4FwLo+mOluDtdW
        afnbMbWMf4sFzgZFB4lmqKlsFRkVgrqpotkYUAh/zF8Ddj5EBxHnYhwXjsGHHZr2
        +cZvHITZW2+R3OddfyYrAaoPGZ3AClo39aO+q0Q/EKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2vqTwR
        Aj8rKUQI5FEi3ykYXRB1k4zegHIlQuKg4fomE=; b=NMiDvNMajHaTcmhNhHJDRJ
        LxoRolymMSLrRfnC6Zfe/tdjtSgorGcRt1KUNOWEg4u15nFEsCcFtE4ewc3ogqL/
        /YYDfhOep/u7JiXTdaCLcXTZQR3JN/kegTt1PRz/EYH+DkX3DkTcRaaAxj0oCT5G
        sJulfl9NbYp35pwmTNBMdN1TpxWWN/K36nu9tJ9XJWBPfZs0HoaR9MACuL60h+7G
        Wm3f8epOGNHXg0IRoulAKrt0c3sZpHM9rpcJm5gjSbP0K9ym3e58a0ySCOqymwz1
        h90IrxnC5daRJ707E3rPtzRO3VF5wOdicWVwDQbJF/y4Os0VMUmbGCqZPM4V6G+g
        ==
X-ME-Sender: <xms:oeRUXrAI_D5lMyeQrh8Y3PI5agSSN74a1OXVEw6YYsKhXaM1zzQ5zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
    gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:oeRUXpPp_tWwjZ5pBvF__9IjfA7_SYFMb_fJkhiPTMNqcPYv5Z1Vyg>
    <xmx:oeRUXoyVlVMIhiKZ2a7RhVmWsEvryuZPI8XFgXhn9RlgLUovu5sL2A>
    <xmx:oeRUXsf5xQiPAdVua7pKGb6rMMxFptU4NPlbe0O8ISHJTfAaJfrrjg>
    <xmx:pORUXsDYLuWCdLiFjcC3j_NZSInmV5T-JKOadfkUFxS16bPHqlZLdw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE2CB328005D;
        Tue, 25 Feb 2020 04:10:56 -0500 (EST)
Date:   Tue, 25 Feb 2020 10:10:55 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200225091055.ubm5r3p6r4ydchyh@gilmour.lan>
References: <20200225094437.4170502-0-mholenko@antmicro.com>
 <20200225094437.4170502-2-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qlwsrkwbcxhj43j"
Content-Disposition: inline
In-Reply-To: <20200225094437.4170502-2-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--7qlwsrkwbcxhj43j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mateusz,

On Tue, Feb 25, 2020 at 09:46:45AM +0100, Mateusz Holenko wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
>
> Add documentation for LiteX SoC Controller bindings.
>
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
>
> Notes:
>     This commit has been introduced in v3 of the patchset.
>
>  .../soc/litex/litex,soc_controller.yaml       | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml b/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
> new file mode 100644
> index 000000000000..039894265319
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
> @@ -0,0 +1,46 @@
> +PDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/litex/litex,soc_controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LiteX SoC Controller driver
> +
> +description: |
> +  This is the SoC Controller driver for the LiteX SoC Builder.
> +  It's purpose is to verify LiteX CSR (Control&Status Register) access
> +  operations and provide function for other drivers to read/write CSRs
> +  and to check if those accessors are ready to use.
> +
> +maintainers:
> +  - Karol Gugala <kgugala@antmicro.com>
> +  - Mateusz Holenko <mholenko@antmicro.com>
> +
> +properties:
> +  compatible:
> +    const: litex,soc_controller

Usually compatible will use dash as separators, not underscores.

> +  reg:
> +    description: Base address and length of the register space

This is usually removed since it's what's expected from the property
anyway. However, what you should really test for in the number of
address/size couples being set, and you can do that using maxItems: 1

> +  status:
> +    description: |
> +      disables or enables node
> +
> +    const: "okay"

This is added automatically by the tooling, so you can leave it out.

> +required:
> +  - compatible
> +  - reg
> +  - status

And in general, status is not required. Leaving status out is
equivalent to status = "okay"

> +examples:
> +  - |
> +
> +  soc_ctrl0: soc_controller@f0000000 {
> +			compatible = "litex,soc_controller";
> +			reg = <0x0 0xf0000000 0x0 0xC>;
> +			status = "okay";
> +  };

The indentation looks weird here?

Maxime

--7qlwsrkwbcxhj43j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlTknwAKCRDj7w1vZxhR
xTU6AQD8Cy+uoGwSrrpsJlekRlGK1bt9y8kmOWrOWFI/wEg4sgEA1FuWrfWI4m9J
4Mg4k4q9o4wFx3JoZnsWCNziqQYXugU=
=agyM
-----END PGP SIGNATURE-----

--7qlwsrkwbcxhj43j--
