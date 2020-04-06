Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F3CC2BA2B
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 09:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A10206F8
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586166874;
	bh=JySuv0PudjYeh/FL38Bu9IBjCHRDdt6DoTfZ4HM5AvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ONyH9RFvUSKDeVVW2leUCICIB5jfFnvSH6MPR62FW+hzudWQqNgy4XLS3QUTIw5dw
	 NDyOabIMXg4HGJz0AT+FXsRo7F3hBy0Fy3WeYoxpFeaXPcI1o0pLz2qYPju40aUykW
	 W+p7pYeB0zdRtJuMuYa+sBE6Pzsfy9H4NHT6LSIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDFJya (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:54:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43355 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgDFJya (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 05:54:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so18417615edb.10;
        Mon, 06 Apr 2020 02:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jq4dLklSvXAh4mHXbS3uqTp1YFNR8Y8OhfEZxV4SEp8=;
        b=VDsECvv3dJgi/WyNSZFMnqH3tsD34fheZWAJo4vw+UFqci/Nu5BJ01uGZMnST6INBi
         VXM7yNlHLkNJ99iLC0KHJXaN7YRq901+WLGHU1fa6Pk7zCcXy6cvcSy2TUgOqg2GhCr6
         MNG+zcLv6GxdgGTRg78xqDlumDVA0P1vEKq9Y4VYdUtjALLaFtVGhoYIXCV33IhxhrBS
         cuanFkxpXyYCrJ5n4nAnWBS5oIyI0u/S8qp0vhEQF0umBpMSkX98MKNT60qE7acWXtvf
         y8kWDx6ToPNoV2vwQ8WEBoHaPNB53ERL5XmcOoo7Ymqm7OPNBFvmnX1ZTAdP45Ohr2BH
         0/ww==
X-Gm-Message-State: AGi0PuYvPmA4+xned3M0dvI6E48WB61LDhaB+F3ycgi8ZYQ7a2rEcSc2
        QTucn9f1mKSktqxh+qp98UU=
X-Google-Smtp-Source: APiQypIGsI1vy9jtZIncxZtn6HgnNsW1Vh3ZNhBDX+cUzlu30NjC5DdfbDeJxopv+1PyeG+Z0DSLcQ==
X-Received: by 2002:a17:906:30c5:: with SMTP id b5mr21234309ejb.102.1586166868311;
        Mon, 06 Apr 2020 02:54:28 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id y10sm2858156ejm.3.2020.04.06.02.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 02:54:27 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:54:25 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, 'Kukjin Kim' <kgene@kernel.org>,
        'Jiri Slaby' <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200406095425.GB13565@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
 <20200403111511.10598-1-hyunki00.koo@samsung.com>
 <20200403115941.GB29484@kozik-lap>
 <000001d60b92$2adaee50$8090caf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000001d60b92$2adaee50$8090caf0$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 06, 2020 at 06:35:46AM +0900, Hyunki Koo wrote:
> On Fri, Apr 03, 2020 at 9:00: 10PM +0900, Krzysztof Kozlowski wrote:
> > On Fri, Apr 03, 2020 at 08:15:10PM +0900, Hyunki Koo wrote:
> > > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> > >
> > > This is required for some newer SoCs.
> > >
> > > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > > ---
> > > v2:
> > > line 954 : change rd_regl to rd_reg in for backward compatibility.
> > 
> > I did not see any change around line 954 in v1... so what was it?
> 954  line  is changed like below.
> V1 : rd_regb --> rd_regl : we thought, this register need to change to 
> V2: rd_regl --> rd_reg : we discuss internally, and 
> I decided not to change  to existing devices for backward compatibility.
> So we changed to rd_reg.

Thanks.

Best regards,
Krzysztof

