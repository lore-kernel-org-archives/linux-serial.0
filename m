Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD9C7EE2F
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jun 2023 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjFJQpM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jun 2023 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjFJQpM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jun 2023 12:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8475BD;
        Sat, 10 Jun 2023 09:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65427619A2;
        Sat, 10 Jun 2023 16:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8888C433EF;
        Sat, 10 Jun 2023 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686415509;
        bh=3OTF3VCRu8OlBdYQoRhfTjRUbn1Wo8d/EOOeHBboymU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bufwS41pwlwBK4KCshhrD26XB69FC9UnZEdw2iwqnoGBFdQucB53XMB22duc7QEY5
         hfq4V0A1pYSrfmtgK7o2xmHW5opj0P87VFeaRfWFKPUpXU5SEKN+xeu5m1u1gNxyrG
         ktGxXCh+AqksTkZmPLeYQh3SKilXddbOJKHwvpkPLxQJf1p7WAXjnbmJUtyyj4zN9u
         JziPN1lA03fHs/0mI0Yx70LuuiQnHZJeAb5z7x3aUNsDZ6ApboAhF1YZnJSmg4g6Wv
         hNfokjJ8dRb0Ufpbl1WTwMcP1dsnca7x3/tQy0TZBbPhv5sucW9JfvY586uaT+Z2sp
         o283dXyFMlfgw==
Date:   Sat, 10 Jun 2023 09:48:37 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     "Mehul Raninga (Temp) (QUIC)" <quic_mraninga@quicinc.com>
Cc:     "agross@kernel.org" <agross@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Viken Dadhaniya (QUIC)" <quic_vdadhani@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
Subject: Re: [PATCH] serial: qcom_geni_serial: Setup serial port after Deep
 sleep
Message-ID: <20230610164837.gjncik7aasvfqhe7@ripper>
References: <20230530111557.10944-1-quic_mraninga@quicinc.com>
 <20230530150631.7eg6nkre6sva5dcz@ripper>
 <SJ0PR02MB7742A7386189692ACACC0A3FE3489@SJ0PR02MB7742.namprd02.prod.outlook.com>
 <20230601040734.qiy3ibrpznrqptui@ripper>
 <CO6PR02MB7731BA49B9EBDC82E801F745E34EA@CO6PR02MB7731.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR02MB7731BA49B9EBDC82E801F745E34EA@CO6PR02MB7731.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 02, 2023 at 06:39:02AM +0000, Mehul Raninga (Temp) (QUIC) wrote:
[..]
> > On Wed, May 31, 2023 at 01:06:22PM +0000, Mehul Raninga (Temp)
> > (QUIC) wrote:
[..]
> > > > > +             if (pm_suspend_via_firmware())
> > > >
> > > > I'm not familiar with this api, but aren't all our systems
> > > > implementing firmware- assisted suspend?
> > >
> > > Not all the platform supports deep sleep hence to differentiate if
> > > resume is from deep sleep suspend or normal suspend, this api is
> > > required.
> > 
> > Can you point me to where this difference in flags is coming from in the
> > upstream kernel?
> 
> In upstream kernel by default the flag is false, and for deepsleep
> support vendor kernel sets this flag true.

I am questioning whether this is correct, given that we indeed "suspend
with the help of firmware". But I might be misinterpreting what that
statement means.

Regards,
Bjorn
