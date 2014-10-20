From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v1] tty: serial: 8250_core: restore the LCR register in set_sleep
Date: Mon, 20 Oct 2014 08:01:27 -0700
Message-ID: <7hppdmg4zc.fsf@deeprootsystems.com>
References: <CAJJ77WsAi5jmnDxY45ipu3a94D6+yoHJNHgExhFsVoirV3NoyQ@mail.gmail.com>
	<1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57583 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaJTPBb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Oct 2014 11:01:31 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so5186597pdi.10
        for <linux-serial@vger.kernel.org>; Mon, 20 Oct 2014 08:01:31 -0700 (PDT)
In-Reply-To: <1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
	(Sudhir Sreedharan's message of "Fri, 17 Oct 2014 18:09:18 +0530")
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

Tested-by: Kevin Hilman <khilman@linaro.org>

I boot tested this on a bunch of ARM boards and don't see any
more failures/regressions.

Kevin
