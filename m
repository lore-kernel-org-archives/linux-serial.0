From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 06/12] 8250: use the 8250 register interface not the
 legacy one
Date: Wed, 27 Jun 2012 18:39:53 -0400
Message-ID: <CAP=VYLopNPeYCi4uQoHuqU0vWFF5hc4J9x3uzSOXJVv=DGLLWw@mail.gmail.com>
References: <20120627112102.5678.4141.stgit@localhost.localdomain> <20120627112205.5678.80154.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37353 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab2F0Wk0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 18:40:26 -0400
Received: by lbbgm6 with SMTP id gm6so2254958lbb.19
        for <linux-serial@vger.kernel.org>; Wed, 27 Jun 2012 15:40:25 -0700 (PDT)
In-Reply-To: <20120627112205.5678.80154.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, linux-serial@vger.kernel.org

On Wed, Jun 27, 2012 at 7:22 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> The old interface just copies bits over and calls the newer one.
> In addition we can now pass more information.
>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---

[...]

> - * serial8250_register_port and serial8250_unregister_port allows for
> + * serial8250_register_8250_port and serial8250_unregister_port allows

This seems a bit lopsided.  Can we convert the unregister too, and
then just keep the old names, and avoid the doubling up on the
presence of 8250 in the name?  (I confess to having not looked
at the code to seeing if there is an obvious barrier to doing this),

Paul.
