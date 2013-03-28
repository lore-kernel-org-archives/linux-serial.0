From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250: Make SERIAL8250_CONFIG_RUNTIME_UARTS work
 correctly
Date: Thu, 28 Mar 2013 14:22:54 -0700
Message-ID: <20130328212254.GA20051@kroah.com>
References: <1364502043-13018-1-git-send-email-karthik.manamcheri@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57382 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab3C1VW5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Mar 2013 17:22:57 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so82869pab.18
        for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2013 14:22:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364502043-13018-1-git-send-email-karthik.manamcheri@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Cc: linux-serial@vger.kernel.org, Karthik Manamcheri <karthik.manamcheri@ni.com>

On Thu, Mar 28, 2013 at 03:20:43PM -0500, Karthik Manamcheri wrote:
> Currently, if you set SERIAL8250_CONFIG_RUNTIME_UARTS

There is no such config option, please get it correct.

> to 0, you cannot get any working ports.

Isn't that on purpose?  Why would you ever set that value to 0 and
expect things to work?

> This change will enable serial8250_register_port to successfully
> register a port even if SERIAL8250_CONFIG_RUNTIME_UARTS
> is 0. If you need legacy ports, you will set the
> SERIAL8250_CONFIG_RUNTIME_UARTS to the number of legacy
> ports you need created at boot time.

I don't understand, if you set the option to be 0, how can anything
work here?

greg k-h
