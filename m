From: Sudhir Sreedharan <ssreedharan@mvista.com>
Subject: Re: [PATCH v1] tty: serial: 8250_core: restore the LCR register in set_sleep
Date: Tue, 21 Oct 2014 12:15:24 +0530
Message-ID: <CAJJ77WthYSoA745Nbcqf_dVfN+ydO1LpCVTRDS6xaZMm0zLSmw@mail.gmail.com>
References: <CAJJ77WsAi5jmnDxY45ipu3a94D6+yoHJNHgExhFsVoirV3NoyQ@mail.gmail.com>
	<1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
	<7hppdmg4zc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36768 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbaJUGpY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 02:45:24 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so443836obc.39
        for <linux-serial@vger.kernel.org>; Mon, 20 Oct 2014 23:45:24 -0700 (PDT)
In-Reply-To: <7hppdmg4zc.fsf@deeprootsystems.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, lkml <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, Oct 20, 2014 at 8:31 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Sudhir Sreedharan <ssreedharan@mvista.com> writes:
>
>> In ST16650V2 based serial uarts, while initalizing the PM state,
>> LCR registers are being initialized to 0 in serial8250_set_sleep().
>> If console port is already initialized and being used, this will
>> throws garbage in the console.
>>
>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>
> Tested-by: Kevin Hilman <khilman@linaro.org>
>
> I boot tested this on a bunch of ARM boards and don't see any
> more failures/regressions.

Thanks Kevin
