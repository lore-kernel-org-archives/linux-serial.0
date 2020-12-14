Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF04C4361B
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3320657
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 16:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440069AbgLNQ2f (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:28:35 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:49876 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439386AbgLNQ21 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 11:28:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 4459D123B40;
        Mon, 14 Dec 2020 17:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607963254;
        bh=hu9iB9JUGNU/0E24WGPhmjcNTO4ODbRItq6MiPJhM44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y88L057RazIJRKp6wPqHe4gJ63jVhm+zybppiwdzP5ZOunqfFy3FX22vA+mW7PNSG
         +Tu7PIAqVnw+psnFroOuaz9D22CSU6RTEkZ4VCjTKUK0M/+g8jGrSDcx9obsREGkFr
         U0n55BnkfCWHNJ7+7MxYaE8R+SnwOGjX5g/BO55buVqwS7Ux47oklQnUYAXZe225gW
         JzyMDF7ShOXopg0qGNqykzMduKn0GYlh1VQjq2MdvATPBHIwbE6M/u9nkTeXcvCLdW
         Pc7JglveHkZdgOt0myFw4laehp0If/ccXq9eII/TN5ZXlV0OH0Xq/4VR6Rd0SvxO1h
         hU678uHaPYYPQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bBFepFV1-_aB; Mon, 14 Dec 2020 17:27:04 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id E347E123B3D;
        Mon, 14 Dec 2020 17:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607963224;
        bh=hu9iB9JUGNU/0E24WGPhmjcNTO4ODbRItq6MiPJhM44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=9e4c25+ZX1pZdQmfIddhggMvDPyXadCj5KilaWVtnzhMe47XYsvn3NxOcH0VybpB8
         Ru2RqZryK8RmPqrRP+6gdKUDqzIzl/QD2CIhW+HsEAJLdDtfJcRKN3hxgQQmSroD+l
         KD6YZA8YfquIE7H90/X+dr+Jjcp34cp0s1zNrY+PXtwC6HHTuXp9RDUCxvXxyPxYQ1
         RGwiA862/PUu7q6P3pRPQ615s6NGHQr0Q/lsrThd89Mkty8+IFLIpgo6Pabcfn79+X
         8x4dqLBf2Fbqz+a3TSQNo0/xHqxPiT2t8+dl2RodWBipa+kpGY8gGkVv6jUBAoJo4m
         pdHADZjZZINsw==
Date:   Mon, 14 Dec 2020 16:27:02 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Serial: silabs si4455 serial driver
Message-ID: <20201214162701.GA32214@dev>
References: <20201212070944.GA13909@dincontrollerdev>
 <2855efaf-79a5-f43b-ff8c-9c01a3f14df7@kernel.org>
 <20201214123519.GA10229@dev>
 <77bb5835-b1f2-125a-d2d1-ad67612b164d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77bb5835-b1f2-125a-d2d1-ad67612b164d@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 14, 2020 at 01:39:09PM +0100, Jiri Slaby wrote:
> On 14. 12. 20, 13:35, József Horváth wrote:
> > I'm in trouble with the device tree binding schema of this driver too.
> 
> Sorry, someone else has to help you who actually masters DT details.
> 
> -- 
> js

I have answer. I forgot read before write...
The silabs,si4455.yaml was in wrong place, the good place is
 Documentation/devicetree/bindings/serial/silabs,si4455.yaml as Rob wrote earlier.
Everything is fine now with it.

Sorry for this.

Üdvözlettel / Best regards:
József Horváth



