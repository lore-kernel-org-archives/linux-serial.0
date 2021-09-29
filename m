Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D15C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 21:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48646613CD
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbhI2Vbu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:31:50 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35610 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbhI2Vbu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 17:31:50 -0400
Received: by mail-oi1-f173.google.com with SMTP id n64so4676025oih.2;
        Wed, 29 Sep 2021 14:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xj3A4rvClnuXjjs9tt5J5UAtJSSY9GP9bYs5NYEPfs8=;
        b=dlkEnL1/PjATKw+BYyLiHsbslr1o78bPXXInb0cF1yM8ZT1DnOs2gHKbAyCtefYGzj
         VgdmmVs5UVP6SnlvnSNgYb66qqZQu1/bAymm2SYZNs4vQ15L8l9POFiLVP/35UerNS0g
         0WepLMGeSIRezaNpPWlCIiVMlWi13BfmWlSnJQ0tVMpqqKzjBf9XU/5RFgglF6Y7pwZm
         MKRcsiSfP/IaiPgyFqewbNXvjl1Z1T1ZlKFWBm8e+UceQmlpTmZpCuWZJ1GBKUp8Xkvd
         PC8Ioi1yzH2/mAQu0FvUip/1gezBbSWJXc6pFXn7PchoqKN0Zj8zabEPAhGx3v72c7tg
         K7yw==
X-Gm-Message-State: AOAM530Dmb8cEtWYlFOnrwLEOgM8jUUu1sqerRa0GDps1aZ/eZJ+LetG
        eWdfB/N/meNj68HU4xTxwbd2IfsfCg==
X-Google-Smtp-Source: ABdhPJwMOVqFhsChePGW0D8oj7w80frc/fDvBCM3G907ladFwiT0DkQpLc8pRZba5bEr7dmrT7qtGw==
X-Received: by 2002:a05:6808:a9c:: with SMTP id q28mr9871562oij.148.1632951008390;
        Wed, 29 Sep 2021 14:30:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh39sm225250oib.37.2021.09.29.14.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:30:07 -0700 (PDT)
Received: (nullmailer pid 244287 invoked by uid 1000);
        Wed, 29 Sep 2021 21:30:06 -0000
Date:   Wed, 29 Sep 2021 16:30:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <YVTa3pt279D/qWz6@robh.at.kernel.org>
References: <20210929082034.15098-1-pali@kernel.org>
 <20210929082034.15098-4-pali@kernel.org>
 <1632923185.716457.3674443.nullmailer@robh.at.kernel.org>
 <20210929140132.gom6qiohucsczoxq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210929140132.gom6qiohucsczoxq@pali>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 29, 2021 at 04:01:32PM +0200, Pali Rohár wrote:
> On Wednesday 29 September 2021 08:46:25 Rob Herring wrote:
> > On Wed, 29 Sep 2021 10:20:31 +0200, Pali Rohár wrote:
> > > This change adds DT bindings documentation for device nodes with compatible
> > > string "marvell,armada-3700-uart-clock".
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > ---
> > > Changes in v6
> > > * Fix license
> > > * Rename node to clock-controller@12010
> > > * Remove maxItems
> > > ---
> > >  .../bindings/clock/armada3700-uart-clock.yaml | 56 +++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: $id: 'http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
> > 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: 'maintainers' is a required property
> > 	hint: Metaschema for devicetree binding documentation
> > 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> > ./Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: $id: relative path/filename doesn't match actual path or filename
> > 	expected: http://devicetree.org/schemas/clock/armada3700-uart-clock.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: ignoring, error in schema: $id
> > warning: no schema found in file: ./Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > Documentation/devicetree/bindings/clock/armada3700-uart-clock.example.dt.yaml:0:0: /example-0/clock-controller@12010: failed to match any schema with compatible: ['marvell,armada-3700-uart-clock']
> 
> Hello! What does this error mean?
> 
> Should I add .yaml suffix into '$id: ' line and rename file via?
> git mv Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml

Yes. They need to match.

Rob
