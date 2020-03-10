Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF2C10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 15:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D1D20578
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCJPay (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:30:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:53066 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbgCJPay (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 11:30:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 08:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="388966183"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2020 08:30:52 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBgq6-008UmY-Ce; Tue, 10 Mar 2020 17:30:38 +0200
Date:   Tue, 10 Mar 2020 17:30:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 4/4] serial: core: Refactor
 uart_unlock_and_check_sysrq()
Message-ID: <20200310153038.GR1922688@smile.fi.intel.com>
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <20200310132004.86367-4-andriy.shevchenko@linux.intel.com>
 <4f6ca0d6-f1dc-5757-2ce7-b2b4f64f10aa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6ca0d6-f1dc-5757-2ce7-b2b4f64f10aa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 10, 2020 at 02:48:51PM +0000, Dmitry Safonov wrote:
> On 3/10/20 1:20 PM, Andy Shevchenko wrote:
> [..]
> > @@ -3286,22 +3286,20 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
> >  }
> >  EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
> >  
> > -void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
> > +void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags)
> > +__releases(&port->lock)
> >  {
> >  	int sysrq_ch;
> 
> Probably, you could move it inside the condition it's used.

I can do this.

> Though, I wonder why you decided to rearrange the code.

I hope commit message sheds a light on this. Main reason to (easily) see
how locks are being maintained.

> Otherwise, LGTM.

Thanks, I will send v2 when we get settlement on patch 1.

> > -	if (!port->has_sysrq) {
> > -		spin_unlock_irqrestore(&port->lock, irqflags);
> > -		return;
> > +	if (port->has_sysrq) {
> > +		sysrq_ch = port->sysrq_ch;
> > +		port->sysrq_ch = 0;
> > +		spin_unlock_irqrestore(&port->lock, flags);
> > +		if (sysrq_ch)
> > +			handle_sysrq(sysrq_ch);
> > +	} else {
> > +		spin_unlock_irqrestore(&port->lock, flags);
> >  	}
> > -
> > -	sysrq_ch = port->sysrq_ch;
> > -	port->sysrq_ch = 0;
> > -
> > -	spin_unlock_irqrestore(&port->lock, irqflags);
> > -
> > -	if (sysrq_ch)
> > -		handle_sysrq(sysrq_ch);
> >  }
> >  EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);
> 
> Thanks,
>           Dmitry

-- 
With Best Regards,
Andy Shevchenko


