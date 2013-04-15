From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 00/24] lockless n_tty receive path
Date: Mon, 15 Apr 2013 13:14:11 -0700
Message-ID: <20130415201411.GA27360@kroah.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62996 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871Ab3DOUOX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Apr 2013 16:14:23 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so2721412pdj.16
        for <linux-serial@vger.kernel.org>; Mon, 15 Apr 2013 13:14:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Mon, Apr 15, 2013 at 11:19:04AM -0400, Peter Hurley wrote:
> Greg,
> 
> Unfortunately, this series is dependent on the 'ldsem patchset'.
> The reason is that this series abandons tty->receive_room as
> a flow control mechanism (because that requires locking),
> and the TIOCSETD ioctl _without ldsem_ uses tty->receive_room
> to shutoff i/o.

Can you also resend the ldsem patch series, as I no longer have it
around anymore, and I don't think it was part of this big resend, right?

thanks,

greg k-h
