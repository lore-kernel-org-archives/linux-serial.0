Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE9DC4361B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 20:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9919D22C7D
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 20:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgLOUrs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 15:47:48 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:36522 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgLOUrm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 15:47:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 00DE6123B5B;
        Tue, 15 Dec 2020 21:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1608065205;
        bh=19l+chU3+45wQcptA8+XqtWJ7OyQVDIIoXRA/3ApHwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYejNmqWHnLAY7p7fKkGbmWAz/mzzH4q7Wa/XSibgCa+jd2fHbrpvbukwRgveP9b6
         i70JOl9zqkPQj/3I6nsWRlcUrVZmgjc65siEi4eU5NY2jRsgCPGmtaMO8x5FYF4WTY
         QJ0rnPnc0TmLcUaxBnr8jrBw08Ezmxmj5Ru9gSfBZ0sq6otVs21XagrwGUxBNvHogy
         lFOeNmfbOXJ8S2POSfRL/qurFLVimyjYN+Peg/rnAX5WgKDGDdS5JM4xlJCmGrPjci
         8YmZQ3LnADdDS9NiaR+XwUtGOQIpHhXr0HkLUah6HWJGH7H6DSQ9DXkv3yPPazeRXs
         FPUdgSXp+bGAw==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CnQoZGfJPRoV; Tue, 15 Dec 2020 21:46:20 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id E7A24123B47;
        Tue, 15 Dec 2020 21:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1608065180;
        bh=19l+chU3+45wQcptA8+XqtWJ7OyQVDIIoXRA/3ApHwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=8paTSlZ1VTyh0RYtDIhJTUghadlzmSW7RbQd+9o55JNtYNM11zmg58gLCs1v8ido+
         m/l37eMu6SWnmoEpI8tnfQQypXXErs3BDsWZ+A5roMJZPUyXMYh3tlQx364cFSocQD
         qJJwxbmYNhjRrNxjNAXaCvjZ0Rt+Gb9msHTdmLXzSlSTGYYbSTg3bv3dVih0+6yQfV
         9J6tRYDYEV90dtWz3sR32oi31rN81jPZcLLqcx3OY4iaX1Ca9BIYcycKEmbmP2l3nD
         jEY1EppXJAWp0n8VzD8PZcB97bRT/BH/jNb6e6ZhhZ6KssMW1FBtXOkY3Xj/DRTZgX
         bWSnLfcgR31oQ==
Date:   Tue, 15 Dec 2020 20:46:17 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Rob Herring <robh@kernel.org>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Serial: silabs si4455 serial driver
Message-ID: <20201215204617.GA14153@dev>
References: <20201215072004.GA12388@dev>
 <20201215200219.GA4148374@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215200219.GA4148374@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 15, 2020 at 02:02:19PM -0600, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 07:20:07AM +0000, József Horváth wrote:
> > This is a serial port driver for
> >  Silicon Labs Si4455 Sub-GHz transciver.
> > 
> >  - fixed: dt-bindings: silabs,si4455: serial.yaml reference added
> 
> The revision history should be after the '---' so it is not in the git 
> history when applied.
> 
> > Signed-off-by: József Horváth <info@ministro.hu>
> > ---
> >  .../bindings/serial/silabs,si4455.yaml        |   98 ++
> 
> Please make the binding a separate patch.
> 
> >  MAINTAINERS                                   |    6 +
> > +  silabs,ez-config:
> > +    description:
> > +      Radio configuration data file name.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    items:
> > +      pattern: ^[0-9a-z\._\-]{1,255}$
> 
> We use 'firmware-name' property for this purpose. 

Yes, I saw it, but in my mind it is still a configuration
 and this name covers the meaning,
 but I can rename it, the "description" above describes the real meaning.

> 
> Looks good otherwise.

Thank you and everyone who read or commented my code.

> 
> > +
> > +required:
> > +  - reg
> > +  - interrupts
> > +  - spi-max-frequency
> > +  - shutdown-gpios
> > +  - silabs,package-size
> > +  - silabs,tx-channel
> > +  - silabs,rx-channel
> > +  - silabs,ez-config
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      si4455_0: serial@0 {
> > +        compatible = "silabs,si4455";
> > +        reg = <0>;
> > +        interrupt-parent = <&gpio>;
> > +        interrupts = <7 2>;
> > +        shutdown-gpios = <&gpio 26 1>;
> > +        spi-max-frequency = <300000>;
> > +        silabs,package-size = <30>;
> > +        silabs,tx-channel = <1>;
> > +        silabs,rx-channel = <2>;
> > +        silabs,ez-config = "si4455_spi0_0.ez.bin";
> > +      };
> > +    };
> > +...

Üdvözlettel / Best regards:
József Horváth

