Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ABFC2BA17
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7962082F
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585913976;
	bh=w0jqL9tj7pQTt1pZj1giryviTnK5UbFL/q7mv/JOMAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XsRjz/IzqHHFz7y2dR2509WbxVePI/KWYqfPpxY6smHzGFCs3EPbeelmie6QBSxDN
	 jOnU1lsoYDvfpE/1lgvZvl+1GrKv4J7mLPimlE5JNEb6RqbMHzfCNLXc5y4TirdaHB
	 X63e24ZdF/W3bMcEoiMXY0sTlEfaip3lhRgdl/yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgDCLjf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:39:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42589 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgDCLjf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 07:39:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so8859435edb.9;
        Fri, 03 Apr 2020 04:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKKPCRgqOm2anwGdxhjT+1W/zjQgQoWsKsTzbih7afk=;
        b=Opa/tCraMNYcTLoWj0QQSHWKGO5DL0QrAptosrYnVDjQu2lMUq6UZetXZkm2eM6wt9
         mOc3NUqTcnhnbBcgCuf3Ujhr1AR6zWaDZ3rNFaqokCUyKWzP/cLdmAhdipwf+QKIOuke
         ZYIYw/12B/4rEWRasmJyc2H3QZOf5at4vHxlR/HeSFAqr5/S6HYCFYEp+gGFIer2dyIc
         YgbOKpkmfkIlIX9QxqgkkWWE0yQ2mbIcIG2KnWRqzgjx9WEbfo3V6n+5NT5qkO8zgq8N
         gfVfdaVKyHF14sRyYfaEDyYUhhsHePCOiAEV6pXUHUKXAdBaM/nYdasDa5Qxm3SXyvmv
         Ozqw==
X-Gm-Message-State: AGi0PuaqOdVLx67gbp1957aWzSYUJyoX1EjYLG8NO32twetT8nRNYgbE
        /g8rVzpiG1TTNIL/5RkkzRSRyWjI
X-Google-Smtp-Source: APiQypIFfUmjJ6MKsEttuYiNjXdHs3Tt9Cih39BKeATM+aTzjF/Fk/3pMfwKnIQQJinSpqgNPABv9w==
X-Received: by 2002:a17:906:1001:: with SMTP id 1mr7947398ejm.267.1585913973645;
        Fri, 03 Apr 2020 04:39:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id l19sm1609707ejn.31.2020.04.03.04.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 04:39:32 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:39:25 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, 'Kukjin Kim' <kgene@kernel.org>,
        'Jiri Slaby' <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200403113925.GA4957@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8@epcas2p1.samsung.com>
 <20200403102041.22015-1-hyunki00.koo@samsung.com>
 <20200403104744.GA29385@kozik-lap>
 <005601d609a8$d3243710$796ca530$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <005601d609a8$d3243710$796ca530$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 08:12:55PM +0900, Hyunki Koo wrote:
> On Thu, Apr 02, 2020 at 7:48:38PM +0900, Krzysztof Kozlowski
> > On Fri, Apr 03, 2020 at 07:20:41PM +0900, Hyunki Koo wrote:
> > > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> > >
> > > This is required for some newer SoCs.
> > >
> > > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > > ---
> > > v3: change rd_regl to rd_reg in line 954 for backward compatibility.
> > 
> > I cannot find this change against v2.
> Okay, I will add all changes.

No, I mean, I cannot find the change rd_regl->rd_reg around line 954.
There was no changes around line 954 in v2.


Best regards,
Krzysztof

