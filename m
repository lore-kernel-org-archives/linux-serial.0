From: ttuttle <ttuttle@chromium.org>
Subject: Re: [PATCH 2/4] qcserial: log when an interface has too many altsettings
Date: Wed, 1 Feb 2012 17:15:57 -0500
Message-ID: <CADyrwZQNMpxh5yTBnH68+0KK9r5NFvFMgad1K8qXouWAHY=1Rg@mail.gmail.com>
References: <20120201210723.GB16802@google.com> <20120201211116.GA30758@kroah.com>
 <CADyrwZSN6xeibZzgaPCL7qZfpwrTLipkXwQUOTOMZGpg0uRhHw@mail.gmail.com> <20120201220232.GB893@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:54476 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757251Ab2BAWQi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Feb 2012 17:16:38 -0500
Received: by obcva7 with SMTP id va7so1876666obc.19
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2012 14:16:37 -0800 (PST)
In-Reply-To: <20120201220232.GB893@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Feb 1, 2012 at 17:02, Greg KH <gregkh@linuxfoundation.org> wrote:
> As the code properly handles such an error, my point is, if a user sees
> this new scary message, what are they supposed to do with it?

The intent was that when we saw it in logs, we'd know to look straight
at the USB configuration, but okay.

> So yes, please drop it.

Alright.

> Are you going to resend this series based on the comments so far?

I can, if it's easier for you than just selectively applying the two
remaining ones.
