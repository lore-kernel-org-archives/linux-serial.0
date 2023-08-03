Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC4C001DF
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 06:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjHCG4m (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 02:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjHCG4j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 02:56:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36F9F30E5;
        Wed,  2 Aug 2023 23:56:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3528C80FE;
        Thu,  3 Aug 2023 06:56:36 +0000 (UTC)
Date:   Thu, 3 Aug 2023 09:56:34 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] serial: core: Fix serial_base_match() after fixing
 controller port name
Message-ID: <20230803065634.GG14799@atomide.com>
References: <20230802114846.21899-1-tony@atomide.com>
 <496b56e1-1cc3-dfa3-d628-aeab62b9e60f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496b56e1-1cc3-dfa3-d628-aeab62b9e60f@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [230803 05:13]:
> On 02. 08. 23, 13:48, Tony Lindgren wrote:
> > @@ -6,6 +6,9 @@
> >    * Author: Tony Lindgren <tony@atomide.com>
> >    */
> > +#define SERIAL_BASE_CTRL_NAME	"ctrl"
> > +#define SERIAL_BASE_PORT_NAME	"port"
> 
> Could you make those char[] instead? The compiler/linker will hopefully
> (will it?) de-dup the occurrences, but the arrays would look cleaner and
> safer from this POV.

Heh yeah so we already have that in serial_ctrl_type.name and
serial_port_type.name so let's just check against those for a
minimal fix.

Regards,

Tony
