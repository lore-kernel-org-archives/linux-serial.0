Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16629C61DB3
	for <linux-serial@archiver.kernel.org>; Thu, 12 Jan 2023 17:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjALRto (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjALRtW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Jan 2023 12:49:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D860E3
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 09:09:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9217620DC
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 17:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408A0C433D2;
        Thu, 12 Jan 2023 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673543376;
        bh=9xQ33Eh9z3TFCKCJ2CPzPxhtL7agkZ3pnyzzji0v8uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raTAz9plym1EoPh2G4jyDAgi/7oIHZyRxhNVsLREvxf+ASINg+53X+KwQoziit//s
         j/fiE/SVBWGZrfPEDbC7E0AXZMWAMbCvUoDjk5SuFP4+f6CAAHE8e3sFNJ9KjD44/q
         uWzZWm4p2CBFWk14zoytfpNfJA+4Gun5vOtomN6TJcG5V0Xz3j0k8QbyjJHPd7No73
         nBRgJxTEvdoF3j/rnXVtMpq5jIprr/LQydDlU3Pn9XDOY+fAnHbmytgDWVh9X/mcy4
         i/O46W4tDoAasbVjYLM7EW5j56y+KgqyxIzU7mp8+0rT70pW6Wtr2szkrYFA/vSdSO
         XGMB0WpTe0Xrg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG15D-0004aa-Aw; Thu, 12 Jan 2023 18:09:44 +0100
Date:   Thu, 12 Jan 2023 18:09:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Message-ID: <Y8A+1wUUNCU+3Kry@hovoldconsulting.com>
References: <20221216115338.7150-1-marex@denx.de>
 <Y6sHr5kuxUoahlzJ@hovoldconsulting.com>
 <Y7vou3wAeLP4X+TY@linutronix.de>
 <Y8AHaJIttNga68q4@hovoldconsulting.com>
 <78e3f61f-4f87-9ac5-7c7c-172714da69d3@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e3f61f-4f87-9ac5-7c7c-172714da69d3@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 12, 2023 at 05:38:48PM +0100, Marek Vasut wrote:
> On 1/12/23 14:13, Johan Hovold wrote:
  
> > The author did not seem to think this was stable material as there is no
> > cc-stable tag and it also seems fairly intrusive.
> 
> The author does not have enough experience with preempt-rt to make that 
> determination, hence deferred to Sebastian for better judgement.

Fair enough. And it's not obvious that the stable team should backport
patches that only concern PREEMPT_RT either (e.g. as parts of it are
still out-of-tree).

The stable tag is still missing from the final revision though.

> > But if the ST guys or whoever cares about this driver are fine with this
> > being backported, I don't really mind either.

Johan
