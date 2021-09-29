Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB48C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F489613D3
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 14:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhI2OFG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245240AbhI2ODQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 10:03:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 848C960F4F;
        Wed, 29 Sep 2021 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632924094;
        bh=u765s826tzbfU6E7Jd+UfNUmJveS9TYHdoRPAUBCuQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqx8IaVhudHizsPHXmBuAIACus4x8V6AtWzV14J6HjnFg4wasOX4qg8jYK6/prsoM
         ZFsRWknBPnZ7YftRS3qfUsWAH0Qrfctd6vkrh4DMBnH7yncp0jh6oKKwqRGF2LL4n1
         eWjLFIJItIB92u1wE/18XCOn/nMde3fLI6GHxVqPo3+qaUtHk3zbYoxSnnAz8dYv2+
         RYyTuaVYcB9vRF8DxeLXAudMTarxHFquZBPHOZQiEnHxtIbzGEUPw4v92BmGA9ZNFK
         ItK38QSUr0PXJyQ7i6iA++bxRo6iWmk+xhirHQSYhjbNfSeS+Vnb+gl+dT+47P6T3P
         vNBdX0Rac/Gow==
Received: by pali.im (Postfix)
        id 28A0E76E; Wed, 29 Sep 2021 16:01:32 +0200 (CEST)
Date:   Wed, 29 Sep 2021 16:01:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <20210929140132.gom6qiohucsczoxq@pali>
References: <20210929082034.15098-1-pali@kernel.org>
 <20210929082034.15098-4-pali@kernel.org>
 <1632923185.716457.3674443.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1632923185.716457.3674443.nullmailer@robh.at.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wednesday 29 September 2021 08:46:25 Rob Herring wrote:
> On Wed, 29 Sep 2021 10:20:31 +0200, Pali Rohár wrote:
> > This change adds DT bindings documentation for device nodes with compatible
> > string "marvell,armada-3700-uart-clock".
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > Changes in v6
> > * Fix license
> > * Rename node to clock-controller@12010
> > * Remove maxItems
> > ---
> >  .../bindings/clock/armada3700-uart-clock.yaml | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: $id: 'http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: 'maintainers' is a required property
> 	hint: Metaschema for devicetree binding documentation
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> ./Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/clock/armada3700-uart-clock.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: ignoring, error in schema: $id
> warning: no schema found in file: ./Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> Documentation/devicetree/bindings/clock/armada3700-uart-clock.example.dt.yaml:0:0: /example-0/clock-controller@12010: failed to match any schema with compatible: ['marvell,armada-3700-uart-clock']

Hello! What does this error mean?

Should I add .yaml suffix into '$id: ' line and rename file via?
git mv Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml

Or something else is needed?

> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1534231
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
