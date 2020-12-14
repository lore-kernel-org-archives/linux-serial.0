Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A466DC1B0D8
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 12:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACDE20728
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 12:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404928AbgLNM4W (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:56:22 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:40048 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731990AbgLNM4W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 07:56:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id DF4ED123B3D;
        Mon, 14 Dec 2020 13:55:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607950539;
        bh=8V5E5Pu+o3YKcYQ76fndo/VtVVHwpALTJPhg7qg6B+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6bkd2eqmEsiIl9LyvZIJgP0NrWyUpfwvkTzhqC2IUjI/dZtwKGDoi9gKsp3IOwDQ
         dc09vOQUhINlHSoJ4Tmc3R0Gd5lXbzEvN2pY1kvJkzsr4CTMmiTLY6MCrfag/UlIXr
         VWf7swjObjft4NLoTfpcZH2i7pdr30bS7IueC3AtvDdHZmsuzwCtf+vJdeU0WWfhID
         NTLDZhzErrcaJenoGcQ7q2r3mwJDxSIKZnInoelPCYG9TsvPiVFkaxeWDbk345TdeB
         r6I1XBsIUKu9nnFJykWf03EgsOLHytHkxJrtsWhr8mB8P2W6s0EhljDFLLfYineCMn
         ADc+atE7cBlNg==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hGhxen1l195o; Mon, 14 Dec 2020 13:55:12 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 4D548123B3B;
        Mon, 14 Dec 2020 13:55:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607950512;
        bh=8V5E5Pu+o3YKcYQ76fndo/VtVVHwpALTJPhg7qg6B+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Ayq8EgrfFLIoSfgP/H3sScDMb8tz3KOToy2iwXBAd+q51nLgow5wMMzXnh3rI19X
         wh0sRq0p727Hbm4bsF4P8pxsTRJKas3oLGL+MraGPHFm3Jt2oK0Fy9V6I9LZHMaOC4
         tQIz24pWstxZcKsVEms5Z61lc8n89RaY3exU8zv7BTMuuLJZvngsAsQ19zHzx88Jhd
         Bgp3aEDgYTn6g3F0R6YZVi+hEZaVBN5CoCdbYCNZ3MSQtrjsFUggrbUtec6w93fxw7
         Ov/clsnpQqMTKzJDeTWie8DjE8okNfJ2v7YCfyp75TJdoTzNqNOlCnW4FkQzSE66JT
         0HTq6WpTwF3Hg==
Date:   Mon, 14 Dec 2020 12:55:10 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Serial: silabs si4455 serial driver
Message-ID: <20201214125510.GA21614@dev>
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

Thank you anyway.

Üdvözlettel / Best regards:
József Horváth

