Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B6C83001
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A7C206E2
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="vOy6cik5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgD1OKX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:10:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38506 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgD1OKW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 10:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1588083017; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+w+KwDzaOwV/ww7pNfZrsFBOSdK2uRoIyYyszXC2jE=;
        b=vOy6cik5Ke533LRPLshMJ+qzIX64H6Cij9kixdoYn7wlFWU7BcpUORTgGjl00q+cPNyTHh
        BbFCg7mLoK1rJVPcplaMCp9tjrNaBELaA/yLJ5L01LwPb6aiWQha9Riei2/T2hz8Wp0kvk
        mMmfgtX5WwOdDWnDWKeSk5Jfz8HZyCs=
Date:   Tue, 28 Apr 2020 16:10:05 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/8] dt-bindings: intc: Convert ingenic,intc.txt to YAML
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org
Message-Id: <TO4I9Q.UQRWC3A2ABT52@crapouillou.net>
In-Reply-To: <f865b39a-3e8d-a367-45b2-aa5e7412e81a@cogentembedded.com>
References: <20200426185856.38826-1-paul@crapouillou.net>
        <20200426185856.38826-2-paul@crapouillou.net>
        <f865b39a-3e8d-a367-45b2-aa5e7412e81a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sergei,

Le lun. 27 avril 2020 =E0 12:11, Sergei Shtylyov=20
<sergei.shtylyov@cogentembedded.com> a =E9crit :
> Hello!
>=20
> On 26.04.2020 21:58, Paul Cercueil wrote:
>=20
>> Convert the ingenic,intc.txt doc file to ingenic,intc.yaml.
>>=20
>> Some compatible strings now require a fallback, as the controller
>> generally works the same across the SoCs families.
>>=20
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> [...]
>> diff --git=20
>> a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.ya=
ml=20
>> b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.ya=
ml
>> new file mode 100644
>> index 000000000000..28b27e1a6e9d
>> --- /dev/null
>> +++=20
>> b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.ya=
ml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:=20
>> http://devicetree.org/schemas/interrupt-controller/ingenic,intc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ingenic SoCs interrupt controller devicetree bindings
>> +
>> +maintainers:
>> +  - Paul Cercueil <paul@crapouillou.net>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^interrupt-controller@[0-9a-f]+$"
>> +
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +        - ingenic,jz4740-intc
>> +        - ingenic,jz4760-intc
>> +        - ingenic,jz4780-intc
>> +      - items:
>> +        - enum:
>> +          - ingenic,jz4775-intc
>> +          - ingenic,jz4770-intc
>> +        - const: ingenic,jz4760-intc
>> +      - items:
>> +        - const: ingenic,x1000-intc
>> +        - const: ingenic,jz4780-intc
>> +      - items:
>> +        - const: ingenic,jz4725b-intc
>> +        - const: ingenic,jz4740-intc
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>=20
>    Do double quotes work the same as the single ones?

Yes. The only difference is that you can escape characters in double=20
quotes.

-Paul

>=20
> [...]
>=20
> MBR, Sergei


