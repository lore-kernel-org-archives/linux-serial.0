Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B8CC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 03:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0249164ECD
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 03:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBVD6B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Feb 2021 22:58:01 -0500
Received: from ciao.gmane.io ([116.202.254.214]:38728 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhBVD6B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Feb 2021 22:58:01 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1lE2LY-0008a6-7o
        for linux-serial@vger.kernel.org; Mon, 22 Feb 2021 04:57:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Date:   Mon, 22 Feb 2021 03:57:15 -0000 (UTC)
Message-ID: <s0va2r$vcg$1@ciao.gmane.io>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
User-Agent: slrn/1.0.3 (Linux)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-02-21, Michael G. Katzmann <michaelk@IEEE.org> wrote:

> Does anyone have any suggestions to get this working at 110bd or
> what other experiments to try?


Does the standard termios2 API for setting arbitrary baud rates work?

  https://github.com/GrantEdwards/Linux-arbitrary-baud

--
Grant



