From: Paul Gortmaker <paul.gortmaker@gmail.com>
Subject: Re: [PATCH RESEND] serial: Remove old SC26XX driver
Date: Thu, 19 Dec 2013 17:46:19 -0500
Message-ID: <CAP=VYLqJM=MB=7aa2YHTXvJB_wtRyzGpXpJ7Gdsv+skN2nExXw@mail.gmail.com>
References: <1386686824-15291-1-git-send-email-shc_work@mail.ru>
 <1387481356.914448614@f290.i.mail.ru> <20131219194254.GA1443@kroah.com> <1387483251.210379532@f290.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41049 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab3LSWqv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Dec 2013 17:46:51 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so1774178wgg.24
        for <linux-serial@vger.kernel.org>; Thu, 19 Dec 2013 14:46:50 -0800 (PST)
In-Reply-To: <1387483251.210379532@f290.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Thu, Dec 19, 2013 at 3:00 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

[...]

> OK for me, except removing file.
> Lets try to apply version without "-D" option. I'll resend it shortly.

Yes, the unconditional delete is a win for review, but git-am does not
like it.  I proposed a patch to fix this some months ago; I should try
and re-push it, since for mailing list reviews, it is a valuable option.

Paul.
--
