Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EBBC4361B
	for <linux-serial@archiver.kernel.org>; Sat, 12 Dec 2020 10:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D59822D50
	for <linux-serial@archiver.kernel.org>; Sat, 12 Dec 2020 10:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438724AbgLLKcn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Dec 2020 05:32:43 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:55514 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404988AbgLLKcn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Dec 2020 05:32:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 5D710123B2F;
        Sat, 12 Dec 2020 08:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607758352;
        bh=kZeSCSwSGTWmFcQdD2xOY2pXclNCQANQ9vp1xU+NWxA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=8CTKUbynervwWV8olbmC3kb00d2Xmi+LHUtGTqProgANws7js8kuxF2fMUmNKPkFn
         klkop4M0hvpmztbm2ahDmpioLQjx/rWT2mz12a3+Vg8fei0rNn9GinyCS37BZX2BG5
         KF8l0t/+2eJm6bLE3YiJ++6gdLJlrmES4cCS0yl1bwUWvY6SDAYQHYkSlgfeMSLpkz
         U+7vxLFScL/3cC3lnyPUubZHyJK+LTV6qlgHMv8FY4FUPBtu4TnaYUiWM/Dtu07K0H
         k0Jv3gDOIvPhUjgCcuribvV1FhB5Wpo/WXZC5SmQ/cXI3PwAHNPAReznYjL/3jF5++
         xhPbU4Kv1ipLA==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i_zPc8qjmekt; Sat, 12 Dec 2020 08:31:34 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id E587A123B29;
        Sat, 12 Dec 2020 08:31:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607758294;
        bh=kZeSCSwSGTWmFcQdD2xOY2pXclNCQANQ9vp1xU+NWxA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bPvAWdQURUYh09IDcnvXjTzii/iTdHSBd07hU453xSt8yHTbpyNKyEE0q/0WpVJmV
         qEegehpGzms/mY2dZFyKyCz6Leha6UeNtZoPJU6rJzAX7xiH3du02IHOk6s+LgQzVz
         dgJqWrQ0DmLvVSlx0MUrDv5XFNaR0PKCJvSn92v99ucRoihgHvk+BmY+4Eng3v5+ja
         06CPOQvxTG0BbLwdgPqwaQ3qM7eYFzzKxWMSFvYP7uO7zw/fZKR/J65SuzGBy9qdEj
         TG5mgGmznpDZn2+QHt+ykqFyfOSVzg5ujmTW1CNIW9Qo25bXToNsC9hs/LD+sZh+08
         Q0Uow4iUiMvwA==
Date:   Sat, 12 Dec 2020 07:31:32 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Serial: silabs si4455 serial driver
Message-ID: <20201212073131.GA14792@dincontrollerdev>
References: <20201212070944.GA13909@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201212070944.GA13909@dincontrollerdev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Dec 12, 2020 at 07:09:46AM +0000, József Horváth wrote:
> This is a serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> The goal of this driver is to removing wires
>  between central(linux) device and remote serial devices/sensors,
>  but keeping the original user software.
>  It represents regular serial interface for the user space.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> Signed-off-by: József Horváth <info@ministro.hu>
> ---
>  .../staging/serial/silabs,si4455.yaml         |   95 ++
>  MAINTAINERS                                   |    6 +
>  drivers/tty/serial/Kconfig                    |    8 +
>  drivers/tty/serial/Makefile                   |    1 +
>  drivers/tty/serial/si4455.c                   | 1328 +++++++++++++++++
>  5 files changed, 1438 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/serial/silabs,si4455.yaml
>  create mode 100644 drivers/tty/serial/si4455.c
> 
> diff --git a/Documentation/devicetree/bindings/staging/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/staging/serial/silabs,si4455.yaml
> new file mode 100644
> index 000000000000..d3a8c07c6714
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/serial/silabs,si4455.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml#"

In this version I changed the $id to "http://.../staging/..." and removed $ref: "serial.yaml#".
The make dt_binding_check completes without any error or warning, but this is not a good solution.

My question is, how can I use $ref: "serial.yaml" dependency, while my schema is under staging?
	allOf:
  	  - $ref: "serial.yaml#"

The make dt_binding_check output, while the schema is in staging, and $ref: "serial.yaml" dependency in the schema:

	Unknown file referenced: [Errno 2] No such file or directory: '/home/administrator/.local/lib/python3.6/site-packages/dtschema/schemas/staging/serial/serial.yaml'
	xargs: dt-doc-validate: exited with status 255; aborting
	Documentation/devicetree/bindings/Makefile:59: recipe for target 'Documentation/devicetree/bindings/processed-schema-examples.json' failed
	make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.json] Error 124
	Makefile:1364: recipe for target 'dt_binding_check' failed
	make: *** [dt_binding_check] Error 2



> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Silicon Labs Si4455 device tree bindings
> +
> 
> 

Üdvözlettel / Best regards:
József Horváth

