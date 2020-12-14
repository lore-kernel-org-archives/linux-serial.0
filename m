Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F019C4361B
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 12:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30182206FB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 12:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgLNMgc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:36:32 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:35998 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgLNMgc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 07:36:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id AA554123B3B;
        Mon, 14 Dec 2020 13:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607949349;
        bh=z1o91ipcko8gQeyW2F+RhK2XI913BoAYPZf1nyvexD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0UzOO3DnH0xfIvVl0lEOJNjD4SW+FOHwETCI8CCrz9ZUeJuVtyAujjHU1Mm1Ivyzk
         CRlA0l9b3VvmpM9LgBIlsXyNstyhjKYuXoyLfrpHJ2GUxK9FH8rTaOcQjNjLGm528x
         lOsbJ4sBo1xcBGeSY1yO8IfGqPPxkwWHyaCSbfoqpp09Yvs5CHyi5d7uDe0DwEUm71
         f5PKvacaPXR6xGAA1rT2Gj6k5gH5FAcvTeECggaS0UPmk12p1M2hkhdP0y1sTGoRJs
         mp3JwMXMGWb28NRYPTkz+VmrAwVhh3MObSx3q6sJ5GKMLuIhyqunJnhAB4fhf5kAiq
         A6hIaQ0jqTwZg==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3pmV4oLaPgFt; Mon, 14 Dec 2020 13:35:23 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 28FFA123B38;
        Mon, 14 Dec 2020 13:35:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607949323;
        bh=z1o91ipcko8gQeyW2F+RhK2XI913BoAYPZf1nyvexD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlASKX8xx+q+UECjBiX4GzhiHZeBCnQhwDNmx6XYJDUasUBFH09BDgWqDsYr22ewo
         mAjIMld5uSWuz0aTwqYEUffUfe3vfp36D4TSiP6nDpXoaorcOm3AqdAQAysTc8qxgW
         +gXx8sjSq6p3hQhLRnxUhqcAOoNHalNW+5TlfHxCbo9TfZfkW1oXTvYhXKRZE+eZG8
         u4bzlh7y/Zahv2MdVK5IJAeVzzMfbDoCJi7XRSGiwdjNo/lRDBFDsFFaUQGAFf3iUe
         vLyrkOM2RhUHFIUf8nZfPCWk+wF9Q8mSPg4YOYCNw9mxYs5TAKDz/3wHYyiJs8e338
         jtgYacrhqWxkA==
Date:   Mon, 14 Dec 2020 12:35:20 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Serial: silabs si4455 serial driver
Message-ID: <20201214123519.GA10229@dev>
References: <20201212070944.GA13909@dincontrollerdev>
 <2855efaf-79a5-f43b-ff8c-9c01a3f14df7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2855efaf-79a5-f43b-ff8c-9c01a3f14df7@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 14, 2020 at 09:04:13AM +0100, Jiri Slaby wrote:
> On 12. 12. 20, 8:09, József Horváth wrote:
> > This is a serial port driver for
> >   Silicon Labs Si4455 Sub-GHz transciver.
> > 
> > The goal of this driver is to removing wires
> >   between central(linux) device and remote serial devices/sensors,
> >   but keeping the original user software.
> >   It represents regular serial interface for the user space.
> > 
> > Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> A description of changes between v1..v4 here, please.
> 
> > Signed-off-by: József Horváth <info@ministro.hu>
> ...
> 
> spi_register_driver can fail too.
> 
> > +
> > +	return 0;
> > +}
> 
> regards,
> -- 
> js

Thank you for your suggestions.

I'm in trouble with the device tree binding schema of this driver too.

When I run "make dt_binding_check" with $id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#" in schema,
 and silabs,si4455.yaml is under Documentation/devicetree/bindings/serial/,
 it completes successfully.

When I run "make dt_binding_check" with $id: "http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml#" in schema,
 and silabs,si4455.yaml is under Documentation/devicetree/bindings/staging/serial/,
 the make dt_binding_check output:

	Unknown file referenced: [Errno 2] No such file or directory: '/home/administrator/.local/lib/python3.6/site-packages/dtschema/schemas/staging/serial/serial.yaml'
	xargs: dt-doc-validate: exited with status 255; aborting
	Documentation/devicetree/bindings/Makefile:59: recipe for target 'Documentation/devicetree/bindings/processed-schema-examples.json' failed
	make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.json] Error 124
	Makefile:1364: recipe for target 'dt_binding_check' failed
	make: *** [dt_binding_check] Error 2

When I run "make dt_binding_check" with $id: "http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml#" in schema,
 and silabs,si4455.yaml is under Documentation/devicetree/bindings/staging/serial/,
 and removed $ref: "serial.yaml#".
 The make dt_binding_check completes successfully, but this is not a good solution.

My question is, how can I use $ref: "serial.yaml" dependency in silabs,si4455.yaml, while my schema is under staging?
        allOf:
          - $ref: "serial.yaml#"

If you have any suggestion that brings me to the right direction it would be great. 

Üdvözlettel / Best regards:
József Horváth

