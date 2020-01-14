Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43EC33C9E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47432465A
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ws8m8W0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgANRvs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:51:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRvs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 12:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sc1Nx+HAQZISsrmd3+gnlnxtvqsFDI0QD633bhln+Vw=; b=Ws8m8W0VdPB5r8ceyEL0CggzY
        pip6/AhQ9Mj/yUu4KR2E5bvi+rhUSqsDYpUZyDsrUpvAT4gBTB09jojYdwktpoQmIBOC3jVgAkiGX
        p38uVHu1Oxdwds2Thne/H1ZHyWI+1c3rJHThx/j1R+sN68n2qn3bMgCdQzkCvNISRlZwb/+3aqPZf
        OD+jIzeHMniQjm9uRnuXcxyUpVXfxg6+s038vsuTSawmf42QTeSsouYJZFzj2+Pb5DCWinRfu1Ius
        LBCdgchHvlDQ70mSpq0QF3c240Z80izr53BpNnYn+nyP47qep5kPb/mgnarDpCwXaXdM4kU2t3Q12
        lIWW+L0Sg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irQLz-0000tX-Cs; Tue, 14 Jan 2020 17:51:47 +0000
Subject: Re: [PATCHv2-next 2/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-3-dima@arista.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a1ba665-fc32-8dd9-ffa1-de71209d0153@infradead.org>
Date:   Tue, 14 Jan 2020 09:51:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200114171912.261787-3-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/14/20 9:19 AM, Dmitry Safonov wrote:
> +static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> +{
> +	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
> +		return 0;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);

That sizeof(...) is confusing (to me).  I would just write:

+	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= U8_MAX);

> +	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
> +		port->sysrq_seq = 0;
> +		return 0;
> +	}

cheers.
-- 
~Randy

