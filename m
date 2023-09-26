Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C466E8181F
	for <linux-serial@archiver.kernel.org>; Tue, 26 Sep 2023 06:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjIZGPG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjIZGPF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Sep 2023 02:15:05 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74FADB8;
        Mon, 25 Sep 2023 23:14:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D059F8168;
        Tue, 26 Sep 2023 06:14:58 +0000 (UTC)
Date:   Tue, 26 Sep 2023 09:14:57 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Kumar Udit <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: serial: 8250_omap: suspend issue with console_suspend disabled
Message-ID: <20230926061457.GU5285@atomide.com>
References: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
 <20230920053828.GD5282@atomide.com>
 <332111c2-f3f5-3d7f-09ef-f3ebb3f48eb0@bootlin.com>
 <0ab0dc61-aa9b-1f3f-f889-9c6e10dc62f7@bootlin.com>
 <20230925152630.GT5282@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925152630.GT5282@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [700101 02:00]:
> * Thomas Richard <thomas.richard@bootlin.com> [230925 13:03]:
> > On 9/21/23 09:58, Thomas Richard wrote:
> > > I tested it, it works for me.
> > 
> > Tony,
> > 
> > As your proposal works well, do you plan to send a patch ?
> > Or would you prefer me to send it ?
> 
> Thanks I'll type up the description and send it.

Sent now as:

[PATCH] serial: 8250_omap: Fix errors with no_console_suspend

Regards,

Tony
