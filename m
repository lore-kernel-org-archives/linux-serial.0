Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0908C001B0
	for <linux-serial@archiver.kernel.org>; Fri, 14 Jul 2023 07:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjGNHUd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Jul 2023 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjGNHUR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jul 2023 03:20:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A1923AA9;
        Fri, 14 Jul 2023 00:20:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BD2DD80A8;
        Fri, 14 Jul 2023 07:20:09 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:20:08 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 3/3] serial: qcom-geni: drop bogus runtime pm state update
Message-ID: <20230714072008.GB5194@atomide.com>
References: <20230713145741.30390-1-johan+linaro@kernel.org>
 <20230713145741.30390-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713145741.30390-4-johan+linaro@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Johan Hovold <johan+linaro@kernel.org> [230713 15:01]:
> The runtime PM state should not be changed by drivers that do not
> implement runtime PM even if it happens to work around a bug in PM core.
> 
> With the wake irq arming now fixed, drop the bogus runtime PM state
> update which left the device in active state (and could potentially
> prevent a parent device from suspending).

Reviewed-by: Tony Lindgren <tony@atomide.com>
