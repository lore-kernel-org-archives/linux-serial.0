From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] tty: serial: 8250_core: restore the LCR register in set_sleep
Date: Thu, 16 Oct 2014 00:21:17 -0700
Message-ID: <7hwq80h442.fsf@deeprootsystems.com>
References: <54369F77.5000906@hurleysoftware.com>
	<1413355395-5871-1-git-send-email-ssreedharan@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50057 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaJPHVV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 03:21:21 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so2924023pad.27
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2014 00:21:21 -0700 (PDT)
In-Reply-To: <1413355395-5871-1-git-send-email-ssreedharan@mvista.com> (Sudhir
	Sreedharan's message of "Wed, 15 Oct 2014 12:13:15 +0530")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sudhir Sreedharan <ssreedharan@mvista.com>
Cc: peter@hurleysoftware.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org

Sudhir Sreedharan <ssreedharan@mvista.com> writes:

> In ST16650V2 based serial uarts, while initalizing the PM state,
> LCR registers are being initialized to 0 in serial8250_set_sleep().
> If console port is already initialized and being used, this will
> throws garbage in the console.
>
> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>

Since this caused regressions in -next last time, could you describe how
this was tested, and on what platforms?

Thanks,

Kevin
