From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Fix wrong register read address and add interrupt
	acknowledge.
Date: Tue, 5 May 2009 14:24:04 -0500
Message-ID: <ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com>
References: <20090505191116.GA7267@codiert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f133.google.com ([209.85.221.133]:48066 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbZEETYF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 May 2009 15:24:05 -0400
Received: by qyk39 with SMTP id 39so1670899qyk.33
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2009 12:24:04 -0700 (PDT)
In-Reply-To: <20090505191116.GA7267@codiert.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin Krill <ben@codiert.org>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, arnd@arndb.de

On Tue, May 5, 2009 at 2:11 PM, Benjamin Krill <ben@codiert.org> wrote:
> The receive interrupt routine checks the wrong register if the
> receive fifo is empty. Further an explicit interrupt acknowledge
> write is introduced. In some circumstances another interrupt was
> issued.

The one-line summary of your patch is too vague.  It should mention
the name of the driver somehow.

-- 
Timur Tabi
Linux kernel developer at Freescale
