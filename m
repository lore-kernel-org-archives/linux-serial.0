From: Corbin <corbinat@gmail.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 22 May 2012 15:31:15 -0500
Message-ID: <CAA0x6__sgnqhCXiSR29qnqKhGZrLuOa7siQcBJM7-UnkSn2Jtw@mail.gmail.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
 <20120515165339.6b142cd2@pyramind.ukuu.org.uk> <20120515155833.GA24878@kroah.com>
 <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
 <20120515172710.0d0ce47b@pyramind.ukuu.org.uk> <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
 <20120515220831.11f04213@bob.linux.org.uk> <CAA0x6_8mPs_JLxnjrzNYc4qej-c0kkhbVyuJPsaPg8xBvmThqQ@mail.gmail.com>
 <OF12D97EE0.DCA5956B-ON86257A05.00532260-86257A05.00537F9F@ni.com> <20120521170553.7822c01c@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62884 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab2EVUbh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 May 2012 16:31:37 -0400
Received: by vbbff1 with SMTP id ff1so4158033vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 22 May 2012 13:31:37 -0700 (PDT)
In-Reply-To: <20120521170553.7822c01c@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jason Smith <jason.smith@ni.com>, Alan Cox <alan@linux.intel.com>, Corbin Atkinson <corbin.atkinson@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Mon, May 21, 2012 at 11:05 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> I was hopng Jiri would chip in.

Jiri,

What do you think of my patch?
