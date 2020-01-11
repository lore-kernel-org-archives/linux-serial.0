Return-Path: <SRS0=GYIK=3A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C68C282DD
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 14:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3178620842
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 14:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgAKOJy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:09:54 -0500
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:46564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729630AbgAKOJy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jan 2020 09:09:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2E45A181D3417;
        Sat, 11 Jan 2020 14:09:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot67_733f2d71df901
X-Filterd-Recvd-Size: 1566
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Jan 2020 14:09:51 +0000 (UTC)
Message-ID: <f0e313b585cd8fa30e85ee86d6612af4a860a50a.camel@perches.com>
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Date:   Sat, 11 Jan 2020 06:08:58 -0800
In-Reply-To: <056bff50-f67e-f00f-c98f-ccb427344691@arista.com>
References: <20200109215444.95995-1-dima@arista.com>
         <20200109215444.95995-4-dima@arista.com>
         <5293a7cb1ccb16275ddb36c7f26fb9e83f4fac9b.camel@perches.com>
         <056bff50-f67e-f00f-c98f-ccb427344691@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 2020-01-10 at 22:10 +0000, Dmitry Safonov wrote:
> Hi Joe,

Hi Dmitry.

> I'm not aware of a way to put the max string length in Kconfig,

Nor am I.


>  so I did
> in the patch:
> BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >=
> sizeof(port->sysrq_seq)*U8_MAX);
> 
> Do you have something more elegant in your mind?

No, I didn't notice this and think this is fine
so thanks for that.

It's be nice to have something like BUILD_BUG_ON_MSG.

