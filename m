Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F9C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 13:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiBNNNZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:13:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiBNNNZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 08:13:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EB4C429;
        Mon, 14 Feb 2022 05:13:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5D4614BF;
        Mon, 14 Feb 2022 13:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF86BC340E9;
        Mon, 14 Feb 2022 13:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644844396;
        bh=dwP4ORzzSZp1wcvNBEfmmWf6TIon1lSMX7u1HmhWW/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jy7wNy575lugQhAbS1VG+3VhQ/4I4lAs8tP26/3muN/PWan9QvoO4+mKo8OSGmVOL
         pyTtwGUK8EZc44bZWFDYpRfhTHzP/EBIEh9Z6PnjtxqBIu5ZGQtaEKPmCngERJk41w
         6AZxKSJ2e5Hx4xM0jv8qUEayEMU33QNUy8JPNOgU=
Date:   Mon, 14 Feb 2022 14:13:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: =?iso-8859-1?Q?Ad?=
 =?iso-8859-1?Q?d_Pali_Roh=E1r?= as mvebu-uart.c maintainer
Message-ID: <YgpVaR421wQYx9mt@kroah.com>
References: <20220214124808.31971-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214124808.31971-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 14, 2022 at 01:48:08PM +0100, Pali Rohár wrote:
> Signed-off-by: Pali Rohár <pali@kernel.org>

I can not take patches without any changelog text, sorry.

