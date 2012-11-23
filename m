From: Yan Hong <clouds.yan@gmail.com>
Subject: Re: [PATCH 1/2] tty: remove redundant initialization in initialize_tty_struct()
Date: Fri, 23 Nov 2012 23:04:52 +0800
Message-ID: <CAH+=+MEpjwXUnD0Hey18fRbvY56wDHVmD5L1PsHwK_QmHCg4TA@mail.gmail.com>
References: <1353681708-5413-1-git-send-email-clouds.yan@gmail.com>
	<20121123145107.22bab04c@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33399 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2KWPEy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Nov 2012 10:04:54 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so5673982vcm.19
        for <linux-serial@vger.kernel.org>; Fri, 23 Nov 2012 07:04:53 -0800 (PST)
In-Reply-To: <20121123145107.22bab04c@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

2012/11/23 Alan Cox <alan@lxorguk.ukuu.org.uk>:
> On Fri, 23 Nov 2012 22:41:47 +0800
> Yan Hong <clouds.yan@gmail.com> wrote:
>
>> tty_struct is already zeroed, no need to zero its field again.
>
> True but its asking for impossible to find bugs later if this changes

If it's true, we should have concern for all memset() usage. Is this
case special?

Thanks
