Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490A6C43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 14:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiGNObe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbiGNObZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 10:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B766AC0
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 07:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DA6618BC
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 14:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C5FC34114;
        Thu, 14 Jul 2022 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657809083;
        bh=V1gntsxGW+5fHdbMUpK4E6VPAiRZKI+MRVJ/syzvWRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUEqmcexOlmn0FvgE13566cXXQEfPBQCUuWV1qLSk3T+2eqEMLr7XUxzeVJKfnxaQ
         kTJHS1jBgxXQQa5uPX0Z3mfVD5a7eG2SnUGYdZ5L24BcV9UuAeZdenVv1A/i7vnwkn
         gTCkUKMCALTDn9HKQq75UoYkXrp4JL8aySUtadAw=
Date:   Thu, 14 Jul 2022 16:31:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shenwei.wang@nxp.com
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit in CS7
 mode
Message-ID: <YtAouJ0aaZsdCzV/@kroah.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708195800.325933-1-shenwei.wang@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 08, 2022 at 02:58:00PM -0500, shenwei.wang@nxp.com wrote:
> The LPUART hardware doesn't zero out the parity bit on the received
> characters. This behavior won't impact the use cases of CS8 because
> the parity bit is the 9th bit which is not currently used by software.
> But the parity bit for CS7 must be zeroed out by software in order to
> get the correct raw data.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

What commit id does this fix?

