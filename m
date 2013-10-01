From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] serial: 8250_dw: Improve unwritable LCR workaround
Date: Tue, 1 Oct 2013 10:13:11 -0700
Message-ID: <CAAYSxhqMGOspc7Y1QEa68W2ADpf-k33SOH4nHWhnis_71cyKsQ@mail.gmail.com>
References: <1380069549-9176-1-git-send-email-tim.kryger@linaro.org>
	<20130925114232.GA26259@xps8300>
	<CAAYSxhpXNj4Jo9puhc56EkaXKEg=XjNYG_iwX0FDgpLyySWiZg@mail.gmail.com>
	<20130927074950.GA25098@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33008 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab3JARNM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Oct 2013 13:13:12 -0400
Received: by mail-ie0-f170.google.com with SMTP id x13so14931449ief.29
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2013 10:13:11 -0700 (PDT)
In-Reply-To: <20130927074950.GA25098@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Patch Tracking <patches@linaro.org>

On Fri, Sep 27, 2013 at 12:49 AM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> OK. The LCR issue is only a problem when the UART is configured with
> the busy functionality (UART_16550_COMPATIBLE == NO). Otherwise LRC is
> always accessible and this is not necessary.

Reading through the latest DW databook, I believe you are correct.

> We need a flag for the UART_16550_COMPATIBLE configuration, and
> use this WA based on that.

If I adjust the workaround to force the UART idle only when an LCR
write was ignored rather than doing it prior to any LCR write, would
that address your concerns?
