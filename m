Return-Path: <SRS0=U7OZ=5Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F34C10F26
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5BE2145D
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585660286;
	bh=1xtFAKXGm+X1qtcHwxiBg5ZrZy/4PYKqBeAGcz/qET8=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=E8ia5MLGZ+jRgwhAKdwSea03cDbrGqwIFktlzjkL+UzpOVZ+Y/T4Hbm5oGv+lfwa4
	 EdpCdr4HMPsWvpjaCvW5Pk4CNFTM99jKNXxzrUNl+95oogUi7U+xyS4T58ynvxpk4s
	 DMKPeNyHJLNnMEzZX/hwbw+uG3C0eTIjbenqWiCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgCaNLY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730905AbgCaNLY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Mar 2020 09:11:24 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF8720786;
        Tue, 31 Mar 2020 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585660283;
        bh=1xtFAKXGm+X1qtcHwxiBg5ZrZy/4PYKqBeAGcz/qET8=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
        b=tXt4LeGnhP9krLmXqluqzBjodEfN0liFBtRkGaWgfGtdS6tS00UKfambIvVTpYSOl
         gnvaWY65JfvQyzfwLxheA5TPNtdFYVBxiwFCGMcmaXAdqEHu7qcZBv4n3Csnu8QGd4
         XkhOKUzJvsOln2QhyzBgwdHipWaG+LuRUlaQx/qE=
Date:   Tue, 31 Mar 2020 13:11:22 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     <stable@vger.kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
In-Reply-To: <1585333048-31828-1-git-send-email-kazuhiro.fujita.jg@renesas.com>
References: <1585333048-31828-1-git-send-email-kazuhiro.fujita.jg@renesas.com>
Message-Id: <20200331131123.2CF8720786@mail.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.5.13, v5.4.28, v4.19.113, v4.14.174, v4.9.217, v4.4.217.

v5.5.13: Build OK!
v5.4.28: Build OK!
v4.19.113: Build OK!
v4.14.174: Build OK!
v4.9.217: Failed to apply! Possible dependencies:
    Unable to calculate

v4.4.217: Failed to apply! Possible dependencies:
    Unable to calculate


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
