Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8006DC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2F721D56
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 16:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCJQsw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:48:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:40942 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCJQsv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 12:48:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 09:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="242379227"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2020 09:48:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBi3n-008W0I-27; Tue, 10 Mar 2020 18:48:51 +0200
Date:   Tue, 10 Mar 2020 18:48:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/4] serial: core: Use string length for SysRq magic
 sequence
Message-ID: <20200310164851.GT1922688@smile.fi.intel.com>
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <64f650b7-8c39-4bef-f1d9-ff2720923c8c@gmail.com>
 <20200310145706.GQ1922688@smile.fi.intel.com>
 <c26a1397-6b65-7d80-7fec-cb0f94ff412d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26a1397-6b65-7d80-7fec-cb0f94ff412d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 10, 2020 at 03:57:17PM +0000, Dmitry Safonov wrote:
> Hi Andy,
> 
> On 3/10/20 2:57 PM, Andy Shevchenko wrote:
> > On Tue, Mar 10, 2020 at 02:38:48PM +0000, Dmitry Safonov wrote:
> >> On 3/10/20 1:20 PM, Andy Shevchenko wrote:
> >> [..]> @@ -3209,7 +3209,9 @@ static DECLARE_WORK(sysrq_enable_work,
> >> uart_sysrq_on);
> >>>   */
> >>>  static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> >>>  {
> >>> -	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
> >>> +	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
> >>> +
> >>> +	if (!sysrq_toggle_seq_len)
> >>>  		return false;
> >>
> >> Eh, I wanted to avoid the strlen() call in runtime for every time sysrq
> >> is pressed. It's not very frequent moment surely, but..
> > 
> > I really don't like ARRAY_SIZE() against plain strings.
> > This will use \0 inclusively and confuse the understanding the code.
> 
> I still feel a bit awkward that handler will run strlen() for something
> that could be done compile-time, but I won't insist.

Have you seen to the assembly?

For me it seems that GCC is clever enough to precalc length for constant
literals.

With default string (empty) there is no uart_sysrq_on() at all in the code.

With "pqr" I see this function and in particular:
     621:       be 03 00 00 00          mov    $0x3,%esi

With "pqrst"

     621:       be 05 00 00 00          mov    $0x5,%esi

(Note, I compiled entire series, that's why uart_sysrq_on() has strlen() in)

> Thanks again for looking into warning,

You are welcome.

-- 
With Best Regards,
Andy Shevchenko


