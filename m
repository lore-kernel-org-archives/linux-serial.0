From: Kalle Vahlman <kalle.vahlman@movial.com>
Subject: Re: [PATCH] serial/amba-pl011: Return early in deadlock work-around
 if there is no tty
Date: Sat, 25 Feb 2012 12:57:50 +0200
Message-ID: <CANVCJSE5x4LrRferm5mSyx_jtkRyycrvNgK51OGtCP26s7pesg@mail.gmail.com>
References: <1329718024-23623-1-git-send-email-kalle.vahlman@movial.com> <20120224214743.GA25330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:54412 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754833Ab2BYK6N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Feb 2012 05:58:13 -0500
Received: by qafi29 with SMTP id i29so821546qaf.3
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2012 02:58:11 -0800 (PST)
In-Reply-To: <20120224214743.GA25330@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, stable@kernel.org

2012/2/24 Greg KH <gregkh@linuxfoundation.org>:
> On Mon, Feb 20, 2012 at 08:07:04AM +0200, Kalle Vahlman wrote:
>> The first amba port does not always have an attached tty, which will
>> result in a crash if the work-around is activated.
>>
>> This seems to be the case for example on Snowball which has no modem
>> hw, which seems to be the main use-case for this work-around.
>> ---
>> =A0drivers/tty/serial/amba-pl011.c | =A0 =A04 ++++
>> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> Can you re-read Documentation/SubmittingPatches and resend this patch
> with the needed information so that I can apply it (hint, you forgot =
a
> signed-off-by: line...)

Ah, sorry for that. But actually I was alerted to a plan to eradicate
the whole workaround so this patch can be left unapplied.

I will follow up with a new submission if that doesn't happen soon.

Cheers,

--=20
Kalle Vahlman, Movial Creative Technologies Inc.
Porkkalankatu 20, FI-00180 Helsinki
Tel +358 9 8567 6400
=46ax +358 9 8567 6401
www.movial.com
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
