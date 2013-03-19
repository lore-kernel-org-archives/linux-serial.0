From: Ilya Zykov <linux@izyk.ru>
Subject: Re: [PATCH 6/7] n_tty: Fix unsafe update of available buffer space
Date: Wed, 20 Mar 2013 00:26:57 +0400
Message-ID: <5148CA11.3010106@izyk.ru>
References: <20130319141017.GB24900@kroah.com> <1363703218-32333-1-git-send-email-peter@hurleysoftware.com> <1363703218-32333-3-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363703218-32333-3-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 19.03.2013 18:26, Peter Hurley wrote:
> receive_room is used to control the amount of data the flip
> buffer work can push to the read buffer. This update is unsafe:
> 
>   CPU 0                        |  CPU 1
>                                |
>                                | n_tty_read()
>                                |   n_tty_set_room()
>                                |     left = <calc of space>
> n_tty_receive_buf()            |
>   <push data to buffer>        |
>   n_tty_set_room()             |
>     left = <calc of space>     |
>     tty->receive_room = left   |
>                                |     tty->receive_room = left
> 
> receive_room is now updated with a stale calculation of the
> available buffer space, and the subsequent work loop will likely
> overwrite unread data in the input buffer.
> 

Sounds reasonable to me.
Thank you.
Ilya Zykov <linux@izyk.ru>
